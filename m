Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40D77DC8.5030200@ntlworld.com>
From: Oli Ellis <oliver.ellis@ntlworld.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Re: diNovo fancy bits
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
Date: Tue, 22 Jun 2004 01:31:04 +0100

Ref the multimedia keys on the diNovo, they seem to be misinterpreted by 
the hid de-scrambler in the bluetooth libraries, BUT apparently the hid 
de-scrambler is a carbon copy of that used in the usb bit of the kernel. 
So, four possibilities -
1) Logitech have blundered with their HID implementation and the 
keyboard simply reports the wrong keypresses, and this is patched over 
in the windows driver.
2) Key data is getting corrupted by the bluetooth stack (seems unlikely)
3) The hid de-scrambler is in fact not a correct copy of the usb one (I 
have checked this briefly and it seems to be ok?)
4) The kernel usb hid de-scrambler is not correct.

(Am I talking any sense here?)

The best way to test this is - see what keypress events are reported 
with the keyboard under normal, backwards compatibility mode (ie usb, 
but not bluetooth), and see what keypresses are reported with other (eg. 
microsoft) keyboards. Anyone have any idea how to get this info? 
Unfortunately, I can't help much here as I have just 'upgraded' from 
gentoo to suse 9.1 and crazy stuff happens with the device even plugged 
into the usb. I have not tried bluetooth mode yet. (keypresses send the 
mouse jumping all over the place and moving icons...)




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
