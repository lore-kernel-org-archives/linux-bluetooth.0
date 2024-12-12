Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9372135B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013258; cv=none; b=ilulmJWNb1Wqntazx+2oty5cvZZy5bse8UtD9xMaPBWuHhL5i+jCWnqUJrXG6OlkkB4Vz77YqoilyE3pV6kSN+/X3XMWPUNZb1oDIai3U3il5tsmh7M6McWP/vq2iJgKTF6q/tlv1V3MuAC9bAvk4vp0zpbNb1yhJOZXX48VUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013258; c=relaxed/simple;
	bh=gj5dSvIJ9NOdAWbk2JpFznT7x1ZaiuwWikuYm6gRFXM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jn5rczJmAvAtly2drC67mHfZRYVoQNT2oqSQf7jff7eN1YKjryYA3RkIkt/7I1vZn7yk2PC880dZ4rXHUmQh10z9pckDiZWvWjnDdwX6uzu727A3v4d1w8QQN8qE/K6Jcy1DCZ+Fw7FhwXuvuaf8h3sFldWP/wLtCTCatNHuUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1Ot1GXz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Ot1GXz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21631789fcdso12730285ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734013256; x=1734618056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5We9iYJu4xJUFHRm28QUx0Pz4MgvQER8E+XzB9X0kXI=;
        b=F1Ot1GXz7yjpHRljdm7iF4JRdzP5w3bn5BmG1DSDujgb5KuSQiNUaVCu7PLsi2Sko8
         DCT+latUii1q4jjFigynxI+tTlrkS/9EshLvYEvF1TcKQcmr7zQdc9qkfyBhyKowCGm1
         Mgovoal953Y2B1l4aQCNr3iJx+c2tKAPniP6PhccrAUu9xLjR2FNmtdrQrZ1y7pSGslk
         84PuUVJM1JhB3gB7CAqDxm3Ol6jmfLGZaALyL7oHIhwbb3/Ndmc/9y2M9DHsIvxhykqZ
         6gDddLPP+XphQwmum4QeXqUngMRopJ4L1Hc4QDL2Y5Pf4r5Qpt5if0cArEXI1SLE/wC7
         hVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013256; x=1734618056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5We9iYJu4xJUFHRm28QUx0Pz4MgvQER8E+XzB9X0kXI=;
        b=qqewmsuwCL4YaoE+JqNUEviVf+rT2hw175htkBegaoNY6sSGF+6ErRF+T90Kw5rAkp
         sOPkSYSlfY0dAlPls4HifkzILLdU3j8aLmCZmyXvMLd22kljqZF3T4tGaKs9WQ6u9dTk
         UPCOBegwDukTSGcBhGimmr5PGz4j4Mhm+VBv9+axyA5Orcu93CILW+lhDmN89K7mmFux
         uZVlUdzikTfP6fJ1XLsZ5vtxJgMvD8WT7AQ/Dhw0hk9kcPlRlcG8zvEIQHf3SJ2ZvymC
         arv4bh6TCQpgrZMQdxv3n/iGpKzpVwaouArGIGxDZrYE48hm+hK05i8XfRMLCMLLaOi2
         1+1g==
X-Gm-Message-State: AOJu0YyrRDi5BPPX3mCBYoIzD6v+Z+6OpUUi1Pxu4AOMszzpaNy2NjfB
	KBG0143HoeeZVZNym8bn7sIaFA5T+tMRu6damU54Y5Q1eddz158RKncEOA==
X-Gm-Gg: ASbGnctGo5vEH99XoT2L542rvfP3hsmi6jrQ9+4BtPv3oR9MGazotHyLQCwRLyoljdz
	TVGIVOSGrA7lpuMOLq9WKJ4//76Urgl5PSbDVxjL6SldM4G+T1JdrOp/VXbWvRdwsYfqKVlmxOo
	W+1T7QMemCp/Xs4EEt0JJA9Y5DyEMdG7HOhGuL7/ePTAQ2aWqvg3DOaNuZyfS1c+IM/pFU2ssim
	A8FpL4V8q/H940gh5z+g7cZl4iIAM0Mc/IvFO3WmUN4/PMROfU1sVJrwIo7AQ==
X-Google-Smtp-Source: AGHT+IGE+Tm0QeKd5pCr/aBSJ6haud6iVeB9WXUK74a4dfVOtaozTWKa+szVPzVL5i0XIzKS1zJ5SQ==
X-Received: by 2002:a17:902:ea02:b0:215:b1e3:c051 with SMTP id d9443c01a7336-2178c84dc8amr51386695ad.11.1734013255689;
        Thu, 12 Dec 2024 06:20:55 -0800 (PST)
Received: from [172.17.0.2] ([13.91.69.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21630fee27bsm89001055ad.269.2024.12.12.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:20:55 -0800 (PST)
Message-ID: <675af147.170a0220.8e75b.c793@mx.google.com>
Date: Thu, 12 Dec 2024 06:20:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6743336758983635982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v1,v6] tools/obexctl: Add support for system/session bus
In-Reply-To: <20241212124903.3450994-1-quic_dgangire@quicinc.com>
References: <20241212124903.3450994-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6743336758983635982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917182

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      1540.41 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      158.08 seconds
CheckValgrind                 PASS      214.11 seconds
CheckSmatch                   PASS      271.75 seconds
bluezmakeextell               PASS      98.61 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      846.43 seconds

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


--===============6743336758983635982==--
