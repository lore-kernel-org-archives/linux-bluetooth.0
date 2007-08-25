Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Tom Allebrandi" <tom@ytram.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
References: <c669a7c70708240036j38c8f42bhdcdb5ee15a8ae4be@mail.gmail.com>
	<1187943850.15402.129.camel@violet>
In-Reply-To: <1187943850.15402.129.camel@violet>
Date: Sat, 25 Aug 2007 12:26:45 -0700
Message-ID: <000001c7e74d$e4e21bb0$aea65310$@com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] problem in parking device. bluez-libs 3.14,
	bluez-utils-3.14
Reply-To: tom@ytram.com, BlueZ users <bluez-users@lists.sourceforge.net>
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

-----Original Message-----
> the park mode support is always complicated. I would advise you to not
> support it. Especially with non CSR based chips. However you have to run
> hcidump -X -V to see what is really going on.

I would echo Marcel's comments. Use of Park Mode is generally discouraged
and at some point in the future there's a decent chance that Park Mode will
be deprecated.

Because of this, many of the devices that you might try to connect to may
support Park Mode but not enable it. You are much better off making sure
that Sniff Mode is working -- if your application needs to care.

--- tom
tom allebrandi
tom@ytram.com



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
