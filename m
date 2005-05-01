Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] authentication problem - link_key prevents from
	pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505012210.59716.RJenster@web.de>
References: <Pine.LNX.4.30.0505011025590.18702-100000@stealth.kirenet.com>
	 <1114959364.21785.18.camel@pegasus>  <200505012210.59716.RJenster@web.de>
Content-Type: text/plain
Message-Id: <1114989560.21785.82.camel@pegasus>
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
Date: Mon, 02 May 2005 01:19:20 +0200

Hi Ruben,

> I've a really enerving problem.
> 
> On my desktop I'm not able to pair my headset without 
> deleting /etc/bluetooth/link_key. After deleting the link_key
> the pinhelper pops up and asks for the pin. I insert them and 
> I'm able to connect.

use the latest BlueZ utilities and run "hcidump -X -V" as root, so we
can see what is going on.

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
