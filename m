Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 12:18:58 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Paulo =?iso-8859-1?Q?S=E9rgio?= <paulo.sergio@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix error status when pairing fails
Message-ID: <20121026141858.GA8499@joana>
References: <1351192136-6925-1-git-send-email-paulo.sergio@openbossa.org>
 <1351194951-7534-1-git-send-email-paulo.sergio@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351194951-7534-1-git-send-email-paulo.sergio@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

* Paulo Sérgio <paulo.sergio@openbossa.org> [2012-10-25 16:55:51 -0300]:

> When pairing fails due to wrong confirm value, the management layer
> doesn't report a proper error status. It sends
> MGMT_STATUS_CONNECT_FAILED instead of MGMT_STATUS_AUTH_FAILED.
> 
> Most of management functions that receive a status as a parameter
> expects for it to be encoded as a HCI status. But when a SMP pairing
> fails, the SMP layer sends the SMP reason as the error status to the
> management layer.
> 
> This commit maps all SMP reasons to HCI_ERROR_AUTH_FAILURE, which will
> be converted to MGMT_STATUS_AUTH_FAILED in the management layer.
> 
> Reported-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> Reviewed-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> Signed-off-by: Paulo Sérgio <paulo.sergio@openbossa.org>
> ---
> 
> Please, disconsider the previous patch. It had a wrong commit message.
> 
> PS: This is my first patch.
> 
>  net/bluetooth/smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth.git. Thanks

	Gustavo
