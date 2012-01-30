Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963830.1955.200.camel@aeonflux>
Subject: Re: [PATCH 8/8] Bluetooth: Add support for notifying userspace of
 new LTK's
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:50:30 -0800
In-Reply-To: <1327962558-25720-9-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-9-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> If we want to have proper pairing support over LE we need to
> inform userspace that a new LTK is available, so userspace
> can store that key permanently.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


