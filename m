Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A319B5.9040100@bglug.it>
From: jimmi <jimmi@bglug.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] don't find the module "snd_bt_sco"
References: <20051216103855.90185.qmail@web36113.mail.mud.yahoo.com>
In-Reply-To: <20051216103855.90185.qmail@web36113.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 16 Dec 2005 20:47:01 +0100

Swathi Mathur80 ha scritto:
> I am unable to find the module "snd_bt_sco". Where can i find this module ?
> Do you think i might have made any mistake in any of the steps which are 
> executed before.
> Can anyone help me with this.

I also had some problem because the "make install" couldn't copy the module.

If it was compiled correctly by "make" you may find the module 
"snd-bt-sco.ko" under btsco/kernel

You shall create the directory "/lib/modules/KERNELVERSION/extra", where 
KERNELVERSION is the kernel that you booted, and copy inside it the 
module. After that "modprobe snd-bt-sco" should work correctly.

Jimmi


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
