Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827314AEFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770717; cv=none; b=GH8acWhr6kRPBiJ7F9RnMbL3QQgk5+XAHJIcEfHUIm84BRnpvr9u4JqsqeyoguASMQayzFJ5YuwBnWiM2OyRZhiGW20Dpw0GqOVqZ9WWGrO/PrSUmfQwVHqzjq74th4NavtCOKT96qCEDsJdUBUX92eUGxcS95/Ka02aE4NKfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770717; c=relaxed/simple;
	bh=EDcOlr+IXSRQzC67CmMiUWrT6tgVWB6LEzOR9zHRnqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c6y2pkMmcY0OrhI2ekTdSjAoFzfDzganPH4lErbQqyhVODIATUWfhntE47lAdjRl0d5Hz2W7xQQgFS4Qma26wQBWytS4l6pfbJUJuEUBUxLyTs3LJ7ePWD+Hs7xqoya2SHxyKn4AzUwa4AMKQWu4RwZxIyP+El2XxnyjmzQk4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVMy6d43; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVMy6d43"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618596c23b4so71232647b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713770715; x=1714375515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFcyxEC9zbVLPap6Ey9gG9OoDKAWEGSfij/agCtqgRs=;
        b=FVMy6d43K6gnbRNYkqijdJdtK0/iyqlLPjSJmTK16pVT4vLJv1ySiOvikzHufk2/0s
         tM8FDaf7ghlObrm85vA57+RM21bvQcTzD7NFHuw1tOcH5pI9B0+vmfh45HGZlRjXSipc
         rUojJk6idHABZe4K0Hox63xBEd7cUrwtK3pHR4mne5xFAevzsw//bopOG8jmUsN/E7EB
         H+yA5fDnJrrL31MOIN1jcPdskamNl/reSOZzVFK0HxHsHbzFrNuHMIzLWc7lV+WUkUm0
         YXlQ1S0Hb4t/evVywnEglFEyXenoRRJ5MJhsnPr5R+6zDlOTyT5EWA83oz7q735JdgQ+
         ivDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770715; x=1714375515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFcyxEC9zbVLPap6Ey9gG9OoDKAWEGSfij/agCtqgRs=;
        b=ccdE5frb5L5WlLXJmxMvYrfhdnQl465s97VowwCIx0WvB7zzsNEJ7AFNPiMLeF9RUY
         OeSbMtqlstu8k2buUwiYsVvzGaruQK3DYSE7D/LYa8s05lnJ65AbZ2sF/DWn9Y81a0qN
         DLXJSAMaJgnJNx1eef5LMTWG/mORF22WijqvI3RdNOtL94+V4dWLZSd2QoY7Gb1tblaJ
         7uOg0WJzGWLThrz/8jltrKyRCdOsCZQp6SCaaSz/eXAw6AB979E4sF/x/wstfQy7t52g
         k7iwgiK1cxLjlhwnIZp3hGeGoJtt3p2JDtVA//bvljYFXHKaLB/hIR9G+LEGDfgPGhO5
         8xdg==
X-Gm-Message-State: AOJu0YwvmiJh/56Pfi9LpVlIgdvwo0TDg3GlN7j8VnM7a0HwoD3uzFUL
	6Nm7FHsn0ccaqNy3L4Y6O4fpuvBooylMcaDImOXz9yOr4BjGxjD1fK8GuIkIEdK44dw08NYaUhm
	ePxu8kKqgOxynCyOZg5RZWpkonwQSgTfPIila3Dy+1PeX0ecpLVAuM73wldMxDCOZAFiTf+CGg/
	sg4HKZ6OYrclzWfcaUI8JvodqUHj8l0Nqd0mZe/Qegx1rwx6Kg9g==
X-Google-Smtp-Source: AGHT+IEGFEdCCHbuaKhEU3U0OHmIQH6peL/wCW0VUPpxDYeKYiIvQgjR3u+Zdc6yZaJTLiExsft4+JYTrTah
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:725:b0:dbe:30cd:8fcb with SMTP id
 l5-20020a056902072500b00dbe30cd8fcbmr735816ybt.0.1713770714905; Mon, 22 Apr
 2024 00:25:14 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:25:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
Subject: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

Sometimes we want the controller to not wake the host up, e.g. to
save the battery. Add some debugfs knobs to force the wake by BT
behavior.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8bede0a335668..846b15fc3c04c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -873,6 +873,9 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
+
+	bool force_enable_remote_wake;
+	bool force_disable_remote_wake;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
 			    &force_poll_sync_fops);
+	debugfs_create_bool("force_enable_remote_wake", 0644, hdev->debugfs,
+			    &data->force_enable_remote_wake);
+	debugfs_create_bool("force_disable_remote_wake", 0644, hdev->debugfs,
+			    &data->force_disable_remote_wake);
 
 	return 0;
 
@@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		}
 	}
 
+	if (!PMSG_IS_AUTO(message)) {
+		if (data->force_enable_remote_wake) {
+			data->udev->do_remote_wakeup = 1;
+			if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+				data->udev->reset_resume = 0;
+		} else if (data->force_disable_remote_wake) {
+			data->udev->do_remote_wakeup = 0;
+			if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+				data->udev->reset_resume = 1;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.44.0.769.g3c40516874-goog

