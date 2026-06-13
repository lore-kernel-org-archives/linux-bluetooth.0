Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FB1E8826
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781378343; cv=none; b=YclQF6p07qDPX3mscTdg1GOyjSRAtv2jSQ57AZXWeIF14Xvr0MAqteEU3SvUJ7xi8affNToHovuDe6uyaG6ge9USPGAiEqhfKTRAtRgHhmGEVivuSYmEBhmcAW3j6DfZsqaMLXXFtbfifxf5W27BzxnfUeTj2ipzLpItD4z7Zvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781378343; c=relaxed/simple;
	bh=eyWCxjHGdFYlgBCKdG365KCHz9uocns1foMYMDqZ22w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lhkCu4KE2Co6FBVEA5ZDYsBQ3x/Z3RAzW7PrzP6kxLgp7aYHy7G1zN5uTKmYSZ8lqU6/m4WLHW4Yud0Cni9QgRubD/KuwKDJFXtkURKbJ5cVkahuuYVvb9z69IZBjcA9mFUBbNsKlzzq6a/OiqcXW5EvEyYMk3lBlcDEDuVOJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQZ/3sOn; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQZ/3sOn"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304ec41197bso2435967eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781378341; x=1781983141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MGY61To+PMIVq1ejzhxGfBckShP7DW73mh8zvmhumFw=;
        b=GQZ/3sOnTAFKYuWnmAFUVMA7hzIaE6cXyRriGM+MHzkHq5006EShEEcFvBKWYyWZga
         +39lGKzWuZZ2fQbRHBEZCfW6jY9jH9tVNripmOqxUWbhqemxNCYuufATdCs7XPlN8sWu
         0pYcBvlSwZYvR/F8geCYI3Mun7U25eR2HIYRaSX0AuxWnowJ3m7CVaVx30qSCBzxziEi
         MxSwAmb7L41SfZhobuXt54GDcpPvLMUnSyl4/D9BIsRHmgrFLSC/E2OFQ/FwqsAdWuxP
         EA0T2JG1tXdP7AQHQ2h7BE+tMqqsG6nGMOStCHLMFY5I0zWj4bP7QFBLpISH7IhxbJRy
         fgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781378341; x=1781983141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGY61To+PMIVq1ejzhxGfBckShP7DW73mh8zvmhumFw=;
        b=E3/U1A8ZEQeJ26+9Qk4GD5fRvK41bmXL0ORgl3k7Aook5geI5WUuxKgZLkhYokzZ0K
         ZurdabMsiTngFWghq+lx4Q/DagmkBueIaHRWHS3mygvqjXGl3pgLSCkEk+ngV2USqr9v
         e1zPjCd0a75Pp7q0wYj8O7RBGlnSrKpquxHqeFX/AIgCrP+uyyegNsWnouEQrAuXycz7
         HqTJ6IHVi/N0sRV1JQ2fVeWXgzcIOayVfhzPqtSU2s4L4/yD88yArk1G0h/892nU7UQR
         jZTOolX2HRANsFAIA9izm0qKR8iRSS2btf0FzumRUZaTLg5Jh3uXAQbdOl1P7K92En9H
         tOHg==
X-Gm-Message-State: AOJu0YwgTwbh1oRJfpraEg9/qNeYiY/RWcbwG1ku8KDS4huutie32cCN
	KwcGTDRfwVB7fZyX9x8GKrRrQUlj5z3sHuXgjKlkz/rNzwSiOubOkWq4h2u/zA==
X-Gm-Gg: Acq92OEzmTEcWp3v7refaVby+9uakTkgnS2uRfbFbEqD52k/TsQnKk22FYZiJfsb/Li
	9W5tZcDhYmGSglzcAit4hPAtIuk+Rt69iy63BJWg0Ox2Rv5ZBvz62BuIAZX6DliZAgMqWtKDtDf
	I4pTVgIxv6u9xY0Vt3iHisIFy2Old02tgFrRLO8OowZItucSN9KfQ2gnWKtx8VrOMolEugPKcJ4
	2XQygVPjlpVOyfaJLqshEs6KrNOU+vfr+tG5HclbVppNOVtNJSNhCwfYp2RP5U2Eztg3C6aBXJq
	GIgAtsBGXgw02JRzhsFl/VMpA7WSPlbfwu8f69gZRKc7xS3s9nO9PSzuhIiSQVPZlSD1n3jNySn
	elmB5jtNhtZSCgPfCnIIysvN0knO0BESsOdhAY1/RYoYn4rETeppAx49lPG3eSk0L7WCXiROEkz
	4YM8xtgOk50j1hlw7KUOpBUvOPSJN30t6WAEYKEsO9
X-Received: by 2002:a05:7301:578c:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-30820096097mr4115094eec.26.1781378340817;
        Sat, 13 Jun 2026 12:19:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.45.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e920243sm8558808eec.18.2026.06.13.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 12:19:00 -0700 (PDT)
Message-ID: <6a2dad24.d68db960.cf21b.9b0e@mx.google.com>
Date: Sat, 13 Jun 2026 12:19:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7156212733834463512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
In-Reply-To: <9fdead8517c36f37c0b23b7b60f590d735792cfa.1781375875.git.pav@iki.fi>
References: <9fdead8517c36f37c0b23b7b60f590d735792cfa.1781375875.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7156212733834463512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111109

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      27.75 seconds
CheckSparse                   PASS      26.42 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      530.62 seconds
IncrementalBuild              PASS      23.82 seconds



https://github.com/bluez/bluetooth-next/pull/313

---
Regards,
Linux Bluetooth


--===============7156212733834463512==--
