Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Porting bluez onto different embedded systems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051202121947.73018.qmail@web36108.mail.mud.yahoo.com>
References: <20051202121947.73018.qmail@web36108.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133528475.20834.46.camel@blade>
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
Date: Fri, 02 Dec 2005 14:01:15 +0100

Hi Swathi,

> I doing research on porting the powerful bluetooth stack, bluez onto
> different embedded systems. I went through the questions which were
> being asked on porting bluez onto different embedded systems. Some of
> the developers have said it is possible to port bluez onto different
> platforms but it involves a lot of modifications have to be done. Can
> someone provide me with useful links or informations which will be
> helpful in porting bluez onto different OS.
> All the comments are welcome as it will be helpful in doing my
> research.

I think that it is badly spent time even trying to port it. Everything
of BlueZ inside the kernel is fully kernel specific and the Bluetooth
library depends on the interfaces offered by the Bluetooth subsystem
inside the kernel. However feel free to try porting it, but keep in mind
the every line of code is GPL and that any port must be GPL, too.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
