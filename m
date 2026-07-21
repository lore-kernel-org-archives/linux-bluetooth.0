Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81142F6EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626328; cv=none; b=LO2ykhh5k6tMyo6RGbDd7t6bnWtviDgLVQa8qRQkEbdVJfDb1LP3ThiR/Z58DXbZNyXH/uPitnYyAFDJtjQ/WcPvcXF9oqU33MaS2G2wwywZ977MOotf+/hI1HYDAIG/shG3wnaiOQqrgkeCMLA4XMUtNYgS8YuY+L6KOobyWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626328; c=relaxed/simple;
	bh=YzKQ1EWSbTo7e0PDW+k4rLGROTtBMizBok5ahZGHs00=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YwtLpzMeenxRP6q+x09httpGUnT/XQq3RuWm5ek5Y1NX5Nfo/Rg1qgtqNbsX4sM+U1l49RHqzfY+ML9ZD88qvQtejvSVTwl5QJgz8dZjVwlVqBigMkKg8nN0Vma0zRfftO3kVv9kCxAwrd4F3z1L+xiFPi3bmo2ljRY6YU0c7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d49ACMMR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d49ACMMR"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c5382806fso65813911cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784626326; x=1785231126; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PPoq0y5A31j/uuyuMJBd5mEgU3iRB0rIfZX9zYMtSio=;
        b=d49ACMMRMdOS0QVa9Y/GictDIUk9l/Jyut9xVRjPXc8GN79fVl9/mtIyuHwaiuohDV
         NWIG0/vdzXFtyrL9ofcgTwXduAB82pBckaobc9SlEImf9bXMEYcX5e86VydP0bS9ckLp
         ozXxoygse417A5LJuFsve8yG3XadeR0ojxHWSoWK0wcLi26qVwUKKBl4oEqxxishsroB
         2cPsxsG7p59Za1dtioXEEd0kZ2aAVBWgR3X7OZT6jHW2Jg8fVaXsiILazAUl9tr9WpgX
         ZomF8RZlh41mQFlUXuPq87+srdCkdmTh2cezItNMnxVTUYSPoJyPma3DDtXu3MjK/U1K
         zQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626326; x=1785231126;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PPoq0y5A31j/uuyuMJBd5mEgU3iRB0rIfZX9zYMtSio=;
        b=H+s8APTqU4lgMkaWKbgC2f6tl19oeVU8wMERKOLj0LECT8f+5ZTEeuUwTj7omVNovz
         MxrkPzn2EUUhds3jZlz0Wt5YOZkSfnLiWxdMvvOiokMnIiYyGNGHFM7D+vlH+4LlADHf
         w5O6im8SF7a5Avf6q9VZpfiTk5PWemYJPElauK4OY7ccFksCf+zjLYN1eVxHRCtxfpc3
         mENH8kkqoWUhfnVgheVcqpaUR+YNBVagw7CYjJSkfxyek+2A4C8QABVkG0b0E0XgOP77
         A7FoizxG+Y0UfnzAXYLV8cQ0abvLQgcGLC9AZB8O/tKDslp+++G9EkCyUI26FXbG31pd
         HGyA==
X-Gm-Message-State: AOJu0YyU3P7gufvZRjeXiavS0bhvYG6IsvSXIXcK77FuvZPCiwAgJsz6
	nFQRHJfbpKW1x9V0/0cNVP6dFrAlvbQTeqxwt9nBqUhCyXIHtu+x+ynEkMoYXQ==
X-Gm-Gg: AfdE7cnSa17J7NFrTLhI0Wy2zIJ1eCDEFACJgbFxDA/MQEEfFs6bXwEq+HJac6jQPZo
	lVddb33UBeXPNni5ehIYEvaeq1U0rfn7DU/smSmzv0bEaJnwYI/2d01sliOCNFeFxdo5hfxpSU8
	6ECw4zx12Dd8C9I54ADDLWLtwkohbpWrAX5OMgLLHlPstQrSR0TlKrJiSqvfsavBYe5j9U1hSWY
	/wX8jYkj2I+6uSpfcwH0J9MmzLWHiuNM8C+EYmBhX/jOow5NHi0KLdeOQ1A/OCbhZZPuRvC4A7+
	EsdKXotT0A2TQUZOCMjMQTM+3f6Fn4tEJZixWTItA4KmlHuPHrX4RamkTOn/4oX46lGbvRYHT70
	kwekI+8vnv7LhL2oRExA3QvLJPsYBr2yfsySdeQcrYhcvWs8/ljV6e+10jbLmMX1sBBqEt/QFkq
	JIxABYy5EG
X-Received: by 2002:a05:622a:38b:b0:51a:8c97:fb9d with SMTP id d75a77b69052e-5213fc58323mr160562111cf.70.1784626325997;
        Tue, 21 Jul 2026 02:32:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.238.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521500c552dsm93002281cf.28.2026.07.21.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:32:05 -0700 (PDT)
Message-ID: <6a5f3c95.a80a6acc.cbe10.2ff0@mx.google.com>
Date: Tue, 21 Jul 2026 02:32:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0792846937319891668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: sco: Remove redundant mtu assignment in sco_conn_add()
In-Reply-To: <tencent_C817DCB733CA5C38DBF7EE648B196E904509@qq.com>
References: <tencent_C817DCB733CA5C38DBF7EE648B196E904509@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0792846937319891668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131416

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      29.58 seconds
CheckSparse                   PASS      27.91 seconds
BuildKernel32                 PASS      26.18 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      489.37 seconds
TestRunner_sco-tester         PASS      31.31 seconds
IncrementalBuild              PASS      25.58 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/468

---
Regards,
Linux Bluetooth


--===============0792846937319891668==--
