Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 12:56:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] MAP: Skeleton of application parameters support
Message-ID: <20111208105600.GC30533@x220>
References: <1323087685-9528-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323087685-9528-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Dec 05, 2011, Slawomir Bochenski wrote:
> This introduces skeleton of functions for supporting processing of
> Message Access Profile specific OBEX application parameters. The code is
> usable in both MSE (server) and MCE (client), thus the patch enables
> linking the code to obexd and obex-client.
> ---
> Changes as per comments to first version.
> 
>  Makefile.am  |    6 ++-
>  src/map_ap.c |   89 +++++++++++++++++++++++++++++++++++++++++++++
>  src/map_ap.h |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+), 2 deletions(-)
>  create mode 100644 src/map_ap.c
>  create mode 100644 src/map_ap.h

Applied. Thanks.

Johan
