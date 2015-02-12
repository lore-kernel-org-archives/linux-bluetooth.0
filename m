Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 23:03:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: Do not allow LE connection if LE is
 not enabled
Message-ID: <20150212210325.GA14557@t440s.P-661HNU-F1>
References: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Feb 11, 2015, Lukasz Rymanowski wrote:
> Kernel gives possibility to enable/disable LE host support.
> There is flag HCI_LE_ENABLED which is set when this support is enabled
> and some parts of the code checks this flag e.g. SMP
> However it is still possible to make LE connection if LE Host support is
> disabled, what might be confused for remote device.
> This patch makes sure that kernel will not send HCI LE Create Connection
> if LE HOST support is not enabled.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
>  net/bluetooth/hci_conn.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
