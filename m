Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <440BEDC4.5040300@service2media.com>
From: Herman Meerlo <herman@service2media.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Inquiry and connection through different devices
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
Date: Mon, 06 Mar 2006 09:07:32 +0100

Hi all,

I am trying out a setup in which one USB dongle constantly performs an 
inquiry and another dongle then performs service searches on the found 
devices. But this weekend I was wondering whether this is efficient. The 
inquiry returns the found devices together with their clock offsets. But 
I suppose that this clock offset means nothing to the other dongle. So 
is it wise to do this or is it better to let both dongles perform their 
own inquiries and determine their own clock offsets?

Regards,
Herman Meerlo


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
