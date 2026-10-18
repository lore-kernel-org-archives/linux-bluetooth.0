Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412B3F23BD
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341639; cv=none; b=g7eO2FtkQnHtJq10/nmElY+tFOUAGHc4qwVZmsrUaP7BavF7kli4H1q66Z76Z0Yky7siNhtev6x+/3fyMAn/3QqHeMuwS8pXm6oRyGtoZLwsW6Is4v8cnxTt9lW01VAivJDK6wND1fbwEwV3v1uVdtuPcFnYzaKw8ztoiVWQWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341639; c=relaxed/simple;
	bh=P3fR3TcOESn5RM/xsAwSgXXBCnxTDtieZhUrgBxrljY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5HMo2Ut9dP+/0kU8tgHFKy+CuFNfyKOwXrtJFaD403qG2WcKGfxPy8tBr0OMLJpoFbwF4gYfL5tvKsJGWN4a+mP+Zd1ah1sBdviTKiy5Zww2VT14rwjtKF9wkT9YktiwKWTkZp5BgZLc7jK8wGznrqHdvaczES9ZDe1QUsPYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiserkol.ac.in; spf=pass smtp.mailfrom=iiserkol.ac.in; dkim=pass (2048-bit key) header.d=iiserkol-ac-in.20251104.gappssmtp.com header.i=@iiserkol-ac-in.20251104.gappssmtp.com header.b=e0bzrW/G; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiserkol.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiserkol.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iiserkol-ac-in.20251104.gappssmtp.com header.i=@iiserkol-ac-in.20251104.gappssmtp.com header.b="e0bzrW/G"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso3219094eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiserkol-ac-in.20251104.gappssmtp.com; s=20251104; t=1792341625; x=1792946425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHLj44GLDXfyBHeapt737XpOEodJJku26M3e8ENdbMM=;
        b=e0bzrW/GqBItWOr3KJi6p0J43spJJ1eoOSKZ+7izYgTlRJxm+gz0CqSMvuTWlWi14k
         P3Ze75zELKWxASxGvipz08GqJEB/c0bOvkIGw2TG/Sx82VRV9C1MquDLZ+ziPTTRmnTs
         o6p+LaiZ6/VfUU2L2jJlbPYp0jhTl14kbqUgEHi4gqax2oRKBw2VjIM81VLfpukf+6Mh
         rjWLWejoJq3voezYf/eWEII4vfPS2sYpLJJLFqVSPnY9OqrZLsZRv+7/ZqWeVOCHhnNh
         EgqY2GuW3do+MrGMSLSolnOqBF2DYrkBs0lb3o3OIE9c/ZXbIOB0DgyqWejfIHSa5bmI
         L2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341625; x=1792946425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHLj44GLDXfyBHeapt737XpOEodJJku26M3e8ENdbMM=;
        b=Di+/cDVeHcuW2CVv8DzE3JpB5X+QypxH1QZ70CYeJ5JioQkXy1hOSZJN03JEfSYKMK
         E+yhAgX/V2NyDRdJj7N+E7SMJdM7q8PnQGiKneEr4tQ2BmEkfiWMMm/nAIdggCYs6bqe
         BPlWPTRghOfQREpId38iKpcWa5guqYrm7ngB7R0UP31ELmP+gRHcSOmQfvvTifuMrJbo
         0AT6IbuYxneZyapPnWtaUdAQiaYlYukKnUjPQk5U5SEqh+juab70wfcfczsCuvMDMtYw
         2YmzyTIA633s8oMIvoeDvDp9IKbe93M7IpUhcpcL41x3owV4B8jF2tPx+ZenidVO15iz
         jvmQ==
X-Gm-Message-State: AFq9FYLlIT8ELF+EcALw1PGtapkqttLpOVGDuaITwV+NcKIkYo6Q4qSD
	//7s0hGFpN/GtFkHIPotuj3lqN21/0MCcs+PH9Dz0u93Jvxhq7oOY59/eu7TGXyqHoWOwJgvTLd
	Htmbo13HrNRQ0abQ=
