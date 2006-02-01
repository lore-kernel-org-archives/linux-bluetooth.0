Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Optical Desktop Elite for Bluetooth
	and dual booting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43E09717.4040405@gmail.com>
References: <43E09717.4040405@gmail.com>
Content-Type: text/plain
Message-Id: <1138812167.3806.1.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 01 Feb 2006 17:42:47 +0100

Hi John,

> For the last past months I have been searching for a way to use my 
> bluetooth keyboard and mouse in both Windows and Linux with no luck. 
> Most of times I wasn't able to choose Linux with GRUB since the keyboard 
> wasn't working during booting and if I was working in Linux, on the next 
> boot in Windows, I had to re-authenticate my keyboard in order to work.
> 
> So, I have to ask one last time before I get another keyboard and mouse: 
> Is there any way to properly use my desktop set in both OSes?
> 
> Please don't tell me to search anywhere to find a solution. If you have 
> a suggestion, just write it as explicitly as possible. I promise to 
> write a guide for bluetooth keyboards and dual booting if I finally find 
> a solution.

pair your device with Linux and then write the link key to the Bluetooth
chip with hciconfig. After that it should be possible to use the device
in both operating systems.

It is of course also possible to transfer the link keys between both
operating systems, but this can get very ugly.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
