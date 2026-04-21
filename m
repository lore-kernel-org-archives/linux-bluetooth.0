Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE73D6481
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775702; cv=none; b=JzCrzM2+5+J885HuZaRFfMT3MRvyT7Z6kngtPFpsePieKob8TMg5/ZEGX9OePIeHTIQRpUia18KMWtJq8b2uongeG3e149Qa37Kz5qhYCq+/0sN23HmJ+K65/5liD5Ru8Ny914nLdcZhCM9UWuPiH0Rz9PKz4NHBUjQjjf4/O1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775702; c=relaxed/simple;
	bh=dDkYto7SJQrKtdLACLzOjY0EjqsINESEgTn+sfcVJ/w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f3T57fQSK8Cy/64dC0zIwsqE4staXQt4KVOMAo1QhYRUZ08RJcBcIU9oZxZWZtbOnuihT1CybrhGYLLb0Co1/n6MuFgMSiYPoS2nsx4XXir3lMMaK/Wk3wgjAJIWxPrgN/H+tfEvAB5f6V4b9VxTCpjAyZtihMJuNP3t+Puzt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/cH3U1N; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/cH3U1N"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50fb18c55beso9279041cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775699; x=1777380499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ1sZDj1MZtwGX8BRXiCTWq4uqoIcpZhlsi5j7HUuh8=;
        b=a/cH3U1NTjtjpGSj95rplISbIonfRl9jexuNOepMmmRwZYecY5rscfHd/ZMzkD8BYy
         BZj05ktneBkVrE9p8W6p3Y6FyJuE1nxfHxTvYmxEErW8ylYjIIiuVSqHs0tWxNfua+uI
         OISGUAFHkTNVEg5SxrUOihB9wYSu9D8k5Nfouym5cnp9lkB910gv3pgaSK1J961TgjpT
         Z6TQRr0Gm5XllfLsriwrBiwb29tW91dK2DIQrQVAJZUx0z2PW6QlvBVKumgCeyCF7B9p
         YIPGMy3btzCtWd0q76fHUc3vwEKMkxtPCcihozsTeByz2uu4ya+Acqa+lTvrfO4UjU/4
         Rn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775699; x=1777380499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ1sZDj1MZtwGX8BRXiCTWq4uqoIcpZhlsi5j7HUuh8=;
        b=sE61lKRva3eAFFJ8B1mhKUKyVDxl1yK9y1PSUiKGx/P3jGpik+2ybHRnSmn/8Xc/Xp
         uHuHNyEfrRqJ/KjIXEzb30F93dwWxbyOGjwPGc8+VDfxP+2v5EsQGHZCfDaSroNUNit1
         7LctRELNC0Nh2Ye5RhO0EOzm5J1agElej6+GcweQEScteWwrZk16U7ITywuNZfGe8mNv
         f9JRsw50HY58wdi0O7k+pcQ6pL7M+8BgQ0Egz5SzOMsv3f9TcSAoJ9lZqd3wB/dS4mun
         ZTxpaBO3IN0RDzVHVgXPe7EZzGvWDeFBxz27BEnOTTC5AEXgnQDORzpMp9WV24Hl82Zg
         a5hg==
X-Gm-Message-State: AOJu0YxGKQHm0U9MhcpEoGMIXjO1jW5vxMflaHyUWRb+snc2Hv33SIbF
	JuFYtC4cm89pjVE/5WBMUeKW2KzHRwkp8zG8HJn8XiyMcRSFaIaQsiMGvf0+qA==
X-Gm-Gg: AeBDieunzH0ziw7DM+tDZZC/4H34mOUHNmpYCwsJdI+014GFCf39ofg1wjvAEe5h7Ar
	aH3SQMTF9xl9svoByYPUgmpqwUqvqR2iCpeGOFZVleBbPoy30kTnXXvbBPFjyg4dZIJINI2zeBx
	KNCkQmOh1MgMRfWie49pZjrQ0uljykQAKf3hd8UWGh4QanU/cKeo3ZUdYlE/NVtU276cO1ldB3f
	74hOgtY3FYHBY5wvDtN6bfCg9DcFumvrV/RK5u2J2iIVH75kN1BUVAcKx0wNRtcQUNI3OBn/SRW
	eWbVNtYNZOScKcrPNehwo2XhwXPwx7ocAp1Ffzef0EwaDgsRAHSehZRfSP5NsBpVY1UmYtVHre5
	8d/F6bCygrst2lFlTVKIm3Tg+kJ5zHFDRMfmeqSKUhqwP5pwfcZEBOEfFtaQgBjn4M7DVC4bp0E
	zGwngUy2/BbjwFbWsmsoTrLQxdbzC1uK6WDGfR
X-Received: by 2002:ac8:5892:0:b0:50b:2d93:97bd with SMTP id d75a77b69052e-50e36b40e4cmr279604171cf.24.1776775699004;
        Tue, 21 Apr 2026 05:48:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.8.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c261sm100476536d6.23.2026.04.21.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:48:18 -0700 (PDT)
Message-ID: <69e77212.d40a0220.3d709c.9dc5@mx.google.com>
Date: Tue, 21 Apr 2026 05:48:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8144447456320429494=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add initial Channel Sounding support for
In-Reply-To: <20260421113148.3809176-2-naga.akella@oss.qualcomm.com>
References: <20260421113148.3809176-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8144447456320429494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083806

---Test result---

Test Summary:
CheckPatch                    PASS      2.60 seconds
GitLint                       FAIL      1.03 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      642.15 seconds
MakeCheck                     PASS      18.68 seconds
MakeDistcheck                 PASS      244.26 seconds
CheckValgrind                 PASS      291.29 seconds
CheckSmatch                   WARNING   346.14 seconds
bluezmakeextell               PASS      181.46 seconds
IncrementalBuild              PASS      687.56 seconds
ScanBuild                     PASS      996.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v11,1/3] shared: rap: Introduce Channel Sounding HCI raw interface support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v11,1/3] shared: rap: Introduce Channel Sounding HCI raw interface support"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2059

---
Regards,
Linux Bluetooth


--===============8144447456320429494==--
