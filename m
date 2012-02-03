Return-Path: <cyrus@holtmann.org>
Message-ID: <1328285272.2062.40.camel@aeonflux>
Subject: Re: [RFCv2 05/10] Bluetooth: Add l2cap_chan_lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:07:52 -0800
In-Reply-To: <1328279789-10870-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279789-10870-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Channel lock will be used to lock L2CAP channels which are locked
> currently by socket locks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   11 +++++++++++
>  net/bluetooth/l2cap_core.c    |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


