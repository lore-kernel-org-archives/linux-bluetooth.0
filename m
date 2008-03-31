Return-Path: <cyrus@holtmann.org>
Message-ID: <47F059B9.5030003@aircable.net>
Date: Mon, 31 Mar 2008 00:25:45 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>
	<B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>
In-Reply-To: <B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>
Subject: Re: [Bluez-devel] CreateProxy usage?
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

Hi Marcel,
> the proxy is what it is called. A proxy. So you need to have a  
> Unix,TCP or TTY server to connect to.
>   
Ok good, what would be a TTY server in this case? I can imagine a TCP
server, but a TTY server? Never heard of it.

Maybe it wasn't CreateProxy the one I should be using. I just need to
create an RFcomm port, and then wait until someone connects to it,
should I use createPort then?

Thanks,
Manuel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
