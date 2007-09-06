Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Marco Milanesi <marco.milanesi@iaki.it>
In-Reply-To: <20070906113357.be276256.marco.milanesi@iaki.it>
References: <20070906105703.d2e79f4d.marco.milanesi@iaki.it>
	<1189070433.7318.26.camel@aeonflux.holtmann.net>
	<20070906113357.be276256.marco.milanesi@iaki.it>
Date: Thu, 06 Sep 2007 11:53:37 +0200
Message-Id: <1189072417.7318.36.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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

> > wild guess is that you used the wrong RFCOMM channel number. Make sure
> > you use the Object Push channel retrieved via SDP and not some static
> > magic. If the phone requires a PIN you can't do anything about it.
> 
> that was it! at least... partially. now operating on obex push channel (I didn't knew that there was a specific channel for PUSH) I can approve the file receving from the mobile, but obex prints this strange error:
> root@myhost:/home/kpanic# obexftp -b 00:02:EE:46:5F:32 -B 9 -p image.jpg 
> Browsing 00:02:EE:46:5F:32 ...
> Channel: 10
> Connecting...failed: FBS UUID
> Still trying to connect
> Connecting...failed: FBS UUID
> Still trying to connect
> Connecting...failed: FBS UUID
> Still trying to connect
> 
> I'm noticing that also that I use -B 9 but Channel 10 is used, weird

use the OpenOBEX mailing list for any OBEX questions.

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
