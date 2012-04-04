Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 12:56:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib: Fix "make distcheck" build
Message-ID: <20120404095642.GA11856@x220>
References: <1333468891-2686-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333468891-2686-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Apr 03, 2012, Anderson Lizardo wrote:
> Any new header files (att-database.h in this case) need to be added to
> Makefile.am.
> 
> Fixes this "make distcheck" error:
> 
>   CC     attrib/bluetoothd-gatt-service.o
> ../attrib/gatt-service.c:35:26: fatal error: att-database.h: No such
> file or directory
> compilation terminated.
> make[2]: *** [attrib/bluetoothd-gatt-service.o] Error 1
> make[1]: *** [all] Error 2
> make: *** [distcheck] Error 1
> ---
>  Makefile.am |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
