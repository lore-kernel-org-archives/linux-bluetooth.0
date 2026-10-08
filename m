Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01647F3B7
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498405; cv=none; b=qCKy5SVbNYIceq0wx4uf6dbMsdJmT0h/Z+iYk+R6UXYmWO+TdnnW/qRiUxYQYEt69QSajvVHvuhfNzdAW7fLWYbBLXllZDH0+pnTJQrXdtgMighPtQDH5CUFhzTBMONYQ9w7+9Fk5YP3la409S4S2he7VopmjGzNDhSf/D8yzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498405; c=relaxed/simple;
	bh=BdXuWYnFC6mW8AzlAuTnRylrEW9B8jQRjQdbFJ/Dv3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq5c8uvffSfF70v2VWKrhJN7rZ3LHrlAboVII7iCph8wqxa5KVOcZk0iBXfbKsmHtwZgiXsELsv/H98aK3q4bW4R47bhtDqPpIepFTyHHMyITN97nUv+UA8DchDlMuDhvoSEPHALulOh4tvYigY9UQg9mkD22Dv8pKc2Br4nVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnBs20N7; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnBs20N7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3517ec27a49so148080eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498403; x=1792103203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8HRxgfJUsb3JUSHlaPlRDGMli+DzHQt8v9NsuQ2Tag=;
        b=BnBs20N7d1oy2GR7K4YqFp0JzRUjBl4RvbTyV7SOMbZ4XH90iWGuG+79woqLoQVBiA
         GHZVIWkD3Ua0RGgbmDK2HseVGAVMR+c8/VjHSnvOrATwD/4cACr5WwnVq7AQF+iHnaeD
         qH8KLYTGC4fuz+AIFEXsGjyGQ9mbxNUgSqXThoX2UZ7Mowbf2CgvBptKZlY/+o+h7Iu1
         FMfS3aR3C4UvtE1nAEg9wIO9K2/SSvRGza3VqH+PXT+OCcqUv52adt1no9aN7dhFc093
         WWgwnv2MCYUDBFFEYRZ+aUv7aZ+JPfrcr2qZVwooYN9F+BILRLQpsPo669VRmQvSsesT
         LN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498403; x=1792103203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H8HRxgfJUsb3JUSHlaPlRDGMli+DzHQt8v9NsuQ2Tag=;
        b=ZTTHxiIYgeeGoF6pezN0O0umTf4jnBwbIh0lYB0tJ9b+ZxpM40jJ6CvFcM09mteHZV
         +UR87b8QgikQyhOiIOMIimbhiSjJrSNAS3WDNkPYrfpJAKmFRMnzjaxEVTbEPJF14VcA
         HiVVwotSIe7u36OnXmwRVaVUMDnv+4QtOAOmKWpZBRmPuGJt5a4zO8qxMCsMRZ8hvxpW
         OiXvAwcxRs9dTXyiHldmRPWRAN8n2SBRIa8MV3CkYsxaA43V7OyLTksM2zm9uLPjqy9z
         BNZH6XLMtVFSqAlHNsB7lmsdQ8JYsFF1JxITrmUm/EPOiHKFCwDgbvJ3oaxsKnNaoV/C
         LUZA==
X-Gm-Message-State: AFq9FYJDJ9H8GVHIquoTqP+DWJ4+24VBDh9xop7JY6iwPx8Dk0zPIPYJ
	Ls9Kg8oz+AJhWoMMkNSFWptq+nnQiS42/I16lv1cVjCZIzV9+ItwZB33pLuDrxqCQjI=
X-Gm-Gg: AYBFou0ipaKhdaMJwZ/aFfQqSyYp8ddGjoRkQw8UXsUHiEfBAjDr7GF6yJSnUdzJLmW
	phJUEyive6/Kyo/ewpjh5GNwqYCzwKTl8d8PLmcoQv0vJwk4YpgW65LIgMHITbHZ75Z2EsFVZnu
	cgYPgBS7R6zIZIvsgDwQVS6UBinkrKjwMisw8RAb+s8252xlix8k2Td4/6owlhI8cei9ontDhtr
	bTkg96mQSOJk4T9johgTk1o+Dchud/EgCXwJfnjKXSRaHd/BLq01MxU5GjVsEsJPqo1hea6NNG+
	u9GceuXRWEq/EaZMCMg4+0ngK+b8TrkD5T5gSDqCLbqw0BOA+eushuKBll8NOBYsNdknTZHkcqE
	/Gd8ESfBblo8o+ICKotqlA29Oaa9IO169gT7Mb2AbNen6/WuKw7MaD7O5I1Ltyv6HJgfyK8Icw4
	+zCrjLQnoEUq7aeSys+kJSij8cA0NWBzN4RhQzDkrqGF+EW7+B6EmHUt9Ylq7/NfL5RegmZGKlG
	7bhQ5f0HgsEuUtQ2tnJGbIQBe5bVmQIVu11sNf+
X-Received: by 2002:a05:7301:4d0b:b0:33e:6714:3945 with SMTP id 5a478bee46e88-3537e0129e3mr468276eec.2.1791498402836;
        Thu, 08 Oct 2026 15:26:42 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm985148eec.24.2026.10.08.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:26:42 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v3 6/6] Bluetooth: hci_event: Notify the driver only of SCO links that came up
Date: Thu,  8 Oct 2026 18:26:16 -0400
Message-ID: <20261008222616.2780570-7-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008222616.2780570-1-enghitalo@gmail.com>
References: <20261008222616.2780570-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_sync_conn_complete_evt() notifies the driver of the air mode of a
synchronous connection whether or not its link came up, while
hci_conn_complete_evt() only does it for a link that did. A connection
whose link failed, or that refused the handle as it is being aborted,
is deleted right after, which notifies HCI_NOTIFY_DISABLE_SCO. btusb
picks the alternate setting of its isochronous interface from the latest
of these notifications whenever the number of SCO connections changes,
and HCI_NOTIFY_DISABLE_SCO selects no air mode: with another SCO
connection still up, the interface ends up at alternate setting 0, which
stops the audio of the connection that is up.

Only notify the driver when the link came up.

Fixes: 1f8330ea1692 ("Bluetooth: add support to notify using SCO air mode")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 14270711c..28fefddf9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5307,10 +5307,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
-	/* Notify only in case of SCO over HCI transport data path which
-	 * is zero and non-zero value shall be non-HCI transport data path
+	/* Notify only of a link that came up, and only in case of SCO over
+	 * HCI transport data path which is zero and non-zero value shall be
+	 * non-HCI transport data path
 	 */
-	if (conn->codec.data_path == 0 && hdev->notify) {
+	if (!status && conn->codec.data_path == 0 && hdev->notify) {
 		switch (ev->air_mode) {
 		case 0x02:
 			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
-- 
2.55.0

