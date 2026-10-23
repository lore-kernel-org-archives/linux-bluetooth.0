Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761864;
	b=ymnshCyiAkgHwI/Fp/xfBfpDvGzMffZHN+hBKCSy0F7Xz/OyXr6ofResYFOAv6AMm/rT
	 qkYB3oAk9dIV/KFxlaK/be4mL/BKdpTeRdTn1kiCDSdjcjLMHhX2jqVD33oSPn/T04TVi
	 QKMEMy2tzNV3bqrBc5dQeeVmxEOxvJ6jjmTPPkt0EXERNaIoIBmd0qm5Rjpo8tyHJ39xs
	 oYm6JL/7Q1uDZhl/g+1s7RToJJNqejRsmr5Sb+gaDhViHPoqtNEt1ftm4p7AAdxotb2O2
	 03+qZ0YKQjTv/B8UDvAUMUV/+ccN6GRoo4q+OpRxEjviBsKZHls12RQn525Un5JtFMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gfH14VpdGEvGGcrVPlCWics3MoVEs4FJ1uWKtiDUpaw=;
	b=BHPIhz5IwJ5M03/3CIZ01PlbJksuGp8lG4pzj5ZZJT8SBlcD8a8cgaWcpuyBBO7rkY4h
	 ivMeoR9eklKDu7zJ37RsOmZhrr1FOLNHR84n6PmcGQwgjHDiHFYcjs2y+xT0Bbi5nBYlk
	 hlWlX/fIfzGatAaMbnfcxjq7NlAOVtOT/WA72oDnJujEqRnifqUdyVLVby3YVtwSF6twx
	 pBJ4wLH0lvtmc/J9ZEoIorsMoGhm8SRjSOMbg0lI/quGk0FBG9nwxzTUgJTSVwk9UUjwZ
	 EP/+usezaEfXsnUP/NdlMiTCUXDodlr4Z9GMEcPxdgQWBFzSY1DjK+jJDDEAaDY2y4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H754NUc3;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77633606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 13:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77633606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H754NUc3
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18cdcfc05ffso981932c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761863; x=1793366663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gfH14VpdGEvGGcrVPlCWics3MoVEs4FJ1uWKtiDUpaw=;
        b=H754NUc3B3G33vmfMv9bIoSBpCFLtloVAx4ml5tBsvAZ8c0dVlsHD0v/KBcuYWqVqo
         n/EMBh4ExE5NwdLAJTPr80nFvBc83z9/3x8RSnwF84kfEhEkfu6gUe1HYDtqwovmiokH
         i1zwHITOYnVvzlRcIwiuaLkBTE3fOW50FGZhzx2WY1MQCrCD+8vWRFdDzlpUhWjuZRk8
         hsYww3ECphZ0M1L/v461SDUn1QOcpq702/JzIFk++w7PyrVuFBAbk6yjY2FT4NxM1wAd
         A3om3rh6CdXG8sGYOzF/alEzIgeQitIackLOaRlpBb1CegAFVWIdmzgPKLAdP40PopYb
         EG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761863; x=1793366663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gfH14VpdGEvGGcrVPlCWics3MoVEs4FJ1uWKtiDUpaw=;
        b=eeELo4a/NXe6EQER9t149sy8XpzYEtDHA7bvcsqt+eGUYj3FR+Rw38KcGVQdPGbrYs
         QM4vgld31Gl0F64BY8nutv9Dv5nd+0+1sMU6Zm150TnoUnJ2/2+/Rg1fv+FP1f8XqUl7
         Y9V6RlrTC3VWksdgZiag4wZlRrKSDYNapWCzlihog39zrn78pgQ9GHZBaOH3Inl+PoyR
         NLDciZnod4WFU+b5r5eYaV7Moi2k8q6YyHX6uCZVGhUZWhcJ8o3EAOLerSXjffGupBcE
         gvIozQmT88+XXh+/gLqUG1+mg0nZl2RE7DFl7C33Pzb3goDvPAyjpHBfHcjkADsyJf+h
         x6qg==
X-Gm-Message-State: AFq9FYKrvfcG5RtSpXJMrBhUFEcWYfiH84nQfARZFXIK5DuK/rM2K5K4
	8uRVTsRvrZUOvqrUzD+pBssVD3zFaggdT2EoqbPtq5b6AypOMy3k7mRE0bOBLpmuYEubtQ==
X-Gm-Gg: AYBFou3pnjfLSdqRER9UU+w/KarFxooiQ2vuGduC1SeVCQgS5PcaQgcnxxqkjaxZgvR
	F82TkPTwd+wWK9oN1PmZyb6gdOekE3P2Xe8CKhOEqaauh0wHWbPBWMcLuvWczMeVosPOheuXyKZ
	Ue6JXbV7RUkUofHBZdmdn/VtGMSSu9grhPMqey5E7RYmkQZR/fhlZOj4n+PeBSk83SLP5Gg3SfD
	y6DNCcdJHbCDMsNcruG4qyXemYFh2AeQGTZaKDqrFAkQoOPuaeGIVckHGXCvPn4EJ0wSeoLq1Aj
	tO35pycgqvSJqO4JOimHIyhO/9xBNnu3bGdJzZhsIgSRELMFDJcsnMo6749sdJ29orBBmE/GVUr
	0Np5JO2NWYAIJcEPVWA7jIFd+4ZpTNOlTt98rEaO2sVjvdpS7Vq63pocWZ0nysPi4/AJ16nsQP0
	S9H2IstvrBNxxQ7wteYu9UEZ4w+SsYdQ2zb51T4MLp1G+o15dbta9cb8uI5q6psvFh/abVDPEPT
	Wc3eGI4UvhUm2i7Pcy4zwSfcP5j1IG3kWFvAsn0pfrZMnjRrvOapGEU7YAw5ulGYX4Ea5cbZw+q
	WKJ4FZQLom1Ny3NWFMgpQsmvWQ==
