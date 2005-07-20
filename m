Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42DE5ABC.8010802@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Permission problems, Bluetooth Headset
References: <42DE3EAA.30705@toughguy.net>
In-Reply-To: <42DE3EAA.30705@toughguy.net>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 20 Jul 2005 16:07:56 +0200

Hi Ola,

Ola Benderius wrote:
> Hi,
> got a problem when trying to connect my Bluetooth headset (it's a
> Plantronics 2500) with Linux.
> 
> I follow this guide and this is my hcid.conf:
> 
>     #
>     # HCI daemon configuration file.
>     #
>     # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
>     #
> 
>     # HCId options
>     options {
>             # Automatically initialize new devices
>             autoinit yes;
> 
>             # Security Manager mode
>             #   none - Security manager disabled
>             #   auto - Use local PIN for incoming connections
>             #   user - Always ask user for a PIN
>             #
>             security auto;
> 
>             # Pairing mode
>             #   none  - Pairing disabled
>             #   multi - Allow pairing with already paired devices
>             #   once  - Pair once and deny successive attempts
>             pairing multi;
> 
>             # PIN helper
>             # pin_helper /usr/bin/bluepin;
>             pin_helper /etc/bluetooth/pin-helper;
> 
>             # D-Bus PIN helper
>             #dbus_pin_helper;
>     }
> 

> But the PIN is set to '0000' since that the PIN of the headset.
> (according to the manual)
> 
> /    echo "0000" > /etc/bluetooth/pin/
> 

what's pin-helper?
It's your script?
If yes, it must echo "PIN:0000", not only "0000".
typically:

#!/bin/bash
echo "PIN:0000"

Cheers,
Pizza

-------------------------------------------
Luca Pizzamiglio
CEFRIEL - Embedded Systems Design Unit
Via Fucini, 2 - 20133 MILANO (ITALY)
Phone:		+39 02 23954 343
e-mail:		pizzamiglio@cefriel.it
ICQ:		5046978
-------------------------------------------


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
