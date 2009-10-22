Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Oct 2009 02:11:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaikumar@google.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix SDP handling when the SDP record is modified on
	remote device.
Message-ID: <20091022231124.GA15283@jh-x301>
References: <1256251587-18043-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256251587-18043-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Thu, Oct 22, 2009, jaikumar@google.com wrote:
> We invalidate the in-memory SDP records list only when a profile
> is added or removed. So when a SDP record attribute like the rfcomm
> channel number is modified on the remote device, we will miss the update.
> ---
>  src/device.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

The patch makes sense and has been pushed upstream. Thanks. However, I'm
not aware of any code in the current bluez tree that would actually try to
use the cached RFCOMM channels. E.g. the serial plugin as well as the
HFP/HSP implementation always do explicit lookups over SDP before
attempting to connect. So most likely there's no immediate benefit of the
patch but it's still good to have it in case some future code does rely
more heavily on the SDP record cache.

Johan
