Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74ED4DE721
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472392; cv=none; b=k5k3SYuPy8cq8C+wIkELEL3gsxNS2OGuw6HSFGMBzpvZR0FIAl+ucwyeD5tg+ph/+0I/Ll1Q+lNC3NHVfVyRjeCff40Cl7UvQM/+MlTRwjKjldwN8UjPE7gbvXYlp/ICAeeH/kCLjDuG3B+RxV7hYIr8twJgh5VdNs1306gwXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472392; c=relaxed/simple;
	bh=XK1oYlYECHEwBL7QCAkCIQPSESe0kV06DpwVskF/JVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVaFEbP8M9jrCTidj+oZdixCqnMfvk1vrk5lKCQjQdfMvkAnstKaY+Z5uhJxLZjWL/+y41LQI3E4IrOwYBSSIOg2wAM2p4YLIzaH3zli+kDFd5H55w34NSN3HufSMjCdsQKPxJYSmOTn/89djaXX5jWWq39urXgT/FLHhjBz7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/2k9wMY; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/2k9wMY"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1430eec0070so69039c88.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472385; x=1792077185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjpjkwPYKzGVosbZ1v1zTZF30K7B38BpoSgAGU1cdHg=;
        b=c/2k9wMYqXb7ONnuLoUFlI6uujG1MMT4GdhftCLUhSWOUUDlERVzsplpeMgAzS6hac
         9apiFRrbh04lzcS0XIQiy/2cBshURRTCH48EeK2Vpr/uuKXDeUCgweG7btZ18AEP9j8o
         HVHiCs2Fp63mOtS+EYUvFKXWULYnRep6FH+8RjpCWT6MBWCp7boNL34EhiHdtcZIi5vE
         vEELD+QtWJ6tjAwQ1nPYf6HVVfbmi0OWlc6FaIRMl9P8+ro6H7oZn5Jmi+1tNEqwD5Tw
         OvdWEjGA4q7elKKTiJa+2ja+6C1F10vMuQjt95rfOtoNjv0YBoktWLcHmHJ5vNnaOjzc
         xIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472385; x=1792077185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjpjkwPYKzGVosbZ1v1zTZF30K7B38BpoSgAGU1cdHg=;
        b=SGJzg5rCAl7kgAmWJdv/weNhf9oSmLqagLhAb+FfmsNx7EIV9W8B8znkVNn2UOQvGb
         tZ18v6WAp78r/SqUiqwz2cK/BcWM59NWq6Jc0dsPeng0fCm/lbdzOdxptCTKpbyb7JYh
         Z+sPsoi6S3PGUFuSIZK5wDg8USOzjEHyBlpB8dUKWUkT50J5J3uLQYE7nJhrmO6ru75y
         1DyuUUWUgJAEAoTlW5WY9eNpqAoCjsBygPlAKRKeW2my2QJjWebB66mmLD/O5wGk2Ktz
         ub6VWKOO0lZD0TVXh6wqxextCh73qXkFbD3kn+cjuG+jnPQGjbUs4vyECxrZBV/oJ2cu
         dNiQ==
X-Gm-Message-State: AFq9FYJbQQKDay3j8B0iHlvrUPwaEWamcNeblRh1aBXRDK6T9oBGDQrw
	L0FSgdH0mJCapsYXv8Ciky5pEv5dEP3mwa67onBfpHoz1KVoqme3OpMO6jWVMd/8g/Y=
X-Gm-Gg: AYBFou3OlTpXJN+YH8N3NUvcJe7lW5urIltQYODUhpgerUZX71XqRBTYkKNHGIs1ta1
	Tz+KA9JdXU1PPNUq12nkJsZYisvRhJaQ0YN4CcX+mqhrbg0C7sDrD9gOFVfVyNZnZFWZvD3c+vf
	K9WRGtCfdyt2IQ2sR3xO2Mmup2kKFUFWL/j4r6SRQaKe0VnVGk/BJZ0G02XmEkuJUz3qSwXzgwS
	MjvqCYDdXxcEMc9BkWPqiv9qQUfzcBCXII7mrAwI2V6htW/XOX5DOBhefZoC+OVZ2u996MmcUuq
	4CC7IeHqUK18obKreoITQK4hXsrBkjE85BQ6RPmGGPBBfDGk8jsdN8+9viCNZcoGyFKt29lbpN3
	PCZPWBYj1NXXtowbPS0V4KGpvXHPjdrNefUw8JAn1N1JeOAnNyEvfDafJW4zVjUwfYtxbhKamnZ
	+oM/MV/f4ZCs871Et+DReogPN/6XmsJFVQ+94p53bZWk/Vsw94U1nF02yY7jDTkXCU4Yo12K502
	kdH3YNFgHwoDM9p+3tp7lbcGq3OcAKcC8FgBCPi
X-Received: by 2002:a05:693c:4199:10b0:34b:47b2:677e with SMTP id 5a478bee46e88-351755e1cd9mr6229724eec.1.1791472384302;
        Thu, 08 Oct 2026 08:13:04 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm18052389eec.23.2026.10.08.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:13:03 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v2 6/6] Bluetooth: hci_event: Notify the driver only of SCO links that came up
Date: Thu,  8 Oct 2026 11:12:38 -0400
Message-ID: <20261008151238.2138665-7-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151238.2138665-1-enghitalo@gmail.com>
References: <20261008151238.2138665-1-enghitalo@gmail.com>
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
index b1c107457..781d7124c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5317,10 +5317,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
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