X-Gm-Gg: AYBFou3Hik2C3T8DqHZyPskX5gvqoFpur9tEFv3YNBZtmV6hWT3p0r4hQ5pB6WS1AF3
	424JnHS27f5StnXmPNInJX/EFWaRmw/Z4hST71J5umz5qLIotATau4HUB8R59VBD1ngYIrzwowP
	n1pm8JKGE3bRquTQP/FZtIoTJ4/0wioksLW8rRq0YEJUWHA8PPYS8vbEMbB4I+tSMr2p/re0fjm
	8uGp6jMP3uGX2mYjYmzgJ575RyZU/h/7dHzAro0snfhZwSpXyDZSyWpPN0IJJdmAyBB74nVGRaE
	LgAKVGWTptyrfCNYRO5sFURORT65JGAvSSwJFg+sl+b9GCvP85t88K3awqiPWWmgzraOZqeQTZ+
	RsHQMR002exxvBdejetclO+TcpV4t6VbJWxgHXMCGNg83yY7x38qw1COO67n/AgBLGjoPrjmB+o
	bIij6HSWjaGMtmTMRAYjHhshOTCi6X/8+pwC/R8m1C76HY5aYXfehv3mGO4p1kKiyj7ICAEu9fw
	B/Cf6+YLAnEB7K1GA4SdPywUNIUcWk0Tk9NfGFKglmT+remuA4yCzsIHWK7BA==
X-Received: by 2002:a05:7301:6186:10b0:352:744f:80a3 with SMTP id 5a478bee46e88-361a2053a3amr8292284eec.16.1792341622836;
        Sun, 18 Oct 2026 09:40:22 -0700 (PDT)
Received: from masterr.tail7ee2dc.ts.net ([2409:40e0:115c:1889:1040:5757:b0b9:8769])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm40329452eec.12.2026.10.18.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:40:22 -0700 (PDT)
From: Shuvam Banerji Seal <sbs22ms076@iiserkol.ac.in>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Max Chou <max.chou@realtek.com>,
	Hilda Wu <hildawu@realtek.com>
Subject: [RFC PATCH] Bluetooth: btrtl: Add support for the RTL8852BD
Date: Sun, 18 Oct 2026 22:10:17 +0530
Message-ID: <20261018164017.35330-1-sbs22ms076@iiserkol.ac.in>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuvam Banerji Seal <shuvambanerjiseal@gmail.com>

The RTL8852BD is a cut of the RTL8852B (USB ID 0bda:b853, lmp_subver
0x8852, hci_rev 0xb) that reports rom_version 3. None of the patches in
rtl_bt/rtl8852bu_fw.bin target it, so btrtl fails with "didn't find patch
for chip id 3" (or -ENODATA with the v2 container) and the controller
stays on ROM code with a non-functional radio.

Realtek's Windows driver carries an "eco 4" patch for this cut as several
records, each with its own RAM load address. Before sending the 0xfc20
fragments of a record, the Windows driver writes the record's load
address into 0x801200cc with the vendor write-memory command 0xfc62;
0x801200cc appears to hold the address that 0xfc20 fragments are stored
at. Data fragments use plain indices, and a final empty fragment with
bit 7 set commits the patch.

Add this download path, used only when the regular parser finds no patch
and the chip is identified as an RTL8852BD. The firmware is read from
rtl_bt/rtl8852bd_eco4.bin, a simple container of the records:

  "E4RD" | __le32 count | count * (__le32 load, __le32 len, data[len])

Every command can succeed while the patch still fails to start, so read
the local version back afterwards, as rtl_download_firmware() does. If
the controller still reports the ROM lmp_subver, reset it and try again,
making up to three attempts in total.

Tested on a Lenovo laptop with an RTL8852BE combo card, on v7.2.11
(linux and linux-zen builds): the patch starts on the first attempt
(fw version 0x3c91950e) after a reboot and across repeated module
reloads, and inquiry, paging and A2DP streaming work. The retry path
was exercised by skipping the commit on the first attempt: the ROM
version was detected and the second attempt succeeded.

This is sent as an RFC because rtl_bt/rtl8852bd_eco4.bin is not in
linux-firmware; Realtek would have to publish it first.

The download sequence was originally worked out by mihaits.

Link: https://github.com/mihaits/rtl8852bd-bt-linux
Signed-off-by: Shuvam Banerji Seal <shuvambanerjiseal@gmail.com>
---
I bought this laptop only to find that Bluetooth did not work at all on
Linux. After weeks of fiddling around, this is the patch that makes it
work. I am sending it as an RFC to ask how to get it into a mergeable
state, and in the hope that Realtek can publish the eco 4 firmware in
linux-firmware.

