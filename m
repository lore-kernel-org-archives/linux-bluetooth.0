Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4E9809.2090107@nokia.com>
Date: Tue, 27 Jul 2010 11:25:45 +0300
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART driver
References: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/24/2010 07:46 AM, ext Gustavo F. Padovan wrote:
> From: Gustavo F. Padovan<padovan@profusion.mobi>
>
> Use the new hci_recv_stream_fragment() to reassembly incoming UART
> streams.
>
> Signed-off-by: Gustavo F. Padovan<padovan@profusion.mobi>
> ---

I tried with h4 transport over usb serial. Seems to work like earlier.

Tested-by: Ville Tervo <ville.tervo@nokia.com>

-- 
Ville
