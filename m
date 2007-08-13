Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
Date: Mon, 13 Aug 2007 19:06:13 +0200
Message-Id: <1187024773.6698.217.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
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

Hi Frederic,

> > Certainly a very stupid question : but how do we get started using
> > the 
> > brand new A2DP support ? - for me it seems that it still favors sco over 
> > a2dp :-(
> 
> I modified the test-audio python script to get something like this:
> Look at your syslog to see what happen.
> I then got my headset connected and could hear something ;) 

once you called CreateDevice (which is needed only once), you can
actually press a button on the headset and it should re-connect and you
can play music.

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
