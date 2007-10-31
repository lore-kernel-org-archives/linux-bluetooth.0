Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <slrnficmht.ogv.matt@coleridge.tplus1.com>
References: <slrnficmht.ogv.matt@coleridge.tplus1.com>
Date: Wed, 31 Oct 2007 17:25:37 +0100
Message-Id: <1193847937.32459.50.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] I need help pulling photos off my phone
	with	bluetooth
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

Hi Matthew,

> I have a Samsung A707 phone with AT&T.  They call this the SYNC phone.
> Anyway, I can export photos off the phone when I boot into Windows, but
> all attempts to do this with my Ubuntu linux box have failed.

you might wanna include the output of hcidump -X -V when trying this.
However I am pretty sure that you have no passkey agent running or a
screwed up system. I would advise that you have a clean install or
better switch to something like Ubuntu Gutsy were all the needed tools
can be installed easily.

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
