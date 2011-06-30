Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 14:48:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Make use of g_slist_free_full when elements are
 dynamically-allocated
Message-ID: <20110630114811.GA4634@dell.ger.corp.intel.com>
References: <1309432294-14898-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309432294-14898-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jun 30, 2011, Luiz Augusto von Dentz wrote:
> This avoid having to iterate twice in the list to free its elements.
> ---
>  plugins/bluetooth.c         |    8 +++-----
>  plugins/pbap.c              |    7 ++++---
>  plugins/phonebook-dummy.c   |    3 +--
>  plugins/phonebook-tracker.c |    5 ++---
>  plugins/vcard.c             |   17 +++++------------
>  5 files changed, 15 insertions(+), 25 deletions(-)

Thanks. All of the (BlueZ) g_slist patches have now been pushed
upstream. Since there are so many pending obexd patches around I fear
that your obexd patch will conflict with quite many of them, so let's
see if that needs to be resent once I finish processing obexd patches.

Johan
