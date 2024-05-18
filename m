Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F92F3E
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2024 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990592; cv=none; b=V6maVVJDpQMpXg7rQRuRbrce9XhHMimydy9LZrE8a51Frs3C4NmhJP/DgfgGVerJXZU0HKDsKlV1RJzJ9zgg4L5eZsYTlJ4uHg4A16SsZYfJK24nheY0wO6JCBbBWLfv8TndYvvc4hT+avo9rCVPB5K4D77Bc2YmO+6wHTYwjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990592; c=relaxed/simple;
	bh=r3whb1M4sItdxnWLJVz349QzeARsDZZAAOMuIqEjru0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fskPEm79xdhRZ3BvVT3F3JFgPFvq0VZCldzXI5ql57SqU3Z/VhYhP1AdJyfbZ+NLpgI0wY57AXLo+tjrznvMurnAcbCkGg2tHsq6TjMYmEKZcyxz7dDXDMhW2EsqcNcpcW59/uIKGfX2h15Vv953l1S68X+RcgZ1c8tyKcvLqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cakDVp30; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cakDVp30"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edc696df2bso28317645ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715990589; x=1716595389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUEnkAcArRRmpLRp4/nvXAmInubnyq06DYqDZwf8mm8=;
        b=cakDVp30Ri1RKVjJvpga6nObWwYioCc/TKVhs+71zKzmS5r+rrDO1CWPmfi2LgcR14
         ydotdZbLjdIMgcYqgoOTMZ+RsbtqIxwFmHmt2WoZAv3xtUkXmRLcF6YJAqQFF0C0qD9k
         xYI9UpBCn1bC6QV9Qzi75VZL93ft4up18Orhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990589; x=1716595389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUEnkAcArRRmpLRp4/nvXAmInubnyq06DYqDZwf8mm8=;
        b=lDu93YvOrdkNUbhqX6FxMeTZwGNtnx8ewHHE6L2SFwfn7T9x+CvCcob3wDtDKQMBRY
         0D2IorI6thxA9zfMQ8iHPtBcXwTh0NlRR5RETg7vgal8YytrJb955KECgZLdBqSOlrLF
         NM9axW9GWLoSKLORp+4juARj3XIxsWIlV7IusjKp65EDD603xR9t2bQHVf9HQz6WrrVq
         0ePdiSBgDm6jQqQnMsZ4E6L+UmSoBk+hTgoEzy9XAkgm8yg4wILPhNAKBBY3yF/8n5GT
         Zc/qWt9rRPJG5jgPasfgRrzau/gw0sDQ4IEqPLj4+eOSTjoHJrFdEwFcqBAfw4GrBGQ5
         rRcg==
X-Forwarded-Encrypted: i=1; AJvYcCXn3OO73ZxwYFdoQ2TTPjSgaupsFs0/sYhhN44X08OxRUO7JyIHVm/NebwdLLrKbJh8SK5Rl8Ocd0k96Ofi1s54vPp0+kO3vkbJQlOqejGn
X-Gm-Message-State: AOJu0Yx0EjaPrlQ49WYxE3AOC6cdaCx+W1RAdped8FjxWl3snldeASN6
	QIMcDjs4rSFHca0Owf+QAyiOGAVR9sDs5K8xmkGGq4w1/SNEy8v02dKDd1p0DA==
X-Google-Smtp-Source: AGHT+IEOG6HPDJFK6vYgQBtD9jxWy7OIhkCMVi3oRs2g4y0sfBe1bSWs69Nb2rWkw8Yv74K4NQG/NQ==
X-Received: by 2002:a05:6a20:729b:b0:1ab:82fe:910b with SMTP id adf61e73a8af0-1afde1df2b3mr29013106637.58.1715990589009;
        Fri, 17 May 2024 17:03:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f2cd5c71sm11692201b3a.25.2024.05.17.17.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 17:03:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sai Teja Aluvala <quic_saluvala@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
Date: Fri, 17 May 2024 17:02:46 -0700
Message-ID: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems in the field, we are seeing this sometimes in the kernel logs:
  Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95

This means that _something_ decided that it wanted to get a memdump
but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).

The cleanup code in qca_controller_memdump() when we get back an error
from hci_devcd_init() undoes most things but forgets to clear
QCA_IBS_DISABLED. One side effect of this is that, during the next
suspend, qca_suspend() will always get a timeout.

Let's fix it so that we clear the bit.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm nowhere near an expert on this code so please give extra eyes on
this patch. I also have no idea how to reproduce the problem nor even
how to trigger a memdump to test it. I'd love any advice that folks
could give. ;-)

 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..1ef12f5a115d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1090,6 +1090,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

