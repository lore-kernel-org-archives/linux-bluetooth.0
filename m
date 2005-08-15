Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <dc98d8d905081422386b5a5ae2@mail.gmail.com>
From: Paul Webster <pjwebster@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A8C@netbe01.net.unimis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E64BAD5A8AD46740828069A678D9DD73011A8C@netbe01.net.unimis>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Aug 2005 15:38:33 +1000

>      You are right about BlueZ was not initilized. After I force define M=
ODULE in
> af_bluetooth.c , creating bluetooth socket using hciconfig is OK. But com=
mand "hciconfig
> -a" still can't read the bluetooth USB dongle information.

What about "hciconfig -a hci0"?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
