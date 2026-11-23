Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425920;
	b=cPi+ccjv2GIj+m7fd45XeCeDwGYEmpDQxdMENkQI0x0QO5pNaUPuw/5xVU5fxAJymS/K
	 R7PxCCe0upiPoa+0OA5MnSgFhjaI3j/xAvkPTfs5NCxdzuf4V0RyBe8ovf1cLFtE4F7dX
	 Zo9zUcwLj1KMy3tp6mphMc/BQfts8ZrfRtDf2ks992Vo60j+NQd+cdEvHHKv8e94yO8dK
	 nnzaD5+JjePDjKtmnepneRgkl188ZHluVluXcLYPtcBWBjjeUrVNbKgrWJw2iDNCCceWN
	 qB/XZghbJhkG1BnRSq7ImGW0eubkwOajuqvTCcgqQWzggcZYJjN7Gt3dPCmPBR4vJuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SouaPJ9Vaz0OO59zLnVz9up+Kde5MYxluRvOXTlywj4=;
	b=IiyZ9+/soC47kUW+AyRMvOz1TSIBU8J/Wan1bCTsyaAHaVCCTAG4/RAIZFbVQKsoNGJz
	 A/dnkZoIzZKAiZ9oa/oeaOBFuvd0szNrOGiCbXK6Wo9QweJDSXAWRKtaDOQjrAe5VoW1l
	 3i7Dfo7dRZpAsFciEN+O9usWvs8AIyj99cj+KMzrBkL0ka0aBKb8KzDPu9SYsxwpbRq64
	 i/2CT9ODR9nDlPl97zYgz9dXIE0RsxGHhsbuMOlg6WA/gEpBik2GxmUpkbBRiVvAGuzsY
	 tBNo2tHaDzqX8i3CnboHFHNzh2GNiFrmzsI7bCjqToeZzWR7Bxjx5YacvQQefd+Njzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uZHmgd3g;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B9606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uZHmgd3g
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so27550585e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795425918; x=1796030718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SouaPJ9Vaz0OO59zLnVz9up+Kde5MYxluRvOXTlywj4=;
        b=uZHmgd3gSMW1RYFB3vkZ2AO2BLdyiTGbCgeN9M1UbTLkKPJBiweOTOOgospG2RHdrF
         xmtgzBfS6Msscl/DArBJTMSHlxXDMJ50GCVMi70koG4FFGgWJC4Jhe5eA5AzUUV83X0Z
         RSToxfJvmu0kWd04FSl5APA9x7W2OSZeiluaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425918; x=1796030718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SouaPJ9Vaz0OO59zLnVz9up+Kde5MYxluRvOXTlywj4=;
        b=VlyUNZct9NI6JbD2CAW/1Is1wRkRAJJsIMbhyFLIYNf/ERbtOLQT89IzwfcDQWQ/YU
         odkr1wNjOP3pqU8K5Uk+JvWHnS9HNjYiCiqzbxAB8zypnQzGvb/0TJnTFrYUXTkNTO0F
         UqFtWVy+P8h5W4YarlIu+5eB/MQl2EphWQxDidHQ62MIy2OOrz5CwtXou7q7N01+Mnm5
         kNrj++WoPnkMH3OwX4NC3RJVPSVQ5nIfIQG0CSciXxGW+GxlmUT6NPA9cFvAgboJ0vhb
         oGVfUSSUA2fw0WVwrihT02s/E4kGmdPvdUy7iApVfQu9DBhLqgXhhFO6Nq6alcuGKUry
         mKGQ==
X-Gm-Message-State: APuU4Z8444dp8Af0fbliyKB0trfkWcPxazq/N1N+kzSMDI049SwEZWMw
	uFKzjsGQhjoDcz0OzfvibMNRa4DF4cbwOvxgskPJrrrqOxX6S5txXU8JiwMP1iHRDO/L1dxnzpz
	wRwSv
