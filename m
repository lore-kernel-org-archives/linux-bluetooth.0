Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1131119054.11673.1.camel@localhost.localdomain>
	 <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131488427.5544.15.camel@blade>
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
Date: Tue, 08 Nov 2005 23:20:27 +0100

Hi Claudio,

> In my opinion we can start playing with the feature below:
> 
>   up                      Open and initialize HCI device
>   down                  Close HCI device

leave this for some other time. It is not that easy to do the up and
down properly.

>   name       [name]  Get/Set local name

And include the inquiry mode. We need to configure the name and the
inquiry mode. I also wanna remove the inquiry mode setting inside the
periodic inquiry call.

>   auth                   Enable/Disable Authentication
>   encrypt               Enable/Disable Encryption
>   secmgr               Enable/Disable Security Manager

This is a no. We don't need to configure it. I am not going to support
security mode 3 over the D-Bus interface. People are already doing
enough mistakes right now with it.

>   piscan                Enable/Disable Page and Inquiry scan
>   iscan                  Enable/Disable Inquiry scan
>   pscan                 Enable/Disable Page scan

This is all the same setting and the correct names for it are
"connectable" and "discoverable". There is no need to expose the
Bluetooth crappy names over the D-Bus interface.

> Maybe we could analise the possibility of make the configuration
> permanent updating these values in the 'hcid.conf' configuration file.

Maybe or maybe not. Convince me that you can do it in sane way.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
