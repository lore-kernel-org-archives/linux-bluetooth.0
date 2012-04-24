Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Apr 2012 15:49:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6 v4] client: Remove buffer based transfer
Message-ID: <20120424124926.GA2327@x220.P-661HNU-F1>
References: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Apr 24, 2012, Luiz Augusto von Dentz wrote:
> Simplify the code by using temporary files and eliminates reallocations.
> ---
>  client/ftp.c      |    8 +-
>  client/manager.c  |   18 +++-
>  client/map.c      |   18 +++-
>  client/pbap.c     |   39 +++++--
>  client/session.c  |   34 +++---
>  client/session.h  |    7 +-
>  client/sync.c     |   36 +++++--
>  client/transfer.c |  301 ++++++++++++++++++++++-------------------------------
>  client/transfer.h |    8 +-
>  9 files changed, 230 insertions(+), 239 deletions(-)

All six patches have been applied. Thanks.

Johan
