Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Audio & Bluetooth 
In-reply-to: <1099965952.27159.7.camel@loke> 
References: <418FC205.7070102@tootai.net> <1099943857.29330.27.camel@pegasus> <1099954588.6339.144.camel@loke> <1099956503.29330.35.camel@pegasus> <1099965952.27159.7.camel@loke>
Message-ID: <15251.1099994062@csr.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 09:54:22 +0000

Martin List-Petersen wrote:
> Must be blind. Anyhow, i guess this doesn't sound good for sound:
> 
> # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:60:57:02:7F:E1 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 12.7
>         Chip version: BlueCore01b
>         SCO mapping:  PCM
> 
> I have problems with no audio on this dongle. So i take it, that it
> might be the oldish firmware.

12.7 is prehistoric, unfortunately.  The last release for BlueCore01 was
16.something, then we stopped supporting it.  If you want further
improvements after that, you should get a new dongle.  All new ones
should have at least BlueCore2 in them (we only have one BlueCore01
customer left and they don't make dongles).

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
