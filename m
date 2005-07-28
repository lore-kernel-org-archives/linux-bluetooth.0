Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Wolfgang =?iso-8859-1?q?M=FCes?= <wolfgang@iksw-muees.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Kernel module for PCMCIA/CF Bluetooth cards with CSR chipset
References: <20050728030527.B34DB12FEB@sc8-sf-spam2.sourceforge.net> <Pine.LNX.4.60.0507281157380.15380@purdy.demon.co.uk>
In-Reply-To: <Pine.LNX.4.60.0507281157380.15380@purdy.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507281340.00164.wolfgang@iksw-muees.de>
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
Date: Thu, 28 Jul 2005 13:40:00 +0200

On Thursday 28 July 2005 13:10, andy thomas wrote:
>    # hciattach ttyS1 bcsp 19200 flow

ommit the baud rate and the "flow" parameter. It is done automaticly.
Baud rate is set to 230K. Other won't work.

best regards
Wolfgang


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
