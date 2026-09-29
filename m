Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E613A3821
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664676; cv=none; b=gUSGl1EDzjKhVof30KwuERvBZZarAI9etxmFsgY7tqTNPkhl3p0hLLfnuH/fJrQOZ/Mu1AHcY8ijh7hbWsA5EzGOLy+Karatob/s03ttLzXWX2yCSV0IjWVg0mMaD3zFnmL+GgAMgRuLHe64jkYTo+axsarDQwPkBo8OzPqWeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664676; c=relaxed/simple;
	bh=SMligWmOOu8U/z5wgO18I3pWZQoMFXDYub3O9g8qGbc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KIehLft9vSJdTiTAsr5wULWhMHTfTZ6ZeOA/p7OO8iaBiCR6VK01nehpzcV9T3Z8gcfCKW5x8VL2Fo0JQj7529XW8eUVVZgoABfUpRHI9RZsqFgVU2De/g1W21RTYW1/WQIZy3tGtYOV9OMJYTMPkp0dvx7sd4D7hat4fSHQBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKQpQCMC; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKQpQCMC"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e6afe2c84fso1251928b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790664673; x=1791269473; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kFVVgmjFXeJdRJmlwgXHJJRRP6MxJiZF+zqBL9okGwk=;
        b=rKQpQCMCLTuptasl2g8L++cRJJm6TGB7sm33B72R79JEaik83qGFA0V0iSsgdRtieQ
         dKjGZ+Bhb3NB4GaEURj0wJZ/3dsrnDqrZKPVu2cDWmDnT2X2KxlAteUYN/asU+/moDkS
         uTOygyavk/L1UTZkRXHNh45aWSJLBP4HJDiIQGqRmOU7wFGJBF9Nr83obTDrqwm7lEJV
         IhkxA4h0F+ocl9a1VSZPiGkH1vMeIiYqjVlZ88NOrKP2KWNjjm/ygefOg6t/hG3rCoby
         DslYCxZkJTwEynePqPHya/pE7DHg8TTwzAQBi0JprFkBDGLUjW3t0NVpvXKHK3QVHr49
         iecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790664673; x=1791269473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kFVVgmjFXeJdRJmlwgXHJJRRP6MxJiZF+zqBL9okGwk=;
        b=SHEdsM3AyBZDph+StPpxVt973llFtFdilRji1kSp8bHQ5lFD2Hatel/yzDtLr+54Uq
         N2aC/MqGt38dIYQp3eQT2JqGhYTvKP5dg5QTAW0q1QymJ5e0r7b0xoQIpNK/UeYA9QA0
         uFgwmmj/TxyUJvCAj3VTdLrbkqiQi23LvaqFQA5dDbDEi2t2gNPp7sJuzqg6YSaaN/nF
         7Ej/cTVuVGXyjfhn3kl7mOrzonmf1xBW4e5ijtxb6XU97MXqy6U3lZ/xM/fNLrHltdpg
         rCciqtSHwSRbQSBFGsAM3yCDXbCMKhR89I9SfdsKkAr4ZTBc/I3IMJAUqc/Ev5zxTXYK
         gDuQ==
X-Gm-Message-State: AFuF++mJHBOUHGyFjGnpksh334+lrZDUPYEES4FKUQ55BLkgd48EuF8R
	6FqUQ6N+X5cbaK6c0zrTuiq/iS38NAnVrw9jUDwrpQM3w2D5KQW/Lqv6+HXA2XOr7n0=
X-Gm-Gg: AYBFou2EnaMKWH2mItAgzIu9uxJwSMrplCsyJoc76vtwdbHOIcsNE8Wfhq3lVwqu3XP
	1cq6fCtov2x7hBUwpokyK46ZQ11+Bj9LJv722da5bAnfir7BP2KjlxhJnUQ2HMxuX5Ewm2Vjfia
	ojwK30vNK9kgK9LQP6yTapKqSdW3Dwyuo0jnjlpqIpOG3FEzjoINo5oAVurLnjB+sFcrUPsxky2
	3fdkbkXAY9rQtPwFCTBetsW/Yi5++PMAmWvHv+a82j6EZauyg7ktQnuT2Ph/x7zjasQq4rBjvBX
	+RdYmy7+m9r37u+IWjRZwfe5C2P9DirD26pTxpbRvvxHyBa1nKVibzK5IUJthFQoPyQr3zUYUTJ
	BvKbYIg0/+7hBH1QDfYF085+AQskQqudYBgrQ0kr2zv39dIHwTpJ3OTnTb3VUth7Qc3k1Zw0xoi
	DxZOUN+zmimscEReGl9kRTy1YY5tFRPXneJD0FDB3nrl8HxQcQAP4nwPT00XsU6J4+QdgJluPhB
	HhA
X-Received: by 2002:a05:6808:4f66:b0:4ec:d580:2441 with SMTP id 5614622812f47-4ecd580297dmr3380962b6e.63.1790664673453;
        Mon, 28 Sep 2026 23:51:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.5.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbc7b7acesm3884709b6e.11.2026.09.28.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 23:51:12 -0700 (PDT)
Message-ID: <6abb5fe0.6510e82a.2e908.df31@mx.google.com>
Date: Mon, 28 Sep 2026 23:51:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6231328656126364325=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Add shared HW reset for clean start
In-Reply-To: <20260929061233.204406-1-aluvala.sai.teja@intel.com>
References: <20260929061233.204406-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6231328656126364325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175797/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      1.83 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      19.43 seconds
CheckAllWarning               PASS      21.83 seconds
CheckSparse                   PASS      23.36 seconds
BuildKernel32                 PASS      19.30 seconds
CheckKernelLLVM               PASS      26.61 seconds
TestRunnerSetup               PASS      490.39 seconds
IncrementalBuild              PASS      18.00 seconds



https://github.com/bluez/bluetooth-next/pull/837

---
Regards,
Linux Bluetooth


--===============6231328656126364325==--
