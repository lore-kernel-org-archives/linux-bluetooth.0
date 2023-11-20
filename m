Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1pfLCxc"
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49327A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:10:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41cda69486eso27021561cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700493042; x=1701097842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8VDoPWPPH+5rDcEVesWVNNFTriBFrHhPfUd9g2+lU=;
        b=T1pfLCxc9vwNmB++eAQVvnf6QqZawEjzCJ/FC2qhO8CVSBkAIw1RsAXZG5PvaRy8PP
         59Z3q3QVeaqpjPkCcakpgy6/lDYbItfIsE1cvrUqeUJuW5BgVAWEmZZg6rSL95rDKnVx
         Dh9LKjuTlFCVP3t8S8pL/Hrb9Jlg+LzFmbVhjE6nYT5cXa++5jeXx1XVeVpLUvxwgWzi
         hYxn4K4F7gksFpgjiauk1IXdCNx+VcNY7LX0CCpw9EA84t+NOfhv8tHhgZjgWOURxJtm
         SGB3gcDVsGpLtmEEu2Tsn6y+h0hyxo/k9bHFHZimyCfgmj7AxEgD6zPkVbdZOiN4bIDF
         CKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493042; x=1701097842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8VDoPWPPH+5rDcEVesWVNNFTriBFrHhPfUd9g2+lU=;
        b=RHdgB9UeyVBpsAuzIIHjRmItg2Cx+MghcgIZYYrcThW/hEeyos0EEmWJufesmLMYnc
         nTYKgGDgddTUaQ2RpAFP8NwdQx0cti4UvEIKEmj8x6XK/yu2mcwFwp815VZKGEPA8nC3
         GlwPQaJuQJTOMxyVPQ37q8L11m5yhACfRqGMYyAy6XASwE2uH/flkQypQttqsGKsAsXI
         HBnjPZmLJ9VOpu2zksotug3zRwBYc+w8Qctklox9j/CZOVxNMQPDAwDi2W6JmxpCW6I5
         aeaiaW8m9x9zN0q0gcnLwuSFTDE1CfJ7USKKMH8j30cQwAWFwdk0u+r73N1uy5gCWbW0
         jQaA==
X-Gm-Message-State: AOJu0YwouyyzealviSoQ8Khb2kmDtX0wPN09WUxgRpn9szMu/Tq8O4m5
	ZsWcbWddfTH9JuLbuFkaz/q8W5mn7Iu9XPLi
X-Google-Smtp-Source: AGHT+IEqfnK8pkwS12I4Owf8ZI6lBzkibO0epXTYPn3+SXru942n5BoTSJIVAQXE8ymV12vVF5IGwg==
X-Received: by 2002:ac8:5a45:0:b0:421:bc1d:409 with SMTP id o5-20020ac85a45000000b00421bc1d0409mr9106685qta.21.1700493042154;
        Mon, 20 Nov 2023 07:10:42 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id j12-20020ac84f8c000000b0041b12d5fd91sm2701959qtw.55.2023.11.20.07.10.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:10:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
Date: Mon, 20 Nov 2023 10:10:39 -0500
Message-ID: <20231120151039.323068-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Before setting HCI_INQUIRY bit check if HCI_OP_INQUIRY was really sent
otherwise the controller maybe be generating invalid events or, more
likely, it is a result of fuzzing tools attempting to test the right
behavior of the stack when unexpected events are generated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218151
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5b6fd625fc09..a94decff233e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2302,7 +2302,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
+		set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
-- 
2.42.0

