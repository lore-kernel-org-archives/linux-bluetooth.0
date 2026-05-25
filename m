Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B053101CE
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707904; cv=none; b=WAj1MCwEvWWVBQVzfLU9WQiShAJoxR0mLRdgUuVxN17otzYB7+dp128/O08jsh8+ajs76LQhmKMN13liqrNNA2Hky+YpD+vOe61VD28p9cyZOQTIS5hsEKHgo1NXvl9NJBBZym6vnbkeEW3A/mB65r9/vz3X7nZgQpzVXysXsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707904; c=relaxed/simple;
	bh=MYheQnZOBOPw+sKp+tyoqT5tCeCP6D14PPqctWBULjE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iU6msElYvKyvZdTnGNBJRJqajL1iBudvT75L1B/y86Ow5Vp2PXkJYHUlRgS4utu4sZDBlnsDZK+6Gx9fw8odvkEDs6TOFj88QIpXXQhKvTOVhZvKIfnhh9QtpAxkVHX+znMuuzXWDk0p1aCMMnDYlRzMQm1hMnOFVdFxaMH6X28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX5Idttc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX5Idttc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso4385500a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779707902; x=1780312702; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8z2Z6vB6+vByIW654NCImywOuFv37LlslAbtQLI1gHU=;
        b=cX5IdttcqTW/yB1WNSI9U9PJbYjaje1ZjiKCiLqPp6lda1/y0QpgrLnaFemXojaUPD
         NaZVvaGwXi078FFOVAI2X/RrsUkrbMwzQ4+7a/wv15ILOEdNbR09Rub0YedpapcHNt1b
         g+BkhEtIX1GaymKWMbgt/qHvVfQDgtjwa58IrS6f1iYUzvTqGfYxhy6u1RtshsGdf3/W
         UB0NQDy2AjoNfzQsqVSUK7XhLCjn3MQRceT/wlKDhsSq+rb7iirXwt/ngs5CQ8qvbKlZ
         DFsrJqTfqDWGvW3WxkXzCBS/waPaakfKimLLvmGLH9Qkdr/gOGG8FDQJtsLj1GW2Efcp
         WQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779707902; x=1780312702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z2Z6vB6+vByIW654NCImywOuFv37LlslAbtQLI1gHU=;
        b=in5Gvfs01xxo2XCzB+TrxNdm9C6zKUgmvvA8W9uMpoqVlYkQzhzeU1fYDG2IJ3YGJF
         Av6EA4o348jwOWw0pSVpZG3a6YFHukORRGNbF0GaT1JTRCh1yIqwAmhR8jUzKt2/NMvU
         8t+u5j41Owxo/2BFZczfqL8MQd7cJqlBDQs7esHdeuUrbcXTqrQcigAyvSW55vGhF8eJ
         AJhOojLuJV1H8oNB6Si4lnzVALoyjGGe2Gjw4jzM2wNDz3lQmauWpjSt9uIxxerLk4kd
         6sPnr/4LSgCrNcbNdAd8ynCzd5RiOEzmpdfwc/Gf/rdsRA47FDgQWD5eAnrpTEHXLKro
         jwPQ==
X-Gm-Message-State: AOJu0Yz5ArmTfC7CKAY17Rd/KPziqKXTri5pRgSR1YbIUGGuHBuKMZQE
	da8wiCHGGdZqtuZHC09IcR4vg8kGNB7fQb+GXoCXbjYbHMEwDUziYYf/OYTBIA==
X-Gm-Gg: Acq92OHiw3KDoY2j8nSqmU/GjJG3U34oMtFmxURDQogw8OT2oqxxJk92NgfEX7SBJ6y
	h+p1kH3sCxsRBb3kKt38o67ftKXKzioteBH8NtBmG/EChNXjEkI3AYqSW1BdDea4Kr3N5pdaYUD
	YuYGRN0pYGNtdKHjh3OctvO/RvScNGJLzmpDKMELZqMb+Bo1Q8+Px2JqyIXtS3NnGJTwvYjETma
	EGg5URiF/4Xf40URkzRMlZ0bJwXprHUyqMTE1g/M7k+uD7zL9KwjrtoGirJXM82AXXvLx8QB8cX
	XMfkyS64TVFAxJ/1jaD+QtQv4TjUE6ONNAqF3naB5CdsCh7xZFdemrZjvHrofJB8djk+SvDg+8+
	bAH3f6S79Q9ZBVgFfdCDJwG7IUgX1kP114CUf5pWQ2e8n1CMlsbZPkVVBb9u93dQUcJXzaqETbT
	2fVDwEtLP/JiEw20ttJI/8NTvu1oDoFf6EeoajCOA=
X-Received: by 2002:a17:90b:224e:b0:369:7003:4e30 with SMTP id 98e67ed59e1d1-36a674f43a6mr14422581a91.15.1779707902216;
        Mon, 25 May 2026 04:18:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.233.87.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72674492sm8921424a91.8.2026.05.25.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:18:21 -0700 (PDT)
Message-ID: <6a142ffd.2bdfb79d.32155d.d97e@mx.google.com>
Date: Mon, 25 May 2026 04:18:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8281452292560024056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
In-Reply-To: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
References: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8281452292560024056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100263

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.29 seconds
CheckAllWarning               PASS      29.22 seconds
CheckSparse                   PASS      27.37 seconds
BuildKernel32                 PASS      25.45 seconds
TestRunnerSetup               PASS      574.26 seconds
IncrementalBuild              PASS      25.16 seconds



https://github.com/bluez/bluetooth-next/pull/235

---
Regards,
Linux Bluetooth


--===============8281452292560024056==--
