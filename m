Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_read_rssi command
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060109092540.65589.qmail@web50506.mail.yahoo.com>
References: <20060109092540.65589.qmail@web50506.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1136909383.7200.11.camel@localhost.localdomain>
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
Date: Tue, 10 Jan 2006 17:09:42 +0100

Hi Mahtab,

> My project is to work with rssi/tpl/lq. My initial goal is to read
> them and show them graphically with some handy features!
> 
> I have gone through hcitool.c (most of the code) and tried to exactly
> copy the necessary things only to retrieve RSSI. But, I couldn't call
> "hci_read_rssi" as them. Compiling my program gave this error:
> 
> mySignalScan.c:102: warning: implicit declaration of function
> `hci_read_rssi'
> mySignalScan.c: At top level:
> /tmp/cc4x36ri.o(.text+0x25b): In function `cmd_rssi':
> : undefined reference to `hci_read_rssi'
> collect2: ld returned 1 exit status

looks like you need to install a newer bluez-libs package.

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
