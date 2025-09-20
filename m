Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDF189
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364948; cv=none; b=ME1LpyVUQariid07KkjsCjdaj/5+486QZNvhCi5J+iUpMDVBJOfXyE8GLIPFUZhEZbSmhBQH+DqOe8R8wb8iCSDW7Rb1HQcnNcXzjslCRa2CtYJE4/O44ykOKfhCQzCev/XeHp5jn5axbsqfAcxa+28/YTZsbt/bKXd/1pD7KjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364948; c=relaxed/simple;
	bh=cilEpw3vtndU0FDaAOZSQtTDCtEQP53zy3wTWfK2i5A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M4jsCAEGg75dgO/pFzz7v50A0LU8+ET4I/sZ0beThouw0o9+zHfEnl465EGeUmWeRK7TxUKcdBWhkL+vT0RKh+19HrQ230CQhYHKV7frrGG3l550+V3zruwhTvFJRwe99uU7dGgGS5+acNGquf5BVUxrjfJX72cvNdYjbwZjDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMkX8w77; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMkX8w77"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so26420971cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758364946; x=1758969746; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1jPQkVjofamHSOJSQc5DEsD2i8uOgJlvEeqzoWt4Fo=;
        b=UMkX8w77S2iiTT3NLrCtH5e6B6383N1OfbpK93KYujsvPZgQHusrdnEiJ8sPngfpk1
         /fWq2AfHu1bJn6hsiAuVBi4f8fipYzgNIxEDC1HXqYOs0rNITAFCfRwkm3KWekuYsw+e
         odpeTvwn3sbJSnB7JsMTriYXFMxsmNmq1pLNNrJgM+64nz72dIbf8WrDWI7cWbTQGSJm
         Ximjqv3J8lb4xCUTvRrnBSZjSOBQvPA2AnVi4UwGammM/RjNEnBOYmyoQG/bwD65wVpP
         YBA8RY/MXjO9qBnkdUy4J5QrqwKggHv4Q3G5uu4tWXYGntDvWGkb9xrVGo/a/q877mw6
         8+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758364946; x=1758969746;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1jPQkVjofamHSOJSQc5DEsD2i8uOgJlvEeqzoWt4Fo=;
        b=m6/kn70IrScQrKsWe7XCs4i4VeQCbKt6M/SCePHCIwUqOSGjLtlv4eM0HgTbC59vvq
         mh4ghuhps9sS8afcAOzztTGnFtZ1RuFfYLKCiAJD7siAz/A9qZl5WhN2HBS1Ls0+3gDy
         5s8qrcDeToCVRXkoUGdE0jfBKIixAox9/b4u63BmlLrwaUPKsQCP9c88VXg7Q3msy/tM
         3vmbchZ0YrgyMkQlB+iTCa82qxKRSGOgTauc2O1EcTV5TneVw8vHixtQpSbjeOQCn2XH
         jgsYHAV1Ndhnd/mDpCXtU42YnQRrJlGzDcWGYCFr2nRFYI9Nb4uSu1FWcVIbtvd0hEqj
         jDiA==
X-Gm-Message-State: AOJu0YxKQXycvVUTAWXE5OilUXnAgPknhO5rtb/gR3yg72nsOHOOYxT1
	rq2KNVauoTL+9PWK2Ba8YBdTjrPksikyQ1nK3qbnX3ebHvbFBcU39FuBU4awBg==
X-Gm-Gg: ASbGncswqDWVv4s2fhNr/z2O9B2kL3VA/+GDmYnUcmjSRx0nctkhfDwgucobbYgjzz8
	ElxycxuRilSHTvMIyLA1Dp/N5KakfXHM+5EFqyVrS/zuhUd+d+FU8ERp26jxuF/7YPhz6Nt9uxz
	BUbcfz7it2GHIiyZ2nJB1NHIwqvp+1+AEovAL8ZmDMggAacHtXez+5WhivkwCvhjy2hyG36s/8D
	QGR4Ic1ksHczT+893/gNtCxubaSvgcISOdDce27clMPFnL48A9XvxnLmoy0rJW9ey/ZrqE0CVXG
	Uj/3bKUi5vOF2pXhZaDg3aJWm9lR1kKYEDp7Jt22rxvmlVh9zkRZmjfv9ZIt86vQ4WLSBpfqSrp
	P5eSx6TvX29zCTZBsTkn5uMc5B7bBxFw=
X-Google-Smtp-Source: AGHT+IFSGXSbzWIPgyZ+zyNtACrBLblCWj0tmuO/1VG34SmTG8r/3co+nRMbwrJ61Fhk2HF7xPOHTw==
X-Received: by 2002:ac8:7d0c:0:b0:4b5:e9bb:8478 with SMTP id d75a77b69052e-4c072e26e9bmr79359561cf.63.1758364945814;
        Sat, 20 Sep 2025 03:42:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83633732305sm484463585a.63.2025.09.20.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 03:42:25 -0700 (PDT)
Message-ID: <68ce8511.050a0220.1b8b2b.0c8d@mx.google.com>
Date: Sat, 20 Sep 2025 03:42:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7867250803952770376=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] doc: iso: add BT_PKT_SEQNUM documentation
In-Reply-To: <5ad48176668987b22fb71be24cf4e478d0869dc2.1758360020.git.pav@iki.fi>
References: <5ad48176668987b22fb71be24cf4e478d0869dc2.1758360020.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7867250803952770376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1004473

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      19.96 seconds
BluezMake                     PASS      2712.96 seconds
MakeCheck                     PASS      20.40 seconds
MakeDistcheck                 PASS      185.02 seconds
CheckValgrind                 PASS      235.21 seconds
CheckSmatch                   PASS      306.44 seconds
bluezmakeextell               PASS      128.20 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      913.65 seconds

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


--===============7867250803952770376==--
