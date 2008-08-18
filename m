Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2342E2FF-BAE3-4236-8E9C-AF2F9DAFB0BD@soe.ucsd.edu>
References: <2342E2FF-BAE3-4236-8E9C-AF2F9DAFB0BD@soe.ucsd.edu>
Date: Mon, 18 Aug 2008 07:12:34 +0200
Message-Id: <1219036354.7591.17.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How to turn off advertised SDP services?
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

Hi Ricky,

> When I do a 'sdptool browse local' I see a list of advertised services  
> such as "Headset Audio Gateway", "AVRCP TG", "Audio Source" and etc.   
> I remember there /used/ to be service conf files that I can control  
> which services are on/off, but I can't find them any more.  It is  
> possible to "sdptool remove" the services, but they come back after  
> reboot...
> 
> I am wondering how to turn them off for good.

for the audio services look at /etc/bluetooth/audio.conf and check the
Disable or Enable section of the services.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
