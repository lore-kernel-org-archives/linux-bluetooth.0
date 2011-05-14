Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 02:18:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net,
	padovan@profusion.mobi
Subject: Re: [PATCH 1/5] Add length argument to hci pincode reply
Message-ID: <20110514231854.GC28969@dell.ger.corp.intel.com>
References: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, May 05, 2011, David Herrmann wrote:
> This adds a new "length" argument to the hci pincode reply to allow
> sending binary pins including \0 characters.
> ---
>  plugins/hciops.c  |   10 +++++-----
>  plugins/mgmtops.c |    9 ++++-----
>  src/adapter.c     |    3 ++-
>  src/adapter.h     |    3 ++-
>  4 files changed, 13 insertions(+), 12 deletions(-)

All patches in this set have been pushed upstream. Thanks.

Johan
