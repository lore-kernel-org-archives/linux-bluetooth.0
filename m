Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/4] monitor/rfcomm: Add support for UIH frame decoding
Date: Fri, 07 Nov 2014 16:39:04 +0530
Message-id: <1415358545-10145-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415358545-10145-1-git-send-email-gowtham.ab@samsung.com>
References: <1415358545-10145-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode UIH frame in btmon.

In below UIH frame, MCC frame is present, so no credits field is printed.
      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address : (0x01)
           Command/Response Bit: 0
           DLCI : (0x00)
         Control : (0xef)
           Poll/Final Bit : 0
         Length : 10
         FCS : (0xaa)
        81 11 20 e0 27 00 9a 02 00 07 aa                 .. .'......     

In this UIH frame, no MCC frame, so credits field is printed.
      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address : (0x81)
           Command/Response Bit: 0
           DLCI : (0x20)
         Control : (0xff)
           Poll/Final Bit : 1
         Length : 0
         FCS : (0x1e)
         Credits : 33

---
 monitor/rfcomm.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index ee1eede..d31a6bb 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -85,6 +85,31 @@ static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	print_field("%*cFCS : (0x%2.2x)", indent, ' ', hdr.fcs);
 }
 
+static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	uint8_t credits;
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_lhdr *hdr = &rfcomm_frame->hdr;
+
+	if (!RFCOMM_GET_CHANNEL(hdr->address)) {
+		/* MCC frame parser implementation */
+		goto done;
+	}
+
+	/* fetching credits from UIH frame */
+	if (GET_PF(hdr->control)) {
+		if (!l2cap_frame_get_u8(frame, &credits))
+			return false;
+		hdr->credits = credits;
+		print_field("%*cCredits : %d", indent, ' ', hdr->credits);
+		return true;
+	}
+
+done:
+	packet_hexdump(frame->data, frame->size);
+	return true;
+}
+
 struct rfcomm_data {
 	uint8_t frame;
 	const char *str;
@@ -170,7 +195,8 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 
 	/* UIH frame */
 	if (ctype == 0xef)
-		packet_hexdump(l2cap_frame->data, l2cap_frame->size);
+		if (!uih_frame(&rfcomm_frame, indent))
+			goto fail;
 
 	return;
 
-- 
1.9.1

