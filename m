Return-Path: <dwmw2@infradead.org>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
From: David Woodhouse <dwmw2@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030722092654.096aad60@unixmail.qualcomm.com>
References: <1058555551.31052.261.camel@pegasus>
	<5.1.0.14.2.20030722092654.096aad60@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1058897607.32360.10.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
Date: Tue, 22 Jul 2003 14:13:29 -0400
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2003-07-22 at 13:09, Max Krasnyansky wrote:

> Ok. I know what's the problem is. Basically what happens is that we fill up socket 
> tx buffer before MSC exchange completes (aclsession script does wait 10) and app goes to 
> sleep in sendmsg(). Then we receive MSC and send 5 frames from tx buffer (we only 
> send 5 frames at a time when credit flow ctl is not enabled). App is still sleeping 
> at this point because sock_def_write_space() will not wakeup the process unless there
> is a lot of room in the tx buffer. 

I think this is your problem. You should wake the writer as soon as
there's any space in the buffer for it to write. If you want to throttle
tx over the wire, do it by other means, not by letting the writers sleep
indefinitely. 

> The fix is simple we just need to reschedule DLC when credit based flow control is not enabled. But I'm
> not sure how often we need to do that. 

Why only when flow control is disabled? Surely we have the same problem
in the case where flow control is enabled too? You want to keep your
buffers full (but not too _large_ for latency reasons) or you might as
well not have them, surely?

> If we do it too often we'll essentially restore old behavior, too
> seldom and performance will suffer. David, any suggestion ?

The old behaviour which I fix wouldn't be restored by waking on dequeue,
surely? What I did was limit the tx buffers, and that would still have
the desired effect.

-- 
dwmw2
