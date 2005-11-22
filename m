Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <438356EF.9010503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can the btsco module support muting the microphone?
References: <loom.20051122T162417-540@post.gmane.org>
In-Reply-To: <loom.20051122T162417-540@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Nov 2005 10:35:43 -0700

Andre

The driver probably does need a modification, but if you go down this
route, you should find out how to support the actual mute operation that
is failing.

Brad

> With the snd-intel8x0, I found that couldn't mute the capture control so I
> switch the capture control between the microphone and line-in
> (a non existent input source) to unmute and mute, respectively.  Is there a
> strategy I can follow to mute the btsco microphone or do I need to add a fake
> input source to the btsco module?
> 
> Thanks.
> -andre.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
