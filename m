Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Epox BT-MS02B Bluetooth HID mouse, authorization and encryption?
Message-ID: <20040919124431.GA485206@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
References: <20040917202651.GA485579@kosh.hut.fi> <20040919075226.GS26469@wacka.mjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040919075226.GS26469@wacka.mjr.org>
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
Date: Sun, 19 Sep 2004 15:44:31 +0300

On Sun, Sep 19, 2004 at 08:52:26AM +0100, Paul Hedderly wrote:
> I think you'll find your mouse is the same as mine - try "1234".

Thanks!

I did try 0000, 1234, 1111 and 9999 then but none of them seem to work.

The trick is (or this time I was just lucky) the little grey button
on the bottom of the mouse has to be pressed down whole time when 
"hidd --search" is run on the Linux side. Only after the PIN code had 
been entered and the hidd --search has succesfully connected to the mouse, 
so BT pairing has been finished, the button can be released.

Maybe EPoX technical support can correct me or confirm me, when/if they
reply after the weekend or some day to my request mail. I found it
little odd the EPoX Bluetooth Mouse User's Guide, which came with the
mouse, does not mention anything how the BT pairing should be done.

It would make sense though. When authorization is negotiated, the
software on the mouse end of the peer checks if it accepts the PIN code 
which is send by the host computer. The host computer must be the
initiating party. If the grey button is then in that moment pressed down, 
authorization is accepted (would think any code would do), if not, 
the PIN confirmation request is rejected.

It works now authorized and encrypted. Also recovers after the sleep
mode.

// jouni



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
