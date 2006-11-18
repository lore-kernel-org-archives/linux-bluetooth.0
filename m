Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455EDA23.5020003@free.fr>
Date: Sat, 18 Nov 2006 11:02:11 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr>
	<ef9938ec0611161238p63da651dr497c04024c8ecbb7@mail.gmail.com>
In-Reply-To: <ef9938ec0611161238p63da651dr497c04024c8ecbb7@mail.gmail.com>
Subject: Re: [Bluez-devel] SCO on bluez : some architectural tips
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

Hi Albert,

>>  * The unix socket between application and the daemon would queue some
>> data, which would add unwanted delay.
> 
> just curious, was setvbuf( fp, NULL, _IONBUF, 0 ) to disable socket
> buffering an option?
> 

In our case we use direct read/write calls from socket descriptor, which 
means that setvbuf is useless, as it works at libc layer.

Good try anyway ;-)

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
