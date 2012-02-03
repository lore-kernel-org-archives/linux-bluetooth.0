Return-Path: <cyrus@holtmann.org>
Message-ID: <1328228657.2062.22.camel@aeonflux>
Subject: Re: [PATCH v2 4/7] Bluetooth: Add MGMT handlers for dealing with
 SMP LTK's
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Feb 2012 16:24:17 -0800
In-Reply-To: <1328227685-27245-5-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328227685-27245-5-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This adds a method to notify that a new LTK is available and
> a handler to store keys coming from userspace into the kernel LTK
> list.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/mgmt.c             |   80 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


