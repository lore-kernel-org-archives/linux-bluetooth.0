Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436F4D85.4030404@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco (BTA-6030
 Dongle, Motorola H500 Headset)
References: <436F1C3B.5020002@web.de>
In-Reply-To: <436F1C3B.5020002@web.de>
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 07 Nov 2005 12:50:13 +0000

Oooh, this is just like Jeopardy.

I'll take Bluetooth for $500.

Dirk Stockmann wrote:
> ... 266Hz ...

At what rate are SCO packets transmitted in an HV3 link?

What do I win?

> I would be very grateful to get pointers what to do to get rid of that
> buzz. I am a experienced programmer with some low-level kernel
> knowledge, so I would also invest some time in debugging if I would knew
> for what I should look.

Based on the frequency, this looks (sounds?) like an electrical
problem. Many parts of the RF will have duty cycles of 266 Hz. Even
the current demand of the module will have a profile with this
frequency (it may pulse from a few milliamps up to 50 milliamps at
this rate, with sharp edges).

I expect you're getting pickup from the electronics on the module onto
the microphone cables,or, more likely, the audio card in the PC -
they're notoriously badly shielded, you can even hear when you drag a
window round the screen.

I don't know if this information helps.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
