Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 2 Aug 2006 13:01:09 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1154488151.3905.34.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.63.0608021246050.6321@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0608011659100.2567@redbean.intranet.gw-instruments.de>
	<1154488151.3905.34.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Patch for rfcomm tty server ports
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


Hi Marcel, 

On Wed, 2 Aug 2006, Marcel Holtmann wrote:

> the idea of using BDADDR_ANY is kinda nice, but the use of another
> kernel thread for the listen RFCOMM socket within the RFCOMM module is
> not good. We need to integrate all the processing for the server state
> in the DLC itself.

I partially agree with you. The solution with the kernel thread is somehow 
"quick 'n dirty". The problem was that I got only a limited time to get 
this working and did not want to break anything. Currently, only a socket 
can wait for an incomming connection. It would be nicer if we can put this 
into the DLC itself, but this would require some more internal changes 
with a high risk of messing thinks up. 
 
> I am not gonna working on this, but I am supporting it and happy to
> review any patches.
Thank you. 
When my understanding of the internals gets better I'll try to work 
something out. 
 
Regards, 

Peter 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
