Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722113308.097cd6a0@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 12:43:38 -0700
To: David Woodhouse <dwmw2@infradead.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
Cc: Daryl Van Vorst <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058897607.32360.10.camel@lapdancer.baythorne.internal>
References: <5.1.0.14.2.20030722092654.096aad60@unixmail.qualcomm.com>
	<1058555551.31052.261.camel@pegasus>
	<5.1.0.14.2.20030722092654.096aad60@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 11:13 AM 7/22/2003, David Woodhouse wrote:
>On Tue, 2003-07-22 at 13:09, Max Krasnyansky wrote:
>
>> Ok. I know what's the problem is. Basically what happens is that we fill up socket 
>> tx buffer before MSC exchange completes (aclsession script does wait 10) and app goes to 
>> sleep in sendmsg(). Then we receive MSC and send 5 frames from tx buffer (we only 
>> send 5 frames at a time when credit flow ctl is not enabled). App is still sleeping 
>> at this point because sock_def_write_space() will not wakeup the process unless there
>> is a lot of room in the tx buffer. 
>
>I think this is your problem. You should wake the writer as soon as
>there's any space in the buffer for it to write. If you want to throttle
>tx over the wire, do it by other means, not by letting the writers sleep
>indefinitely. 
May be I didn't explain it clearly. The problem is not in the buffering. It's in the TX processing.
Read below.

>> The fix is simple we just need to reschedule DLC when credit based flow control is not enabled. But I'm
>> not sure how often we need to do that. 
>
>Why only when flow control is disabled? Surely we have the same problem
>in the case where flow control is enabled too? You want to keep your
>buffers full (but not too _large_ for latency reasons) or you might as
>well not have them, surely?
Again buffering is not the problem here.
If credit based flow control (CFC) is enabled rfcomm_process_tx() will use all available credits 
(assuming tx buffer has enough stuff to send) and then wait for more credits. As soon as we get more 
credits we send more frames from tx buffer. 
Now when CFC is disabled we send 5 frames and do not send more until app wakes up again. That is
the problem.

Here is an example. RFCOMM app sends 1KB of data and waits for response.
Lets say MTU of this channel is 100 bytes.
CFC case:
        - They grant us 5 credits
        - We send 5 frames. 
        - They grant us 5 credits
        - We send 5 frames.
        <1KB transfer is complete at this point>

Non-CFC case:
        - We send 5 frames.
        <that's it. we're stuck here>
Waking the app here won't help, it already sent what I had to send.

So what should happen instead is
Non-CFC case:
        - We send 5 frames.
        - We reschedule DLC.
        - We send 5 frames.
        - We reschedule DLC
        <1KB transfer is complete at this point>

See. Buffering is not the problem. The problem is that we have to restart tx processing.
I guess we could solve it by making socket send buffer == MTU * 5. In which case the problem 
is kind of related to buffering. But I don't want to change socket buffering just for non CFC
case.

>> If we do it too often we'll essentially restore old behavior, too
>> seldom and performance will suffer. David, any suggestion ?
>
>The old behaviour which I fix wouldn't be restored by waking on dequeue,
>surely? What I did was limit the tx buffers, and that would still have
>the desired effect.
Now you should see what I was talking about. If we reschedule DLC immediately
after sending 5 frames we'll end up sending too fast (ie exactly the same as before).

btw We're talking about RFCOMM sockets here. But it might affect TTYs as well. 

Max
