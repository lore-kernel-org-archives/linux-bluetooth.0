Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <7255BF0C8B1D6E409EB51F386145DD9E1258C64A27@teo00208.de.t-online.corp>
References: <mailman.24195.1189073979.21972.bluez-users@lists.sourceforge.net>
	<7255BF0C8B1D6E409EB51F386145DD9E1258C64A27@teo00208.de.t-online.corp>
Date: Thu, 06 Sep 2007 14:42:51 +0200
Message-Id: <1189082571.7318.37.camel@aeonflux.holtmann.net>
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

> I compiled an installed fine from http://bluetooth-alsa.sourceforge.net/build.html
> 
> ...and got the a2dpd up and running.
> 
> Also added the SDP records:
>         sdptool add A2SRC
>       sdptool add AVRTG
> 
> I can connect to the service from my windows laptop, but not from my cellphone and in either case, theres no sound on the Computer. Pairing etc. worked fine.
> 
> How do I play music from the cellphone to the linux-box? Theres a lot of HOWTOs the other way round but not this way.

there is no point in playing with a2dpd anymore. Use the new audio
service that has around for a couple of releases now.

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
