Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333246;
	b=FUItJBu9uZbaAbj4dGKB2NfauHnW6nvyozn7uxVoT1S3Xk6ub9GmmKA66Iewi7L/OjQC
	 TCV/bpihpZUIMcvqlU/hnX10xL6iU82xIWa0PirVZq0ObsZa3dgT/vJ7pZEq96tI/vCQK
	 uFp8XdEJjjPJSWHJP+Yv0sLDqwESJJ8Lil7pOkFSnbCojvduCCAS+wXONR53E+z4en49+
	 2lDzEKsRNBu3M6aoOhPYx+zL3bmgioGptOsokDajbcmqfp5H+s0lXmu9OEvXNYoSzUAl/
	 AC3M1J+KqVNWqdPLWJscfxIVINIHGzGdS4mkZcrG4FmidTvTbYVwk1mEkqVEE0eFWLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
	b=qHojbG1viO8pPCz/7dJgeoCnQ/4Zu6dr8Ne4N/McZTqqZ6bzfPPpShNKWDuiel8W8h4T
	 uMzlAEhV8TfnMheZui+rUDGC0Km9qoUORxAl/4oWVHx7nZBP7A6s4VVpYgxbf26+7ionI
	 G3e/C25Z9kVRmhuHoP/M0HyVjpwrLh/OiDkCsSooQuyg39LVdx2PNVFIgxblkAHSuiaGa
	 BLlIYZxry6wC0heFtNcndu35POyVRVUsBjSPw88elb1mj0mIjcHVPv++U6qqCUnyLWoZ6
	 EgwPGJwDjvSgseaFm/cTuTzzJHmf33eHuIZyrzB2hk+trkPPFLdu2+xTXpQcel9g6aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MMzEiEXv;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36030606A206
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36030606A206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MMzEiEXv
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so3633911c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794333242; x=1794938042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
        b=MMzEiEXvFOif7JcyED/VTrHGWAmrz9sVbe2WvjhdzoUO06U9CnL9Z4HXaF94yk4AFO
         EkVh+Qo3VL9XZrinppLR8Q6yIMdYa8PmKRg7Emkkpbh1d0Z/JoR5rNW9hUTMtOzza8tr
         zP7lfFDfShQl8QLZMfsrjAbiXcbj12PVGdaGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333242; x=1794938042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
        b=CcnNZz3M3CJvn1rocT7/wFpqhaTiOiu9vlvIPQ7SXrK0L+jIm8jZioy1ss5BCuy62H
         NrutYN6aGjYHB2Q2I8jqtkqxDDV4zl7N5CLF6PKLFSkgnehuHtKANzGIli/TK/oHifnq
         wvyv7Mrk55cSgLxg9DVrSH8XPucKTxXfWsqy5HtGo3tltJTFmsppquQ/JcTfuyscnBla
         j9UUCzvmdBrD0K4u/BFnfehur9Pia7US0bc+NRE5PsJ9B5RpbaI07Vc24xKcS32hJO9P
         Lvm5HSRtT9KjtNitM+ic8+MOFlMS6xxcZUdHZaQUyML2ghJb6O/HRJw/dX3+n4+OLnSA
         R99w==
X-Gm-Message-State: APuU4Z/7adW0OwWBFUVGbOXiqtiJiFfjiV/EvXVJuEDiBWN2vZA1z+qz
	F2yK4SraPc0avDXcgPh5WhvdJrYNOka/K5BLjnLQ996TOLDs9NbD+4BaaTOvjwxWJCE=
