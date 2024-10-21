Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05B1F1300
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513531; cv=none; b=RVeH5iO/f+xdQ5g0zTu4eMbtRj7UDmA71fgXj1lbheTK0ecUO/qdh2z4dLQkFQ46qhIB/ZSPS0QjrVZTHYNngTVrb3P64WJhYPjrUgizXMyEbGDxfQl4iMKTRPIK0DieBQ3I3/p9bBU2wvGAYyiMTh99hQ9d6sNY4hc+6Oa8A9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513531; c=relaxed/simple;
	bh=nkmqn4efxHj5i/+TRFAoOvi1Og9DVd8FDufwvFPiDk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUjRdrGK1Q6yDuywfE0Mr/TRyn9atXOG7ZW7Z0Wr/CBZg0YIs26zWF99XvXc8/OowEOUdl5aFS/+KwC72Mnyl0V19MnfgtBwzk9WcUKqMziJ2MHR8+xPGCDpJEveHIE3yvaRBtAkgoBdlJS2t3fpgKkbCxRvFq5erQlqiWl6qLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGDzc66H; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGDzc66H"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539eb97f26aso4882767e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513527; x=1730118327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7wijC3SR4+mgvDEZEUCC/DXA2u96faSspEMVqCVdB4=;
        b=AGDzc66Hi0ALQSEVm45ynv/IRqo/oyrYQgUy8caziAOuqTv+VDzdYB9ZV2PfKltY8R
         ytcVekOT0C7K6vu5XkY0sXRlYjbD7UDYc1cohaW5L3YwnQqIfms06qAknw2SzvHqhr49
         R8S16VQ1DiS+LasGdRfEK0fdznOULveaedP4Zy9lis5Vkgk7gwPVFXzu8bFUPU07ZGIX
         aZHG0M5AJCY10VITftEg2IdkJl7NpG8qJ9eh97nzifETtYml9HcopjF/fL7OOp+dRFgx
         nhfj5o+eNtscVA9a1UR1+RkLnnZkIie5SlDjiyI7lTav+WJ1r1BDpfnCJCf4O6fwnJMM
         lhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513527; x=1730118327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7wijC3SR4+mgvDEZEUCC/DXA2u96faSspEMVqCVdB4=;
        b=e+KPtWqtvJ4w6jfzM0UtUxUDnEg03GAZATPtxNNzkUhcKkVQYeMVx5hOIXnPlL6xi1
         qcjaJ/sv0LtazTCNmP1oKc0U1jsMrF8CV2Yu9DJhXdUv7eQ6CESIldaSl3Q23GP81RJ5
         tHlGW5kcLUiR9Bg1TrhaZ6R7UJKp1QMi/F7QqmllenAhe+aMp3asgbH7SE9NTfXtaxfA
         0Y1bNNA8/rWPOjHqZGBMMS+FqYo+ZO9FeGfC6CUJMSpHFiW84C15T34bH9Pfx7r8x0BV
         BfA1xpEOFGIO0ImkVCnRNrlzb6HJezjSDOYx0PaZhGbCdjtSqLrOJEc4rNMNXrUt2BZa
         +W3w==
X-Gm-Message-State: AOJu0Yy9GetSEQpu7ga4eo4xdKwUbAnMA5s5XypLW87KK4htpdGK/zsq
	HIZh3qLxHXd2gGzvj/Ob+tRfG+p8ML0jXUk8iGlajc1u5WdhYvmpvTMNn5j5924=
X-Google-Smtp-Source: AGHT+IFr0RAVDUyJgmoQrEpZi5N63qpPoE6QkQxeu/TAq9yG4mBYT9ZbM8XVoKYdsGBTGJVXJU0vtQ==
X-Received: by 2002:a05:6512:31d3:b0:539:e232:e436 with SMTP id 2adb3069b0e04-53a15218a32mr5009736e87.24.1729513527021;
        Mon, 21 Oct 2024 05:25:27 -0700 (PDT)
Received: from ha.lan ([185.52.141.89])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f02c1sm464015e87.111.2024.10.21.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:25:25 -0700 (PDT)
From: Danil Pylaev <danstiv404@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: uhrmar@gmail.com,
	raul.cheleguini@gmail.com,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Danil Pylaev <danstiv404@gmail.com>
Subject: [PATCH 2/3] Bluetooth: Support new quirks for ATS2851
Date: Mon, 21 Oct 2024 12:22:45 +0000
Message-ID: <20241021122246.1569235-3-danstiv404@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021122246.1569235-1-danstiv404@gmail.com>
References: <20241021122246.1569235-1-danstiv404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for quirks for broken extended create connection,
and write auth payload timeout.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
---
 net/bluetooth/hci_event.c | 7 +++++++
 net/bluetooth/hci_sync.c  | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bbad90ddd6f..65f5ed2ded70 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3626,6 +3626,13 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
+	 * to avoid unexpected SMP command errors when pairing.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+		     &hdev->quirks))
+		goto notify;
+
 	/* Set the default Authenticated Payload Timeout after
 	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
 	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 40ccdef168d7..cde96debef3f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4838,6 +4838,13 @@ static const struct {
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
 			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(WRITE_AUTH_PAYLOAD_TIMEOUT,
+			 "HCI WRITE AUTH PAYLOAD TIMEOUT command leads "
+			 "to unexpected SMP errors when pairing "
+			 "and will not be used."),
 	HCI_QUIRK_BROKEN(LE_CODED,
 			 "HCI LE Coded PHY feature bit is set, "
 			 "but its usage is not supported.")
@@ -6467,7 +6474,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 					     &own_addr_type);
 	if (err)
 		goto done;
-
+	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
-- 
2.43.0

