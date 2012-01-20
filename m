Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Jan 2012 17:05:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6] client: fix circular dependency of session and
 transfer
Message-ID: <20120120150540.GB18984@fusion.localdomain>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jan 20, 2012, Luiz Augusto von Dentz wrote:
> Currently the code has to to pass session to transfer via user data
> (void *) only to be casted to session.
> ---
>  client/ftp.c      |    7 +--
>  client/manager.c  |    6 +--
>  client/map.c      |    9 +---
>  client/pbap.c     |   42 ++++-------------
>  client/session.c  |  129 ++++++++++++++++++++++++++++++++++++++++++++---------
>  client/session.h  |    8 +---
>  client/sync.c     |    8 +--
>  client/transfer.c |   68 ++++++++++++++--------------
>  client/transfer.h |   13 +++---
>  9 files changed, 168 insertions(+), 122 deletions(-)

All six patches have been applied. Thanks.

Johan
