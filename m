Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DA2367D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901741; cv=none; b=dgWfvCP50pAi6nC05YAMKR+4QVLuZSNP5B1kWZcsbQQRvvCVLx9YXbLAx9QW1wM4R31eAb18xOYVl5HerVmk3W38CbzACmTLEsAz6reiu3JZJ+fGXECeCN0oI53FMUBosOkXMnYBEf+L9xy7oaBaR7kZIjEyfoF3f3uORNnLiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901741; c=relaxed/simple;
	bh=rwdQTbm1qbSn8RVi0NsXQvM/WtmVE55dZKkX8qoGsvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DIQEiCDEnl++2Mpf87Fyec0k73kb6wrBIVGfBX4onSJb+Wr2UqwqHNC+/0eGKXtOvdkgBPfvK8t7oNGebxgy25+ZKEUsbuo89Ct2snUNMedQ4KMeLEqW21ipvZubmMDmZPynQk5sH99MdTPAMpNPA7NJuN2L+lOFXIKsQEVFX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULMMQ25z; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULMMQ25z"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bbe260539so925294e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901738; x=1759506538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkbsXUkZeDQJSjVmJRl/RqnZVjJES/PyKoRSuV/ib8s=;
        b=ULMMQ25zvriMSWsrP2deRA9f4Wi+qcfMbB+WXdTNL4cClX+hi6jkP9rxD/mfPbcUIv
         yu1qy5jjvBqtm6TGUXsblaU4ZYCJblBLtGzcirRYf5JZYZp6EB79QN0y3B3UPH3xrEIE
         zrXKqKXfgpGh2gdiBSPjydgMkz+UuEgegZL6LfkpQd37XtSn/mvyRdi86WnJAuQ9bvIV
         cL/4QVFEib7gmsoQPn34ffbnWd777xp/QJxnatxgcHgeTeSPe3vUdsW/xzMREPtmAn14
         2eblwMXrEmBDToD6nhQjrpfzqyKruxKaXVgJIUWC8QXSt22bEbOpD4xsNnUPNQL+6LbW
         XIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901738; x=1759506538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkbsXUkZeDQJSjVmJRl/RqnZVjJES/PyKoRSuV/ib8s=;
        b=hlr5z2j4IKtkzcDliGWb37FJvxzWSBnHt+ikFSaSu0m6PwSYvuKhU+d3j7MzI51tXt
         IdASE+9dsBHDMpusJM6PispbPpcuLhoommb9XIO8YA2U+Mh8H9tjOWWbrqutGTDZVKjN
         MM/8sZ1ZLzVjMJa1hlvudKcfZuWsZBVZ/QzHT51gj2CTsoLigT4TS6FdyqyAzU0obFIg
         lBedEeN8T+midAyH9LVfRKPk7XXS+M9ktFbtTI/bdFmvjKsdAlZRkWnbWrXEt8NjG/Je
         c/yreZVA02MQgJZeEtngxYuMtM4prKR96ho6ZDrmkf9wKwiatFAXG3cLHNZq/OqLNLhR
         sJrg==
X-Gm-Message-State: AOJu0YxzwzCXiMvQyyFI4cTbFU9eYBB8IzFnKlxKnwgwkPFQNyaVP8SX
	UIh7wzA0XfALQcoXF2pZ4zqamPacuwN/1GYCHqi8Z9Cth6KYPJUo5MrPD2Klfg==
X-Gm-Gg: ASbGnctxYnxuLPrPJRcLMh3YNg4jEXWxvYjECQg5oQzA7pBrj5Ktj1f3c6j+2A0tOHb
	CvzNWq267WmpTA9ZsucqTL5ds3sfr46XJWt5ybvx7pc+MJxASs/kzZhNEBE7YJtrPl0FIF14Awh
	lOctQyRCjOKS0GrcSnECYoJC574OqFefuIuSCeIQmxKMuH9bi9U1Kx+rd9XIiu8siKSov+dMEsT
	cyO8wVHx8AG7wK8D97QDQqGgOLcW/PlRbbZP5mQaBdECV/JNwo4BhXPPQ0jUSUUBDfjSj8B0yJh
	VNjaqVIuPXTLTmBqdGMRzyt9MxUxZPusJIvEziIxnepKvL6wWdVtFtZ0PDQ6EeB5DowDxh2Zkgm
	GO0y2xRDwCWTgbHefsSyx//FAA/99Anp0ykuoxaTTaTIu/eVeH+VOrLjF0psE8oQjxw==
X-Google-Smtp-Source: AGHT+IHIjBYZOrhSI10wm/eM/0SxVfW9/lnWf9cvEGGUw6+CvPmKv3ZtdQpURpySQBwINUojPmHu8Q==
X-Received: by 2002:a05:6122:3bc1:b0:54a:9a1e:c07a with SMTP id 71dfb90a1353d-54bea0acd08mr3027989e0c.3.1758901738047;
        Fri, 26 Sep 2025 08:48:58 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedc9f653sm922420e0c.16.2025.09.26.08.48.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:48:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Fix BIS connection dst_type handling
Date: Fri, 26 Sep 2025 11:48:50 -0400
Message-ID: <20250926154850.714148-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Socket dst_type cannot be directly assigned to hci_conn->type since
there domain is different which may lead to the wrong address type being
used.

Fixes: 6a5ad251b7cd ("Bluetooth: ISO: Fix possible circular locking dependency")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 4f10ea750106..318b5b914cc4 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2061,7 +2061,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		 */
 		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
 			bacpy(&hcon->dst, &iso_pi(parent)->dst);
-			hcon->dst_type = iso_pi(parent)->dst_type;
+			hcon->dst_type = le_addr_type(iso_pi(parent)->dst_type);
 		}
 
 		if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
-- 
2.51.0

