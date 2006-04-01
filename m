Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph Simon <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20060401131949.fdb6d992.ml133@netpole.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Anonymous service setup
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
Date: Sat, 1 Apr 2006 13:19:49 -0300

Hi,

I was asked to set up a linux (debian) box, which has an usb bluetooth
dongle, and which would allow anyone passing by and having a bluetooth
enabled device, to fetch some file from the server.

Unfortunately, I'm really stuck with all this, too many TLAs. I
managed to run hciconfig listing the dongle, to scan and inquire a
cellphone and to use l2ping on the MAC address. But there doesn't seem
to be a way to make a basic filetransfer.

When trying with obexftp, the celphone will asked for a PIN, when I
enter that which is written in /etc/bluetooth/pin, but then it just
hangs. In daemon.log, I can see the messages from hcid
"link_key_request" and "pin_code_request" but nothing else. After some
time, both obexftp desists, and the Motorola celphone would reboot. I
have been looking for some sort of debug mode of hcid, but couldn't
find any flag. I also changed the pin_helper line in the config file
to be a shellscript which just outputs "PIN:1234", but still doesn't
work. (the script is executable and works on the shell).

Thus, my first question is, what do I need to do to make this work. I
should work, right? And the second question is, what kind of service I
would have to setup, such that anybody can get some files prepared on
that server, with the minimum hassle of typing pincodes.

Thanks,

-- 
Chris


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
