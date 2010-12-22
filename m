Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 13:54:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/18] Fix attrib plugin deregistration
Message-ID: <20101222115410.GA27483@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
> As the comparison method used for find what to de-register was
> wrong, it was causing the btd_device reference that the attrib
> plugin was keeping never to be dropped.
> ---
>  attrib/client.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
