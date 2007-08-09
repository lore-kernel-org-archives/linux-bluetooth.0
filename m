Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDEEEECAAA.leiyu@kcoe.cn>
References: <EJENLMBEOLKAMCJFBFMDEEEECAAA.leiyu@kcoe.cn>
Date: Thu, 09 Aug 2007 08:45:55 +0200
Message-Id: <1186641955.20129.160.camel@violet>
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

> It is same as the information of hcid.conf  that the command " hciconfig -a" display the attribute in PC linux,
> But I have a try in embedded linux, it is not same as the information of hcid.conf, although I call "hcid -f hcid.conf ", it looks like calling "hcid" command has no effect
> How to let the attribute be same as that listing in hcid.conf? 

actually /var/lib/bluetooth/<bdaddr>/config can overwrite any setting in
hcid.conf. The hcid.conf are the defaults, but they must not stay as
that. Actually you should never touch hcid.conf unless you are really
know what you are doing.

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
