Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Palm hotsync over BT
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126826943.17881.20.camel@wyatt.hadess.net>
References: <1126826943.17881.20.camel@wyatt.hadess.net>
Content-Type: text/plain
Message-Id: <1126844669.5934.7.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 06:24:29 +0200

Hi Bastien,

> Apart from submitting a patch (attached below), I wanted to ask about
> the PALMOS and HOTSYNC SDP records that sdptool can now add. First of
> all, what is the difference between those two?

oh yeah, the patch fixes a stupid paste and copy mistake. Thanks.

The HOTSYNC record is the record the Palm OS is searching for when it is
doing HotSync over Bluetooth. It will fall back to a normal SP record,
but this can be confusing if the sync host runs multiple targets. The
PALMOS record is an identification record like NOKID, I think. This
hasn't been confirmed and so far I haven't seen any device requesting
it.

> If I understood well Marcel's mail[1], one could now sync a Palm over
> Bluetooth by doing:
> - sdptool add HOTSYNC
> - adding an rfcomm connection to the Palm
> - using pilot-link or other Palm software using the just created rfcomm
> device as the serial device
> 
> And the mail mentioned above was to avoid having to create an rfcomm
> connection by hand. Am I even close?

The pilot-link library should be extended to do everything by itself.
This means the service registration and the RFCOMM channel handling to
map the HotSync protocol over RFCOMM.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
