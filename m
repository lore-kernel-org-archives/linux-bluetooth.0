Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B1DE9B.5020607@conectiva.com.br>
References: <42B1DE9B.5020607@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1118957189.8980.102.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] - Fixes hcitool error code on memory allocations.
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
Date: Thu, 16 Jun 2005 23:26:29 +0200

Hi Luiz,

> This patch adds proper error code and message for memory allocations
> errors in hcitool program.
> 
> Comments are welcome.
> 
> tools/hcitool.c |   72 +++++++++++++++++++++++++++++++++++++-------------------
> 1 files changed, 48 insertions(+), 24 deletions(-)

applied. Thanks.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
