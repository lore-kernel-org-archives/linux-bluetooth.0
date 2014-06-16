Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402577830.27142.22.camel@jrissane-mobl.ger.corp.intel.com>
Date: Mon, 16 Jun 2014 12:34:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B2A5A19A-21A7-4350-BFF0-A7BF7ACC9812@holtmann.org>
References: <1402493714-30849-1-git-send-email-marcel@holtmann.org> <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org> <1402577830.27142.22.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>> so this patch is just the groundwork to deal with the socket vs kernel internal handling of TX path. And this patch should most likely also be split into providing the default for alloc_skb and then adding memcpy_fromiovec.
>> 
>> And I have just compile-tested this patch. I have not run it yet. I leave this to someone else to actually test if this works ;)
> 
> just tested this and it works ok so ACK from me.

I split the patches now and added a proper commit message to them. Just keep in mind this is just the first step here. We should investigate on how we can combine alloc_skb and mempcy_fromiovec callbacks. This interim step is just to no block 6loWPAN support until we have figured it out.

Regards

Marcel

