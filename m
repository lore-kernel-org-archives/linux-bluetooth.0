Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A27A122
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244671; cv=none; b=D0qeCBAA2STFso1v3oO+sDJzystdxz+soa+khbTZyWkoloJBc5qJrqaoj+bPMmcSvw20yyXtYhhlOk621m8v21BM8kddl5dF8Hs0F6LNj4mxFv2UcG5sCcpxQ7Aza+3LLxqlcRgAdvzVjdaEzTr7YkQx28QfUEPJnt0UL7OhU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244671; c=relaxed/simple;
	bh=PDfSOl0NJRRg6E5ZyUmXJbo/XcHiYo5cPHeZe4NCdK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eILeUIVosnkw/KuFwaEJu6buAgttA+tEyME91tJoYK+aXRDC2uiYNwa4k3RlXSErm2Mxu5bILKZTm84id2eOa9x0qKwOkNF4PsOms40noPkfAdg04oft8Wq8dIMOoEMU7O0bUlmpPsJTSfXB8yxgFUueqz+NKCECHq6q5jrTNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNGRk4dQ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNGRk4dQ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47288b46f2fso879173137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710244669; x=1710849469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IOVWhRNbSiUrWQEyyKcwCxKI8TBszxl2MqWxOPsKtH4=;
        b=cNGRk4dQcHxbG2HJLZ83QkMZyFKGvX8SFB01slvbt6JwTMFe3zenG5snErUv+5cuiT
         t38jAS/zYwpPOxSQnkzGk6b1ztGrjk+NIiCTBf73ZBnS6KKIfxacfum1R1VlFpKavyVv
         91OgkH7kJi4lWl0uPWNfxBkD0wS9vbo6vxj/7RJ05z9FuUafrmMZhmapanVlAhSXUTtR
         sDAzxr2Ydg0EdXx9kLz5YxPGa9WsttI1r9mVvP8sgbZfJwZrWZ6CNxCFQyAbliuqPr3s
         U7GiGzNiFEZlD+T0GIbI8IJXL7mTXcipKJERofnel8Pzondu2g9tFKPqD4Xs/8tLfUw6
         Sh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244669; x=1710849469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOVWhRNbSiUrWQEyyKcwCxKI8TBszxl2MqWxOPsKtH4=;
        b=iciVwAc4RuuHzFjUvrHWC+VovkY/c3u4ii2zjhlBjZ2ZUQ9GKfkB3PcthJ8AQrWsb5
         iXGssFDi212JKqVHC+T57vZ2WWPF4tBjCg76iPn0NOJlaoHYQyIPUSPQZKx/oEqP/W3Y
         ScbA9pmDiG6I2OXYbxJbJi+qKeaWDH3kk26N9/jDatGODdjXI5Y5yfEaxBkAFCKZtmqP
         lFD8x48/KgKlpg/dcJ5ZL1sPLFDHQii1erifFl5g3slq+dvNgq4KX/MYe5ZnIbI9xXqq
         jQe+bY8GdY324RqRMKgAZM+SgRmLX+aJuHMpDq8ANBgGp7xf8zhT70CqjTTOi/mXutja
         BWhg==
X-Gm-Message-State: AOJu0Yy1aDnYuGV8+TwK3KgnqnuM8a6DSwE1UMNBHUXQqF9OxHJKEDBw
	Cas2HgR5rZgxK2eSd+ZEVzHJ1H7EPaJ1n2xLU5UeqFXRGk2HeqjBFlCnRpK/
X-Google-Smtp-Source: AGHT+IFxYBD+QideWb0Edb/sU5VWvArlgJ8qpJnnL02clFM+FMt/AYOR/N5jke64GLQNK9r5VnRWwg==
X-Received: by 2002:a67:f041:0:b0:472:64f5:f0a5 with SMTP id q1-20020a67f041000000b0047264f5f0a5mr6155957vsm.18.1710244669041;
        Tue, 12 Mar 2024 04:57:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.131])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce7cc000000b00690c33599f0sm3201684qvo.91.2024.03.12.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 04:57:48 -0700 (PDT)
Message-ID: <65f0433c.0c0a0220.9c47.ba2b@mx.google.com>
Date: Tue, 12 Mar 2024 04:57:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6687736244479685239=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Add the support for RTL8922A
In-Reply-To: <20240312111848.4599-1-max.chou@realtek.com>
References: <20240312111848.4599-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6687736244479685239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834605

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.96 seconds
CheckAllWarning               PASS      30.66 seconds
CheckSparse                   PASS      35.95 seconds
CheckSmatch                   PASS      99.48 seconds
BuildKernel32                 PASS      27.21 seconds
TestRunnerSetup               PASS      511.01 seconds
TestRunner_l2cap-tester       PASS      19.94 seconds
TestRunner_iso-tester         PASS      28.20 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      110.37 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      6.96 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      26.33 seconds



---
Regards,
Linux Bluetooth


--===============6687736244479685239==--
