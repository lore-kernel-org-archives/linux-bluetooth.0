Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Nov 2014 11:33:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix error not returned if service is not supported
Message-ID: <20141126093324.GB31813@t440s.lan>
References: <1416831099-14791-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416831099-14791-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Nov 24, 2014, Jaganath Kanakkassery wrote:
> Without this patch, error will not be returned if remote device does not
> support the service and hence application will never get any response
> for the connect request
> ---
>  src/profile.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
