Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200612191103.20942.thsuut@utu.fi>
References: <200612191103.20942.thsuut@utu.fi>
Date: Tue, 19 Dec 2006 10:39:14 +0100
Message-Id: <1166521154.29972.4.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm_sock_sendmsg with len==0 (in Linux 2.6.18)
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

Hi Tuomas,

> I've made a buffer for socket connections to use with C++ iostreams. 
> It's quite simple; just uses send and recv to fill and empty the buffer 
> when needed.
> 
> It worked fine for a while, but yesterday some strange errors occured 
> with it. After few hours of debugging I found that code responsible was 
> using syscall send() to Bluetooth socket with buffer length set to 0. 
> Problem was that I assumed it to return either -1 on error or 0 when 
> success, but instead it returned positive values sometimes. 
> 
> Ok, it was stupid calling send() with len==0 anyway, but still (at least 
> according to manual) send shouldn't return anything positive then. So I 
> traced what kernel code is responsible and found it's 
> rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c. It returns 
> uninitialized variable err, if called with len==0.
> 
> Simple fix is to initialize err to 0.

this would only hide the real problem. It should only return err if the
sent is still 0. The return statement is

	return sent ? sent : err;

And sent is initialized with 0 and if len is also zero it will never
enter the while loop and thus not modify sent at all.

Please add some printk to the code before and after the loop. Something
is really wrong on your side. I would suspect a compiler error.

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
