Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE2367F4D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216525; cv=none; b=ck9AyV7bhH8xX71fGuvrZ+8Zu4p69E8ISvNdUq+PEU0wnzcTLhIYnshFeYmoyVEaleJP+ygsHgkhVQFTMUbQr3VTVLWzeWUMavdBFESY5yZDFMQQu+n2CI0nwqm++oCZ1Lezw8YdTD1jwVWkqFPedqI8YF4uk/GZB80LCIRPb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216525; c=relaxed/simple;
	bh=+ReRBvwgjN62CEzvlVK3O2mCtDVNfcKsS0SOX61dM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBw+yGFiDRsTLJQnHbHX23kmee57/2AFeHMRgSaOLbdWiR1bxDkAOCK+eWrH7NeZLS8fMYm6M4rC1qkfQkB4qNiQg+IRemcyGJxwEv5ucd7Yg+wrD0bsCz0M+UXtJsnW2JPaJbMuAtnWOKNfTyztFaqJJgb1RQf01uzNWJIGqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ7nGeIi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ7nGeIi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so1226910f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216522; x=1779821322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=AZ7nGeIiPiV11tqr5OiXylB0A+LHisu0sWb4Mp+VfffK6ClvXoUdhbfBy1Yw4E1MDV
         ON7K/36Y/BM+zxnmmOZtuAB5jUiJffFnN5hm7ICSxna3KnVCwznNfPDwWd3JO+FckH6J
         dqt1SYuNmA4+u4T1xv7fri/To6BNgBAmp5whuF7v+HjgtUrLK19A1iz6B5bRChb/xpE3
         M63MEbDbewgGwaJ+fs6Ig0JFtdXcN6UjnZEk0iU35Oaq5xr/BCVg+0edxeGFpIcEliQy
         TfPXSSpBdd9MSIGvGAUy8D/eQwUIIyUyC5bSIAiIZKdBT0BQzPtLRrBhzPi6IbNFDyoE
         5MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216522; x=1779821322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEdQj3UnvnU4h8yi+M71QNzdIXPY/4/VW20nlE/VJic=;
        b=HHgDJYcsy4JxzUOwjb+oOazxoWzwKX87WczUmCgrOr+Y+Gj/rL5vNsqE65F4yb0a/5
         rqEzr0dqFIrp1iAb/LD/q+5I+2BpPeUMoqRYo1hECIrph8Exe8iKSXviNu13J9fYRcpO
         XO3pABLUHiMm8O4152CJFDtsQO9na6R69ksX4clNyhQC6ne5Xa/uuq9kNdXgs19PcN7u
         evT4sir+6o6vw/4JGm+7YvBGk/C1U/Yf0lBZmgRd9P3fZ0p3ob/OH7IAwNZCEFsnP9jS
         G5xewkqbzx/P50FmDUMQGIAPvdCD890lQsAQBFpD1H9kXTqI/rUAa9WUwp27ejgEbTOY
         mk1A==
X-Gm-Message-State: AOJu0YxNIHIKsROe6PWxOcqDkrpQXkFIGksc6I2U5UhluAEhR/qlVmcY
	tiztTvYg08Bn5Cf4xPn/UdXtyAobrmmlS0UzeWOczHvl+ZYmlBnUHRq8pCjGjnBO2Y+8lA==
X-Gm-Gg: Acq92OEZ6OGWMA2AsEiWcnjwSbhXzeJOu26I3wtCRrWPqjoqVHHGrOFOtSKxHGovXrQ
	9rMQhdaVNRe052Us4Np3ikliJkxvTpRg40OSWUvwnxrllc9CZCJUGGKLVUnpfSW7IrqCHZ2d9Ir
	EUuoV0NlJ7GzHCThMZb5jkRhmQG3F4Y3eoThUnWJpGDZTqtqw3UKU3cFE7DKNFdYNn1Laru7Rjc
	u7ohC8oGrtOoQN+xslPxFjAozr2XhhoYg3BPoHbVUpn1mMls9fY8Iyr2ZVy4JqcSgYMROJNr6iP
	KhfnXos3Bqh9AKCwp/UiFuW6knymE/0Ocd869T/3jEDkS0mUpWoZEual3SSwl+VTHjUSw/qZWAM
	4iSnBqR898Wfg6KMebb1BN20wQKu1q/bUOOWE5imBZO597WkgAJ5cRTurX5rsx16yhft1xqJHSl
	wuvLit0IbHKvl7sXk++1BVOq3B5dgkcdjgR4gRIbRgcxgJ561XYGk/KjlR9EC1MSO8fMrtXO7q5
	IjvqWm5Gh3w
X-Received: by 2002:a05:6000:2902:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-45e5c594d5dmr32513532f8f.29.1779216522437;
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm47420197f8f.37.2026.05.19.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:48:42 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:48:21 -0400
Message-ID: <20260519184821.18925-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v4:
 - Keep no-session comment and add blank line after header/len guard
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..e78ce11fa 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,8 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,14 +1751,21 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0

