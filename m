Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067493BA253
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488336; cv=none; b=K6K6dIXYzWin/4F1BhcD32SEs5gvE9soRpKDJoehWcDorX6QdRaJaVdgI+ZhcDitSemeYQQXfKxcflgIuDsRB6fJWK0txyu+/Wxlnvgbe8YWwdue4vCvQMS2SgQ3tZ++nGLFTjcmUbE/pGKU/D75jdf8JwkthOSpw6C2lyvFgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488336; c=relaxed/simple;
	bh=gkCLn1rB41k1HBGmEr9BMtghvpgESwkksWN/1LCmCgw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SzX0yDNA412KPmt6XGFDANtDoNqXnwz9CQ/2CpZaHmpH153SWnTmOf5z5wU1XHHaaPF5NSMwBbYWnDSNKs//wJNElLgONAFAUZ1OLeoC0ThNY9Vyh2w9xCO0FwpJkALOEEH9J4lu1+8d2eyW668pwXcaDS+FM6lDbs02c4Koucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/5nVDra; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/5nVDra"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d65f4073bfso568770285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778488328; x=1779093128; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rfQoIgp9EqC8BsTWP/9AYA8IfWEQc7rXdxlWx/9WCWw=;
        b=S/5nVDra/bunNZPpCpb2AhTDj8cCpFeG8iTIV3QDjxKg5Qati8Rj11jKxirb2EcIVs
         MYfO0u8gUOoRqzQYaTHWUfgTC3lz9yV3n+gQv9ZeTOQkZoOW0Bf70+kJUDamxEO8hHCq
         Z+JUm5lUqNanUtma1OdJu7IK8Qz0oT9N2xXISqvenxmf6QWODd9tMFhEuouEZN3MkrLx
         3NPsWGS1jjukwETWBka0crY+UzWTEztqAmhb0mO2AmIkkzZ0Rc6iqLqsCrY2sAiOXwZc
         fu0LdavaOgV2iWONADzkc+HEFgTy4AxnGV2zX7N8Q85xqjg++g/ZtBorVKBJCP8Ur0wQ
         vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778488328; x=1779093128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfQoIgp9EqC8BsTWP/9AYA8IfWEQc7rXdxlWx/9WCWw=;
        b=OQ8hxyRV3KGUcxkGaKCtT1TV+AMXITkeltjEKpB50YqZbbtgBmmn5Z5q28/uC7jqx9
         hDr7VGq7KLWOZB3JHa+j6BI9GgJX7r8LxN1FKARdqV9f9n+2PrOqU1TX1GsOzbK+F47q
         d7V16RzNtDWim0RhquRgzctFQZgqj4/L1TSiyp29NQeaDyvizR2U5Y+Uy7ZdlAYWs8ZZ
         p4HtUFnNnmiuXHovjE2eIHhd/MmVuCNx+HGeTZX0wLkSITtz0u4A8uU38CmVu7v9mbPP
         BEfq81f8GAoPNHZPYZdMAPb0Q9HuiFHAwIzGnpVZkrp0FdYapHPdqtNzqktKXVckl6ah
         D9fA==
X-Gm-Message-State: AOJu0YzB3Ny8sZSNXhfGCBVMKrqxzD1nzS4m8RdCcZiv27hS5lE6DJod
	HiUwd2JM40M08v7SaZ876FaOm9y0krwQnn0q5UXc651JP9SVwJOtQ0rvv01ppw==
X-Gm-Gg: Acq92OEy2Z73jOFwc753/qI26FXrg3rB5Gg4XGLOkcYuxqDjJfCcb+sftPdQ9y6I9Or
	OlJjmPgw1iNf6VINTAbtgQqQnO/Lcrbp050h3ZOTem5q6Aao3PTHoQV85epvEwDTYeYiotsxsGV
	TmUI1EgKA3/7Wra4PiODCb5X33EEd6khe7/imKAbaGzc7GyStiU5HBiETGmUgVtbIOp4Z78J1e0
	xmbwd9PjOGvpYTSXGXBhNDPxyayoU1GxQEUVNriWMDYu7Cv0vV+qf+uZJviaIkPFHUa3fQoDRF2
	bdQsBwBbNtND2YMUZvdWWY7DAKrHSa72HIdRS+DQRVJL0eWdRhyiKdrN3+V67aquk3ZBhJ/4A+w
	iyYJpSsGmBIq+JOCCEBf52PLDG/lmuP8XoXlYJcF1RM2SFQ8ZEjo2tsDnO9Vb4AY8MxIQUcz+fQ
	FiSUET4wq9U2F34IYjnzCiNLWSFgGE4g==
X-Received: by 2002:a05:620a:2a16:b0:8eb:605f:6ce0 with SMTP id af79cd13be357-904d43924b2mr3389319085a.5.1778488327783;
        Mon, 11 May 2026 01:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.92.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b966ee91sm1004628585a.10.2026.05.11.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:32:07 -0700 (PDT)
Message-ID: <6a019407.050a0220.321be4.4b8a@mx.google.com>
Date: Mon, 11 May 2026 01:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3406897249301157562=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260511045124.298319-2-oss@fourdim.xyz>
References: <20260511045124.298319-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3406897249301157562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092493

---Test result---

Test Summary:
CheckPatch                    PASS      2.09 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.70 seconds
CheckAllWarning               PASS      28.70 seconds
CheckSparse                   PASS      27.32 seconds
BuildKernel32                 PASS      25.31 seconds
TestRunnerSetup               PASS      561.40 seconds
TestRunner_l2cap-tester       PASS      378.21 seconds
TestRunner_smp-tester         PASS      18.06 seconds
TestRunner_6lowpan-tester     PASS      51.06 seconds
IncrementalBuild              PASS      24.97 seconds



https://github.com/bluez/bluetooth-next/pull/163

---
Regards,
Linux Bluetooth


--===============3406897249301157562==--
