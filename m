Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495E56472
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774687623; cv=none; b=emKg5QWyWiqMB+4iRIp5I9rcuaeWVfa6ShBaZ+zOF2GZ9AfT/58Pk5R3vpEXsP536qhOBuCejld9X08O57JmONlKQap6Ooz3OmVUafalYVdkP2K15liqhhaDW57bjzHJT+Fl8M9g49HwzqtLXRYLdm61WAcVCzd+mTp1vfqPK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774687623; c=relaxed/simple;
	bh=S1/uGDiGHa9UOtjwyAnQrKq0EKeyJnfG9lOs8cWnkxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFtidksRFNq9FQ4o4Usz+7FJgrp+fOpnwRk6KSSDNghqRBXdYFtSOKgYIxHvD++Zl+FDqV+8I8L1AAnnfmcJaWVbiCvuq380vdALbkPUpJ7CxG4sWaclZmJxL/r3pJyNCermO4P7vj6jjFz07dmQQUYleO0U2EOa6M2m4IiZ+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvCOQYXn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvCOQYXn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358ed696623so1373438a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774687621; x=1775292421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E49LiwD34CnxCZCtS2NlRCH3BBKW4NzoBsph9Hx9niI=;
        b=NvCOQYXntVEqGZI1hwh0k4PNZHjIY48/RB5V2FSay7BVtl2hOjMJmOZYiaufgwnUhL
         4kTbi8NVk+QwzLbu0kUSwGrzpEQNIhBR1NLHb3K7aj6amPlwe6YkEHDjylGSZUcx9v/p
         r8m2gUF72md50AEfE69/5jNnCCTbAEC/eJutQL/DYPUQKD2bg+h8rC/qKDf/fDnVJkbh
         lQP/ZfnVriYExpJIjPo5Gg18XraMlpAJdL59jDsTm64Gn6FoU25BAZs7plsdxxO2EMVJ
         Z5RVZHEDxtRva/3eXAF6ejDhzXFtWlmcuANx0CkrF2sbwsBYq13jXB0GaAJTLcL3Svh+
         JL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774687621; x=1775292421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E49LiwD34CnxCZCtS2NlRCH3BBKW4NzoBsph9Hx9niI=;
        b=DZGvn20QYjr+Wvvi01KtNPlTh2dLYcMypleLqk/qNQLJR2vnTwP8iPTjBl21jvuYXQ
         1rB1Usf0wlgy4V0RulPkQYECPf98+vMkG4jqWzWyLJkgSkH+wQgxIWD0spLy97n+go/i
         3T6y0og2eL3rcSb+86ka6OnX7dGL8Gn9hkzBS8YdUfPC6ipmZQpTQw4xzYQKHRCmcgQI
         eYv06fh1lI/iU/JVo/pSiMFQ980Th/mQRd+b7iOczPF6UE5+WsI5itBKMhoI+f9/05CR
         RijEu6qPn/Kj+Bp0yQVyNPumi6qFyl1DWJnKbsd5f7mYoSIk0e1UwTKyG2D2ma8iTZVe
         hFWQ==
X-Gm-Message-State: AOJu0Yz1x1hYJNdl+sCLQBub3d+/6+swpxDfIj+HrXKoDmSv+aBk7sui
	cdZIeW5fubia0BosQSdX27C42BWUPybkwVv1L7UVK3m8MyAcLkNy6UJz1++U2kwu
X-Gm-Gg: ATEYQzyQoCbPvq7qMANR30iIeu/YQUBCUt7/1KKUDaNwE7EBshfv8vCw0is25gfS0K4
	BMbG3nkZ1WqaDhjIlBTppQPw6uUgZGkOIlPmQKJtEFV37ncx9R7s4JDWMZSpaLZ1mvKS0K4PVzK
	3WsXOiQP4tVkFszehIHhLZ5QPOa3k2lw8M7qODhOIrQromyJ1/C+voScZiVO9DnrOdEFrAp0zjZ
	blb98xw32j+V/tc/2XPndWh6jeLvN+rlhztUJNmMCwpGqXemJ4D7VbrPK+8QMs+BK/UnvasaOJT
	XJN+TFBIxKyqxtF1V+5CQmX7EiKi76Aebkilw5ec0VPHg5f7Rpz2Jy5UbKCgrw/LBUmBl76OPbV
	obCMpmSAAnwRyPn9HOuJ0ZjvNkDNRrgfHW6L8Djr74U1zSpdY24orAJvg2A/YC5EY3Ohhcvg+qK
	7hFhYWe70ZJJr6PXnWmY8T+/QlZZDBVGrOtFJl4W3wBnt4vKubMbTVhAQaWFwTI542
X-Received: by 2002:a17:90a:e70d:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-35c3011abbbmr5050568a91.29.1774687621419;
        Sat, 28 Mar 2026 01:47:01 -0700 (PDT)
Received: from LAPTOP-KU1E7KI5.fudan.edu.cn ([202.120.235.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm1689510a91.17.2026.03.28.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 01:47:00 -0700 (PDT)
From: Keenan Dong <keenanat2000@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Keenan Dong <keenanat2000@gmail.com>
Subject: [PATCH] Bluetooth: MGMT: validate LTK enc_size on load
Date: Sat, 28 Mar 2026 16:46:47 +0800
Message-ID: <20260328084648.51158-1-keenanat2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Load Long Term Keys stores the user-provided enc_size and later uses
it to size fixed-size stack operations when replying to LE LTK
requests. An enc_size larger than the 16-byte key buffer can therefore
overflow the reply stack buffer.

Reject oversized enc_size values while validating the management LTK
record so invalid keys never reach the stored key state.

Fixes: 346af67b8d11 ("Bluetooth: Add MGMT handlers for dealing with SMP LTK's")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e5f9287fb..adcd86c15 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7248,6 +7248,9 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 	if (key->initiator != 0x00 && key->initiator != 0x01)
 		return false;
 
+	if (key->enc_size > sizeof(key->val))
+		return false;
+
 	switch (key->addr.type) {
 	case BDADDR_LE_PUBLIC:
 		return true;
-- 
2.43.0

