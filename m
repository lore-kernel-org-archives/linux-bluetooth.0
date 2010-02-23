Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Feb 2010 10:59:10 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix service driver selection when WHO header is
 informed
Message-ID: <20100223135910.GA11428@jh-x301>
References: <2d5a2c101002230206r5a945ec0hd8b638f171440a33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101002230206r5a945ec0hd8b638f171440a33@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 23, 2010, Luiz Augusto von Dentz wrote:
> Drivers which support WHO header should be checked first since they have
> priority e.g. pcsuite over ftp.
> ---
>  src/service.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

The patch is now upstream. Thanks.

Johan
