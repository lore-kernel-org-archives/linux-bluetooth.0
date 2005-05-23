Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050523165711.055d97c2.szz@freemail.hu>
References: <20050523165711.055d97c2.szz@freemail.hu>
Content-Type: text/plain
Message-Id: <1116857587.30044.84.camel@pegasus>
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
Date: Mon, 23 May 2005 16:13:07 +0200

Hi Zol,

> I would like to ask you some help to make my 3CRWB6096 PCMCIA card to
> work. According to some documentation
> I use bt3c_cs driver.
> I use this:
> Linux localhost 2.6.9-19 #1 SMP Wed Apr 13 15:09:16 CEST 2005 i686
> UHU-Linux
> 
> Here is the output of some events:
> [After insterting the PCMCIA card: ]
> May 23 09:37:49 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
> May 23 09:37:49 cardmgr[2407]: socket 1: 3Com Bluetooth PC Card
> May 23 09:37:49 kernel: Bluetooth: Core ver 2.6
> May 23 09:37:49 kernel: NET: Registered protocol family 31
> May 23 09:37:49 kernel: Bluetooth: HCI device and connection manager
>  initialized
> May 23 09:37:49 kernel: Bluetooth: HCI socket layer initialized
> May 23 09:37:59 kernel: bt3c_open: Firmware request failed

do you might think this line could be the problem? You need to install
the firmware into the right directory.

	http://www.bluez.org/drivers.html

Regards

Marcel






-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
