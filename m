Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F12E824
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnGiI3WB"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5edf3780534so17687967b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704471044; x=1705075844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5v0lNfLjntS9f1DgYX9NfXbvlCajhkqRKHWZISUUU=;
        b=nnGiI3WBQZNSJeym+ws0L6z9lEVoSJ0YX+JkkHUdp/ycjy4GeZvw766Tm95JLggABn
         ewPdiD4+EOgkHGMj56EjVn6gpLZd7cOM57HGQxZpBmkGHxdRbZbs1lrH4VpMs9l/DU9z
         TFvWtG0zN9eVXwZRjHfK765wPtWO/SdhO2UBYtwfpk8CBtubaY2FkdpUk5TQRL6uXzfc
         1QnkwOjdXiY3bZfv8iG8qnJDXoVyMiUL/VIpkEa08vg2+Zmz6x/S4fyvEC1M80Kq4iRy
         NO2LZ3nd5KU1fo+a22qE6sisL30k4VDDyfGdHJMBJLuJQC9yM9kl4aL8zA8tUOYqkUeH
         kbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471044; x=1705075844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5v0lNfLjntS9f1DgYX9NfXbvlCajhkqRKHWZISUUU=;
        b=RtQ7eU65gYMHEOJJSN/86WeaeNfImxuV9uKgek5e7ofGMRJHCDe4FhXDedVdY5w9T6
         hxlT989ZpL02cdtmpevKlOdz0blGUSSnrP/J0D/kibkcnw+twIDO2PHyLZ9iTEYPSxii
         TKRYJxWSmuVrgB8goPx//8XwUfgeHPDXmxLVA/5jN3u48Bt2wP7c58MyMxNwJ6/9SyYm
         C0BwBnY40wA5nca/01Zbkl69hpO82MKfCcmYed6tw9JtcuC8UWnHFlkpqa61DIQ+sVvb
         8UenFjPOZ0O5BU3hAlwJYIDF50JOH8yOTSz/HlsQ5bMbkYXbuxVefEcFS6a1bxY15eXp
         azOA==
X-Gm-Message-State: AOJu0YyKIO85wlxPEyi5dRp4QyEo1/GCYLWIcQ3xJalEKAHv8c8z3TJC
	XGuxW8f+jkoRmhpabEtfPHMDAeOj0Q0=
X-Google-Smtp-Source: AGHT+IGxC8pGvKy6hEueLtlGuX/lH+9TnT0jlgEYaODKxOqBwnObmVfze9CtG1g/nsYvvDjEEsmVrQ==
X-Received: by 2002:a25:c746:0:b0:dbd:ae7d:ce7c with SMTP id w67-20020a25c746000000b00dbdae7dce7cmr2245172ybe.67.1704471044295;
        Fri, 05 Jan 2024 08:10:44 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id f16-20020a258550000000b00d974c72068fsm500086ybn.4.2024.01.05.08.10.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:10:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix accept_list when attempting to suspend
Date: Fri,  5 Jan 2024 11:10:42 -0500
Message-ID: <20240105161042.4179775-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

During suspend, only wakeable devices can be in acceptlist, so if the
device was previously added it needs to be removed otherwise the can end
up waking up the system prematurely.

Fixes: 3b42055388c3 ("Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan")
Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b3141e3f9cf6..5716345a26df 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2206,8 +2206,11 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 
 	/* During suspend, only wakeable devices can be in acceptlist */
 	if (hdev->suspended &&
-	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
+	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
+		hci_le_del_accept_list_sync(hdev, &params->addr,
+					    params->addr_type);
 		return 0;
+	}
 
 	/* Select filter policy to accept all advertising */
 	if (*num_entries >= hdev->le_accept_list_size)
-- 
2.43.0

