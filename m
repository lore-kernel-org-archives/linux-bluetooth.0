Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1096249564.1725.0.camel@debian>
Mime-Version: 1.0
Subject: [Bluez-users] SCO route way!!
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
Date: Mon, 27 Sep 2004 09:46:05 +0800

Hi all, 

I am developing Bluetooth on Smart Phone, I have a question about
bluetooth voice, I don't know whether it is suitable to ask this
question here. 

My chip is TI BRF6100, I can change data between my board and the BT usb
dongle, and it can connect to the bluetooth headset, but it can't play
any music to it. 

The rfcomm connection has been connected and I can receive the AT
command from the headset.Using hcidump, I found that the SCO link is
added, but then there is no SCO traffic in the channel. 

The chip can support SCO data route from hci or direct to the baseband
from codec. I think the default choice of the chip is baseband. 

How can I choose the SCO route method? Is it a standard HCI command or
vendor-specific command? 

Any help appreciated! 

Chen



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
