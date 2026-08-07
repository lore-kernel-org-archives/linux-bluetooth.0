Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C8277CAD;
	Fri,  7 Aug 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065984; cv=pass; b=aGKAveNqMcHidX8Ek4gKi/ZeFHn33b0PRNXWSZb+0zAcwK2W/vQHXQt/GUyJGxaIpsFelxPfgUkG5NOwPb0Om1Q/exRthB7WfGz0AaJTz/NZxmtQMRvwenyTzw2JBfCAbuGZDYYMBqQaDhBNDNpgCPXw4SSX/6TJmBrxenUf5xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065984; c=relaxed/simple;
	bh=M7p8nClWdOKdO/Iy8KBlzvIQAqX0giiAHElxJY2tIWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJ6IEBqYfoHHxiGHDdHlMwqUsL2IuF4cTvRq+aLGg3/JCXl+ETSNQjtObGLQqKEGoS3Kl96DCkeu+3j5jAxdNWSL2Egnz+YS/UGPFZCfYMvEtTxCM/IKTv0sjNAdevBapkr44qxaf4wuYviY35DJSBDn9S/d49q1pmywPDvsBCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=pm7R2M1v; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="pm7R2M1v"
ARC-Seal: i=1; a=rsa-sha256; t=1786065968; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ceZbqb/FDNekaunhtckroJSfadpolIGOcM5i5D/CnUJxeXkhH2TMCJuwebfKTx9TmGd7yvaWr9PUG8910Ijue9mKkWNgb5pXC5eo3Z0M1GB6Uv4V7NXrOxogp+7bTftK7R7rXZsx9GxRc51ReOUYo8TLO+8hBvW0Wl7BuQKr0NY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786065968; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s+fW6anuhNIq0JN/xgWNpNcBDbYEbLmHj0v1Zwzq2HQ=; 
	b=FtbF8lXy6Wbgklqbs3cdrEkIvkv2ZXhEunwJt9bt3kvYrWltAS6DmFrx4jdBUlA8NAfR/ozxiZTAlxTelusLcebW/DCFXiXjbuQXkWE94R7g6WzM+aan63lMVB3EWH8GajqOnyswwutDVCoJi8OdsW5tbBdJZC9tWDq2l8ojrwc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786065968;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=s+fW6anuhNIq0JN/xgWNpNcBDbYEbLmHj0v1Zwzq2HQ=;
	b=pm7R2M1vAsGZgSxCC+x5IhtdMvvJLGleCby+FyscXIr2uTNeXUojKjJetC0/h6ei
	tXtBmS3BUC7LkD1/Qt8Vba6NtkNNPSxTD70zCbt2N+VQu/uaV7Sidmf8EuK6xPfNS85
	xU5XJxwNtaNLLQTn5Srf0o9ei/0Jj8Ju2x72uZQ4=
Received: by mx.zoho.eu with SMTPS id 178606596522099.0300871055781;
	Fri, 7 Aug 2026 03:26:05 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: MSFT: validate evt_prefix_len against the response length
Date: Fri,  7 Aug 2026 01:25:54 +0000
Message-ID: <20260807012555.97482-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

read_supported_features() only checks that the response covers the fixed
part of struct msft_rp_read_supported_features, which is 11 bytes:

	if (skb->len < sizeof(*rp)) {
		bt_dev_err(hdev, "MSFT supported features length mismatch");
		goto failed;
	}

evt_prefix[] is a flexible array member and rp->evt_prefix_len is an
unvalidated u8 taken straight out of that response, so

	msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,
				   GFP_KERNEL);

copies up to 255 bytes from a reply that may have carried none of them.
What is copied is data the controller never sent, and it is then used to
match incoming vendor events in msft_vendor_evt().

This is not an out-of-bounds access. An skb data allocation always has
at least SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) bytes past the
payload, which is more than the 255 byte maximum, so the read stays
inside the allocation and KASAN does not report it. It is still a read
of bytes the host was never given, with the length fully controlled by
the controller.

Reject a response that is too short for the prefix it declares.

Verified with an emulated controller over /dev/vhci on a KASAN kernel,
with vhci made to advertise an MSFT opcode the way btintel, btqca, btmtk
and btrtl do unconditionally. A reply of exactly 11 bytes declaring
evt_prefix_len = 255 reaches kmemdup and copies 255 bytes
("skb->len=11 evt_prefix_len=255", with the copied buffer dumped); since
the reply ends at the fixed part, all 255 come from past the end of the
response. No KASAN report is produced, as expected from the allocation
slack described above. With this patch the response is rejected with
"MSFT event prefix length mismatch" and msft->evt_prefix is left unset.

Fixes: 145373cb1b1f ("Bluetooth: Add framework for Microsoft vendor extension")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 net/bluetooth/msft.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index d7badce8746c..ded68568e6c9 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -165,6 +165,11 @@ static bool read_supported_features(struct hci_dev *hdev,
 	if (rp->sub_opcode != MSFT_OP_READ_SUPPORTED_FEATURES)
 		goto failed;
 
+	if (skb->len < sizeof(*rp) + rp->evt_prefix_len) {
+		bt_dev_err(hdev, "MSFT event prefix length mismatch");
+		goto failed;
+	}
+
 	if (rp->evt_prefix_len > 0) {
 		msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,
 					   GFP_KERNEL);
-- 
2.55.0

