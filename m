Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox BT-MS02B Bluetooth HID mouse, authorization
	and encryption?
From: Marcel Holtmann <marcel@holtmann.org>
To: Jouni.Lohikoski@iki.fi
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040919124431.GA485206@kosh.hut.fi>
References: <20040917202651.GA485579@kosh.hut.fi>
	 <20040919075226.GS26469@wacka.mjr.org>
	 <20040919124431.GA485206@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1095603530.5562.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 19 Sep 2004 16:18:50 +0200

Hi Jouni,

> I did try 0000, 1234, 1111 and 9999 then but none of them seem to work.
> 
> The trick is (or this time I was just lucky) the little grey button
> on the bottom of the mouse has to be pressed down whole time when 
> "hidd --search" is run on the Linux side. Only after the PIN code had 
> been entered and the hidd --search has succesfully connected to the mouse, 
> so BT pairing has been finished, the button can be released.
> 
> Maybe EPoX technical support can correct me or confirm me, when/if they
> reply after the weekend or some day to my request mail. I found it
> little odd the EPoX Bluetooth Mouse User's Guide, which came with the
> mouse, does not mention anything how the BT pairing should be done.
> 
> It would make sense though. When authorization is negotiated, the
> software on the mouse end of the peer checks if it accepts the PIN code 
> which is send by the host computer. The host computer must be the
> initiating party. If the grey button is then in that moment pressed down, 
> authorization is accepted (would think any code would do), if not, 
> the PIN confirmation request is rejected.

actually I tested it with my EPoX and I only had to press the grey
button once and use 1234 as pin code when I am in security mode 3. This
works for, but maybe you have to use virtual cable unplug first when
have bound it previously. In general the grey button should work as
virtual cable unplug, but sometimes when you presses it the mouse is in
progress with reconnect and that can cause some trouble in the lower
layers of the Bluetooth chip.

So for CSR mice the default pin code is 1234 and for Broadcom based mice
it is 0000. I need to put that on my webpage ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