X-Gm-Gg: AYBFou3lNRntva3CbmZtJweZak3X5H5CS1/6CwV0rIR7hjl3TwVFhaj6xmdhmRIa7F5
	qgxITG45Wfft9jo1iTtIHuVfRE09xIeHioyycUG78pAAzSDlsk13Vc8FHvaz0WB7n5205rm5mMk
	07dkn2abau0v/V5PIO2Kj/UBKeHLXcxn2GnGkNmfkasNmQN7ztlk4PxutL7BAwcOicYn6Vg1CmP
	oZJI+ab4/dy5hybjpTPjfN51UcdMKQr9yTPH2Ox45FJWkBdOSEXZ4HtFIG0GSHKaOVc3UOTx5/R
	bDUZgKxKImoC8k50qVSNqRka+AMnPL2jlWuhY9xuye3qU5cFrlRSYBcYzxAQ8CDEzEss7w3t8TR
	MahN+CkO367autAWd+6n2c6WfNZLHu3rfTX4mtCsNyf3EtVIBH93vxowBz3DYPygPcoIbkG7Fzf
	AFH8Ek33vIBL8kmKw9IX0D6MmcAoKRW7k7eZxGEZB+VjBC9GZG0vK1D47vMf82Fvs+q3KSdA6DW
	3tF01AbZyLC3BCrmy1DYXBhe/MgFt7BkxcJX73KAcbjfFA9dcuYCAQoU+NHZC9Z/qO7qiMvosYO
	eOgTPu7Ls/h4Voz4spmNPJ7XCN4qb5ozn6/9Vua4CWfLqN+qWxULar+gZ3QsJ06GkVFoZp5q7Ci
	bW7cYfY7+lnp+r2KKZQxdCaRK4xaRjt44ekYg/6x/JIxioGStI61AYc27sO4ORf8Y
X-Received: by 2002:a05:7022:e1c:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-1b3b5fe3b41mr6356459c88.18.1794333241526;
        Tue, 10 Nov 2026 09:54:01 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm11875452c88.5.2026.11.10.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:54:01 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the controller cannot carry
Date: Tue, 10 Nov 2026 23:23:34 +0530
Message-Id: <20261110175334.676816-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110175334.676816-1-piyus@iiitd.ac.in>
References: <20261110175334.676816-1-piyus@iiitd.ac.in>
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

An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
in adv_info. How much of that is accepted when the instance is added is
decided by max_adv_len(), which depends on a feature bit in the
controller's LE Extended Advertising support:

  ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH

ext_adv_capable() reads hdev->le_features[1], which is re-read from the
controller on every bring-up, while the instance list is only freed in
hci_release_dev(). Instances therefore outlive a power cycle, and an
instance added while the controller reported LE Extended Advertising
can be far larger than the capability now allows.

hci_update_adv_data_sync() picks the writing path by that same bit.
Without it the legacy path runs, and hci_set_adv_data_sync() writes
into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
(31) bytes on the stack, while eir_create_adv_data() copies
adv->adv_data_len bytes into it. A controller that reports the feature
on one bring-up and not on the next overflows that buffer. This can
happen when, for example, a USB dongle answers LE Read Local Features
differently after a reset. scan_rsp_len has the same problem against
hci_cp_le_set_scan_rsp_data.

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
  Write of size 220 at addr ffffc90006b679c1 by task syz-executor

  BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
  Write of size 220 at addr ffffc90006ca79c1 by task syz-executor

Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
re-arming a stored instance.

Bounding the copy in eir.c would leave the instance registered and
unusable, to be retried on every bring-up. Unregister it instead, once
the features have been re-read and before anything is scheduled, and
report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
instance again at a size this controller will accept. Dropping the
instances before the list_empty() test below also lets the default
instance be set up.

The removal is under hci_dev_lock() because
hci_schedule_adv_instance_sync() sends commands, which cannot be done
with the lock held.

Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH")
Cc: stable@vger.kernel.org
Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9f26..ee8b1cd9dee5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
+	/* An instance's data was accepted against max_adv_len() as it was
+	 * when the instance was added, and that is a branch on a controller
+	 * feature which has just been re-read. Anything too large for the
+	 * current capability can no longer be rendered: drop it and tell
+	 * userspace, so it can add the instance again at a size this
+	 * controller will take.
+	 *
+	 * This is safe as long as there is no command send while the lock is
+	 * held.
+	 */
+	hci_dev_lock(hdev);
+
+	list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
+		u8 instance = adv->instance;
+
+		if (adv->adv_data_len <= max_adv_len(hdev) &&
+		    adv->scan_rsp_len <= max_adv_len(hdev))
+			continue;
+
+		bt_dev_warn(hdev, "instance %u too large for this controller",
+			    instance);
+
+		if (!hci_remove_adv_instance(hdev, instance))
+			mgmt_advertising_removed(NULL, hdev, instance);
+	}
+
+	hci_dev_unlock(hdev);
+
 	/* If RPA Resolution has not been enable yet it means the
 	 * resolving list is empty and we should attempt to program the
 	 * local IRK in order to support using own_addr_type
-- 
2.34.1

