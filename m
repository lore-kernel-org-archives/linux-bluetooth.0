Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 17:08:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Fix incorrect transfer path id during request
 authorization
Message-ID: <20120111150827.GA1035@x220>
References: <1326294222-21234-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326294222-21234-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, Jan 11, 2012, Jaganath Kanakkassery wrote:
> Transfer is registered with id as cid, but authorize method
> is called with id as pointer to obex session structure
> ---
>  src/manager.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both patches have been applied. Thanks.

Johan
