Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Optical Desktop Elite for
	Bluetooth	and dual booting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43E0F8F7.9070009@gmail.com>
References: <43E09717.4040405@gmail.com>
	 <1138812167.3806.1.camel@localhost.localdomain>
	 <43E0F8F7.9070009@gmail.com>
Content-Type: text/plain
Message-Id: <1138821481.3806.21.camel@localhost.localdomain>
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
Date: Wed, 01 Feb 2006 20:18:01 +0100

Hi John,

> And thanks for your quick reply. Having watched some replies in this 
> mailing list I totally agree that transferring the link key from one OS 
> to the other can be difficult.
> 
> So, let's get back on the first solution: since sometimes I can use my 
> keyboard in Linux, I suppose my device is sometimes paired, right? If 
> not, which commands exactly I have to use? Then, how to write the link 
> key to the bluetooth chip? Could you make an example of the command 
> hciconfig for writing this key to the chip?

use "hciconfig hci0 putkey ..." after you paired your keyboard with your
Linux machine.

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
