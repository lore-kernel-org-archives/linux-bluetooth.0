Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSI dongle flash
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200507090129.43874.cijoml@volny.cz>
References: <200507090129.43874.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1120895302.29504.4.camel@notepaq>
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
Date: Sat, 09 Jul 2005 09:48:22 +0200

Hi Michal,

> I have here dongle from MSI firmware 
> HCI 18.2  	bc02x  	bc02x_8unified_fl_bt1.2_18p2_0405241530_encr56  	May 24, 
> 2004  	0x570 (1392)
> 
> 0db0:697a Micro Star International
> 
> I would like flash it via Apple fw to have it 128bit encryption. Is it 
> possible? Does anybody had success with it? This dongle is some unknown 
> public I took with my new laptop. MSI is not mentioned on it, but it look 
> like MSI

unless you have a firmware for this VID/PID combination I won't try to
flash it. The genernal rule is if they don't have the VID/PID from CSR
set, then their is a good chance that they also signed their firmware.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
