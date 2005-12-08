Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART bluetooth chip problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134020677.3752.61.camel@blade>
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
Date: Thu, 08 Dec 2005 06:44:37 +0100

Hi Arthur,

> I am currently using a bluetooth chip by bluegiga (www.bluegiga.com),
> called WRAP THOR 2022-1-B2B. 
> I set the configurations on the chip so that it is running at 115200
> baud rate. After, I tried doing the following: 
> 
> # hcid
> # hciattach -s 115200 /dev/ttyS1 any 115200 flow
> # hciconfig
> hci0:   Type: UART
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN INIT RUNNING
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
> # hciconfig hci0 up
> Can't init device hci0: Connection timed out (145)
> 
> I checked and error code 145 indeed means Connection timed out on my
> header files (errno.h). 
> What might be wrong? 

first, you should ask you module manufacturer what chip they are using
and then what transport they use.

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
