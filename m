Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: Avoid use of session socket after the session gets freed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406037265-16301-1-git-send-email-Vignesh_Raman@mentor.com>
Date: Tue, 22 Jul 2014 16:09:59 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Dean_Jenkins@mentor.com, Vitaly_Kuzmichev@mentor.com
Message-Id: <987F9D79-392C-4826-932E-5D2A27EBBE4B@holtmann.org>
References: <1406037265-16301-1-git-send-email-Vignesh_Raman@mentor.com>
To: Vignesh Raman <Vignesh_Raman@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vignesh,

> The commits 08c30aca9e698faddebd34f81e1196295f9dc063 "Bluetooth: Remove
> RFCOMM session refcnt" and 8ff52f7d04d9cc31f1e81dcf9a2ba6335ed34905
> "Bluetooth: Return RFCOMM session ptrs to avoid freed session"
> allow rfcomm_recv_ua and rfcomm_session_close to delete the session
> (and free the corresponding socket) and propagate NULL session pointer
> to the upper callers.
> 
> Additional fix is required to terminate the loop in rfcomm_process_rx
> function to avoid use of freed 'sk' memory.
> 
> The issue is only reproducible with kernel option CONFIG_PAGE_POISONING
> enabled making freed memory being changed and filled up with fixed char
> value used to unmask use-after-free issues.
> 
> Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
> Signed-off-by: Vitaly Kuzmichev <Vitaly_Kuzmichev@mentor.com>
> Acked-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> ---
> net/bluetooth/rfcomm/core.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree and I also tagged it for stable.

Regards

Marcel

