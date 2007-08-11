Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c1fa8edf0708051322s1a14f64u4f6b98402a82c021@mail.gmail.com>
References: <c1fa8edf0708051322s1a14f64u4f6b98402a82c021@mail.gmail.com>
Date: Sat, 11 Aug 2007 20:26:15 +0200
Message-Id: <1186856775.6698.46.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] refactor cleanup code in hidd main.c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Simon,

> This is an almost entirely cosmetic patch to hidd's main.c that moves
> some duplicated close()/exit() calls to the end of their respective
> functions, replacing them with gotos.

nice cleanup, but I don't see the advantage of it and hidd is basically
end of life anyway. Focus is on the Bluetooth input service.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
