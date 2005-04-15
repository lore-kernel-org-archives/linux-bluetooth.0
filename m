Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SonyEricsson K700i and HID
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4ca6094ca1c0.4ca1c04ca609@vxu.se>
References: <4ca6094ca1c0.4ca1c04ca609@vxu.se>
Content-Type: text/plain
Message-Id: <1113567708.16433.20.camel@pegasus>
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
Date: Fri, 15 Apr 2005 14:21:48 +0200

Hi Stefan,

> How exactly did you get it to work .. just by starting hidd with --nosdp,  and then it worked out if the box?

you should start the "hidd --server" also with "--nosdp" if you plan to
connect from your phone to the PC, but in general yes, a connect with
"--nosdp" is enough to make your phone act as a HID.

> How did you connect the mouse decive to X? I don't think that there are any appropriate mouse protocols / keyboard layouts for the k700 phone !? 

Everything goes through the input subsystem and as long as you are
using /dev/input/mice you don't have to do anything else.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
