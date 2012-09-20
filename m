Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Sep 2012 14:14:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hog: Fix segfault when discovering descriptors
Message-ID: <20120920111454.GB9102@x220>
References: <1347631010-3055-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1347631010-3055-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Fri, Sep 14, 2012, João Paulo Rechi Vita wrote:
> Invalid memory was being accessed when discovering the External Report
> Reference descriptor.
> ---
>  profiles/input/hog_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
