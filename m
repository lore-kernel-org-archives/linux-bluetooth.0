Return-Path: <cyrus@holtmann.org>
Message-ID: <4C52CFDC.9070907@nokia.com>
Date: Fri, 30 Jul 2010 16:13:00 +0300
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Don't send RFC for Basic Mode if only it is
 supported
References: <4C5020D7.7080005@nokia.com> <1280426444-20469-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280426444-20469-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 07/29/2010 09:00 PM, ext Gustavo F. Padovan wrote:
> From: Gustavo F. Padovan<padovan@profusion.mobi>
>
> If the remote side doesn't support Enhanced Retransmission Mode neither
> Streaming Mode, we shall not send the RFC option.
> Some devices that only supports Basic Mode do not understanding the RFC
> option. This patch fix the regression found with that devices.


Yes this is better. After some research i found out that quite many old 
devices are not handling properly unknown options.

However I found another regression. And this kind of patch is needed 
also. Otherwise the info rsp code is reading feat_mask from failed 
response (and does invalid memory access).


diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0f34e12..1e174a4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3348,6 +3348,13 @@ static inline int l2cap_information_rsp(struct 
l2cap_conn *conn, struct l2cap_cm

         del_timer(&conn->info_timer);

+       if (result != L2CAP_IR_SUCCESS) {
+               conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
+               conn->info_ident = 0;
+               l2cap_conn_start(conn);
+               return 0;
+       }
+
         if (type == L2CAP_IT_FEAT_MASK) {
                 conn->feat_mask = get_unaligned_le32(rsp->data);



-- 
Ville
