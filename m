Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm: Wrong number of parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: frasnet <frasnet78@vodafone.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <002901c4385a$651cb9d0$4a8fe00a@yourygynwf3o8h>
References: <002901c4385a$651cb9d0$4a8fe00a@yourygynwf3o8h>
Content-Type: text/plain
Message-Id: <1084398043.25099.113.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 23:40:43 +0200

Hi,

> hi, I have a little problem with rfcomm. I use a slackware 9.1,
> rfcomm-0.8.tar.gz when I write the comand "rfcomm bind /dev/rfcomm0
> 00:0A:28:A8:F5:10 0" I have this error "Wrong number of parameters."
>  
> root@darkstar:~# rfcomm bind /dev/rfcomm0 00:0A:28:A8:F5:10 0
> Wrong number of parameters.
> root@darkstar:~#

read the text on my old rfcomm webpage and it clearly states that you
must not install rfcomm-0.8. Use the rfcomm utility that comes with the
bluez-utils packages.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
