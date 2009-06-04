Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Jun 2009 23:22:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zygo Blaxell <zygo.blaxell@xandros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove some dead files that are no longer distributed
Message-ID: <20090604202216.GB16595@jh-x301>
References: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com> <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com> <1244145939-32456-3-git-send-email-zygo.blaxell@xandros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244145939-32456-3-git-send-email-zygo.blaxell@xandros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zygo,

On Thu, Jun 04, 2009, Zygo Blaxell wrote:
> ---
>  audio/module-bluetooth-sink.c |   39 -------
>  doc/node-api.txt              |   28 -----
>  src/hcid.conf                 |   57 ----------
>  src/hcid.conf.5               |  227 -----------------------------------------
>  4 files changed, 0 insertions(+), 351 deletions(-)
>  delete mode 100644 audio/module-bluetooth-sink.c
>  delete mode 100644 doc/node-api.txt
>  delete mode 100644 src/hcid.conf
>  delete mode 100644 src/hcid.conf.5

I'll wait Marcel to comment on this one since I suspect he might want at
least node-api.txt to stay around even though it's not part of the "dist".

Johan
