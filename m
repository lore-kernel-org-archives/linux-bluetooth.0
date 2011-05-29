Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:11:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix invalid read and possible memory leaks
Message-ID: <20110529191150.GG32088@dell.ger.corp.intel.com>
References: <1306503231-11664-1-git-send-email-dmitriy.paliy@nokia.com>
 <1306503231-11664-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306503231-11664-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, May 27, 2011, Dmitriy Paliy wrote:
> Fixed incorrect update of transport->owners GSlist in
> media_transport_free. Removal of list entries within 'for' loop leads
> to invalid read of memory (l = l->next) and memory leaks.
> ---
>  audio/transport.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
