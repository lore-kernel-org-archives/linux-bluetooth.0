Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDGEEDCAAA.leiyu@kcoe.cn>
References: <EJENLMBEOLKAMCJFBFMDGEEDCAAA.leiyu@kcoe.cn>
Date: Wed, 08 Aug 2007 16:08:36 +0200
Message-Id: <1186582116.20129.92.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] how to change the attribute of bluetooth dongle
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

Hi Leiyu,

> it can active the bluetooth dongle that I run the command  "hciconfig hci0 up" , I  can use "hciconfig -a " to see its parameter , but how to change its parameter,
> for example ,change the device's name or other parameters?

you can use hciconfig to do that. Check the manual page for details. The
better way is to use the D-Bus API for BlueZ. Check the Wiki pages for
details. Also the UI tools from bluez-gnome use this API.

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
