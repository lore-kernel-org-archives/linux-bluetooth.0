Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sebastian Eichner <mail@sebastian-eichner.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP working :-) , voice not :-(
References: <200412010839.06669.mailsp@sebastian-eichner.de> <200412010907.09587.mail@sebastian-eichner.de> <1101889919.18840.40.camel@pegasus>
In-Reply-To: <1101889919.18840.40.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412010943.33419.mail@sebastian-eichner.de>
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
Date: Wed, 1 Dec 2004 09:43:33 +0100

On Wednesday, 1. December 2004 09:31, Marcel Holtmann wrote:
> this should work. Do you enabled CONFIG_BT_HCIUSB_SCO in your
> kernel?

cat /proc/config.gz |gunzip -|grep CONFIG_BT_HCIUSB_SCO
CONFIG_BT_HCIUSB_SCO=y

Yes, it's enabled. Hmm, tricky thing...
Generally it should work with kernel 2.6.9, right?

Sebastian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
