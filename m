Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 13:37:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [Linux-zigbee-devel] [PATCH v2 bluetooth-next] 6lowpan: Remove
 ununsed dev parameter from skb_delivery_cb callback.
Message-ID: <20140801113713.GB12179@omega>
References: <53DB6FAF.2090707@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53DB6FAF.2090707@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 01, 2014 at 11:45:03AM +0100, Martin Townsend wrote:
> This parameter is never used by any function implementing this callback.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
