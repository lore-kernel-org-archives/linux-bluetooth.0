Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Conceptronic 200M (CBT200U V2.0)
Message-ID: <20050917120141.GA5231@uni-duesseldorf.de>
References: <dgfhr3$nrc$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dgfhr3$nrc$2@sea.gmane.org>
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
Date: Sat, 17 Sep 2005 14:01:42 +0200

"Heike C. Zimmerer" <nospam05q2@gmx.net> wrote:
> Recently, I've bought a Conceptronic 200M BT dongle, which, as far as
> I have learned, is also known as CBT100U V.2 USB.  In contrary to its
> CBT100U V1.1 predecessor which AFAIK used the CSR chipset, this one
> has Broadcom chips.

*grr* I hate it when vendors do this, but


> I'm trying to connect to a Logitech headset (the one mentioned in
> another article because of problems with the mic mixer). I don't get any
> audio output at the headset. 

This is probably related to the chipset: If "hciconfig hci0 revision"
doesn't say "SCO mapping:  HCI", you are probably out of luck with this
Chipset. See also the "Discussion" section on
http://bluetooth-alsa.sourceforge.net/.

> What puzzles me is that the output mixer seems to work;
> increasing/decreasing the output volume affects a very low noise which
> can be heard at high mixer levels.

This is probably normal, as there is a secondary (rfcomm serial) channel 
to the headset that carries commands like Volume, Ringing (check that,
should also work) and button presses. 

> Telling from btsco's -v output, the Conceptronic connects just as the
> other dongle does - I can't see any difference.

This is only this control connection, not the SCO voice data connection.


CU, Andy


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
