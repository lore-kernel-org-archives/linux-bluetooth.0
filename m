Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Moritz Bunkus <moritz@bunkus.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040528180635.GA20450@bunkus.org>
References: <20040528154111.GD24083@bunkus.org>
	 <1085766449.3321.50.camel@pegasus>  <20040528180635.GA20450@bunkus.org>
Content-Type: text/plain
Message-Id: <1085770308.4516.3.camel@pegasus>
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
Date: Fri, 28 May 2004 20:51:48 +0200

Hi Moritz,

> > Send us the binary versions of the dump (with -w and as root).
> 
> Sure, here it comes. This has been done on the 2.6.6-mh2 with
> bluez-utils 2.7-2. This time I've waited until obexpush times out, so
> the complete communication has been captured.

you must make sure the you don't have a previous dumpfile while using
hcidump -w, because it will append the HCI commands and events.

However I don't see any data communication on the RFCOMM channel and
that indicates that something is going wrong here. Please checkout the
CVS repository obex and try the btobex tool from there.

> BTW: You don't have to CC me as I've subscribed.

I always use "Reply to All" button. So it is the job of your mailserver
to filter out the duplicates. Mine does ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
