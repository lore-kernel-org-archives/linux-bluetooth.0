Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <62409.84.168.62.45.1157024271.overlook@webmail.prodigy7.de>
In-Reply-To: <44F6B7AE.1030209@jambit.com>
References: <44F6B7AE.1030209@jambit.com>
Date: Thu, 31 Aug 2006 13:37:51 +0200 (CEST)
From: "Manuel Bernhardt" <mailinglist@prodigy7.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] Play received A2DP data
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Frank,

> My programming task: Receive audio stream from A2DP, decode it and play
> it. Reception of A2DP stream is ok for me, decoding should work with
> sbc, but there is still the problem how to get the data to the sound
> card. So far I thought I need a sound driver for A2DP, as a kernel
> module and call open, ioctl and write via snd_hwdep routines. Is that
> right?

maybe http://bluetooth-alsa.sourceforge.net/ is that what are you looking
for?

Manuel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
