Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Shell script during bluetooth connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040310124449.40181.qmail@web40704.mail.yahoo.com>
References: <20040310124449.40181.qmail@web40704.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1078923303.2537.33.camel@pegasus>
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
Date: Wed, 10 Mar 2004 13:55:04 +0100

Hi Lalith,

> I want to execute a shell script whenever a bluetooth connection is
> established. I am connecting between two computers using USB Dongles. I
> have RedHat Linux 9 with 2.4.20-8 kernel. I am using the bnep
> interface. I have already set up the ifcfg-bnepX files for that... but
> I can't put the script there as it wont be an executable file there...

I don't use RedHat, but in general there is not a big difference between
an executable file and an executable shell script. It is important that
the script is mode 755. However you can also put your script directly
into /etc/hotplug/net.agent.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
