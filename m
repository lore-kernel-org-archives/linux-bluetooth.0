Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAF35CB81
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348456; cv=none; b=GWAwX4/konP2jrofqHcV2ljO/fLh2VhWUoWIal6BO2yMAv0P1p0tz/efW5f0J2joguN7jsjtrjbmP+MYfA2olR/ZU/i3hT9cMgs0526xMjB7ffSWrcRkYXZgnUu+EWBagsRdpmIWFVLJUfC0nMc/kR/vZpstGnsSOzCm0o95Q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348456; c=relaxed/simple;
	bh=Db254dScLOmFYV7YRb15V953XOTkbEH+zalFPCY+GB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRthc7cID42aMlhcWsqVSZRjc5e2wJOD0uYJppnUjROnCRK5eb87Sh7fkD7LAKn3Vsr7TD+J/G2Zg38UVcW505kn7XCy7Xz1RCE8e4v5SbWnNc8MPDNbQy/nwxIgIlTEvpgdHfOCmlCBYgHtbhtFj8GC6u3apfh2O1cZNPIlTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eqPs16gY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eqPs16gY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sxYN91lm0t7/ln7Sp8H04ICrO6zNCua+/3UjbdccBZA=; b=eqPs16gYeSzoT6QLA6xqWzPdt3
	3H0bdysEyy1pJBfWkxeNsli6phpJQ5r7YFvzhG7H6D2Zq2viE7j8XyU1PpgCp4BTQLDfS15zvKQJS
	Me5b5OaBR+gCG1pGFkDRIsaYVmFUlC8pFsEVSbQRFV9cBKMJ+gtFQ6Fs0M0z6I+EBQqY7aw5Kcr72
	Y/W767RBWbWmpzx7fLLo+vTF4mthLy7PI/sBjvF1aYILIJnDitcoOAJG4538Vyk8JYtu6cmi+2EkW
	VRK0BTyoMUwwaDitIFeW83dmbP2ejoQdVStw/Wcn56UW+No332eylioMRUuTes7/zAStb7/QjvymT
	uSweP7Mw==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w4z5O-005I4n-5J; Tue, 24 Mar 2026 11:34:10 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1w4z5O-0000000059i-0Aiq;
	Tue, 24 Mar 2026 11:34:10 +0100
From: Alberto Garcia <berto@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alberto Garcia <berto@igalia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [RFC PATCH 1/1] Bluetooth: btmtk: add USB autopm support to btmtk_usb_setup()
Date: Tue, 24 Mar 2026 11:34:04 +0100
Message-ID: <d854c37829bb084ddb1e60340de6b207505cfb5b.1774348119.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1774348119.git.berto@igalia.com>
References: <cover.1774348119.git.berto@igalia.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_usb_setup() accesses the device without first ensuring that it
is awake, so it may fail if the device has been autosuspended, e.g.:

    Bluetooth: hci0: Failed to get device id (-108)
    Bluetooth: hci0: Failed to get fw version (-108)

Add usb_autopm_get_interface()/usb_autopm_put_interface() around the
entire setup process, mirroring what commit 67dba2c28fe0 ("Bluetooth:
btmtk: Fix failed to send func ctrl for MediaTek devices.") already
did for btmtk_usb_shutdown().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217475
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 drivers/bluetooth/btmtk.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index fa7533578f85..a5d15efa8712 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1268,7 +1268,7 @@ int btmtk_usb_suspend(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_suspend);
 
-int btmtk_usb_setup(struct hci_dev *hdev)
+static int do_btmtk_usb_setup(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
@@ -1453,6 +1453,21 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 
 	return 0;
 }
+
+int btmtk_usb_setup(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	int err;
+
+	err = usb_autopm_get_interface(btmtk_data->intf);
+	if (err < 0)
+		return err;
+
+	err = do_btmtk_usb_setup(hdev);
+
+	usb_autopm_put_interface(btmtk_data->intf);
+	return err;
+}
 EXPORT_SYMBOL_GPL(btmtk_usb_setup);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev)
-- 
2.47.3

