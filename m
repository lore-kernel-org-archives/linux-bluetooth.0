Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm: Connection Refused
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <430E0AF9.4050502@gmx.de>
References: <430E0AF9.4050502@gmx.de>
Content-Type: text/plain
Message-Id: <1124996959.8019.70.camel@pegasus>
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
Date: Thu, 25 Aug 2005 21:09:19 +0200

Hi Johannes,

> I'm having trouble with Bluez. I think I'm almost there, however. Here's
> the description:

run "hcidump -X -V" of your connection attempt.

> And I have paired my PC with my Sony Ericsson K700i Cellular Phone:
> 
> # hcitool scan
> Scanning ...
>         00:0E:07:A7:7E:D2       K700i
> # hcitool cc 00:0E:07:A7:7E:D2
> # hcitool auth 00:0E:07:A7:7E:D2
> # hcitool dc 00:0E:07:A7:7E:D2

Who cares about this commands? These are for testing and development
only.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
