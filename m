Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stephen Hemminger <shemminger@osdl.org>
To: Diego Liziero <liziero.diego@unimore.it>
Cc: bridge@lists.osdl.org, bluez-devel@lists.sourceforge.net
Message-Id: <20040518153310.6ca39ef5@dell_ss3.pdx.osdl.net>
In-Reply-To: <1084788177.21864.54.camel@igno>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno>
	<1084788177.21864.54.camel@igno>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 18 May 2004 15:33:10 -0700

On Mon, 17 May 2004 12:02:58 +0200
Diego Liziero <liziero.diego@unimore.it> wrote:

> Thanks for your support.
> 
> I'm back with the "brige freezes when bluetooth bnep0 disconnects
> before bnep1" issue.
> 
> As reported in the bluez-devel mailing list, in a bridge
> called pan0 with the interfaces bnep0, bnep1, .. bnep6
> connected, if the interface bnep6 is disconnected first,
> everything works fine, but if bnep0 is disconnected before
> the others, the bridge stops to work.
> 
> Arping from bnep1 to the brige results in just the first
> answer received.
> 
> To make it work again I have to use the following dirty hack:
>  brctl delif pan0 bnep1
>  brctl addif pan0 bnep1
> 
> Someone in the bluez-devel mailing list told that also setting the
> bridge in promiscuous mode with tcpdump makes the bridge
> back to work.
> 
> Now I'm removing and re-adding all the bridge components
> when hotplug detects that a "bnep?" device ceases to exist.
> 
> Any better solution?
> 
> Regards,
> Diego

Sounds like an issue with how the bnep does promiscious mode.
Do you see messages on the console like:
	device bnep0 left promiscious mode

Also, the bnep driver seems to need BT_BNEP_MC_FILTER enabled
to do multicast.  

When you remove bnep0 first, what does "brctl showstp pan0" show?




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
