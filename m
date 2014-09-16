Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Tue, 16 Sep 2014 13:12:16 +0300
Message-ID: <CABBYNZJkTTHn=F81W+=Z+CU0zacMVjtcCBZpaifkEoUTAv1qNQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] android/tester: Unifying the way PDU is handled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Sep 16, 2014 at 11:49 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> This patchset makes all testers use common struct for using raw data (PDUs).
> Also some helpers were added for pdu matching.
>
> Jakub Tyszkowski (8):
>   android/tester: Expose gatt-tester's pdu definition to other testers
>   android/tester: Make AVRCP tests use generic pdu struct
>   android/tester: Make A2DP tests use generic pdu struct
>   android/tester: Make GATT tests use generic pdu struct
>   android/tester: Make HidHost tests use generic pdu struct
>   android/tester: Add helper functions for sending sdp responses
>   android/tester: Make avrcp use sdp pdu sending helper
>   android/tester: Expose pdu set and matching function to be reused
>
>  android/tester-a2dp.c    | 74 ++++++++++++++++--------------------------
>  android/tester-avrcp.c   | 84 ++++++++++++++++++++----------------------------
>  android/tester-gatt.c    | 26 +++------------
>  android/tester-hidhost.c | 40 +++++++++--------------
>  android/tester-main.c    | 50 ++++++++++++++++++++++++++++
>  android/tester-main.h    | 30 +++++++++++++++++
>  6 files changed, 163 insertions(+), 141 deletions(-)
>
> --
> 1.9.3


I think this PDU matching is so common that we should have it in
bthost to begin with, so Im planning to implement something like this:

diff --git a/emulator/bthost.h b/emulator/bthost.h
index 49a8649..c73ae6f 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -29,6 +29,17 @@ typedef void (*bthost_send_func) (const void *data,
uint16_t len,

 struct bthost;

+struct bthost_pdu {
+       const uint8_t *data;
+       size_t len;
+       size_t offset;
+};
+
+struct bthost_pdu_set {
+       const struct bthost_pdu *req;
+       const struct bthost_pdu *rsp;
+};
+
 struct bthost *bthost_create(void);
 void bthost_destroy(struct bthost *bthost);

@@ -64,6 +75,9 @@ void bthost_add_cid_hook(struct bthost *bthost,
uint16_t handle, uint16_t cid,
 void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
                                        const void *data, uint16_t len);

+void bthost_add_cid_pdu(struct bthost *bthost, uint16_t handle, uint16_t cid,
+                                       const struct bthost_pdu_set *pdus);
+
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
                                                uint16_t len, void *user_data);

With this I think we would be able to match intervals of a PDU and be
able to respond keeping the original data for the offsets.

-- 
Luiz Augusto von Dentz
