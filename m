Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:50:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] core: Remove unused variable
Message-ID: <20120516075038.GC25830@x220>
References: <1336751135-21337-1-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336751135-21337-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Fri, May 11, 2012, Paulo Alcantara wrote:
> "srcaddr" variable is not used for anything else in
> btd_event_remote_name() function. So, remove it for now.
> ---
>  src/event.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
