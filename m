Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070906105703.d2e79f4d.marco.milanesi@iaki.it>
References: <20070906105703.d2e79f4d.marco.milanesi@iaki.it>
Date: Thu, 06 Sep 2007 11:20:33 +0200
Message-Id: <1189070433.7318.26.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] pin less obex file transfer
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

Hi Marco,

>     I have the need to transfer files from PC to mobile without inserting the pin code in the mobile.
> 
> it has to be done only via command line, I have tried to disable in /etc/bluetooth/hcid.conf the param:
> 
>     - security none
> 
> with no success (it always asks the pin number)
> 
> as a side note, with kfbtobex kde graphic application I was able to transfer file without authentication to the mobile

wild guess is that you used the wrong RFCOMM channel number. Make sure
you use the Object Push channel retrieved via SDP and not some static
magic. If the phone requires a PIN you can't do anything about it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
