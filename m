Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722092654.096aad60@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 10:09:10 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <002501c34d61$84afdc30$5796fea9@baked>
References: <1058555551.31052.261.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 12:19 PM 7/18/2003, Daryl Van Vorst wrote:
>Marcel,
>
>> > Do you mean you tried the aclsession script and didn't see the same 
>> > send 5 frames, wait 20 sec, send 5 more etc problem?
>> 
>> the aclsession scripts produces this effect, but it also left 
>> the ACL link in some kind of buggy state. It must be some 
>> really stupid that I always overlook. The code looks correct 
>> to me and my Bluetooth 1.0b devices are working fine.
>
>Ok...  I guess we can leave it for now then. If it becomes a more serious
>issue I'll let you know.
Ok. I know what's the problem is. Basically what happens is that we fill up socket 
tx buffer before MSC exchange completes (aclsession script does wait 10) and app goes to 
sleep in sendmsg(). Then we receive MSC and send 5 frames from tx buffer (we only 
send 5 frames at a time when credit flow ctl is not enabled). App is still sleeping 
at this point because sock_def_write_space() will not wakeup the process unless there
is a lot of room in the tx buffer. Eventually (after 30 secs) sendmsg() times out but
it doesn't return an error because it did manage to send a little bit. So the app will 
call sendmsg() again and send some more data, which will trigger tx queue processing 
and we will send 5 more frames, app goes to sleep again because buffer is still full 
and the cycle repeats. 
So it's should be obvious where the bug is :), it is in rfcomm_process_tx(). It's supposed
to reschedule DLC after it sends 5 packets. The reason it works for real world apps is 
because there is always some activity on the link which kicks tx processing.

Also the problem was somewhat hard to trigger before this patch from David went in
> >+++ core.c      Thu Apr  3 14:05:20 2003
> >@@ -1430,7 +1430,7 @@
> >        } else {
> >                /* CFC disabled.
> >                 * Give ourselves some credits */
> >-               d->tx_credits = RFCOMM_MAX_CREDITS;
> >+               d->tx_credits = 5;
> >        }
> >  
> >        if (test_bit(RFCOMM_TX_THROTTLED, &d->flags))

ie We used to send more frames and therefor managed free more tx buffer space and wake up application.

The fix is simple we just need to reschedule DLC when credit based flow control is not enabled. But I'm
not sure how often we need to do that. If we do it too often we'll essentially restore old behavior, too
seldom and performance will suffer. David, any suggestion ?

Max