X-Received: by 2002:a05:701b:2302:b0:168:3243:c91a with SMTP id a92af1059eb24-195c44b7990mr2886713c88.13.1792761863136;
        Fri, 23 Oct 2026 06:24:23 -0700 (PDT)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-197ea7d3d95sm118883c88.8.2026.10.23.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:24:22 -0700 (PDT)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Use the advertising set handle, not the instance
Date: Fri, 23 Oct 2026 13:24:21 +0000
Message-ID: <20261023132421.1889022-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00. The parameters,
data and enable commands for an instance use adv->handle, but two
commands still send the instance number as the advertising handle:

 - LE Set Advertising Set Random Address, from
   hci_set_adv_set_random_addr_sync(). The random address goes to
   handle 0x01, a set the controller doesn't have, and an instance
   using a random address, such as a non-connectable one, never
   starts:

     $ btmgmt add-adv -d 0A09434841445654455354 1
     Add Advertising failed with status 0x0d (Invalid Parameters)

     < HCI Command: LE Set Extended Advertising Parameters  Handle: 0x00
     < HCI Command: LE Set Extended Advertising Data        Handle: 0x00
     < HCI Command: LE Set Advertising Set Random Address
           Advertising handle: 0x01

 - LE Remove Advertising Set, from hci_remove_ext_adv_instance_sync(),
   so removing instance 1 fails with Unknown Advertising Identifier:

     $ btmgmt rm-adv 1
     Remove Advertising failed with status 0x03 (Failed)

     < HCI Command: LE Remove Advertising Set  Handle: 1
     > HCI Event: Command Complete
           Status: Unknown Advertising Identifier (0x42)

Look the instance up and use its handle, as the other set commands do.
In hci_set_adv_set_random_addr_sync() the instance stays the function's
argument, so instance 0 still updates hdev->random_addr, which is shared
with scanning.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
Notes, outside the commit:

Tested on a Raspberry Pi 5 with its 6.18.50 kernel, with this change and
a local equivalent of 1bfecdbd03 ("Bluetooth: HCI: Fix tracking of
instances sharing handle 0x00"), which depends on changes 6.18 doesn't
have. The controller is an open link layer on a WCH CH583 behind HCI
over USB, reporting one advertising set. Non-connectable and connectable
instances are added and removed with btmgmt, every advertising command
on handle 0x00 and answered Success. That kernel has also run our BLE test
suite through BlueZ since. Build-tested on bluetooth-next with W=1, no
new warnings.

Two related spots I've left alone, as the ownership of handle 0x00 is
better judged by you:

 - hci_cc_le_set_adv_set_random_addr() returns early for handle 0x00
   and otherwise looks the set up by instance number, so a single-set
   controller's instance 1 never gets adv->random_addr recorded. A
   by-handle lookup there may meet hdev->cur_adv_instance before it is
   updated for the instance being set up.
 - hci_le_ext_adv_term_evt() looks up ev->handle as an instance and
   stores it as conn->adv_instance.

Also, removing a single-set controller's instance 1 now removes set
0x00, which Global Advertising also uses; if you'd rather disable than
remove there, I'm happy to rework it.

 net/bluetooth/hci_sync.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c9e80b957..cdd175fe5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1248,6 +1248,7 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 					    bdaddr_t *random_addr)
 {
 	struct hci_cp_le_set_adv_set_rand_addr cp;
+	struct adv_info *adv = NULL;
 	int err;
 
 	if (!instance) {
@@ -1261,9 +1262,12 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 			return err;
 	}
 
+	if (instance)
+		adv = hci_find_adv_instance(hdev, instance);
+
 	memset(&cp, 0, sizeof(cp));
 
-	cp.handle = instance;
+	cp.handle = adv ? adv->handle : instance;
 	bacpy(&cp.bdaddr, random_addr);
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
@@ -2067,6 +2071,8 @@ int hci_enable_advertising(struct hci_dev *hdev)
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				     struct sock *sk)
 {
+	struct adv_info *adv = NULL;
+	u8 handle;
 	int err;
 
 	if (!ext_adv_capable(hdev))
@@ -2077,11 +2083,16 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		return err;
 
 	/* If request specifies an instance that doesn't exist, fail */
-	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
-		return -EINVAL;
+	if (instance > 0) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv)
+			return -EINVAL;
+	}
+
+	handle = adv ? adv->handle : instance;
 
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_REMOVE_ADV_SET,
-					sizeof(instance), &instance, 0,
+					sizeof(handle), &handle, 0,
 					HCI_CMD_TIMEOUT, sk);
 }
 
-- 
2.47.3

