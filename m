Return-Path: <cyrus@holtmann.org>
Message-ID: <1402577830.27142.22.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 12 Jun 2014 15:57:10 +0300
In-Reply-To: <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org>
References: <1402493714-30849-1-git-send-email-marcel@holtmann.org>
	 <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ke, 2014-06-11 at 18:00 +0200, Marcel Holtmann wrote:
> Hello,
> 
> so this patch is just the groundwork to deal with the socket vs kernel internal handling of TX path. And this patch should most likely also be split into providing the default for alloc_skb and then adding memcpy_fromiovec.
> 
> And I have just compile-tested this patch. I have not run it yet. I leave this to someone else to actually test if this works ;)

just tested this and it works ok so ACK from me.


Cheers,
Jukka
