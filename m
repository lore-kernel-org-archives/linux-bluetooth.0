Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Fenemor <Neil@OnDrugs.co.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088029361.3703.17.camel@localhost.localdomain>
References: <1088029361.3703.17.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088030296.4296.14.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Jun 2004 00:38:16 +0200

Hi Neil,

choose one mailing list, because I hate cross-postings.

> I'm trying to get my MX900 Hub and my i-mate smartphone2 to place
> nicely together, but so far, I haven't had much luck on that front.
> The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you
> prefer to call it. The phone is also called a Orange SPV E200 for
> those on that network.

Send us the information about your phone from "hcitool info <bdaddr>".

> I can get rfcomm stuff to work fine with other phones, so I believe it
> is the phone itself at fault. The end result that I'm after, is to be
> able to sync with my phone, and also surf from my laptop via GPRS. The
> time frame I'm trying t work within is of course tight, as I'm needed
> this next week for while I'm away. 
> 
> When all connected, peered, etc, and it looks successful, I get odd
> things like the following.
> 
> [root@localhost neil]# cat /dev/rfcomm0
> cat: /dev/rfcomm0: Connection reset by peer
> [root@localhost neil]# 
> 
> I've put the hcidump information at the bottom of the e-mail.

Do it again, but this time with -x or send us the binary dump.

> I'm also having problems with the ActiveSync facilities on the phone,
> as when I try the "BT ActiveSync" it comes up with "Please bond with
> other Bluetooth device which supports serial port or ActiveSync
> profile as your ActiveSync partner!"

>>From the dump I saw that you use security mode 3. Do you enabled auth
and encrypt in hcid.conf? Don't do so. Show us "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
