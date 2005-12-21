Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051221084109.16160.qmail@web36107.mail.mud.yahoo.com>
References: <20051221084109.16160.qmail@web36107.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1135163495.26233.58.camel@localhost>
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
Date: Wed, 21 Dec 2005 12:11:35 +0100

Hi Swathi,

> I have installed all the bluez-packages and bt_sco
> module as a root. All the commands which are trying to
> establish a connection to my headset are being
> executed as a root. I login with root privilages and
> at this point if 
> 
> i check the status of hcid it was showing as stopped.
> (below output)
> ------------------------------------------------------
> [root@localhost /]# /etc/init.d/bluetooth status
> hcid is stopped
> sdpd (pid 1725) is running...
> ------------------------------------------------------
> 
> So i restarted the bluetooth and for the first time i
> got the below msg
> ------------------------------------------------------
> [root@localhost /]# /etc/init.d/bluetooth restart
> Stopping Bluetooth services:                          
>     [FAILED]
> Starting Bluetooth services:                          
>     [  OK  ]
> ------------------------------------------------------
> 
> For the second time, i was able to successfully stop
> and start BT services
> ------------------------------------------------------
> [root@localhost /]# /etc/init.d/bluetooth restart
> Stopping Bluetooth services:                          
>     [  OK  ]
> Starting Bluetooth services:                          
>     [  OK  ]
> ------------------------------------------------------
> 
> cross checking the BT status again
> ------------------------------------------------------
> [root@localhost /]# /etc/init.d/bluetooth status
> hcid (pid 2743) is running...
> sdpd (pid 2745) is running...
> ------------------------------------------------------

check this with "ps x" as root. I don't trust it, because the hcidump
output is telling me something different. Show me also the output of
"hciconfig -a".

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
