Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Aug 2014 20:49:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6lowpan: Allow 6LoWPAN to be modular
Message-ID: <20140807184938.GC17452@omega>
References: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1407424003-15073-1-git-send-email-geert@linux-m68k.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 07, 2014 at 05:06:43PM +0200, Geert Uytterhoeven wrote:
> Change config symbol 6LOWPAN from type bool to type tristate, so
> 6LoWPAN can be built modular, just like IPV6
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>
