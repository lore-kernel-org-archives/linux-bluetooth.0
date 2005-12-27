Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What is "Generic Audio" (0x1203) / using Nokia
	6230 as a headset
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051226083810.GB48781@advtechme.com>
References: <20051226083810.GB48781@advtechme.com>
Content-Type: text/plain
Message-Id: <1135699421.3624.7.camel@localhost.localdomain>
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
Date: Tue, 27 Dec 2005 17:03:41 +0100

Hi Dirk,

> 6 months back I was playing at a friends place with his collection of
> mobiles. Searching for headsets from a Windows CE driven Mobile phone
> I've seen my Nokia 6230 as a possible headset in its list. Since then
> I'm trying to use my phone as a headset from my laptop without success.
> 
> Connecting with btsco to my brings connection refused or similar
> messages and when I'm connected my phone indicates it is connected to a
> headset, instead of being one. I suspect missing code or code to be
> changed in btsco and I would like to implement that.
> 
> It is my understanding, that first of all I should be able to find my
> phone using 'sdptool search 0x1108'. I also understand, that I should
> not connect to the "Headset Audio Gateway" as this is for the headsets
> to connect to. 
> 
> | junge btsco # sdptool search --bdaddr $nokia 0x1108
> | Class 0x1108
> | Searching for 0x1108 on $nokia ...
> | Service Name: Audio Gateway
> | Service RecHandle: 0x1004c
> | Service Class ID List:
> |   "Headset Audio Gateway" (0x1112)
> |   "Generic Audio" (0x1203)
> | Protocol Descriptor List:
> |   "L2CAP" (0x0100)
> |   "RFCOMM" (0x0003)
> |     Channel: 12
> | Language Base Attr List:
> |   code_ISO639: 0x656e
> |   encoding:    0x6a
> |   base_offset: 0x100
> | Profile Descriptor List:
> |   "Headset" (0x1108)
> |     Version: 0x0100
> 
> From the output above I can only suspect the "Generic Audio" class to be
> of some help. What is it? 

the Generic Audio is only a generalization service class. Not really
helpful in any case.

> Where can I find documentation on BlueTooth without subscribing to
> bluetooth.org?

You might wanna buy yourself a book or read the BlueZ source code.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
