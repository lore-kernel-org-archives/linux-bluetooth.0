Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <84433307AD6F49AAA3B8E5985813AE1F@iMe>
From: "Eng. Waleed S. Al-Rashoud" <iwaleed@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <60E2CE9DAF064501A26FC14E3A38A8AC@iMe>
	<1191930912.6128.1.camel@aeonflux.holtmann.net>
In-Reply-To: <1191930912.6128.1.camel@aeonflux.holtmann.net>
Date: Thu, 11 Oct 2007 01:56:48 +0300
MIME-Version: 1.0
Subject: Re: [Bluez-users] How many Read_Remote_Bluetooth_name at
	thesame	time?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Ok, them can I search for devices and get both their names and addresses at 
the same time?
It's strange because when I call the functions myself ( get the devices then 
foreach of them get the name) it takes more time than e.g. Microsoft 
bleutooth stack to find the devices and the names..!
Is there something  I don't understand in here?


----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Sent: Tuesday, October 09, 2007 2:55 PM
Subject: Re: [Bluez-users] How many Read_Remote_Bluetooth_name at thesame 
time?


> Hi,
>
>> If I'm gonna search for devices without their names, then request the
>> remote name for each device.. what is the maximum number of concurrent
>> Read_remote_bluetooth_name requests I can handle?
>
> it is exactly one. Every remote name request needs a baseband page and
> you can only have one of these at the same time. Otherwise you would
> need second radio.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
