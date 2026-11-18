Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029099;
	b=zfOfFw6Wc/VloKm2QwHR0d1RCxGjedIM9laPUHhprWPQeDCHCjn7oKyz1/cvAh5DKlMB
	 G/sTqVP99fgbwAW6vj8SHxueluZjfoec//feb/lyT+DAWkiIEd5qVLSEiAUjCx9vOoKFU
	 qLRSMNPSPQJSVkhVNNCuKh1LkrXM+wX1nb/2jAJuM/UWPSthT3dO4Bclc0fJfR9t/WilS
	 zOh2hy3v962jPVxeB/Uwtgwg3iRUtt9jthgpL3rJTpQfceskqW3n2+pCB49/a2vG34I/9
	 pWL96LCQePV7N/ViPKgzzTUZq8P/B8K2UfziKm3jpVb3MPJ2CWFacqRbeER09hTc8VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
	b=gVVkf7heCGmbwRjPZGrsi7VKiUL3ANEr4BaaitMj40Dbq+8Mr86HJ0/IlhlhDlA9gbQo
	 lM9mOXjRjEXj2BB6W/6lMlCFiaWlcp0dVjiWuSJlZlslueb2JkNZOSFBZfCnPeWn2K+sP
	 FtjjGyNePrEqqoY8Lc2dqrgF07wlZzcfjb3A4nwTM3dTUV6sBIXilKtM8tWqXjF1pwVTD
	 COQMBS/ozZHPwWGXlbi3mDj7b5zD98NRJGyQdf2vsBOubBl6avMQ5wMJ/Iknfyx9wcAS1
	 oraDck1lZNOMIcHajNM66GS8o9R1ar7HEhGPnoWzRSZqgHiRi5xtVzQYHr7kWx9oBdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2fXnTGK;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB8606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9BB8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2fXnTGK
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so820524241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029098; x=1795633898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=w2fXnTGKtKxwMEC1hzJS2s+uyrm/6PKwbHhHq33A4dk68X11wpZmWNIuwCbKsXSAQD
         S7VRH0aIyPVm7/DP7z5YOIARR+hPPTvUQJIDJUniYAvaXYie4lqRDBOPnIZhT7Un+Czd
         zhYVUIEHIJkRI+fwlhPvXWN2V049nbO7wUzveguZZa9pQ1o9BJFNzRF53tWZ+T/gWj/6
         qcyU1wdkp8s7JMOoQAaXpCpeGF46fH3VoWnoTfS3seL+zq1/m0YZ5bY4Ai6pFtJ8hsQq
         aKdtqhKRV4xNImbZ2CGBHTRPLzzlQkgbwCXn9OqpVzkvRftd+7WklO9+GHCVACq9t7T3
         +gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029098; x=1795633898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=TeZiZJlumX+C0wwPcPBDTF5ou/VVQXFg45pl2AOwKydKU9EKo7zfnEKNMIBYPniywN
         pm54V73jZm0XgOl16ESOLCu/9356Ge5M8CrOW+f30mJL6F4a2/0uix8qY2/V4Lv0Mr4L
         2ECL+YoHrIuKAZE+1wDPE6z84w78e//MR7U6arqiMJlCT3dZuRqNk/WQF+Ofnfk9KVn9
         b+1Ahh549eVLWZrRApAuqQdqe2IBXwRU52l0Nog/YH/yG9nKqu+CgxLVIKe/3oPGDAUk
         JIEFP/7w3KLlmrfl29eKE3jQ9PI+ubxFYihWD02k1VuU+0KXmzGm9pwOXRjTXO/B7jUS
         GpCA==
X-Gm-Message-State: APuU4Z+Hf4DY5yJYTqHwLoiZ5GHh7cZ3fSO09QNPS/SrqNdbJRjylp4H
	S+2DUpW+R9fb1LCqrwMfPeVPqjG02QWalcWcE8BDaIj0lFtMg4kwm2wP8Yd+JI4p
X-Gm-Gg: AYBFou1XeHYVbwY0+8Syb3MTNjJarQO4wy+1a9QXOWxD5zezhScNwxMjbxcocz9L9ss
	0jBl6GkxnwbHHYfgDgwJWpS4B6C2WzmdHNQFPxWPo4C1zv74vSlVJGtbysaACPmkUCngl8OrbXN
	086ezhwPObSqyuTvH7JdGP3g1De/OiF9p8vWZ+D3tPKFNUFhNZPLL90o4q2XwXh04yQKCtQkQOj
	49HkWppAFL3WKVAYV5J/c1Ag3ty+hbCkuCrvk+H66sholZU5NUieT+U6dIDs9ReoeTLrA6PgMEy
	mMff5Gd2HQeOfYcZT95Pasc+YgYG7cvPat7Q9VTflyupo4i7kGkwzVLSm6gW+YHoekShcce5lVn
	sLDe/8MDtSNhy3IqkZwpu/mUOoUSz6kqY6vebxYICmsw9g4V1+RB7cvD7yT/Q2hinhNoJvxepd7
	EwXqorHqGCzcdjtsnMN4/CSd3barDEUsg/pS/UcDE8Gs+eL3tzPUicXo5FoKEL9HZOoT/rHv18f
	eQmp8pHU9ZJ3I8LHsTG3FczL4miDALgnHjfR51k6gVZdG5tt4jY0L6V/puHztwWE0sgPapplqmI
	dTb7wHCY+nPPEzp3r+KkPLD2mZEgSOyUcksJ8n8e18lI/FhXT+snpr5dhLrB/dwaS9s7EsK+5+2
	2WirCBmxlGZBARmngncr4lSJsF+OgShWz2dpdlWjUFuSSDmUV8WdRvfeo2BIKRH3dxaVeOxc7D5
	bxWes=
X-Received: by 2002:a67:e708:0:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d6ba4acbd7mr1658548137.27.1795029097392;
        Wed, 18 Nov 2026 11:11:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
Date: Wed, 18 Nov 2026 14:11:18 -0500
Message-ID: <20261118191118.318779-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_adv_monitor() frees the monitor when the controller has no
matching handle for it but still returned -ENOENT, so callers took it for
a failure of a monitor that is gone, and hci_remove_all_adv_monitor()
stopped at the first one leaving the others behind. Return success since
the monitor was removed.

Found by the sashiko.dev review of this series.
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5522d4397682..024960e9af66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2134,7 +2134,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	hci_free_adv_monitor(hdev, monitor);
 	hci_dev_unlock(hdev);
 
-	return status;
+	/* The monitor is gone, not having been known by the controller is not
+	 * an error for the caller.
+	 */
+	return status == -ENOENT ? 0 : status;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
-- 
2.56.0

