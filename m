Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Palm hotsync over BT
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126844669.5934.7.camel@localhost.localdomain>
References: <1126826943.17881.20.camel@wyatt.hadess.net>
	 <1126844669.5934.7.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1127142348.24203.95.camel@wyatt.hadess.net>
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
Date: Mon, 19 Sep 2005 16:05:48 +0100

On Fri, 2005-09-16 at 06:24 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Apart from submitting a patch (attached below), I wanted to ask about
> > the PALMOS and HOTSYNC SDP records that sdptool can now add. First of
> > all, what is the difference between those two?
> 
> oh yeah, the patch fixes a stupid paste and copy mistake. Thanks.
> 
> The HOTSYNC record is the record the Palm OS is searching for when it is
> doing HotSync over Bluetooth. It will fall back to a normal SP record,
> but this can be confusing if the sync host runs multiple targets. The
> PALMOS record is an identification record like NOKID, I think. This
> hasn't been confirmed and so far I haven't seen any device requesting
> it.
> 
> > If I understood well Marcel's mail[1], one could now sync a Palm over
> > Bluetooth by doing:
> > - sdptool add HOTSYNC
> > - adding an rfcomm connection to the Palm
> > - using pilot-link or other Palm software using the just created rfcomm
> > device as the serial device
> > 
> > And the mail mentioned above was to avoid having to create an rfcomm
> > connection by hand. Am I even close?
> 
> The pilot-link library should be extended to do everything by itself.
> This means the service registration and the RFCOMM channel handling to
> map the HotSync protocol over RFCOMM.

Do you know which channel it is supposed to connect to on the Palm?
Something like that is supposed to work:

$ sdptool add HOTSYNC
$ rfcomm bind  0 <palm bdaddr> <channel num>
$ pilot-xfer -p /dev/rfcomm0 -l

Right now, with the few channels I tried, the Palm complains about the
port already being used by another application.

---
Bastien Nocera <hadess@hadess.net> 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
