Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97227442;
	Sun, 16 Aug 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870878; cv=pass; b=WQ6pESemQa0gXgeqYtoefa/mwOzJKJNf+Xt3EokEXmMb/HLjZ7YEmyAkqo2jYJPu1vNKZ3lY6ku8j/kZjVwA9b7KiB7gzJdxSFN1pCNa1wRloaGEpKdPlrBZQD4CF19YBFeffIC0YqeKfJofzHVq8Q1oBr4/m8fBKoHj9K3s2BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870878; c=relaxed/simple;
	bh=Fy0R+Mty2SIZ1c+N2i7ar1wHcL633RHR8KRQiFmSkEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8P1fwepbjg3M/n5Q6w3jOtH8C8jeRQycEszjfFv743lZTa1jr4lFPatwxq4LB1oZLhrJ71uCFxjGYI0UYybHJSxY4evhfsrvIjT3a0lOBDbHx3JB703K5lS87FCD4c2KNE9jwlfKOregYd/UkEg8l7vbA68z7kX2FHXkMM66Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JjXJbkXH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JjXJbkXH"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hN91J3TG5zyRf;
	Sun, 16 Aug 2026 12:01:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786870869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LcRkLbXZrtoMA/eyhPhdq+epOQc2zxaPZDVvwynzMRM=;
	b=JjXJbkXHsXEsoS2RWorj/UrZeRPoE+OiojSBuwK7HBF5UC7CvSTSjxWQXImQqIOOPoEVPo
	ARDidAEoHyUwsg1mauK4031fu60S9Eo0IfkWnm1pk8x/7eGotuD4XD81P3mQBmqUyBq4Ow
	kaGShDju5iSgmRRoqw5gV3j4C+TK3yU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786870869;
	b=mb5hHagyctF9n6Z6QirJnlwYQGiFAxo7gzf0M4IVsT3kwwUk73teOLmBo5U7WE5E5I5YRx
	ILkzCiaJISC0ZIGXY/A18laQUarssAkXUN5+ObBgKqSC3AHv5VwsXrqyieXR1F3cywVR5I
	k0IijeRnrwgfLIwZdIugapcVItYWJnk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786870869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LcRkLbXZrtoMA/eyhPhdq+epOQc2zxaPZDVvwynzMRM=;
	b=mPufroGJ0j4nVX5HA5bv5z1PdRkydRJxhr81wgkotigqTpb6YfV2rdRC1WaSv2nQZiKtZ1
	87ccrAyLD5yOnPHPysuKMs8ANSW7NPe6y7ndUkx8r9lL4zteaXkPNbs6HeaScfzk17GE5G
	GUandoBYc/nWENapI64g8+ha5ON7P1k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	nicoyip.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH RESEND] Bluetooth: hci_sync: add conditional locking annotations
Date: Sun, 16 Aug 2026 11:59:01 +0300
Message-ID: <1ceaa25d70f068adfe2c40290a629b73c382ec59.1786870726.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add context analysis annotations to functions doing conditional locking,
to suppress analysis warnings.

Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    - resend, no changes
    
    - fixes build with CONFIG_WERROR=y
    
      Context analysis is enabled by default, the annotations must be
      correct to build with -Werror.

 net/bluetooth/hci_sync.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ea8baf05178e..7150037a864b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1287,6 +1287,7 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, u8 instance,
 }
 
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
 		    HCI_MAX_EXT_AD_LENGTH);
@@ -1375,6 +1376,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
 }
 
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
@@ -1535,6 +1537,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 }
 
 static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
 		    HCI_MAX_EXT_AD_LENGTH);
@@ -1588,6 +1591,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 }
 
 static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
@@ -1729,6 +1733,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 }
 
 static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
 		    HCI_MAX_PER_AD_LENGTH);
-- 
2.55.0

