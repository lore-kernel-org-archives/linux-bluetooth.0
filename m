Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep devices
	with kernel 2.6.6-*
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Diego Liziero <liziero.diego@unimore.it>, bridge@lists.osdl.org,
   bluez-devel@lists.sourceforge.net
In-Reply-To: <20040518153608.707e1f81@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	 <20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	 <1084472140.3354.9.camel@igno> <1084788177.21864.54.camel@igno>
	 <20040518153608.707e1f81@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084986055.28151.263.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
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
Date: Wed, 19 May 2004 18:00:56 +0100

On Tue, 2004-05-18 at 15:36 -0700, Stephen Hemminger wrote:
> Hmm, since all the blue tooth devices have the same address.
> Deleting the first one will cause the entry in the forwarding table
> to be deleted, that might cause your problem.  Perhaps we need a
> reference count on the number of interfaces with the same address (yuck).

That seems like a reasonable answer. I believe there's also some
workstation hardware with multiple Ethernet devices, all sharing the
same MAC address (== hostid). It's not just Bluetooth. How does this
work with VLAN bridging?

Precisely what is it that's indexed on the interface's MAC address,
rather than the (index of the) physical interface itself?

-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
