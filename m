Return-Path: <cyrus@holtmann.org>
Message-ID: <1351816294.1828.21.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Rename ctrl_id to remote_amp_id
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Nov 2012 01:31:34 +0100
In-Reply-To: <1351777023-10018-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1351700642.1828.13.camel@aeonflux>
	 <1351777023-10018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351777023-10018-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Since we have started to use local_amp_id for local AMP
> Controller Id it makes sense to rename ctrl_id to remote_amp_id
> since it represents remote AMP controller Id.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +--
>  net/bluetooth/a2mp.c          |    4 ++--
>  net/bluetooth/amp.c           |    5 ++---
>  net/bluetooth/l2cap_core.c    |    2 +-
>  4 files changed, 6 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


