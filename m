Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B31B37.30202@conectiva.com.br>
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: GCC-4 Patch for btsco
References: <loom.20050617T115730-392@post.gmane.org>  <1119003833.8980.116.camel@pegasus>  <loom.20050617T124909-183@post.gmane.org> <1119006318.8980.126.camel@pegasus> <loom.20050617T133130-516@post.gmane.org> <42B31A2D.1020102@xmission.com>
In-Reply-To: <42B31A2D.1020102@xmission.com>
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
Date: Fri, 17 Jun 2005 15:49:27 -0300

Brad Midgley wrote:
> Guys,
> 
> Should we just require bluez-libs 2.11 or use hci_switch_role 
> conditionally? We seem to be very demanding :)

 Require a library version is a common pratice, I don't see
any problem with that.

 Pre-Processor conditional compile macros makes your code a bit
harder to understand and to mantain, it's not reasonable to
do that without a good reason.

 Well, my 2 cents. :)

-- 
Luiz Fernando N. Capitulino


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
