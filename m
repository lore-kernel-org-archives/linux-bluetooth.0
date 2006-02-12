Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Benjamin Eikel <benjamin@eikel.org>
Message-ID: <loom.20060212T160856-775@post.gmane.org>
References: <200602022157.52386.benjamin@eikel.org> <loom.20060205T233729-763@post.gmane.org> <loom.20060209T124135-748@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Pairing a bluetooth keyboard
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
Date: Sun, 12 Feb 2006 15:17:11 +0000 (UTC)

>

With some hints from Patrik Kullman (his page: http://linux.yes.nu/diNovo/) I
got it working. It was easier than expected. I just enabled authentication and
encryption in the 'hcid.conf'. After that I restarted the Bluetooth system
(Debian: '/etc/init.d/bluetooth restart'). I had a ssh connection from another
computer to be able to change the pin in '/etc/bluetooth/pin'. I used a script
as pin helper which just outputs the content of this file with the prefix
'PIN:'. I wrote a random number into the pin file and hit a button on the
bluetooth keyboard. The keyboard tried to connect to the computer and I typed
the random pin from the pin file on the keyboard and hit enter. Then the
keyboard was connected. I did the same with the keypad. At last I did it with
the mouse and used the pin '0000'. At first this did not seem to work with the
mouse. I pressed the connect button under the mouse and did a 'hidd --connect
<mouseaddr>' by hand and then it worked too. Now 'hcitool con' shows that all
three connections are authorized and encrypted. Nice! :-)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
