Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20071029191950.f9f17f16.vientito1@pppoe.ca>
References: <20071029191950.f9f17f16.vientito1@pppoe.ca>
Date: Wed, 31 Oct 2007 17:23:01 +0100
Message-Id: <1193847781.32459.47.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Error 22 when configurating device
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

Hi Billy,

> I am getting this error as i try to connect to my BH-600 headset on a BCM2045 USB dongle.  as i check out the pcm_bluetooth.c, i realize the error comes up from the fact of checking received packet.  I am wondering what's up with this.
> 
> BTW I see an audio.conf file in my audio directory but it never gets installed in my system.  what is this file and its usage?
> 
> And error 22 signifies what kind of a problem?  where could i find protocol documentation of this?

check the syslog and include the output of hcidump -X -V.

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
