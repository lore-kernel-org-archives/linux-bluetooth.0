Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] convert sdp browse list to icons`
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412010157.11129.wim.delvaux@adaptiveplanet.com>
References: <200412010157.11129.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1101882358.18840.16.camel@pegasus>
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
Date: Wed, 01 Dec 2004 07:25:58 +0100

Hi Wim,

> Can anybody point me to a document describing how to map an sdp service entry
> to the 'class' of a service.

as far as I know there exists no mapping for that.

> I.e. if the 'text'  field (attribute 0x100) shows 'dialup networking' then 
> connecting to this service provides just that.  However could this string be 
> different from device to device ? If so is there a CODE somewhere in that sdp 
> record that says the same but does not change ?

The text field can be freely choosen.

> I thing the attribute 0x9 (BluetoothProfileDescriptorList) can be used for 
> that but it is a LIST meaning multiple values are allowed to there might be 
> different values in that entry ...

You should use the "Service class ID list" (attribute 0x0001) list.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
