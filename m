Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402565437.27142.4.camel@jrissane-mobl.ger.corp.intel.com>
Date: Thu, 12 Jun 2014 11:55:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <519AE03E-8273-4CFE-B4EA-3066A54DA411@holtmann.org>
References: <1402493714-30849-1-git-send-email-marcel@holtmann.org> <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org> <1402565437.27142.4.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>> so this patch is just the groundwork to deal with the socket vs kernel internal handling of TX path. And this patch should most likely also be split into providing the default for alloc_skb and then adding memcpy_fromiovec.
> 
> Earlier in 6lowpan coc patches, you suggested that we would not use
> msghdr for kernel internal data because of extra memory copy that is
> needed in 6lowpan side. Is that suggestion now reverted?

you can allocate msghdr and iovec on the stack and just have it point to a single buffer you have your message in. The msghdr will be modified by the underlying default implementation, but besides having to allocate the message itself you do not have an extra allocation. Look at how A2MP does it.

In the future steps we should look into how we can take a SKB with the existing message and clone or copy it efficiently so it will split over multiple ACL fragments.

As I mentioned before, I never realized how well optimized our L2CAP is to deal with iovec structs from userspace. It never occurred to me that kernel internal TX path is non existent and that A2MP is actually buggy.

Regards

Marcel

