Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 24 Jul 2006 10:38:24 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060724103824.1ff98fa6@McGee-XPC>
In-Reply-To: <2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
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

Hi Fabrizio,

i'm working on a possibly related problem. Could you check the hcidump of
your situation and look out for apparently unmotivated hci_reset
commands sent to your device? 

Greetings & TIA

Andy

On Sat, 22 Jul 2006 16:08:08 +0200
Fabrizio Guglielmino <guglielmino@infitsrl.com> wrote:

> Hi all,
> I made some investigation about the BtOBEX_TransportConnect signaled  
> to the list and Marcel some days before.
> Openobex isn't involved in the problem, in my try I've writed from  
> scatch a simple obex push client (not using openobex but only
> socket).
> In my test I found this : if there are two thread (also two process)  
> making something like
> 
>   ...
>   ret = connect(fd, (struct sockaddr *)dst, sizeof(struct sockaddr_rd));
>   ...
> 
> in simultaneous way the second always fail (return -1). I've also  
> tryed to "protect" the connect using a mutex and all works
> but (naturally) second connection result conditioned to the frist  
> (syncronous so thread it is not useful).
> 
> I think there is some solution to this but I don't know if it's using  
> some ioctl on socket (nonbloking?) or some hci command to adapter.
> Please can some one give me some hint?
> 
> I'm looking at kernel source related to rfcomm (/usr/src/ 
> linux-2.6.116/net/bluetooth/rfcomm/*.c) but I'm not sure the problem  
> reside here...
> 
> 
> thanks, bye
> Fabrizio 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
