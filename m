Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Something strange with minicom
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200504300003.22570@ByZsA>
References: <200504300003.22570@ByZsA>
Content-Type: text/plain
Message-Id: <1114818982.8836.116.camel@pegasus>
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
Date: Sat, 30 Apr 2005 01:56:22 +0200

Hi Attila,

> > Make sure that you grep the initial HCI and L2CAP connection setup,
> >  because otherwise hcidump is not able to decode RFCOMM. Or specific
> > the --psm=3 option on the command line.
> 
> Here is a new dump with --psm=3:

use "hcidump -X -V --psm=3" so I don't have to decode everything by
myself.

> I don't see any echoed characters at the end, only the "ERROR" message. 
> But ATZ is a very common modem command and as I wrote earlier, it works 
> with windows hyperterminal. I noticed that I enter only "AT", I got an 
> OK. But any other AT commands don't work.

The echoing must not be on by default. Enter "ATE1" and see happens.

> I'm sorry but I'm a newbe and don't know how to "grep the initial HCI 
> and L2CAP connection setup".

Start hcidump earlier so it can decode the whole connection setup.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
