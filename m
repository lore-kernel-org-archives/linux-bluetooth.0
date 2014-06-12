Return-Path: <cyrus@holtmann.org>
Message-ID: <1402565437.27142.4.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 12 Jun 2014 12:30:37 +0300
In-Reply-To: <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org>
References: <1402493714-30849-1-git-send-email-marcel@holtmann.org>
	 <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ke, 2014-06-11 at 18:00 +0200, Marcel Holtmann wrote:
> Hello,
> 
> so this patch is just the groundwork to deal with the socket vs kernel internal handling of TX path. And this patch should most likely also be split into providing the default for alloc_skb and then adding memcpy_fromiovec.

Earlier in 6lowpan coc patches, you suggested that we would not use
msghdr for kernel internal data because of extra memory copy that is
needed in 6lowpan side. Is that suggestion now reverted?


Cheers,
Jukka


