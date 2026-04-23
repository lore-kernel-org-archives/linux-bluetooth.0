Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150619C556
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776986987; cv=none; b=ldRe12/MvMhv2zGccf2wVFvZVW5OszWoOfEo/vxEavvFyLL3wKDEugmk88b4jqpQ/XZ0bH3vklosxKVNBRvxYjvcK59s0rvtHgXe+ue2JqQFE6S/YfwwFYrpyT/F4Z5hAMqToiUko4mMh90kyvWRei1Snm5uLbpN+scBrum5uYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776986987; c=relaxed/simple;
	bh=np3sZUHdPi0Zg3J8t4zI5fUwyZIevVlnLJk6s987FWM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e1jUtzNuU5QOrmZnOISFkqf0m2S9nTUKtI23XgBa/bVnRrQCVSX/fKQEOX4cZnbRu2SuyDid7XiZfOMIiSA/ULMVB3AztN/rKsG5nuXRm/0rI+MZ7+B39F//6pSdFcmMnTXdWTVbEVzg9p2K6yu0snY2GBwHTFgd8KSt/KS398k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyvjmYy8; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyvjmYy8"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b6b0500e06so11575083eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776986985; x=1777591785; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prTtN9Ezzc7AyYfuQwQrRZDBaFDsWe6f2SX6SYh2Bts=;
        b=RyvjmYy8RSP28UuPvp9dNKOYIgTAtZS6hxBtGAXIrBLeLvOZkYxfWkiKhc6CjR4VFZ
         FRlzRe7cWoaa7muRYkZBkFBwAcXQqvUC+/UoeeL06UUUj7YqYamUcyzDu9VrQWN2heEr
         TPnfGQLu2pZQxTLU57UgeJNeZX5kS6F3WtHNcpitK00OFTgo//JvJefguxLsM/NWHM92
         zDE1DfuREWe7PMbj2Am3FEn9aiZKkNttPehVcPp8ZOc069G4hPWq465s/h8Q2uyUcHst
         aFCXfGFcY4kOLzuSQFeA+klalCvCk4tSywED+xEkQzXtWDfsUMsd3tOk/GOIBCLp+cUO
         hoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776986985; x=1777591785;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prTtN9Ezzc7AyYfuQwQrRZDBaFDsWe6f2SX6SYh2Bts=;
        b=Hjnkb97P2Kifz63bLjoAAYS5LN7HEueQ4bEUBEIShNEWyVKm3epzFf42N8g36cZ67T
         YouN5bcv/ePr4pBSd0NARq22YYeZWh2SxWjntq+C5Cb3pPz0fg2gLl7A6XxBKE1Zl0x3
         vz3I8vOdI8+WIfI+XF2sorViu3zCd4aJ87GcVgsC7E9HFYswjr6RP8NOUBIISuaforyo
         hOUUc3DUXOzuux4whbIwijUwcVZC43HJxFt5STXWRn5DtogPHVM88OR53Imu8njtlUpf
         g6cb8WHPk6vTfIgPTonarX2yov0CzEz9UwxZkrn96YVVYvBdIOE2FTh4Zs4FQkaoHGWT
         FsAw==
X-Gm-Message-State: AOJu0YxEY8E4OajXB7k68LBd8xRTycCfUH91YpDj7T+slJsQwBXERtxR
	pXzqg4oyGHNc4AeVqYOxytARvGFfeBy2aFh7etOLQMcUxgKTkL8gnyCvJqvI4Q==
X-Gm-Gg: AeBDiesGCoNe8S99Zue1B9UdljSwDCbc9KUp+qJiJAfN6nzGl109aw0Wfg8qHVN9EZa
	PB9GInioLEm6JmBGl7PtQE0i747BxTdKN1Xd5r3gKuLTRLkjRbQ2ZQF3iFCoHB485bpFmnYW3/a
	XUkxhHRdYlW78F1IAzIPsUQ5u+EVrC1FPasrJjGgbdHS/GcEREPIJRTECLMqUJECCHMmu6F07Ij
	McN3RBWxUq8vY4vYalTnbQhrDVxhr8GngWiUrDKOBrBovY1NFbTv/SQsB84rK/7zAZWa5aAWPIk
	w3VAVrheSEv/N0bfLX6ksNMZR4+RfD/5Bw+asG76leEz4P5I8cMxtR+J2dgbnmKIjFTCgBpOUUT
	XNmOJdWTV10E7wD0f50I3BZaaGGaRPfZNExfz4l2wwnYCZ3yAn52jSEgd0uT8tTGRQ2N6DACITm
	gQMb7LiD2CZLBnfJ2njXve8+JIg7cYJZOK46wZJ3Ps5DDu+Cw3rg==
X-Received: by 2002:a05:693c:3007:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-2e46538fd04mr14595508eec.11.1776986985289;
        Thu, 23 Apr 2026 16:29:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.56.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm30429127eec.31.2026.04.23.16.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:29:44 -0700 (PDT)
Message-ID: <69eaab68.050a0220.94ee0.9fda@mx.google.com>
Date: Thu, 23 Apr 2026 16:29:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4900050589898715333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: [v2] Bluetooth: RFCOMM: pull credit byte with skb_pull_data()
In-Reply-To: <20260424070102.1-rfcomm-v2-pengpeng@iscas.ac.cn>
References: <20260424070102.1-rfcomm-v2-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4900050589898715333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084930

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      21.35 seconds
CheckAllWarning               PASS      23.64 seconds
CheckSparse                   PASS      23.81 seconds
BuildKernel32                 PASS      20.22 seconds
TestRunnerSetup               PASS      415.26 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
IncrementalBuild              PASS      20.39 seconds



https://github.com/bluez/bluetooth-next/pull/118

---
Regards,
Linux Bluetooth


--===============4900050589898715333==--
