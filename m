Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RSSI from rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <429996F9.6000700@bungtopia.com>
References: <5256d0b050514160856c4d194@mail.gmail.com>
	 <1116112975.8886.25.camel@pegasus>
	 <5256d0b05051416323a633e2d@mail.gmail.com>
	 <1116115930.8886.27.camel@pegasus>  <428A0F38.5050902@bungtopia.com>
	 <1116366629.10063.119.camel@pegasus>  <4293520A.9010303@bungtopia.com>
	 <1116954340.30044.151.camel@pegasus>  <4293F272.2040504@bungtopia.com>
	 <1117012660.30044.201.camel@pegasus>  <429996F9.6000700@bungtopia.com>
Content-Type: text/plain
Message-Id: <1117362982.7072.57.camel@pegasus>
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
Date: Sun, 29 May 2005 12:36:22 +0200

Hi Michael,

> I have upgraded to 2.6.11. Now getsockopt() works ok, but I can't call 
> hci_read_rssi() without errors! It still says protocol not available.Is 
> there another way to read the RSSI from RFCOMM?

the device descriptor for hci_read_rssi() comes from hci_open_dev().

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
