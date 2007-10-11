Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <84433307AD6F49AAA3B8E5985813AE1F@iMe>
References: <60E2CE9DAF064501A26FC14E3A38A8AC@iMe>
	<1191930912.6128.1.camel@aeonflux.holtmann.net>
	<84433307AD6F49AAA3B8E5985813AE1F@iMe>
Date: Thu, 11 Oct 2007 10:29:39 +0200
Message-Id: <1192091379.6537.31.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How many Read_Remote_Bluetooth_name
	at	thesame	time?
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

Hi,

> Ok, them can I search for devices and get both their names and addresses at 
> the same time?

if you have Bluetooth 2.1 hardware, then yes, otherwise, no.

> It's strange because when I call the functions myself ( get the devices then 
> foreach of them get the name) it takes more time than e.g. Microsoft 
> bleutooth stack to find the devices and the names..!
> Is there something  I don't understand in here?

Use the D-Bus API for discovery here. It will do the name resolving for
you in the most efficient way. It also caches names for you. Example
code is in the wiki and the bluez-gnome package.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
