Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoK14Qm4"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FA171F
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 14:28:47 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5de93b677f4so10317317b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074526; x=1702679326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEyd8Ha/SX5TZcvP6e9MacgWygLSC9m/CuLfXZ3upD4=;
        b=QoK14Qm4S5gtobowvH/Magx5PPML4DV6FyJglotbaPAek6Ci53p4Vty3e51Ttt1tMq
         oapFybonKpiBDu8FqricPxVptiWHl+Zn8svQ74+2oe4Bd+PwPEtDUPj8ttxhdmeud3s/
         1/LgMgzqxXLcUTs90sLLx6jJoKB049QJW/FXaa0ktJfWqH2TYYtwYEjW78TK/fP0hwdo
         EFrX3StuaN18EZR6ycfSVTck5x8P1jYi6oawHn3SmXTRY50p+k1W495BAOI6MNJbig5H
         cw/KGo/IaX9sC1DLfeRB94fJ2nbL+iZfy/GKYB5wr0YK89pZv6o0uAWxThAa+vgRXa/Z
         XXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074526; x=1702679326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEyd8Ha/SX5TZcvP6e9MacgWygLSC9m/CuLfXZ3upD4=;
        b=gHZJ6/p99MfWz4qtp3YfXzRx4qEotF3pY5hAjnC64mdiI7DdKJPZscm6gUrB8l0lCJ
         TT4P4Zsz2yxyIXVmKw1WUxh8SWLin0BrVXL6M65a3i9/OwN+skUz1Su1Rod/j2dtNRqz
         F+XW4o/an34bQNm/TeYebCcBIR8pHU5tE8/DFYvRwrJFBd6aKE+4BvwzeVzTkmCLSRXa
         LFRdDHZHh2QbkL8goJhM43Mw4JqwO87352buO+cvi+I+j/HM+BG0xrTxvLr1rwIYtn2H
         AfV5Y+7Bq2EEvvWSSgWyn+jCEBbajBkvMW+XswrKEbyYiINUKjHkwDBgwXoMut+Q5zit
         Jw1Q==
X-Gm-Message-State: AOJu0Ywk4FvCRwhFONHmW7txDBhXfr4gsEi0Hbh9qE6Yl4AIDNIZpn8e
	uo9sganutI4JUcHkMlGJvfuoo2wA4n4=
X-Google-Smtp-Source: AGHT+IEg1zZ40gWTz0xiExANnXKNbEqSO1hN0HeD97GQQhlsI8L0fpAJZYwKKPvRk0WGdvDpOkdQkQ==
X-Received: by 2002:a81:7b05:0:b0:5d7:1940:7d87 with SMTP id w5-20020a817b05000000b005d719407d87mr606045ywc.94.1702074525637;
        Fri, 08 Dec 2023 14:28:45 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m9-20020a81d249000000b005d72c7c1241sm964145ywl.112.2023.12.08.14.28.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:28:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis
Date: Fri,  8 Dec 2023 17:28:43 -0500
Message-ID: <20231208222843.70028-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_conn_hash_lookup_cis shall always match the requested CIG and CIS
ids even when they are unset as otherwise it result in not being able
to bind/connect different sockets to the same address as that would
result in having multiple sockets mapping to the same hci_conn which
doesn't really work and prevents BAP audio configuration such as
AC 6(i) when CIG and CIS are left unset.

Fixes: c14516faede3 ("Bluetooth: hci_conn: Fix not matching by CIS ID")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0c1754f416bd..59105a3eaa16 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1225,11 +1225,11 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 			continue;
 
 		/* Match CIG ID if set */
-		if (cig != BT_ISO_QOS_CIG_UNSET && cig != c->iso_qos.ucast.cig)
+		if (cig != c->iso_qos.ucast.cig)
 			continue;
 
 		/* Match CIS ID if set */
-		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+		if (id != c->iso_qos.ucast.cis)
 			continue;
 
 		/* Match destination address if set */
-- 
2.43.0

