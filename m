Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How can I use Bluez with 460800 kbps
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Moraes <ra002890@itelefonica.com.br>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4054022B.8090100@itelefonica.com.br>
References: <4054022B.8090100@itelefonica.com.br>
Content-Type: text/plain
Message-Id: <1079350483.3405.14.camel@pegasus>
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
Date: Mon, 15 Mar 2004 12:34:43 +0100

Hi Daniel,

> I would like to know if anybody here could use bluetooth casira with the 
> serial with speeds like 460800.
> I have to configure linux serial?!? What program I can use to do that?!?

if you have a serial port that can do high speeds than you only have to
give hciattach the right baud rate.

> And How can I transmit bits via rfcomm?!? I get a tutorial, but it 
> didn't worked well!!  Does anybody have a good tutorial, or a rapid 
> solution for me?!?

This is RFCOMM socket programming. Look at my latest slides or take a
look at attest.c from the bluez-utils package.

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
