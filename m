Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14484450F2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608394; cv=none; b=gnRnYuDvOogvrxYBUvMDP0nFsmwbKeWy/PhvI5cswbIzHyPNtyVKScA70OGGxeNKPj4U6lzaO4yU/wR7HeuwGUDvGYaRPHCSzAWVr/tCSEoM5BCiVUvUWlq2vfCSTUzFLuesVKMDetCR/SWws+qgH8Y1omo81DOryKaVEQmxGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608394; c=relaxed/simple;
	bh=TYGb7FaTIZZ6R9SECePzqJz3QrZ7I9J2QiX3BLnUNyY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MuJhitdQH7WVUX4i0VPfoD+gWEaUNj4i8f327sMo5+wlWFQZni6HqreKuyI86k9GlFPx/NaNQBvlfkP8Eq8V9hCp+z4HL4+ypr91SCx6kOfGfI5bmldkuj7a20E2htLjO9emFMjxMPF16dzA14vkogwlCo2nzJf9Qq6WsAgkKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPNCWQce; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPNCWQce"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381891a9525so1277807a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608391; x=1784213191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/dgrie5EbwwAWoxY27aoanIdtDlDw61GyeUReDYD9s=;
        b=cPNCWQceqn/k6qxV11VMRs/sJxxTofx2MPnmEU/Xv4GZzUToeTFGW/Z7klYRPxubAG
         D1rlfRNLFBjAqr5eLtvyT+xpJ6Dr6AtDE/OhMYztmeBl/lUACMuCsvnULLc22yMsTGBb
         W5vifCJv+fN77wFi97dycaOVVsmqW3kyfrri4axB1T+A8lJHDvtBp/sVWkipf4e+rwDr
         xu04jwq2m+B6wTWp9idzy42dMWflCZ7UX6eR97JrGQDTT7RAVSocqw2u04MKMlpJ/yhy
         su1uFyqFgihPlF55PRiWebUxRyhezyqGZfS02lPzu3ZQVYprUXVAU1wsDW9T8dzNqiQG
         gGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608391; x=1784213191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m/dgrie5EbwwAWoxY27aoanIdtDlDw61GyeUReDYD9s=;
        b=ezIOxlxh0aYWOiIZOXw0mx1w1fPlLaTO5viaoziPW1vDNrK7HX8CSpp/qdVEMN+CPm
         fbnMVltgLKja6m5pAY7hzZPlG5H0YP0Zlrr7XcrZFHmiA4kgKrDYu5ANy6W5aBc8kRoi
         kcHhnKl4l9XnyqSrKCpC52aGmYD8r5OwGZyhu5knTxXLep4zc+17rSfpJaIpHZYHBgAU
         j/q6U3PV7xbQjiuX6k7WOKBNADBICjAOR5QF0oK7FznUJw5FFSbCGgRyOeFA5EParM8A
         9vToGhNruhGdQDqJ2q3J9ceCIHqrELIMH/jA1Bt1iz57Yz7YS7h/ZdnCz1CVhkWwxc1j
         6lrQ==
X-Gm-Message-State: AOJu0Yx3lZ6Nsh30U/tD2Sk+oeu9c1mc+HHu2smVnUtNOyHKlhc0im2Y
	FAl7o063Jw7gpoGtQhg9IEixwMgNHPZ36KiPFZRPy6kbsDGAkCovC8rglUiM9w==
X-Gm-Gg: AfdE7clKDfpmd2lN40kGbIemeXjevsn1Ubu971dMczuH5YsXAasg94gCWMYtEYLXzqM
	I3rQ9FXtvgj4LRzGluSe8zdwAK12SF1hPP9zNmAy0Ui39Vf7UPchuv/XVQKs3BEtgUoeE9WcrAz
	o6lcHV0eLwotKtsS5jug7cjsEjsb2+sEb6+Sngp9GngSt38+/pvkzYOuntgjPn2t1vZhx5+3Y10
	wea9o1aL+iGYGFMaTrCDLqvebBbb8SXV8S5jetLK2DeSoi3OZoSvulN3/X1Fvkz84dVXRNSAZSM
	Q5IwwO51aoHg1dNx4LptOKrPAxWXhIfm2qagiOYc4ThyWt99Jno7pEYZNgYaodtSq2pcwXvJCGD
	AxR7YdFtvRX9CdlfyQSUGUZfGi+1RL7ybuVAJdvaEIgWkk5zJrrWe/Ck0GRlxqLJooCpIz0djWu
	NJ8uNNSHY3VBNgyadR
X-Received: by 2002:a17:90b:2f06:b0:381:50ab:1594 with SMTP id 98e67ed59e1d1-3894120590amr8604371a91.27.1783608390658;
        Thu, 09 Jul 2026 07:46:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.6.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm33679652eec.27.2026.07.09.07.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:46:30 -0700 (PDT)
Message-ID: <6a4fb446.f732ad81.3a4994.eb01@mx.google.com>
Date: Thu, 09 Jul 2026 07:46:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2841121533900069135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tomcatshoek@zeelandnet.nl
Subject: RE: [BlueZ] adapter: Fix crash on UUID discovery filter match
In-Reply-To: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2841121533900069135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124682

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      18.07 seconds
BluezMake                     PASS      628.26 seconds
CheckSmatch                   PASS      269.35 seconds
bluezmakeextell               PASS      94.72 seconds
IncrementalBuild              PASS      651.86 seconds
ScanBuild                     PASS      866.74 seconds



https://github.com/bluez/bluez/pull/2283

---
Regards,
Linux Bluetooth


--===============2841121533900069135==--