An out-of-tree DKMS version of this change, with the firmware extractor,
an Arch package and test notes, is at:
https://github.com/Shuvam-Banerji-Seal/rtl8852bd-bt-dkms

 drivers/bluetooth/btrtl.c | 201 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d298133..b0e3e6d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -31,6 +31,20 @@
 #define RTL_ROM_LMP_8852A	0x8852
 #define RTL_ROM_LMP_8851B	0x8851
 #define RTL_ROM_LMP_8922A	0x8922
+
+/* RTL8852BD: the RTL8852B silicon cut that reports rom_version 3 */
+#define RTL_8852BD_ROM_VERSION	3
+#define RTL_8852BD_FW		"rtl_bt/rtl8852bd_eco4.bin"
+#define RTL_ECO4_MAGIC		"E4RD"
+#define RTL_ECO4_FRAG_LEN	252
+#define RTL_ECO4_MAX_INDEX	0x7f
+#define RTL_ECO4_END_FLAG	0x80
+#define RTL_ECO4_ATTEMPTS	3
+/* Vendor write-memory command: [0x21][addr:le32][value:le32] */
+#define RTL_OP_WRITE_MEM	0xfc62
+#define RTL_WRITE_MEM_TYPE	0x21
+/* Holds the RAM address that 0xfc20 fragments are streamed into */
+#define RTL_ECO4_DL_PTR		0x801200cc
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define RTL_VSC_OP_COREDUMP	0xfcff
@@ -922,6 +936,184 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
 				     btrtl_dev->fw_len);
 }
 
