Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sebastian Eichner <mail@sebastian-eichner.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP working :-) , voice not :-(
References: <200412010839.06669.mailsp@sebastian-eichner.de> <1101887686.18840.38.camel@pegasus>
In-Reply-To: <1101887686.18840.38.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412010907.09587.mail@sebastian-eichner.de>
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
Date: Wed, 1 Dec 2004 09:07:09 +0100

Hi Marcel,

On Wednesday, 1. December 2004 08:54, Marcel Holtmann wrote:
> there is no need to put sox in between:
>
> mpg123 --au - test.mp3 | sbc/sbcenc - | ./a2play 00:08:F4:30:03:71

Ahhh, even easier... ;-)

"hciconfig hci0 revision" gives me:

hci0:   Type: USB
        BD Address: 00:0F:B3:17:3E:D0 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 18.2
        Chip version: BlueCore02
        Max key size: 128 bit
        SCO mapping:  HCI



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
