Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY12-F257741C2F24AE15EB32DD4B5E60@phx.gbl>
From: "Michael Alladin" <huivzhopu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-users] Multimedia keys (Microsoft keyboard)
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
Date: Tue, 14 Mar 2006 21:29:17 -0300

Hi,

I've posted to the group before but this issue still persists.

Multimedia keys (Media, Mail, Sleep, Calculator, etc) are not working. 
Beside that, the keyboard works excellent.

'hidd --show' reports that both keyboard and mouse are in boot protocol 
mode. However, hcidump does not show anything being sent, that includes raw 
mode.

They keyboard has F-Lock button, which is supposed to switch functional keys 
i.e. F1 becomes Help, F2 becomes Undo, etc.   When I push Flock to enable 
these functions, F-keys stop producing events as well. Press F-Lock again to 
unlock and F-keys work fine again.

Could it be possible that some special mode needs to be enabled? Multimedia 
keys seem to work in windows xp without needing to press anything.

thanks!

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
