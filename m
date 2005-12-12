Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth connection too slow
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134424744.8666.10.camel@localhost.localdomain>
References: <1133028275.9123.29.camel@localhost.localdomain>
	 <1133028830.28718.19.camel@blade>
	 <1133029672.9123.34.camel@localhost.localdomain>
	 <1133029959.15981.0.camel@blade>
	 <1134424744.8666.10.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1134430514.6919.10.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 13 Dec 2005 00:35:14 +0100

Hi Mario,

> I made several efforts in order to try different combinations of ppp
> parameters, but I didn't get any improvement: my ppp connection over
> bluetooth is still 3 times slower than in windows :(
> Now I'm trying to use different parameters for the terminal settings
> (over rfcomm). Just a question:
> If I set the speed of /dev/rfcomm0 to 1200 rather than 115200 or more,
> how does the driver react? Does it ignore the setting? What about other
> terminal settings (flow control, parity,...)

any baud rate change should be propagated with a RPN message, but maybe
the first one got lost and the phone things it is at 9600 which is the
default. Run "hcidump -X -V" for the connection and check if you find
any RFCOMM RPN messages at all. The RPN support hasn't been there all
the time. Make sure you use a recent 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
