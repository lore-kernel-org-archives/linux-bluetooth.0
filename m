Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d7dffb480611280055g6409c2ica54f78d3666674b@mail.gmail.com>
References: <d7dffb480611280055g6409c2ica54f78d3666674b@mail.gmail.com>
Date: Sun, 03 Dec 2006 15:05:28 +0100
Message-Id: <1165154728.19590.51.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM connection problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

>     I am new to BlueZ, and i downloaded bluez stack and i am runnig
> test programs. I am running 'hstest.c'. It was working properly. It
> was successfully opening both rfcomm com & sco connection and
> audio(wave file) is redirecting to head set. But the problem is : 
> 
>        AT commands passed by headset are not captured at rfcomm
> socket. Means if i press headset button, as of i understood, it should
> sned 'AT+CKPD=200\r\n'. But it is not caputured at rfcomm socket in
> the program, in the same way even volume controls(AT+VGS/M) also. I am
> not able to get those AT commands from headset. Can anybody say where
> i am wrong. 

I have no idea on what you are trying to achieve or what's your problem.
So you must be more specific. However remember that hstest.c is a test
and example program and nothing you should use in production.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
