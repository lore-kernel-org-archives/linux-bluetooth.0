Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <7255BF0C8B1D6E409EB51F386145DD9E1258C64A28@teo00208.de.t-online.corp>
References: <mailman.24195.1189073979.21972.bluez-users@lists.sourceforge.net>
	<7255BF0C8B1D6E409EB51F386145DD9E1258C64A27@teo00208.de.t-online.corp>
	<1189082571.7318.37.camel@aeonflux.holtmann.net>
	<7255BF0C8B1D6E409EB51F386145DD9E1258C64A28@teo00208.de.t-online.corp>
Date: Thu, 06 Sep 2007 15:07:02 +0200
Message-Id: <1189084022.7318.40.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] A2DP - Play Music from Cellphone to Computer,
	any hints?
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

Hi Christian,

> This might sound stupid, but I thought a2dpd was the "new service".
> As I read on  http://bluetooth-alsa.sourceforge.net/build.html.
> 
> Could you point me to the right direction / show me where to read?

check wiki.bluez.org. Simply use --enable-audio with the lastest
releases and the new audio service will be build. The Bluetooth-ALSA
project is dead. We are moving code over to BlueZ.

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
