Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <fc3d922d0708290244o2f4be49cv4063e8a70239522@mail.gmail.com>
References: <fc3d922d0708290244o2f4be49cv4063e8a70239522@mail.gmail.com>
Date: Wed, 29 Aug 2007 11:47:15 +0200
Message-Id: <1188380835.6109.33.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Pin Authentication
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

> I want to configure my computer, that accepts connection with some
> defined default PIN.
> How I should configure hcid.conf?
> What I should insert in security , auto, none, or user.
> Should I use passkey "1234" or maybe pin_helper /usr/bin/bluepin , and
> bluepin is file with 1234. 
> Should I set maybe something else?

if you use a default PIN, then you also can use no PIN at all. Anyway
starting with BlueZ 3.x you need a passkey agent.

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
