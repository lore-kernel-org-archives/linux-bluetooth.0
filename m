Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DB259488
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256307; cv=none; b=F0UmznS0K4VmMCip4kLcDK/nenPjnsrGPwybBl8sIeCvpi/LilAl1fcOBCWsKdxL/Kp6i0QmqInuQzeqjKUuc17JpUtFdJD2zvD/YqspUWpVF94429L9bck1rY9nKOoNoY55kiB/btjGmLPsIlasHQJHK2HXuCBRbxmZIGsMom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256307; c=relaxed/simple;
	bh=lskcrj98aFOM/wMrqlXq5o5wVIz6Qmappy3tk8IrGBg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zy4DxRJaTJEGD09fz+jdX6w1QCxit8AUZBzMF6qCIlQ6hWUbH7n18fuqhyTmX6QfhklsELepSDjgRShKzvqtqKR7+ID8/X8blpBGlEmpPcjYTqjYgmKiWo4ZyHLHSt180eUHEn+lP/BfRHk37rq7czvJUvZqdHrrw0w0cDHwmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hISGOVGX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hISGOVGX"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so2086933585a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256303; x=1736861103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hZwuk++Tw9AM0gE5x+XavP3Iw/Q6y+eXPMgY8nM+b2c=;
        b=hISGOVGXE17iYOfQaWfrgBlbNIemcmumlWCEJD/QXO0v4Y5N+Y1TOt5oM2lvB55NHr
         cNR+WEOwLojlaUXNhs/XHYfPx09nbVhTtMu/FuH9DBbE06vmIRIPlwXjQIRnGTwMSSeg
         zO3SIaoDmJ6D7eOIksoFevP/ZIoxraI2rh6XA4G9mqEMQMB5o0DGnRfuVEm8qZjPccDN
         Awp14A/5C9WKfMlugK3joClUyGB3e/zvL7LYgmQBiLsSM3jyfzmPfGj1crdKnaS1QPVS
         IWcGc2tb9MZDpypEYc+GR1HA7qFu0Wyv7VGfwSuzG5jaR722ojlMypr8B/iQ6Kh3Hqzx
         QAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256303; x=1736861103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZwuk++Tw9AM0gE5x+XavP3Iw/Q6y+eXPMgY8nM+b2c=;
        b=Z4L1iNGOsoF/tbkB2zFKxJpNT/OaWFSdjy18sG0xv4MWcLUfn/vFwWlWC9tK/u/JNg
         o+v6D+c2mfCtleSQ2wH3w/KOljjRAPhPW3BkRVtBGTvPDUE3SeOnj4zf8OQtKTrtB12j
         XJ8vEu2cV6RTA5qeATH2GVUgsk4iJ1SpmmUycSDZSN4IQM/CcKW9luTwD3Z+UFwWTIv1
         bUYvZ9Y60sqWgs74ZJeMhjsktNvSdhHcj67vk2EShMVxvtnhWNUpieDD84Ix2loEG9pd
         TWw1+v4UXH/vFyGKY8j8G5dstt5NF603lSB2WivaeMl87t1rjD9b5jpLN8tIPZybfvF4
         UmLA==
X-Gm-Message-State: AOJu0YzCuopOyRSjY+2vs2LMsUAeyNOiLM04EbDzC48lL0RFvN72kNwu
	XIU69JEA3vylZ0840pNrbmSqqWSbsBcDE/7gVIWy1NVlNszB7smlJmQX6w==
X-Gm-Gg: ASbGncuXg4RnMH+OPI0k4CluSAACJzE3r0Q4lWldnJ2mZahI+IbfyP7MpHGd9meQFtF
	Om6rncso8pYjun9pSwni281PsomAwAqF+7xtTZyTlherHn6Bn5FJT47IX213464GLL7MBWu5LYU
	mcqjyK1j/dO6ZkwyLJXtxyOGBpNQu97591W2ob8nJTeN92zC5g8X4w22mqbzmxkwL7MM7dTaF6h
	GtmdUxopGVaPRR16Bvau+WmpmTW4B7RbKqVKzlZrmqSCwr+QM60M+EtGyLP0TUq
X-Google-Smtp-Source: AGHT+IFRNReTpJUnQ+EGdWFNXCR9danMft3cF7jQI28eWbPfOsHe9wukGgXxaZ3/Ru3LFsjxY7TREg==
X-Received: by 2002:a05:620a:2492:b0:7b6:d76d:3bf8 with SMTP id af79cd13be357-7b9ba6efb3amr8056136585a.11.1736256301878;
        Tue, 07 Jan 2025 05:25:01 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.106])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30e30fsm1594118885a.61.2025.01.07.05.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:25:01 -0800 (PST)
Message-ID: <677d2b2d.050a0220.25ef8f.3bbe@mx.google.com>
Date: Tue, 07 Jan 2025 05:25:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6270157508198667691=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v3] Doc: Obex Implement support for message listing format version 1.1
In-Reply-To: <20250107114532.3593843-1-quic_amisjain@quicinc.com>
References: <20250107114532.3593843-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6270157508198667691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922892

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      1510.30 seconds
MakeCheck                     PASS      15.76 seconds
MakeDistcheck                 PASS      157.48 seconds
CheckValgrind                 PASS      213.14 seconds
CheckSmatch                   PASS      270.95 seconds
bluezmakeextell               PASS      98.47 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      836.56 seconds

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


--===============6270157508198667691==--
