Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Regarding a2recv
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050509025805.331c34c7.henryk@ploetzli.ch>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	 <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	 <20050509005413.3787d2d7.henryk@ploetzli.ch>
	 <1115596897.8949.79.camel@pegasus>
	 <20050509025805.331c34c7.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1115600627.8949.93.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 May 2005 03:03:47 +0200

Hi Henryk,

> Am Mon, 09 May 2005 02:01:36 +0200 schrieb Marcel Holtmann:
> 
> > I suspect that it is waiting for a role switch to happen.
> 
> Either that isn't it or I'm doing it wrong. There should be two
> principal ways to archieve this, right? 
> 
> a) hciconfig hci0 lm master
> If I do this I don't get a complete connection at all. hcidump shows
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:08:F4:35:05:3C role 0x00
>     Role: Master
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Role Change (0x12) plen 8
> > HCI Event: Connect Complete (0x03) plen 11
> but nothing shows up on a2recv. 
> 
> b) (I got this from the bthid code)
> getsockopt(fd, SOL_L2CAP, L2CAP_LM, &opt, &len)
> opt |= L2CAP_LM_MASTER;
> setsockopt(fd, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt))
> 
> I'm not sure on which fd I should apply this. If I do it on the streamfd
> right after it has been established the behaviour is just as normal
> (e.g. 6 second hang, then disconnect).
> 
> If I do it with the listening socket right in the beginning I get the
> same as with hciconfig above. (I swear I got a "Role change not allowed"
> message from kdebluetoothd somewhere in between, but I can't reproduce
> that.)

you must do it on the HCI level at the correct time. Look at the
function hci_switch_role() for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
