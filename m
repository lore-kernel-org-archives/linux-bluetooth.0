Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A940EF.6040907@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BT-Sco
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com>	<20041123070621.50569968.henryk@ploetzli.ch>	<41A3471C.4000602@xmission.com> <20041123203836.046fb4f4.henryk@ploetzli.ch> <41A3ACE2.4030501@xmission.com> <41A74FE0.6020006@suche.org>
In-Reply-To: <41A74FE0.6020006@suche.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 27 Nov 2004 20:07:27 -0700

Thomas,

> here is an optimized version of btsco.c it es rewriten for Linux only.
> Is does not need libbluetooth or libasound.
> It is event driven but currently use fixed MAC
> 
> Any idea's are welcomed.

I finally looked at this. You've put some time into it I can see. If you 
look at the bug list at our sourceforge page, you'll see we actually 
want stronger ties to alsa libs (possibly using their userspace driver). 
Working toward multiple headsets is good but if the struct is global 
it's a missed opportunity.

I can understand the approach Linus takes to patches. He likes 
incremental patches that solve a single well-defined problem. It's 
easier to look for correctness.

You should choose one of the many problems with what we've got, discuss 
it here, and take a shortest-distance approach to solving it.

The unconventional stuff like "{{{" and "if(-1 == ioctl(...))" work fine 
but distract the reader from what the code is doing. After all, this 
stuff has to be read by people, not just the compiler.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
