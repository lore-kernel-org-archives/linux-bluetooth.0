Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 15:13:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/10] core: Fix remaining references to
 bluetooth/uuid.h
Message-ID: <20130110131329.GA12523@x220>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 10, 2013, Anderson Lizardo wrote:
> These headers are not public anymore, so need to use "lib/uuid.h".
> ---
>  src/attrib-server.c |    2 +-
>  src/main.c          |    2 +-
>  src/storage.c       |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

All patches in this set have been applied. Thanks.

Johan
