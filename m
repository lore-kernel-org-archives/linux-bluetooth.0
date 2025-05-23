Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E021494DF
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990014; cv=none; b=EqckPbqyK6rY7N6U8/HKoLriZZO3fvkCbYvt221ZvH4jetkU/wiJwyE5GrBq3+Sp9D+SibI3IitsZ9oh5pvHKXKXNBuQEgpkCPQosvPbbvQUOoseHq2G+ZmD9Wiaaw0U1Yr3sobuJowY0gcKaQWSROGq2PR7jaOCA2c8AWTiI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990014; c=relaxed/simple;
	bh=cZ9QR6QMb0xmvLi0zprbZNqlURgjX2tskQRWqEtafA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I9/5Ss17d+9vXvYXHDzar1yZYU+SuUMTXf9qRHNLJ6CjIrJjjdhqu9bBWtxu2CV3XXkHCpaKGILyNhoInEE8gg0tytF4lQ7ivkvngaaiOrDeaJNBqMdHOPSCNJXB+0WXlpcOfuYU8dTUmnkg7+t5mQ7YiUze3Qi76ZnfY2bt/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBzczScu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBzczScu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so5085757a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747990012; x=1748594812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ULTtN5M+0rU0yOqBAnckvro5Xb9yFBftIDzYFHDDYAQ=;
        b=bBzczScu7r/NSVJcl48F64OaNFUSWIduZFLuOjLORbfuGV28Ket42ypfUFG8X93YzL
         aIwzuTffDMa6dYyYpzMFHncXnZR8jrZbNVpy93uloHYBKffpGMX5Hi6V26PjpgITnI+G
         5dH5mI/OelVJwiyHry4ZUdeaSIsNUorLcr2VKyQFZPjtGR/rJW1G1kDK/zTHzmAB9sFq
         vq31GRBx6MDAGzpE28ibJcLILq31RUmVUWLVnSo64/5s30epo3/iCMlifO0hWVR+fVEg
         /oDd+FqOlZSn9BLYfQJWLHdTd4ACkwKXSfOqGvtL6mXkDWgEoTg/A2fQS1/V14rfqvgl
         vFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990012; x=1748594812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULTtN5M+0rU0yOqBAnckvro5Xb9yFBftIDzYFHDDYAQ=;
        b=wiLI52rRGPx1mBczCsn4k0u/ITSwcZu6wrnJbmufkMH2oS/StAZxf+tWnYjyujbL16
         lHMGWNQso4+BkxJP2yQZTu6Ci3JzE9323CWApAN1No57fMFPKX3+0wfRu7lrGtNkGiIq
         wxG2nkeAwIYxIqzevxfxCriU6K6qnSFcfXfCjbBVSVizew1hziAWBMMenJZ+vg6qFJBe
         nDvvE8tg2bGKtiFjk06d52XTTGHeaNEm/GqC0WL9aBse85FRBPyLpsUJuM+kDytrkYh4
         rYrlUrBnZ3EjD6GYPQHpRktJhakZMV0Z27IKcMK5xLIUVjm22iQewleEtO4VJebZeXF7
         KYfg==
X-Gm-Message-State: AOJu0Yw1FTqOSkJj2XGipMcRSXOB/QDlBy0pz0CvVXLDqX1ze8mwWAXn
	0yswPPd44drT1+kuj8YcJngcA13oXoaZ9791aQkK9U52P4HOn7rCVB/Ho0TcrsP+
X-Gm-Gg: ASbGncvut5pIFX/uJNlgXkjMMLiNd/s40rwACIfO8ThNgrGeoUQQTldqdlUY8kbsoBd
	baWSj53mS8ALYjPfBAS/s49blTYbMMwtbPVatNHbf978IPhXrdAt8I656o7AxX8whoiFsLkYYyR
	KCrWC+JRLjhQHVZcHW+utDbNNBM2XRu1ivqMdvqotjO0NP9vtPN7EIRFb+mV2Z48wHMZBkhNahD
	PlSNuUEJhcttec2RccE2wV8s/td3gHWR6aAarFEKuUymaay/p/xoAUbtbUfW4k19MEORPxsG5y8
	mK+EJP7J4uyp0OG+1IJ6ifYq9CbJk9CpeUnG+0FrPcj8yhVY5U/QPkvk
X-Google-Smtp-Source: AGHT+IFY+eaCs3cQCsNJr/3slDQMyxO7jNzjbgq5AN+3uRDTx7+4vDg9iIPj483JhlDDMuKaaXMoug==
X-Received: by 2002:a17:903:58c:b0:232:5872:f00a with SMTP id d9443c01a7336-23258730137mr203596485ad.43.1747990011993;
        Fri, 23 May 2025 01:46:51 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.241.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9256sm119989205ad.35.2025.05.23.01.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 01:46:51 -0700 (PDT)
Message-ID: <683035fb.170a0220.35d608.3e79@mx.google.com>
Date: Fri, 23 May 2025 01:46:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3832595195497354867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Propagate disconnection reason
In-Reply-To: <20250523072647.689324-2-frederic.danis@collabora.com>
References: <20250523072647.689324-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3832595195497354867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=965695

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.53 seconds
BluezMake                     PASS      2611.25 seconds
MakeCheck                     PASS      20.20 seconds
MakeDistcheck                 PASS      201.22 seconds
CheckValgrind                 PASS      277.99 seconds
CheckSmatch                   PASS      305.14 seconds
bluezmakeextell               PASS      130.37 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      927.61 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3832595195497354867==--
