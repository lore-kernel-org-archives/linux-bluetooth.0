Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unstable acl throughputs
From: Marcel Holtmann <marcel@holtmann.org>
To: Sean Loh <blaze_wk@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041026160627.93404.qmail@web41101.mail.yahoo.com>
References: <20041026160627.93404.qmail@web41101.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098826804.14036.119.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 26 Oct 2004 23:40:04 +0200

Hi Sean,

> I have set up a pan between 2 computers with bluetooth
> usb adapters. From the mailing lists, I understand
> that to get assymetric data throughputs, we modify the
> hciconfig hci0 ptype to whatever we want. For example,
> the best assymmetric throughput would involve running
> hciconfig hci0 ptype DH5 on one computer and hciconfig
> hci0 ptype DH1 on the other computer. Am I right?

please read the mailing list archive again and understand my posts about
the packet types. The host can't choose the right packet type. So let
the link manager do this job and allow it to use whatever packet type it
wants.

> When I do this and I measure the udp packet
> throughputs, the throughputs I get are all over the
> place. For an assymetric connection of DH3/DH1. I can
> get throughputs from the DH3 link computer to the DH1
> computer of 650000 bits per second. Remember, this is
> in the pan profile, sending udp packets. Should I be
> getting this throughputs?or is there something amiss?
> 
> The DH1 computer is not sending any information out,
> so does that really matter. Could it be because of
> that I'm getting such high throughputs on the DH5
> computer?

Actually how would you now what kind of packet types are used on the
baseband? Do you have a protocol analyzer? If yes, look at it and keep
in mind that DM1 is always allowed and required.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
