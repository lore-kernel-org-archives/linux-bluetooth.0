Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciconfig question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f30e261041224131026cfa70a@mail.gmail.com>
References: <5f30e261041224131026cfa70a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1103931501.20258.94.camel@pegasus>
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
Date: Sat, 25 Dec 2004 00:38:21 +0100

Hi Jeff,

> I'm studying hciconfig.c to learn how to set inquiry mode and
> parameters.  As I play with the binary to understand the source, I get
> the following error on "hciconfig hci0 inqmode":
> 
> Can't read inquiry mode on hci0. Input/output error(5)
> 
> The "inqparms" command reads from hci0 just fine, with no errors.  I
> have "iscan enable" set in /etc/bluetooth/hcid.conf ... what else
> should I check?

you need a Bluetooth 1.2 device with inquiry with RSSI support.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
