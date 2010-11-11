Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:23:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: Re: [PATCH 2/2] string_free is specific to filesystem only
Message-ID: <20101111212337.GH24514@jh-x301>
References: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
 <1289508380-8873-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289508380-8873-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> string_free is a callback function specific to filesystem plugin only.
> It is used by OBEX drivers when closing OBEX object and not API
> exposed to other plugins. g_string_free can be used instead of it when
> required.
> ---
>  plugins/filesystem.c |    2 +-
>  plugins/filesystem.h |    1 -
>  2 files changed, 1 insertions(+), 2 deletions(-)

Also pushed upstream after similar fixes as with the first patch.

Johan
