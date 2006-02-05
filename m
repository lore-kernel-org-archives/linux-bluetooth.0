Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Benjamin Eikel <benjamin@eikel.org>
Message-ID: <loom.20060205T233729-763@post.gmane.org>
References: <200602022157.52386.benjamin@eikel.org>
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
Date: Sun, 5 Feb 2006 22:47:17 +0000 (UTC)

I have an addition: I tried to set up the encryption at my desktop system. There
I have a Logitech diNovo Media Desktop 2.0. I first connected all three devices
(mouse, keyboard, media pad). Then I called the 'hcitool auth <address>' command
for the media pad. On the display of the media pad I was asked for the pin
number and after I entered it on the pad and the computer, 'hcitool con' showed
that the connection had the flag AUTH. After that I called 'hcitool enc
<address>' and the media pad connection got the additional flag ENC. So I think
I succeeded in setting up an encrypted connection for it.
After that I tried the same procedure with the keyboard, but I got the same
error output and log as on my notebook.
I use the same operating system and the same versions of the utils and libs on
my desktop. The configuration file was the same too. I am using the Logitech
bluetooth hub which came with the set there.

Does anybody has an explanation for it? I have not found any HOWTO or
documentation about setting up encryption with Bluez. Perhaps you have a hint or
can tell my what I am doing wrong.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
