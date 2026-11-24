Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532852;
	b=AwlTPsWe13yDmHi/QIKxgQlVPxK84Q8fckv8h2X9xhwcNuP31FoFwtWvnD5R/OeD/+/6
	 ziTgX4l08znEf3+17+nMV4xYCumrgFlcbS1WgOIPmKW1r3PWtNpz7Nsm/R2q1NzSZIIjp
	 9ysBhVxTQVaY7OtY4daEKLl/ejcHhwznbqLj+KejTiES8d6LqKZ9/Eycf2+mODtdw/Lel
	 qd8T5G23YbU6gIGX9cEnzIXo5VGLDVzICN5sGvl1JoE8jTHtiT3G0uwuipow3Nn90LICI
	 AHs3pFCIL6UutkYbPC9NQu3guStDvA4NtlvsObQpg4F982vDpzdt+mWcwRReWWzlMNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QWQLkDLFKoSp0VrlEJJsDgRmhEMyfHQqSz5LUKuP/dc=;
	b=PiADHg1Y7037JbPqmMwdVkyykP4neTYoV3Fvl3OaQxyfq8BlyKuj/ELh0dX8pwGfzUU+
	 tDFXALVMkVs5UsT4gidddpHn1oxjXs4tCIv9/GY1HwttM5H+lpaEBqsoJ1d59gTgI/Nnp
	 XTG2UPMfvJyI7VJe28hkUDiG2Y0to0+10MPf0FQnu3DwXh1+2w94V+S1nmdnEkeBZ5HdC
	 1w42bjHHdka5VC/iRDUg5YvN1VUl0b/nBkOGUGU20gGsbtgfRv6qh76/RHuZ6T3maIiH5
	 kbfTYSAbPshTrSe6HAF5ePPOOvsKaVNFx8EErAg/3zFzeUb1iMSli07w0j4p1MsaoCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XWMYmjy4;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1970C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XWMYmjy4
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so36224775e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532850; x=1796137650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWQLkDLFKoSp0VrlEJJsDgRmhEMyfHQqSz5LUKuP/dc=;
        b=XWMYmjy4kbSsyLoHjOuFd4zD129/8EDp4U1Z4KSod+AB9zcdXegQMLK1IGzT1N/zsG
         emUxgWFMIx4mivLfJ0ULX/mS+WBKQoshCNEUlXAe0x+ijBDbiYS1tBDzC3jRgyzmb/yd
         D23yeRHYCrspiGW+SH4NVYThM/EjsUmI/9yVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532850; x=1796137650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWQLkDLFKoSp0VrlEJJsDgRmhEMyfHQqSz5LUKuP/dc=;
        b=FtziecWc8rPqvDB55IAPVtN2QlOw5Z+qWbSHNVpvG4c7sSLyW0TjsIDICDox404Sgt
         x5Go80HmBnMr/DenXZKkNVcFYsKGEr22zXjse2dASyVixBcghFeiCw08cK4iBvgNLd/O
         VKMSYtYgjVcEWGXASxsGedEvSlveOUhMRS5un0lOgI+LOnvr8hXHmnDQy0DfTfNPpNcx
         /DuzplkkUPEVQVkiQHr30cW5E+ijOKNyowJfUTNcfg9OLat0lIqzQobfla0cct7WoWPh
         Qtnh+4EJbHxqrEwdCe7x4UTMrWm8JcK8StQueDtampWkqSqHEar0GzQMr/fhsBtBevMF
         HPwA==
X-Gm-Message-State: APuU4Z8qqj3gqyxRS9PTkelPv56AKDon5lGSASW7blHqxm2nwp2InnEt
	fUs8nBKDuFjSJ9D1+9cKdYI4CIuGEc40NjPAsXfY8Sd4bwYoGNfHJeZU6zXtBn4qYXC5WhLez7m
	axOpO
X-Gm-Gg: AZFdTZd6NjTSSGBgEjrRuvnAHM3TnGOLym9YJBpePUogXhG5CYa0mekC3jX/qDLbp5x
	4ME95YqEfnVAoFLMrBxC+yMsZMHKyaB25hq5QiDWuO4kj3HAqwYXYqmSVbBg9QRVxzRp6/qvizX
	mIl93KwKCMABNG6DHZ+3iK3sGckkiTCzUKoP5oDJ27DqpNzGS3D5EC1FpMoa+JNaWQqJZdxmX5c
	U2Va/BHpqaAdtNHLh/KqoWt0RnsXzxR/LTWx6qcj1sSEFfcqXpNlmwiul1bhtjinKi7sixpoeSD
	Iq8KMn3krYBKE2wj4RsLrAnyj9w1WOflwaUcKvibqegxelRNP5MU+poXGiyERYcZfVaPIe90hlH
	PNVUaRA+fabPgTc9HACtlJNauV7fkYHL4zdb1/dA8KpTjUt9KjsXf5dDfiXpkmuJo/6GXzmVDBP
	hboL9e/bcLMS++dcxqID7Mb4LdxLYfHiXqECAjhQ1TQJ4cYuv7s7W2qUhAj7KhinV3inOI5yoVf
	jzUy3Mrn01J8LUqRNKQG6wEhIkEHHkyqoeg3EDmgprrzZLKRVNaymZIRnCdc0nhGrlZofxqnKW+
	yVTtIHSOccBJOxGrChOcHyfBmqzjkwlhoVbcMJr02Sqmw5CDAw==
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4bb88785d24mr291951645e9.0.1795532850448;
        Tue, 24 Nov 2026 07:07:30 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm27844341f8f.36.2026.11.24.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:07:30 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Don't keep the handle of a failed PA sync
Date: Tue, 24 Nov 2026 16:07:28 +0100
Message-ID: <20261124150728.332222-1-simon.mikuda@streamunlimited.com>
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

A failed LE Periodic Advertising Sync Established still stores its invalid
handle, and the controller gives the same value to the next sync. The
lookup by handle finds the failed connection first, so the PA reports of
the next broadcaster go to it and bluetoothd never lists that broadcaster
(btmon, shortened, on a 6.18.2 based vendor kernel):

    PA Sync Established: Connection Failed to be Established (0x3e)
        Sync handle: 0, Advertiser address: 50:1E:2D:00:42:2D
    PA Sync Established: Success
        Sync handle: 0, Advertiser address: 50:1E:2D:A1:5F:1C
    MGMT Device Connected: 50:1E:2D:00:42:2D

Store the handle only for an established sync.

Fixes: d356c924e7a3 ("Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 610207e25fa4..35fc46dcfad0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6842,7 +6842,8 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	clear_bit(HCI_CONN_CREATE_PA_SYNC, conn->flags);
 
-	conn->sync_handle = le16_to_cpu(ev->handle);
+	if (!ev->status)
+		conn->sync_handle = le16_to_cpu(ev->handle);
 	conn->sid = HCI_SID_INVALID;
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, PA_LINK,
@@ -6862,7 +6863,8 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 	if (IS_ERR(pa_sync))
 		goto unlock;
 
-	pa_sync->sync_handle = le16_to_cpu(ev->handle);
+	if (!ev->status)
+		pa_sync->sync_handle = le16_to_cpu(ev->handle);
 
 	if (ev->status) {
 		set_bit(HCI_CONN_PA_SYNC_FAILED, pa_sync->flags);

base-commit: 62fd917f6d2df1a399a453138c2b7cbd563f8f95
-- 
2.43.0

