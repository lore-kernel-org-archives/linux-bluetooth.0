Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A452272E71
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294267; cv=none; b=qihute1K11VAwxmhygInV0f93RmbqNDE1u7FcFwWxKbcFsd5/R5tKkTIeMvSgBsq0GxB5VItFNOC62HOY/HUY6GkjE6qtMEXbfLPdBPLsesCzhMLpdo5ff5ir4ok+Q0epnfYQ6xaGuEZyi2wp9y5XdEjXVc41cqg4B38713Nc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294267; c=relaxed/simple;
	bh=U6DMXDDka9JL3cI1Dud3UrwyI3E+9z9qgsLpSWTd0xo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ancLfi2+xOFSxePwiUdUuVI+zJZ8C0piG1gk2j+XBUdl5X6daq2nQJVFXMJ6x+CEOpnY/BAadlJU3b+C/yhKz0RwLr3P33d2zvEypOVXjV8mwwyj1neLYpqmOtf4V2lR2zo7MMpvY8fanFtXmfdIYQnHtERzu2OXo1vdu/DDXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkyQHUPJ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkyQHUPJ"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b174c9c79so1044179e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755294264; x=1755899064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKeXikMdbGomAkcD+oMdTSPhvPrbJuo9ZEtpNO4Nx/Y=;
        b=NkyQHUPJnK5rR3C1SUPnaYX5YEN7qeQ3td6lo16DNuAQ6kI6tu8s9SL0Mj9I7uQ7u6
         iy8QXxHM4nQ9Ctnsi5miknntmbVZ+Q3yPsusesvJPNdzXrCdiuCJBiCansX0h8R4Uffl
         Mq/YkZCn4HIuLqjuhGD0IDNhGPbht9HtjJjmyXewu0XyGyElDYh127hs86F1sJfVQO2s
         LkHIluifTgh0ol0963dM3ReE3o7XyzJ4s5WoIbk48tqLGeSCFfPDz8ahTHs45tM7NGr+
         62eE5PzQKEOyaT3EMpSTRVCJhc42C1Tsj1y41y/mdv45sPaS/UORoRCXqBhJfQiGuNzX
         NYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294264; x=1755899064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKeXikMdbGomAkcD+oMdTSPhvPrbJuo9ZEtpNO4Nx/Y=;
        b=fP3RVJGV4CYqF+akLNdAeiGq5ig1885GYIcz/nti9wes8fTxDZ95EgXzR0Adwzr/ml
         eZYkRaXsiEvEc7vv+pZBFgP9p9sTNzE9Jhl7/elIzuMbdux/G61FBsEVfSSpjAS188ab
         oT0F1lm48t3cJHM9TJmy9wk1F2GsGFPW1AKSby/eARdq0jIV+OwVxjBkWmOz1oCZJV/I
         EW0YujKY/xsbwqMqeMF1x7DZw6pF52EA449s1qoVREBBnuowQR7zv25dpkVDM8aT0CnZ
         qUZNSpdvvj4/xK2QaGQ7hS/yAhaDiQix7V6hQlcSB/8cw6N3hnnfreso7VSL5jUMuxA5
         UDjw==
X-Gm-Message-State: AOJu0Yw4/M3yeB6k1TmEDHTJYH/N5dc13uM5HCE40DlPBH9bxeeW7ffM
	FECIhx9G3lxDMLuhYDjHGtjxC0aHuVumEED6sn0Un5JklkcjUpaeKUiK7Z8F4Jl6
X-Gm-Gg: ASbGncs5C/Pb2tqdBe0nSxAUYKtGdhoaVZ7/Sr+tK2m74TgECZ2gBOsEqUWAazC+fmX
	t92veTvJGPUe+GsA17uYPlPYrHRtGp4852aDuXYy8QZ462B6F3q9g1tsQVgDSsH6JY1mC2/zfRp
	ZtyKl1f3GxZoLOQe+FvOGVDIdlzlEs8vr0VPIvj+vxhVNyplmYU0k93zDHs/wevHnkok8mOLDwf
	r9PW7DUuJMqfvIX6HqbdraHhpBCWSD6TUjxo0vuYkw4fAGocqbpNCpRJuRQs7PCjPYrviqJhl7/
	T1TPqW1fn9+4Ty4QsqSitRM3VhL/IUCHWMh51ttF/7d8YZwThjOdCfk4La+hnCO8XUwO2Lo2NvD
	DgV+TVEvfyeTBayEBnNEcV5/8vEp3gt8tSf9N4rp3YzPAJKjG5OHQAOoGclgBBNabkHuYAY30R4
	s=
X-Google-Smtp-Source: AGHT+IGPHEsCE4Jm6cQCdmrbsjlZ0I7QOQSHxiaOP067SGxCD4FxK63nnvAmsj+z1JzhAZbL4q6GzQ==
X-Received: by 2002:a05:6122:4687:b0:539:3548:389f with SMTP id 71dfb90a1353d-53b2b8a2a5amr1352362e0c.11.1755294264462;
        Fri, 15 Aug 2025 14:44:24 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2beff1c1sm472053e0c.24.2025.08.15.14.44.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:44:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 5/6] Bluetooth: hci_sync: Convert instances of BT_DBG to bt_dev_dbg
Date: Fri, 15 Aug 2025 17:44:04 -0400
Message-ID: <20250815214406.514260-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 31d72b9683ef..46c20476dae5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5189,7 +5189,7 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 		}
 	}
 
-	BT_DBG("All LE pending actions cleared");
+	bt_dev_dbg(hdev, "All LE pending actions cleared");
 }
 
 static int hci_dev_shutdown(struct hci_dev *hdev)
-- 
2.50.1

