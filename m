Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems with dtl1_cs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1132493286.5669.6.camel@stout.metatype.it>
References: <1132493286.5669.6.camel@stout.metatype.it>
Content-Type: text/plain
Message-Id: <1132657851.28644.10.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 22 Nov 2005 12:10:51 +0100

Hi Matteo,

> i'm using a legacy nokia dtl-4 connectivity card with bluez to link to
> my 3g phone (nokia 6680).
> 
> The card binds, the pppd link come up, but after few minutes the system
> freeze and i need to power cycle the notebook. I haven't been able to
> narrow it down to a particular usage pattern. I've not managed to
> reproduce in terminal only mode
> (no X) but maybe it's probably a matter of time.
> 
> After the reset, the syslog shows usually:
> 
> Nov 20 10:10:22 stout kernel: dtl1_interrupt: RLSI
> Nov 20 10:10:22 stout kernel: rfcomm_recv_frame: bad checksum in packet
> 
> but one time:
> 
> Nov 19 17:24:08 stout kernel: dtl1_interrupt: RLSI
> Nov 19 17:24:08 stout kernel: dtl1_receive: Unknown HCI packet with type
> 0x13 received

maybe the driver is at fault here. However I never had the full
specification to write a really good driver. Ask Nokia or Socket for
more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
