Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDCEEKCAAA.leiyu@kcoe.cn>
References: <EJENLMBEOLKAMCJFBFMDCEEKCAAA.leiyu@kcoe.cn>
Date: Fri, 24 Aug 2007 14:11:01 +0200
Message-Id: <1187957461.15402.144.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] it meet one problem when receiving large file
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

> My embedded device run bluez and I use PC to send file  to it.  
> When the file  PC send is large (more than 20M), PC prompts "Send object fail" at last.  In fact the embedded device receive the file successfully too.
> If PC send small size file ,it does not meet the problem , PC prompts "send object ok",  
> Could anyone help me to solve it? 

if you see no kernel errors with dmesg or in syslog, then this is
probably an OpenOBEX or obexftpd issue and not a BlueZ fault. Use their
mailing list.

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