X-Gm-Gg: AZFdTZfF1XfO4pn1hdVDFgoUGDwI/BrOyu32oV3ksLi1bOiHK1SOWpXiJFtWdL7x5CY
	JhnZLU+h2GsxSnP1r4sV0liWrRnCD3IpLvID1z/HBUg+XwGnvYIFrWsOutRyMLEHmWfQf4J2gs4
	jJV0FgnfpupugJCbxRhZygSdgkC9FRePhvyaRRAQgpYfLa8b5thhG35yrwIynnBfo6rNgvZJ+AP
	ef4cAeDwgc/HhzskOk0JvKR5QMmOrsbUAzGpzeZHJ9zk54KMFoBpEWVNA1s8+cWNGiCn5KkpCOl
	Poj+Zphi8NaIla+qDY9fAb2Rz2WkoWJwowARhbNGqsjJyw8xmygctZmx1wOGpRba5S+8j06ElNu
	ec22KPudsgZWoNZrdhrIEy9aKSFuna8ZBdMQqyf6tHf2r7Jab8S977TWzY7JiMFvdKXvFBDldmF
	PFBHcjcScDWZvYz9pYYnoeRhn/DsJoc6oSEBidBCqtKA6uRszsL0yXY0JT2xVGi8F6cqZnBc1t3
	phKlk8r2YMQ5RoleOdzWk58A7bZSfB9ELsmZ1AmxxRDHV03boF/RJ2geT51V3CNh5BSdv9l9P9Y
	tyEZ1+MVD+VxBKqRrDWWmKBdt+cAtsmMlCwpJL9g+rGSfBaH
X-Received: by 2002:a05:600c:8287:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb887e064dmr232155635e9.1.1795425917538;
        Mon, 23 Nov 2026 01:25:17 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm333751695e9.7.2026.11.23.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:25:17 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_sync: Don't enable instance 0 on Set Connectable
Date: Mon, 23 Nov 2026 10:25:10 +0100
Message-ID: <20261123092510.4085202-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_update_connectable_sync() restarts the advertising of
hdev->cur_adv_instance whenever the Advertising setting is on or an
advertising instance exists. cur_adv_instance can be 0 while instances
exist, for example after the current instance was removed while another
one keeps advertising. On a controller with extended advertising, Set
Connectable then sets up and enables advertising set 0x00, the set of
the Advertising setting, although that setting is off.

Steps to reproduce, after a boot, on a controller with extended
advertising:

  btmgmt advertising off
  btmgmt connectable off
  btmgmt add-adv -d 06097465737431 1
  btmgmt add-adv -d 06097465737432 2
  btmgmt rm-adv 2
  btmgmt connectable on

btmon of the last step:

  @ MGMT Command: Set Connectable (0x0007) plen 1
          Connectable: Enabled (0x01)
  [...]
  < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
          Handle: 0x00
          Properties: 0x0013
            Connectable
            Scannable
            Use legacy advertising PDUs: ADV_IND
  [...]
  < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
          Extended advertising: Enabled (0x01)
          Number of sets: 1 (0x01)
          Entry 0
            Handle: 0x00
            Duration: 0 ms (0x00)
            Max ext adv events: 0
  > HCI Event: Command Complete (0x0e) plen 4
        LE Set Extended Advertising Enable (0x08|0x0039) ncmd 1
          Status: Success (0x00)

To fix this we will also check that cur_adv_instance is not 0, because
that indicates that no added instance is the current one: instance 0
is the one of the Advertising setting, and with that setting off there
is nothing to restart.

Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
Changes in v3:
- The !list_empty(&hdev->adv_instances) check is kept next to the new
  one. v2 dropped it: with cur_adv_instance naming an instance removed
  during a peripheral connection, Set Connectable then failed with
  Invalid Parameters on an extended advertising controller and enabled
  advertising on a legacy one.
- Commit message: steps and trace are from a run on hardware
  (RPi5 with Intel BE200), on a kernel built from bluetooth-next (7.3-rc2)
  plus patches of ours that are not upstream. I test it against other devices
  StreamKits (Synaptics, Realtek, NXP controllers - but kernel is not latest)
- Missing in the v2 changelog: v1 failed six mgmt-tester cases in CI,
  the "Add (Ext) Advertising - Success ... (Connectable -> on/off)" ones.

v2: https://lore.kernel.org/linux-bluetooth/20261122191904.2261177-1-simon.mikuda@streamunlimited.com/
v1: https://lore.kernel.org/linux-bluetooth/20261122145428.1499940-1-simon.mikuda@streamunlimited.com/

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..9896917c973b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6649,7 +6649,7 @@ int hci_update_connectable_sync(struct hci_dev *hdev)
 
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances)) {
+	    (!list_empty(&hdev->adv_instances) && hdev->cur_adv_instance)) {
 		if (ext_adv_capable(hdev))
 			err = hci_start_ext_adv_sync(hdev,
 						     hdev->cur_adv_instance);

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

