Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN and bridge problem when bnep0 disconnects
	before bnep1
From: Diego Liziero <liziero.diego@unimore.it>
To: Christoph Scholz <scholz@cs.uni-bonn.de>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1084457228.6449.11.camel@igno>
References: <1084452714.2318.12.camel@willie.informatik.uni-bonn.de>
	 <1084457228.6449.11.camel@igno>
Content-Type: text/plain
Message-Id: <1084472563.3354.17.camel@igno>
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
Date: Thu, 13 May 2004 20:22:43 +0200

I've solved my issue.

Mine was just a bridge bug introduced in 2.6.6
and already solved.

http://lists.osdl.org/pipermail/bridge/2004-May/000321.html

Regards,

Diego.

On Thu, 2004-05-13 at 16:07, Diego Liziero wrote:
> Maybe I'm hitting a related bug.
> I'm trying to setup a PAN bridge with kernel 2.6.6-rc3-mm2
> with ipv6 enabled (same result with other 2.6 kernels) and when I try
> to add bnep1 to the bridge I got the following error:
> 
> # brctl addif pan0 bnep1
> br_add_interface: File exists
> 
> Everything works fine with 2.4.* kernels (without ipv6).
> 
> It seems like in linux-2.6.* + ipv6 it's impossible to have
> two bnep interfaces in the same bridge.
> 
> Any suggestion?
> 
> Regards,
> 
> Diego.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
