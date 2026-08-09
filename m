Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725034DCE4
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300846; cv=none; b=r7CxCLgR4IVwyWouJYD8eCZajGdi+mdztz6ZbG3LyXK191iO3R8RXL2MZWTh9XZ5cMDjhfsR+trCNUuJz9lvV4BD1w6u1WIsRS1PRjfF6PR0W1kORmjSt1G6E06R4o2KW1tUCHZjTvAQzWJCn3l/kULQCtIbt96nqLMPvh/nzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300846; c=relaxed/simple;
	bh=XCLw4lbv+7HIBPjqdvML66u7ytTCHc9zy2PNdg17YcY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kjxzl4ZHjudHHPwCTNaaFu5m25ifZUiGYpQNTSReOWyD1wUW118PvdNDgE8aAN+nZZJ3LZt55V7ubYuzVBO5HF3ZOPRNrcPFpRfp3X08SgXRCAGIpe43QWMHoZLqBnUGUYMBHNm3mAl5vcJiqwagmSc+H0MltHsTxojglqJ0FhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvKEgtOk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvKEgtOk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92edb12cdf2so64329285a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2026 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786300844; x=1786905644; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BtuC2hMrUAUmvRDwJognr4jiaqyuziTzs5+QJX37v5I=;
        b=kvKEgtOkbSfY1R9X0X1Z9INJgfkSGrVw98fL2LBE4/QFB1hqfecueYOquUmrGvtLlY
         Ujb/qQ3PhXcgGGHc+8B9gQRneP+3axzs0UA4PysHj7yH9jCWXbG/hGMRR2l7ElIkmPD/
         K5j3bvMtKGHwH7RoETFpn6UZKER8nLLXqNIfE24Oa5zwkW+zCWfXTRZSWIYmT0pDtA0T
         3x2CUa9hB/43YPbdlK1EiS4tTwUkbt/zelFg2lB5Er+f24umuKZ6QrNThTXEoRaNqIW+
         6ZHmd/exCLWnYoe/DwsmyPijGfSVrNRoWafoBALKPlqFsjpV1LtzhsiWnsUQ9Tyq3SDx
         rK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786300844; x=1786905644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BtuC2hMrUAUmvRDwJognr4jiaqyuziTzs5+QJX37v5I=;
        b=YcW5BSA9yG+Dbt5h1gcVwt7LtnEAmxR8xHhB4ocIrDvAuZW+0EC04k4rexWD71+0eH
         wzVeeqV9tjRAFAu2Myoi/PA1gw/Ps4yuq4AHwVOAN0fG7GDAWaguPjtQRBt2eGKCYS8W
         YGrsPWanSeXhikHNwTCyQGxOTeMONME5X9v38gX3/qxXrSufBgZHYyDvICot41hy1hGa
         EFAVkvNLwGyjGJ8b8eV5HhAnDlZig11SpGLDQkjKbdDbVwzeujEFJf4KiBSgazh/QTza
         XHKkm2p34J+0W8CkRIINivKE9EP0i2QXCmwVzqoBGwWAEHPiLWA6j44vrkwoNWIcYyr/
         oVew==
X-Gm-Message-State: AOJu0Yz84cfS+MiVTmlUJ+VJAJtZ+EUrAn2tOGjKZSBxiOgPWXPhwxOe
	1io67Q6Jv3zj/tb31T81wkIMqqn8XY1ux9xj4L+NKXZ5I2J1pg5Rj8sYwnXM/A==
X-Gm-Gg: AR+sD12HuF8jLEPNYmKn8/Wa9wc2n2p3G9Y6XcyjjE8muw5Jh/zUCOktiNRGfTu03Lq
	6csFTXKD1fdLfRPW/YNE90aD72uEyhEVguADnnTZQAVLpbZ8DxYXaJeGG4iI0lvErWHEjmoyLaw
	nK89h4DVoZBivB9zaHHAhUAZTFWtimSwznqFuMNyNFonHXQEPbhB/r84TGTW4HQBMsXkXF1CdRw
	23XhHw5cXhdip/B2IFRCxlhqkwZR9P9SjHeN8j/3nOgx3lln2OnsiYVozFQ9Mqt7n6xluybO/vT
	06vK+LPej+biWh1DrdEQ7kU8awc4XvfYZ/H33x7XOLkYcnTbGj0IrIkbCUmnaz7vZgQaT5tj4BQ
	spxHKXslSSW6pNYiLeMcHNOz7Dx3gEPeMyukfqWW7IgGkqKniXR5RnBWcHvugZBcbDVz6owCavJ
	RstVaA/0EnKXK3wYFkGzjtsOxQpYJaGsS7C3qeuaY33rMZ7ZPg4MLJx0Qa3DZNO9XMgg==
X-Received: by 2002:a05:620a:c53:b0:92e:6c8a:2a39 with SMTP id af79cd13be357-93671bad59emr1618257685a.13.1786300843967;
        Sun, 09 Aug 2026 11:40:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e07b6basm612079585a.11.2026.08.09.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 11:40:43 -0700 (PDT)
Message-ID: <6a78c9ab.d6f58ba8.2929e3.eea1@mx.google.com>
Date: Sun, 09 Aug 2026 11:40:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8517962500678977247=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
In-Reply-To: <e4b6658ac62a0dd6ca90e7c7a3d4f58b04ec4b48.1786296912.git.pav@iki.fi>
References: <e4b6658ac62a0dd6ca90e7c7a3d4f58b04ec4b48.1786296912.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8517962500678977247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142960

---Test result---

Test Summary:
CheckPatch                    FAIL      1.45 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.87 seconds
CheckAllWarning               PASS      28.73 seconds
CheckSparse                   PASS      40.08 seconds
BuildKernel32                 PASS      30.49 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.22 seconds
TestRunner_l2cap-tester       PASS      62.49 seconds
IncrementalBuild              PASS      24.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#86: 
Since commit b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")

total: 0 errors, 1 warnings, 0 checks, 181 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14739667.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: access chan->conn safely in get/setsockopt

3: B1 Line exceeds max length (94>80): "Since commit b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/563

---
Regards,
Linux Bluetooth


--===============8517962500678977247==--
