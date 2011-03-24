Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 11:17:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash while exiting when endpoint has a a2dp stream
Message-ID: <20110324091708.GB30621@jh-x301>
References: <1300895013-32010-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300895013-32010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 23, 2011, Luiz Augusto von Dentz wrote:
> After releasing the endpoint should not be used anymore.
> ---
>  audio/a2dp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
