Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963126.1955.189.camel@aeonflux>
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:38:46 -0800
In-Reply-To: <1327962558-25720-2-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-2-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This defines two new messages, one event that will inform
> userspace that a new Long Term Key was exchanged and one that
> will allow userspace to load LTKs into the kernel.
> 
> Besides the information necessary for the restablishement of
> the secure link, we added some extra information: "authenticated"
> that informs if the key can be used to establish an authenticated
> link, and "master" that informs the role in that the key should
> be used.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


