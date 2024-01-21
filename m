Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE74374FA
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705872671; cv=none; b=Dis6xwbHaL2ia4QXW/LPTnNVX5IZldbacMwsQeqee4RHpRnTxGoLO6WLt+FvNvfkpl1+PwK/C/xkHAvvkusq2AlmCREZZGBplq9d7aZxk7szRRXO53RP5vYkATTZt+ldj0ixah0WUjAlvzvD1mzLBCfrarT1FOg2xf7sDObG0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705872671; c=relaxed/simple;
	bh=qGjbQcl+7JyeVergWuVgwx/mVpApkQ1kPPniha7M75c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uC0mYRzxgIqj9Vth3HCDwgDQQ+nXUt5SYNTNWLBjOLey/zjsntOYXcHG1omwO2qZaV1eKvAobY+RSNeKNi6Ff6jdbpT8fyXa9f4xX5MzRbEiBnQepGIau948eH3KLMTlXALuH5KXwFlqJUF8SmBCZmntPNFKnt1j8LczQviQwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI2tovGT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI2tovGT"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6806914dba7so21169806d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705872669; x=1706477469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9OG3n0+FFh12EeiCWhFmLg2r2Ub7+8oiHJ7GG1fufw=;
        b=dI2tovGT0eDAUlj5v4wIhNuBbFUpLi60j/XmyF/faYgNUGHS4olD/Mip5zGpM0JC4g
         g+HaAW4+34aRpZDJYeslvqlJj7YHqPtK/89jRgDxXfSh1xBBpUioeq7w3Xf+lapPQD4A
         Nxu0XCa88YeCR6QAd7Jzjy8n/6Z0tNjnVZL/FUzXFO17VlPJi1SI3dxnfDhxCN5kgOCt
         0VOlmu/x9VVEnYEyjcQ/CNTunmAmyyNRvheu2FfOrrIFAQfaPojYCEb6Tfjg7BHobvb7
         1PnyS2uHlj8Uawbm5j107DgqNAEtWIw+Yk/beZU/YleDYPM9/ia7+FF44TN5bRLGOcFz
         lC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705872669; x=1706477469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9OG3n0+FFh12EeiCWhFmLg2r2Ub7+8oiHJ7GG1fufw=;
        b=Qj4HLkxEUFhW+Rv1HTfaQBqN6QykS6+aCdzs939XaAIWYGxfgmsJo7tRDNNdhyic6x
         Z2tknTrksoD4upRb+mTYWzeNsJJq8oEoBmtkfs9SQgP7IB+Jog7W1tiyLs4CwvE4tkR/
         HWi+oKDaG8E8nhmy+GK16TxDccyx5otNZrIVdXczg//gPF/thuOLtjCAX92Sq6aZTsKx
         hhflNmope+d8WhVZhHketv1MYzL326g1a3VURFW0oLXSH9ndK2dvCcFsh4cZboxe1uvH
         91KZb9FtuOTO7j/VE4wG5xIVAIH1plfqxkpf1A0R0y4tEKJPmG3diYgyPu18QqfKhRuL
         BrJg==
X-Gm-Message-State: AOJu0YzM/cF+wyJomjC3dEojvfdeXQ5RRykmqjVKfS8zrPtAClfJzoPr
	BVJ4vImN1++ersdURESXGlUYDvdU7615g+Lbjra+di0CHRz0Tbij0cfDZWlx
X-Google-Smtp-Source: AGHT+IFUCwBilr4k9YtMXDTt98riYchy4/Tabs8Ti7+1KALcaUhihrWQNOJP2lVf5xPsy6r4M/eydA==
X-Received: by 2002:a05:6214:20c3:b0:681:5567:5750 with SMTP id 3-20020a05621420c300b0068155675750mr5526242qve.87.1705872669131;
        Sun, 21 Jan 2024 13:31:09 -0800 (PST)
Received: from [172.17.0.2] ([172.183.74.5])
        by smtp.gmail.com with ESMTPSA id kf6-20020a056214524600b006867683a3f3sm760499qvb.125.2024.01.21.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 13:31:08 -0800 (PST)
Message-ID: <65ad8d1c.050a0220.3582a.1612@mx.google.com>
Date: Sun, 21 Jan 2024 13:31:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4547482385014450265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: register all endpoints before starting config select
In-Reply-To: <447a1b2f472b1c0c83de357e1c8094eec73308f0.1705868192.git.pav@iki.fi>
References: <447a1b2f472b1c0c83de357e1c8094eec73308f0.1705868192.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4547482385014450265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818402

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      23.77 seconds
BluezMake                     PASS      731.33 seconds
MakeCheck                     PASS      12.37 seconds
MakeDistcheck                 PASS      159.12 seconds
CheckValgrind                 PASS      220.08 seconds
CheckSmatch                   PASS      324.50 seconds
bluezmakeextell               PASS      105.64 seconds
IncrementalBuild              PASS      689.90 seconds
ScanBuild                     PENDING   951.99 seconds

Details
##############################
Test: ScanBuild - PENDING
Desc: Run Scan Build
Output:



---
Regards,
Linux Bluetooth


--===============4547482385014450265==--
