Return-Path: <cyrus@holtmann.org>
Message-ID: <1352934294.20338.12.camel@aeonflux>
Subject: Re: [RFCv1 1/3] Bluetooth: Refactor locking in amp_physical_cfm
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Nov 2012 08:04:54 +0900
In-Reply-To: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove locking from l2cap_physical_cfm and lock chan inside
> amp_physical_cfm.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/amp.c           |    6 +++++-
>  net/bluetooth/l2cap_core.c    |    7 ++-----
>  3 files changed, 8 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


