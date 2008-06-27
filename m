Return-Path: <cyrus@holtmann.org>
From: Alok <alokbarsode@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
	Jui-Hao Chiang <windtracekimo@gmail.com>
In-Reply-To: <loom.20080627T135650-469@post.gmane.org>
References: <loom.20080627T113221-342@post.gmane.org>
	<1214568439.9706.8.camel@greatbear>
	<loom.20080627T135650-469@post.gmane.org>
Date: Fri, 27 Jun 2008 20:28:43 +0530
Message-Id: <1214578723.9706.19.camel@greatbear>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Questions about SCO support hci_usb
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, 2008-06-27 at 14:17 +0000, Jui-Hao Chiang wrote:
> > 
> > The patch was for hci_usb.c. Me and Whoopie had tested it for 2
> > simultaneous SCO connections. If your using hci_usb, you will need the
> > alternate setting patch.
> > 
> > -Alok.
> > >   
> 
> Thanks, Alok.
> I have found it in 2.6.24 kernel source by setting BT_HCIBTUSB=m (BT_HCIUSB=n).
> One more question: 
> how do you test it for 2 simultaneous SCO?
> If I use the multy_connect_mode() function in bluez-utils/test/scotest.c.
> it just fork() several process, and each of them do the following:
>   sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
>   bind(sk, ...)
>   connect(remote device...)
IIRC i had just used scotest.  

> But it doesn't do anything with HandsFree Profile in my cell phone.
I read your earlier post. I am a bit confused on what are u trying to
achieve. BlueZ only supports AG(audio Gateway) role at the moment. Also
most phones support only AG role, so in your case which device acts as
the Hands Free device? 


> If you have some other sample source code you are using, I would appreciate that
> you can share some with me.
nope. I just used scotest.


-Alok.
> Bests
> 
> 
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
