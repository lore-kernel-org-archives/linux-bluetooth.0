Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0kLcuer"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2664AB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 13:32:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77891c236fcso397548585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602322; x=1701207122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9h8ucelJdNwtBQcUnogeNuYf+HCC5O/gwgK1/pOvvM4=;
        b=D0kLcuerwPs49WZPzK4e+k7dpTAYyI5EUQ3Ti2OcN7WHtdfdQS+9WL8o7+14m9bQ8w
         AvnvY9M/en2ELo6zPSlL7Btk8CrAm+M/Nayiynr4h7XsLA0ZkiPcrFqyXRTQJsIMfmh8
         yDYfx5AW37/m5a8SX+xqNbceBjSEp++f+NQkoDZY48A16s58hLN/1Aw+C0dNCkeoEm/e
         MHtXuDkME55612sIma3HbIO5tYdxGGc6Tq8z73AMOtbKMvAeyRzh0nBb1LvtM3O0+QSv
         dR12ecARABhiSl+AsW4q0jby44egQPbbMAJaCytzIErMROS3RhpsE217MT/QLC9sopy7
         AUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602322; x=1701207122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h8ucelJdNwtBQcUnogeNuYf+HCC5O/gwgK1/pOvvM4=;
        b=FI6EtZCz6wQXlvL0tA2t7QdKZCcDGwqlPS/i+5ayEUQ1XZBqCEG+5EvceizXrCuF5p
         FAU6BOBE1fM32u6XztSCTasr2IOlVXKSjCJeqS7Q37rgsyHW0eTO4lJ8kf4tLwHys62C
         YMgbnRnoq3CAK1QHpvluemUq8U/h+RZ82xIg2BV2hOumTr62WOqQeawfXZDXG31Q5HDs
         YosT+ws0HXsqF61DDwJT0V2C8sjOOFSJf2xF2DyssW1RiXCdGpdMFfBrJ63hBFEYnWmk
         A5a/ZUBazPlppZ/3zrmFoE2Q6N8Gn2HgrVlY/vEjfJBtdIB0aQcjs5ZY4RymwXBmpaBa
         SoRQ==
X-Gm-Message-State: AOJu0YzSbbv0XgwADFlvSIcSdq00OA/aGAGABcGgmU3T7OM20famXduB
	Qytpfmjjw7OpS1hmkfA1Qb9Phib3/zL1Rg==
X-Google-Smtp-Source: AGHT+IHRcxVHuswuOLlB9xVN3TOkx8p4SdbnhHGGRd6L/EwKgqeAIN9NegiaBHGFqrvOlDJ2zC3+3g==
X-Received: by 2002:a05:6214:765:b0:65a:fc5b:bc87 with SMTP id f5-20020a056214076500b0065afc5bbc87mr377210qvz.58.1700602322130;
        Tue, 21 Nov 2023 13:32:02 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id o1-20020a056214180100b006624e9d51d9sm4291412qvw.76.2023.11.21.13.32.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:32:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: btusb: Don't suspend when there are connections
Date: Tue, 21 Nov 2023 16:31:59 -0500
Message-ID: <20231121213200.680095-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if there are connections before suspending since that may
disrupt the connections making it stop receiving any data if remote
wakeup is not enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..0926e4451802 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4629,6 +4629,10 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
+	/* Don't suspend if there are connections */
+	if (hci_conn_count(data->hdev))
+		return -EBUSY;
+
 	if (data->suspend_count++)
 		return 0;
 
-- 
2.42.0

