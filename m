Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Data across Bluetooth Connection - Not file transfer
References: <20040318065836.9531.qmail@web40704.mail.yahoo.com>
In-Reply-To: <20040318065836.9531.qmail@web40704.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403180939.06022.pavouk@pavouk.org>
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
Date: Thu, 18 Mar 2004 09:39:05 +0100

Hello,

> I want to know how data maybe sent across an established bluetooth
> connection?
> I actually want to keep checking if a particular message  (possibly in
> the header or something) has been recieved over the bluetooth
> connection and do a corresponding action (possibly run a program) when
> that happens.

I don't know if I exactly understand your needs.
When you have running PAND server and other side try to make PAN connection,
that kernel calls HOTPLUG with NET ADD action and you can automatically 
configure BNEP0 interface or do some other action, what do you want.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
