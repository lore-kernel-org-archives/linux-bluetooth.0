Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Max <spamhole@gmx.at>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez and D-Link DBT-120
Message-ID: <20040404181317.GA962@venus>
References: <20040403190647.GA16596@venus> <1081073362.2839.29.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1081073362.2839.29.camel@pegasus>
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
Date: Sun, 4 Apr 2004 20:13:17 +0200

On Sun, Apr 04, 2004 at 12:09:23PM +0200, Marcel Holtmann wrote:

Hello Marcel,

> disable CONFIG_BT_HCIUSB_SCO in your kernel config.

I have checked in my current .config, and it is disabled:

max@venus:~$ zcat /proc/config.gz | grep BT_HCIUSB  
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set

Any ideas?

thanks for your reply,
Max



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
