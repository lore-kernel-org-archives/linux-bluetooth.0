Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 14:47:54 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add discover characteristics by uuid to gattool
Message-ID: <20110317124754.GC12238@jh-x301>
References: <1300297246-11056-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300297246-11056-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Mar 16, 2011, Sheldon Demario wrote:
> +		uuid = g_try_new(bt_uuid_t, 1);
> +		if (bt_string_to_uuid(uuid, argvp[3]) < 0) {
> +			g_free(uuid);
> +			printf("Invalid UUID\n");
> +			return;
> +		}

If you're gonna use the _try version of GLib memory allocators you need
to check for the return value. However in this case I'd just use the
non-try version (since the amount of memory is small).

Johan
