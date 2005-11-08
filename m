Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
Message-ID: <20051108222033.GA12368@localhost.localdomain>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com> <1131119054.11673.1.camel@localhost.localdomain> <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
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
Date: Wed, 9 Nov 2005 00:20:33 +0200

On Tue, Nov 08, 2005, Claudio Takahasi wrote:
> In my opinion we can start playing with the feature below:
> 
>   up                      Open and initialize HCI device
>   down                  Close HCI device

These we already have (through the Up and Down methods).

>   name       [name]  Get/Set local name

This is good to have. A "local name changed" signal might also be useful
so that other applications can update their UI. Actually now that I
think about it, maybe thare should be a generic "property changed"
signal for all properties.

>   auth                   Enable/Disable Authentication
>   encrypt               Enable/Disable Encryption
>   secmgr               Enable/Disable Security Manager
>   piscan                Enable/Disable Page and Inquiry scan
>   iscan                  Enable/Disable Inquiry scan
>   pscan                 Enable/Disable Page scan

I think the piscan can be dropped so that we have two boolean
properties: iscan and pscan.

Also, I think it would be good to have the possibility to set the
inquiry mode (standard, with RSSI, RSSI + extended inq. result).
Currently the mode is always set inquiry with rssi when PeriodicInquiry
is called (I'm thinking of sending a patch to remove it), but it should
probably be set once at device initialization and then changed only by
the SetProperty method call.

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
