Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Sun, 11 May 2008 20:05:23 +0000 (UTC)
Message-ID: <loom.20080511T195330-239@post.gmane.org>
References: <1209820958.6736.12.camel@richard-desktop>
	<1210336684.28002.29.camel@violet.holtmann.net>
	<be0d0f5e0805091434o26b8595eg9e7bbe57e920a2b5@mail.gmail.com>
	<4826F4E2.80200@gmx.de> <1210521709.6776.1.camel@richard-desktop>
	<1210525996.16390.12.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Disable Notify Bubble?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann <marcel <at> holtmann.org> writes:
> don't give people ideas. This is wrong. It is simply plain wrong and you
> have no clue what it is actually doing. This script only treats symptoms
> and not the problem. Actually that this works for you is simply pure
> luck.

Hi Marcel,

I really like to create proper bug report, the above (very dirty) work around
crossed my mind but I skipped it. The last year I've posted questions how I
could debug this issue (and create a proper bug report) without any helpfull
replies.

I will give you the symptoms:
- Occures *sometimes* after a disconnect
- Both keyboard and mouse are affected
- Sometimes restarting the input service works
- Sometimes only resetting hci0 works (hciconfig hci0 reset)
- Sometimes only resetting the input device works
- Occurs mostly when hcitool con gives SLAVE for the input devices
- hcidump gives output when input is send from the input device (typing keys /
moving mouse)
- I've "trusted" the input devices
- Started to occur since the input service replaced hidd
- Dmesg gets filled with
  input: Logitech MX1000 mouse as /class/input/input13
  input: Logitech diNovo Keyboard as /class/input/input14
  input: Logitech MX1000 mouse as /class/input/input15
  input: Logitech diNovo Keyboard as /class/input/input16
  input: Logitech MX1000 mouse as /class/input/input17
  input: Logitech diNovo Keyboard as /class/input/input18
  input: Logitech MX1000 mouse as /class/input/input19
  etc.

Please tell me what else I need to submit for a proper bug report.

Thanks for bluez, besides these issues I'm very happy with this state of the art
bluetooth stack.

greetings,
Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
