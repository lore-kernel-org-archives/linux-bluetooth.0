Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 26 Feb 2016 00:29:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aar@pengutronix.de
Cc: linux-bluetooth@vger.kernel.org
Subject: re: 6lowpan: iphc: add support for stateful compression
Message-ID: <20160225212921.GA439@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Alexander Aring,

The patch 5609c185f24d: "6lowpan: iphc: add support for stateful
compression" from Feb 22, 2016, leads to the following static checker
warning:

	net/6lowpan/iphc.c:815 lowpan_compress_ctx_addr()
	warn: signedness bug returning '(-22)'

net/6lowpan/iphc.c
   812          }
   813  
   814          WARN_ON_ONCE("context found but no address mode matched\n");

This isn't correct.  WARN_ON_ONCE() takes a condition argument, not a
string.  It should be:

	WARN_ONCE(1, "context found but no address mode matched\n");

   815          return -EINVAL;
                ^^^^^^^^^^^^^^
This is a u8 function and none of the callers check for error.

   816  out:
   817  
   818          if (sam)
   819                  return lowpan_iphc_dam_to_sam_value[dam];
   820          else
   821                  return dam;
   822  }

regards,
dan carpenter
