Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Oct 2010 14:52:03 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Type conversion in read and write obex streams
Message-ID: <20101015115203.GA14659@jh-x301>
References: <1287143179-22136-1-git-send-email-dmitriy.paliy@nokia.com>
 <1287143179-22136-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287143179-22136-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Oct 15, 2010, Dmitriy Paliy wrote:
> Integer types in obex_write_stream and obex_read_stream shell be the
> same as those returned by read and write function prototypes of
> obex_mime_type_driver.
> ---
>  src/obex.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Thanks. Pushed upstream.

Johan
