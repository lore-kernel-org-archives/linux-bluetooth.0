Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Diego Liziero <liziero.diego@unimore.it>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org, bluez-devel@lists.sourceforge.net
In-Reply-To: <1084472140.3354.9.camel@igno>
References: <1084467136.3083.27.camel@igno>
	 <20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	 <1084472140.3354.9.camel@igno>
Content-Type: text/plain
Message-Id: <1084788177.21864.54.camel@igno>
Mime-Version: 1.0
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
Date: Mon, 17 May 2004 12:02:58 +0200

Thanks for your support.

I'm back with the "brige freezes when bluetooth bnep0 disconnects
before bnep1" issue.

As reported in the bluez-devel mailing list, in a bridge
called pan0 with the interfaces bnep0, bnep1, .. bnep6
connected, if the interface bnep6 is disconnected first,
everything works fine, but if bnep0 is disconnected before
the others, the bridge stops to work.

Arping from bnep1 to the brige results in just the first
answer received.

To make it work again I have to use the following dirty hack:
 brctl delif pan0 bnep1
 brctl addif pan0 bnep1

Someone in the bluez-devel mailing list told that also setting the
bridge in promiscuous mode with tcpdump makes the bridge
back to work.

Now I'm removing and re-adding all the bridge components
when hotplug detects that a "bnep?" device ceases to exist.

Any better solution?

Regards,
Diego

On Thu, 2004-05-13 at 20:15, Diego Liziero wrote:
> Sorry, I've been too quick in writing without realizing
> that the patch had been already posted to this mailing list.
> 
> This patch solved everything.
> 
> Thank you.
> 
> BTW, there is another issue that may be related to the bridge
> that is being discussed on bluez-devel mailing list:
> 
> http://thread.gmane.org/gmane.linux.bluez.devel/2160
> 
> Regards,
> 
> Diego
> 
> On Thu, 2004-05-13 at 19:28, Stephen Hemminger wrote:
> > 2.6.6 got too picky about multiple interfaces with the same
> > address. This patch has been already integrated for later releases.
> 



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
