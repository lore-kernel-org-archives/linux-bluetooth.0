Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CD1E1023
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256358; cv=none; b=Gc+HKjpj2Rv4mC1fLXmNFIEj2NSSKEr6+OYsuFy8iraP4pDjPxT9a8tXaO5TprJYXs5ZFYSSd8RcKR5U+MwZDwrpQobWO74JiyX2Cti7dpFG6i6fbgqLZEVxGIAiyDRXS0TqfK+GexYCIIZ3OIR9eGCMby7IBlx+GBhG3M6M6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256358; c=relaxed/simple;
	bh=tlSV+75K0CGHZlKZR5YGvRkECM36p2zBElg95fLj5O8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=siHjJi2q+21covErTR08XoRWpbn4ukAwiw2aAvuP3xBR7gMYjI5SM4ip8YZQnWDtYxY6MNlvf/K9/bDw2DuHi3DHEiEdn4kbS/cXv7Kye7sejkk2rAPr35kJA5NrCbUNMyd7zCylVIJIrY5NKeQuZAgA32SeVmlF1gkmIxtom/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoU4v08/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoU4v08/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46677ef6910so165489091cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 05:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256354; x=1736861154; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtTwydMCO/ujq0pHsitl45cJt0HIn2OVmHAEV0Q6NrQ=;
        b=LoU4v08/YcNgl4i7lFVGR0RztZzeEoBl7MLqppUH7A+TUsQBhqoKEGfRuzH6DW+GDk
         jILSGiQf0ZsTvCq2/2COUVBqReIM5By5UpScoLyiEDrly1OjWGIoiNTO7TN8sf3QYBfE
         Vb0O/7l0vrSMeE/rc9Wh1ckuxvJ4F8DkMsKxIjCBEAb7qx4Fw6vHG7mmxXLuhLUDG+gv
         +0TvAcysEv+fylW3OG+YAZcQANqANN7qoG5Ham1acLeqyfeKRtr+N6FYlV+wywDyRu0F
         RqtPy1669+lI2d/43QxUH4ytetqOUg+3Pt20UJsekVgvgG2GHVon23VTSHnmk037DIcv
         /emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256354; x=1736861154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtTwydMCO/ujq0pHsitl45cJt0HIn2OVmHAEV0Q6NrQ=;
        b=cktu45EKf2Vr3VYBLq7dN9psPCYB7gw2CusjaiGHrO4rslqrKbeWttOpeISm1Ka+oE
         c0d8kD840HXuMizDABF6s0xMhlTUfwMzXhBG46z0Ypbc69qLzRZOYvJMTETRuW2cg89y
         PeYoNZy5jvH/SXUl9n0HkmM/ix6bFrfcgKFibgi5mFfw3lJv/obdObYq1rNd7TY9mu9G
         H4Gns088IR+72Vdfcp8VqhNIgQmW/K16vcA3pjcTkVBFEPCldxv+CF2JkSAW9g11Svmu
         ZUQxhweuj7BYrtA6cVlEK3I7CFt4teZk8OUkPRdzCOm3TUGDYdX2TnEikAzokls6W72L
         bZ1A==
X-Gm-Message-State: AOJu0YwC0IHm2QDU67wnwlEwF3uNJTvYJcQCvN1RqDu0mWLtdwGQ9uq5
	eIXopf7Zi06JcStNKr8g5lOjWRCx9btR5thUxc5JYly3N7xJSqp4oih1Nw==
X-Gm-Gg: ASbGnctprQxL1NnTbx/1T4BdZRmS8r3KGJNB1CHqZvifWpsgIVfBISRpc6iBLeCSqnv
	7Q01v8K9q0onj7XCFy56FOQJjlpULZa0GDPId9m6IMauCZy7lrGZTh1bytn/2+5B5jnXBC0L9XE
	xa0u95iXkWpTQ62dw8MrCt0tH8FR0vxUx2eE81m00j/tZXnCkIW2Lui3uyWjirXO4zG2e49YhQW
	aC6p1DNXCvFMw5SdI5StTVoRXzkCqobiD/Yh0DpUg4TlocZjzFZJ8Whrxf5BWL6OA==
X-Google-Smtp-Source: AGHT+IHqiwoUNrSITo3MGqfP50M2W9lgaqtrTP18vqUN7DiC9MpbSC1uiSvLblEjeOzdQTsPyk6Ihg==
X-Received: by 2002:a05:622a:11ca:b0:466:a6e5:6f0f with SMTP id d75a77b69052e-46a4a8c5ae1mr1179322341cf.4.1736256354403;
        Tue, 07 Jan 2025 05:25:54 -0800 (PST)
Received: from [172.17.0.2] ([172.183.161.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bd995sm1596354685a.21.2025.01.07.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:25:53 -0800 (PST)
Message-ID: <677d2b61.e90a0220.32a72f.40a5@mx.google.com>
Date: Tue, 07 Jan 2025 05:25:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4652411943665522254=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obexctl: Implement support for message listing format version 1.1 for MCE
In-Reply-To: <20250107114713.3594001-1-quic_amisjain@quicinc.com>
References: <20250107114713.3594001-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4652411943665522254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922893

---Test result---

Test Summary:
CheckPatch                    PENDING   0.17 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.83 seconds
BluezMake                     PASS      1532.06 seconds
MakeCheck                     PASS      13.07 seconds
MakeDistcheck                 PASS      159.47 seconds
CheckValgrind                 PASS      218.95 seconds
CheckSmatch                   PASS      277.55 seconds
bluezmakeextell               PASS      99.77 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      845.13 seconds

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


--===============4652411943665522254==--