+static bool btrtl_is_8852bd(const struct btrtl_device_info *btrtl_dev)
+{
+	const struct id_table *ic = btrtl_dev->ic_info;
+
+	return ic && ic->lmp_subver == RTL_ROM_LMP_8852A &&
+	       ic->hci_rev == 0xb && ic->hci_bus == HCI_USB &&
+	       btrtl_dev->rom_version == RTL_8852BD_ROM_VERSION;
+}
+
+/* Send a vendor command and return the status byte of its Command Complete
+ * event, or a negative errno if the command could not be issued.
+ */
+static int rtl_eco4_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param)
+{
+	struct sk_buff *skb;
+	int status;
+
+	skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "eco4: opcode 0x%04x failed (%ld)", opcode,
+			    PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	status = skb->len ? skb->data[0] : -EIO;
+	kfree_skb(skb);
+	return status;
+}
+
+/* The RTL8852BD needs an "eco 4" patch that no linux-firmware container
+ * provides. Realtek ships it as several records, each with its own RAM load
+ * address. RTL_8852BD_FW holds them as:
+ *
+ *   "E4RD" | __le32 count | count * (__le32 load, __le32 len, u8 data[len])
+ *
+ * Before the fragments of a record are sent, the record's load address is
+ * written into RTL_ECO4_DL_PTR so the controller stores them there. Data
+ * fragments carry plain indices (setting bit 7 on a data fragment wedges the
+ * controller); a single empty fragment with RTL_ECO4_END_FLAG commits the
+ * patch at the end.
+ */
+static int rtl_download_eco4_once(struct hci_dev *hdev,
+				  const struct firmware *fw)
+{
+	struct hci_rp_read_local_version *rp;
+	const u8 *p = fw->data + 8;
+	const u8 *end = fw->data + fw->size;
+	u32 count = get_unaligned_le32(fw->data + 4);
+	struct sk_buff *skb;
+	u8 *frag;
+	u16 subver;
+	u32 i;
+	int ret = 0;
+
+	frag = kmalloc(RTL_ECO4_FRAG_LEN + 1, GFP_KERNEL);
+	if (!frag)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		u8 setup[9];
+		u32 load, len, off;
+		u8 index = 1;
+
+		if (end - p < 8) {
+			ret = -EINVAL;
+			goto out;
+		}
+		load = get_unaligned_le32(p);
+		len = get_unaligned_le32(p + 4);
+		p += 8;
+		if (!len || len > end - p) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		setup[0] = RTL_WRITE_MEM_TYPE;
+		put_unaligned_le32(RTL_ECO4_DL_PTR, setup + 1);
+		put_unaligned_le32(load, setup + 5);
+		ret = rtl_eco4_cmd(hdev, RTL_OP_WRITE_MEM, sizeof(setup), setup);
+		if (ret) {
+			rtl_dev_err(hdev, "eco4: record %u: set load address failed (%d)",
+				    i, ret);
+			ret = ret < 0 ? ret : -EIO;
+			goto out;
+		}
+
+		for (off = 0; off < len; off += RTL_ECO4_FRAG_LEN) {
+			u32 flen = min_t(u32, RTL_ECO4_FRAG_LEN, len - off);
+
+			frag[0] = index;
+			memcpy(frag + 1, p + off, flen);
+			ret = rtl_eco4_cmd(hdev, 0xfc20, flen + 1, frag);
+			if (ret) {
+				rtl_dev_err(hdev, "eco4: record %u: fragment %u failed (%d)",
+					    i, index, ret);
+				ret = ret < 0 ? ret : -EIO;
+				goto out;
+			}
+			index = index < RTL_ECO4_MAX_INDEX ? index + 1 : 1;
+		}
+		p += len;
+	}
+
+	frag[0] = RTL_ECO4_END_FLAG;
+	/* the version check below decides whether the commit worked */
+	ret = rtl_eco4_cmd(hdev, 0xfc20, 1, frag);
+	if (ret > 0)
+		rtl_dev_warn(hdev, "eco4: commit status 0x%02x", ret);
+
+	/* All of the above can succeed while the patch fails to start, which
+	 * leaves the controller on ROM code with a dead radio. The ROM reports
+	 * lmp_subver 0x8852; the running patch does not.
+	 */
+	skb = btrtl_read_local_version(hdev);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		goto out;
+	}
+	rp = (struct hci_rp_read_local_version *)skb->data;
+	subver = le16_to_cpu(rp->lmp_subver);
+	rtl_dev_info(hdev, "fw version 0x%04x%04x",
+		     le16_to_cpu(rp->hci_rev), subver);
+	kfree_skb(skb);
+
+	ret = subver == RTL_ROM_LMP_8852A ? -EAGAIN : 0;
+	if (ret)
+		rtl_dev_err(hdev, "eco4: patch did not start");
+out:
+	kfree(frag);
+	return ret;
+}
+
+static int rtl_download_eco4(struct hci_dev *hdev)
+{
+	const struct firmware *fw;
+	struct sk_buff *skb;
+	int attempt, ret;
+
+	ret = request_firmware(&fw, RTL_8852BD_FW, &hdev->dev);
+	if (ret < 0) {
+		rtl_dev_err(hdev, "eco4: failed to load %s (%d)",
+			    RTL_8852BD_FW, ret);
+		return ret;
+	}
+	if (fw->size < 8 || memcmp(fw->data, RTL_ECO4_MAGIC, 4)) {
+		rtl_dev_err(hdev, "eco4: %s: bad container", RTL_8852BD_FW);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (attempt = 1; attempt <= RTL_ECO4_ATTEMPTS; attempt++) {
+		ret = rtl_download_eco4_once(hdev, fw);
+		if (!ret) {
+			rtl_dev_info(hdev, "RTL8852BD eco4 patch running (attempt %d)",
+				     attempt);
+			break;
+		}
+		if (ret == -EINVAL || ret == -ENOMEM)
+			break;
+		if (attempt == RTL_ECO4_ATTEMPTS)
+			break;
+
+		rtl_dev_warn(hdev, "eco4: attempt %d failed (%d), retrying",
+			     attempt, ret);
+		/* drop any partially loaded patch before the next attempt */
+		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_INIT_TIMEOUT);
+		if (!IS_ERR(skb))
+			kfree_skb(skb);
+		msleep(100);
+	}
+
+out:
+	release_firmware(fw);
+	return ret;
+}
+
 static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 				struct btrtl_device_info *btrtl_dev)
 {
@@ -930,6 +1122,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	u8 *tbuff;
 
 	ret = rtlbt_parse_firmware(hdev, btrtl_dev, &fw_data);
+	/* linux-firmware has no patch for the RTL8852BD; the parser reports
+	 * -EINVAL (v1 EPATCH) or -ENODATA (v2 container) for it.
+	 */
+	if ((ret == -EINVAL || ret == -ENODATA) && btrtl_is_8852bd(btrtl_dev)) {
+		rtl_dev_info(hdev, "RTL8852BD: using eco4 patch");
+		ret = rtl_download_eco4(hdev);
+		goto out;
+	}
 	if (ret < 0)
 		goto out;
 
@@ -1558,6 +1758,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
+MODULE_FIRMWARE(RTL_8852BD_FW);
 MODULE_FIRMWARE("rtl_bt/rtl8852btu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852btu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
-- 
2.56.0

