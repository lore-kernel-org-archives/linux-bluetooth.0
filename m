Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sat, 24 Jul 2010 01:48:56 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART
 driver
Message-ID: <20100724044856.GB9787@vigoh>
References: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <gustavo@padovan.org> [2010-07-24 01:46:57 -0300]:

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> Use the new hci_recv_stream_fragment() to reassembly incoming UART
> streams.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  drivers/bluetooth/hci_h4.c |  103 +-------------------------------------------
>  1 files changed, 2 insertions(+), 101 deletions(-)
> 

Please, can someone test this code? I don't have such UART hardware to
make sure that this patch is working.

-- 
Gustavo F. Padovan
http://padovan.org
