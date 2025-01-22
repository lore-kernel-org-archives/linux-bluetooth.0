Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C0143723
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575665; cv=none; b=dZephoB1wNPV72IX+D6DXyYgZ0HrJfpfJwpslLatXwrS0n02Y9+vp9KErrYIN9l9Pcm8tJAhoGu4tT4spMqinCXnRngmeipnrVS8FeSvnkIQjgZPWiFws29jcaQsadVScjs/IQI1Z6/kU1w/2zYWW/Z0ITPYK4LZOz3wTawwGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575665; c=relaxed/simple;
	bh=RyxPugpW/ggprlc/jKE3yDHOLRJk3OaB1jnF79e8DYc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P+VadwWYxCUYijAZwQxdh46HpLwXQzqeeO5az4//gym3TujWp2fJK+kCkMbxPHR5nSUn0CMnGToqQw9IXkE6l7bZXFpdKpDsVvhcxp8hSnxwe2cyOm0H0+QuoaFWWzXltWqd8CKtQWzanT06x9t+RIbgoczrNLTsQJhj5jiwErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqToJaMf; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqToJaMf"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d900c27af7so1994006d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737575662; x=1738180462; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7lnpqJKNwjkfrBrJTS4cb6Jvl91rCjeIUSKoTJB0sNc=;
        b=XqToJaMfiIy+MxmXWrzZZoWLHDqqg7GtLrOEO3OrHsISqRxmYQ2erbf/oKDn1qL5F5
         vi5hIypEsnQKIAEGHBChODSvII3SSnbOJlyXRNmuVKvGpgEGIbBgB/dPs5Rz2pXoLRxZ
         2JSCsRjN+y2MZcNNJcqaf+feYXwyp0JyZ/Wc/hUF+DbLX5L/uVtkecNv0jjhnb+fKEFc
         n03Nd5QZFXU9dmaG/zkiz7x7/H5Jp6tel2mZmE7G+5u/mT/QmxLT05yAlpxpdvsDjT2+
         +8tOXrt5grfnBePsV6jW/sHhGwB1Fpt/R0g6Jk1fD344PIGn0UQJl+lSeMqs/V2TAZzq
         3vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737575662; x=1738180462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lnpqJKNwjkfrBrJTS4cb6Jvl91rCjeIUSKoTJB0sNc=;
        b=Mu9vTXxM5WOmBibRNfhtP+w7IXkeVBipgnO7QoJgpAPFuFV1iu79vD2lZjSHvgTrCT
         hIAS4JYx/+7E42OzZ9cESbf7rkhfHJm1Dfnw+gpkFHzUpgD3CuUcuWa4CGW68P0Mjgis
         3EJGfZUZcfswDH1G6X2OgyupQrbSGs4kZJyZOAUjACKBZErGPP7GACqvCghZL/+gTi2H
         DV2PvK8+yAUPLoA3sAY0weFQ9bv8h1HFqmGJaiyXGRGrkTGrzlJLioyZm5hqowvGyW60
         VYAq71HxhUnJeK1oW+NZ/NHCHjltW4dMM7k0fGGFshisFliIwgn6kTqQcPk7hRx4jtVV
         JiVw==
X-Gm-Message-State: AOJu0YxvqjE6y7ZJZN3+Q7Tf/cPhun3mUVqvJ3IOu0xrjHoWimAw0Eke
	Fy4D6S9af67Cf/zGDSuag2sPKVx9D5btmyz2CeO8Ns/sk+ayVs6O8e353Q==
X-Gm-Gg: ASbGncuSekbtq0S8ZlnZLjzMgvtHQ9YgkeK9H6uCK3zPHwLCqGd3HZINMpbR//xP+NT
	1yF5nkiVGKExelWgyLiDUv8Vo55qbAIF57KkKNuoEn6aVIVfC/HPBfF31SlM7We9psYNnPaDFVj
	VmaOdbERRx1dvjm4xFtMj+8OWuvdtgm8rasqMBWT4MqVaIL6qvNSJy+6OwGJZ9LAPAtehxk3mNy
	rXaREVFG9b/yK4Pt64gvPmMH6Mq+VTFuXyV8wnC4yTKNgRuaBCdq84NBeoWOPPQJQdJwEsuvf4d
	26YXotb1mOhd
X-Google-Smtp-Source: AGHT+IEyzqSn2YYAjd/0SwkeEHdM3q2//L/1EckWfHh0TEqp3bAP0XEPkhr/NzxcB9pJDwnQwqD0/g==
X-Received: by 2002:a05:6214:1d24:b0:6d8:e679:547c with SMTP id 6a1803df08f44-6e1b220e3b3mr293686036d6.29.1737575662547;
        Wed, 22 Jan 2025 11:54:22 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd38a0sm63813726d6.89.2025.01.22.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 11:54:22 -0800 (PST)
Message-ID: <67914cee.050a0220.1ae01f.b4e1@mx.google.com>
Date: Wed, 22 Jan 2025 11:54:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5067241403329699543=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250122192016.86251-1-luiz.dentz@gmail.com>
References: <20250122192016.86251-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5067241403329699543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927638

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.29 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      30.03 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      427.69 seconds
TestRunner_l2cap-tester       PASS      20.54 seconds
TestRunner_iso-tester         PASS      36.85 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      124.94 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      9.31 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.66 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5067241403329699543==--
