Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200309122202.h8CM2X905779@localhost.lateapex.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
To: bluez-users@lists.sourceforge.net
Reply-To: jvp@lateapex.net
In-Reply-To: <1063401632.28890.268.camel@pegasus> from "Marcel Holtmann" at Sep 12, 2003 11:20:26 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Sep 2003 18:02:33 -0400 (EDT)

At Fri Sep 12 17:20:26 2003, Marcel Holtmann wrote:
> the Bluetooth adapter in this notebook is a USB based from CSR and it
> should work perfect with the hci_usb driver. Have you switched the
> Bluetooth device on?

When you say "switched the Bluetooth device on" do you mean like my Palm? 
My goal is to get the laptop and the Palm chatting with one another via
Bluetooth.

However, given the reading I've done (and it's quite possible I've misread,
so forgive my ignorance) the hci device should show up regardless of whether
there's another BT-enabled device around.

# hciconfig -a
# 

I'm not seeing anything.

jas
-- 
Jason Van Patten
AOL IM: Jason VP 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
