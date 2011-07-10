Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:50:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Fix finalize request in callback function
Message-ID: <20110710075037.GB1808@dell.ger.corp.intel.com>
References: <1310041198-4346-1-git-send-email-dmitriy.paliy@nokia.com>
 <1310041198-4346-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310041198-4346-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Jul 07, 2011, Dmitriy Paliy wrote:
> Request shell be finalized in cache_ready_notify callback function.
> Otherwise, reference to the request is kept until vobject is closed.
> It is correct in current implementation since there are no nested
> backend requests when pulling vcard listing.
> 
> However, this contradicts to current design (see phonebook_size_result,
> query_result, cache_entry_done) and may cause problems if such
> implementation would be needed.
> ---
>  plugins/pbap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

This one doesn't apply to latest git.

Johan
