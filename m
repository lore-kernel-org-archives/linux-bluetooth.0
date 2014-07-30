Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 0/7] 6lowpan: trivial iphc changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 29 Jul 2014 18:47:25 -0700
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Message-Id: <5D08EFE0-4DD8-4271-8D44-F2F245A3668F@holtmann.org>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> this patch series contains some trivial changes. Changing current naming of
> the header compression pointer. The current one is named hc06 which stands for
> header compression draft-06. We are most rfc complaint for the things we
> support right now. Other patches use some API functions which was introduced
> in some previous patches and IPv6 API for detect ipv6 address-scopes instead own
> implemented functions.
> 
> - Alex
> 
> Alexander Aring (7):
>  6lowpan: iphc: rename hc06_ptr pointer to hc_ptr
>  6lowpan: iphc: use sizeof in udp uncompression
>  6lowpan: iphc: cleanup use of lowpan_fetch_skb
>  6lowpan: iphc: cleanup use of lowpan_push_hc_data
>  6lowpan: iphc: use ipv6 api to check address scope
>  6lowpan: iphc: remove check on null
>  6lowpan: remove unused LOWPAN_FRAG_SIZE define
> 
> include/net/6lowpan.h |  24 -------
> net/6lowpan/iphc.c    | 177 +++++++++++++++++++++++++-------------------------
> 2 files changed, 90 insertions(+), 111 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

