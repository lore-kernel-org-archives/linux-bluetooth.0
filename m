Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 11:25:13 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix parsing of "Flags" AD type
Message-ID: <20110215142513.GA20583@jh-x301>
References: <1297705009-12848-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297705009-12848-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Feb 14, 2011, Anderson Lizardo wrote:
> If an advertising report did not contain a "Flags" AD Type (e.g. a Scan
> response), the previous flags value was mistakenly set to 0x00. This fix
> makes sure dev->flags is only updated for valid values.
> ---
>  src/adapter.c |    5 +++--
>  src/adapter.h |    2 +-
>  src/event.c   |    4 +++-
>  3 files changed, 7 insertions(+), 4 deletions(-)

Pushed upstream. Thanks.

Johan
