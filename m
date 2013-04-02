Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 09:47:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1 1/2] attrib: Remove norequests and noresponses
 variables
Message-ID: <20130402064750.GB3509@x220>
References: <1364809081-1796-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364809081-1796-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Apr 01, 2013, Jaganath Kanakkassery wrote:
> Passing NULL is fine to g_queue_is_empty(), so removing these
> variables makes the code more readable
> ---
>  attrib/gattrib.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Both patches in this set have been applied. Thanks.

Johan
