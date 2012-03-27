Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:55:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH BlueZ] event: Remove unused dev_class parameter from
 btd_event_conn_complete()
Message-ID: <20120327115530.GJ14481@x220>
References: <1332782979-27081-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332782979-27081-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Mar 26, 2012, Anderson Lizardo wrote:
> This parameter is not being used by hciops nor mgmtops.
> ---
>  plugins/hciops.c  |    5 ++---
>  plugins/mgmtops.c |    3 +--
>  src/event.c       |    2 +-
>  src/event.h       |    2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)

The right fix is to make use of this parameter instead of removing it.
If btd_device has a variable for it, it should be updated and we should
also write it to storage.

Johan
