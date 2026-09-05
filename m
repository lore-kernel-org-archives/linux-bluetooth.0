Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AB302146
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788646120; cv=none; b=H9hGCNn9tgG1m+Io/epAB6zrUrYb8SJj+qs6+7T5HOihl9KLFnYO/uTKaEfkMwNeIYtMDsRj/E/cX/+p/46KT949Y9VyGVgI1cjMHir/hAFGd5Uxs7zeqinl7BTCII3gQqOg+PcNOMZHE1wxm8UXqttbXgWm1KF8SlHJJxplFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788646120; c=relaxed/simple;
	bh=3PeMOM0G4DYeLRmDs/0RGIIb/zi48sU0Ix3a5yNFIT8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YC8fCz1nna7noairE0HJaaxJBnPxVTKwJr2w+vP+Lt1eOjars8GKGWR3VDicPRVCjDM5yDOuA4tvZWwy0et6RWqSV+B+24UVsPPf0rFjJADxT+bgLyIEHX2JgseSJBxHeJg1WZHC13XD4pbr18UpWUY12N8rX3sNAAVa6wYVfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYzPFUIz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYzPFUIz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so1465082b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788646118; x=1789250918; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x6kXO77JdR/mkVSBvhFvc5mZT/2FJ9QOX4k3k1QHKh8=;
        b=aYzPFUIzN9QTEFZMfhBNQexlGB/8yGey1lV+1cJY754GoTK8DKkCczL4Ld6WxzoKI1
         82KxCY74mTo9sGsiqM3KtdycgIKk8yMk5fruD9girOkoKknIcwHKR4IfmTY4g13LXN2t
         V7JFKJiCRHeX33GkULdokQyHCWXd8ex2v8c5k0/vxDfH40Fp8oRlpJDKsisEPAt6HPAX
         WoIAkupoCpAUanXImeE6lbPGM+GDBTvqLFb3vtFKyUwbJ8lqGHgNVRgkniRQCt0MJvZ6
         M9OI8dhOlr/VoNUdUiz2r6EE5wkgUQA5+D4GCg7OyHMphh/kO63MAZ6OthXPnEmyp4tB
         f5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788646118; x=1789250918;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x6kXO77JdR/mkVSBvhFvc5mZT/2FJ9QOX4k3k1QHKh8=;
        b=mYK1hbLCkrf2a3Odz1jDDtvlxJQcA1dblvsAk0e5n/9Sg5mk8CambEBjbSGcgBY3wV
         KRHsWuRuGDW3wI2VkiN8kqhrR0jX2raL9hjdRXcyJkX+eFqBCQz+YFA2tBVvubIM+j3/
         8kRXWDsWsKo3UtyGIxdyc7ELnPeuLcWUBpSXxM6cQOuY63WMETBolh/S+IJ0x6gPVTox
         LyRQjzF69AksKJ7V2wxqj1hn1xwjMD1gp2oV/54Wuznr96gr894Fn7OlD+mUJ0jDJrLA
         auebSDQOEMHdIvuq1kedk/9M4rb3eH2y5hbPV8LeFLWLA63liuNI34L9gf57PXpmZSZ8
         yk+g==
X-Gm-Message-State: AFuF++mRbtG9l0jor548fSxGArEf+ASOrpSqmEvTIstNkQn2LmfAOknd
	YKV/P4+Uk19uBKSitR+mIyrPysYTz3E34UyIU0JoMFAjS5g8oT+WkW6QVGQh6g==
X-Gm-Gg: AYBFou1RaSmEBplvd57dlRG8joiXwelhtQnBWceKDDD8KUqnwtyt2w71ZMV2Qm9HtVw
	vt9i4g9wHgxfbpAns1wRZRm4rONDpWUnH2v2y5dSzo3IFSFE1Akk3h52YD4Bg+uSXuF3I1MZhl9
	M+9lGfMyEL1oSjNScEl/bcGDZzQGGE5vTGlV0dHvkw0HHWVuKY6fznQ+P0fVJl/ml7SDq8i0vst
	7JK2EG81lP6Bj8eX9B8TMePYR0sTUTIDkyeEP11w6zzpZvosYqSGpOMNUqfMAxlJkKeFliNVkmf
	4DKgnqgc8GLEmkme3RoRy5B8PCBSXTdsC1vhyuzE5Sgn7ZiU9pza92GjqI8Rim5lWcRpayzyd92
	/JCkq6KbLUaiwF5TJ7mxBqFbOvXi8d2/nMPbwf2g63idPbbsmWwExV/J740PKEdtpWgKJYZ55ws
	jMuZlCBVTvatNkRYBS5ovlOEp8Zq8MRIE3bFiZ2xIbmCmssVlKbfUACtlju1zcdJn9
X-Received: by 2002:a05:6a20:cfa2:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3da39d0cfd9mr24511033637.7.1788646118145;
        Sat, 05 Sep 2026 15:08:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm18126773eec.30.2026.09.05.15.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:08:37 -0700 (PDT)
Message-ID: <6a9c92e5.fb0efb2a.d02d6.62bd@mx.google.com>
Date: Sat, 05 Sep 2026 15:08:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2862278287395036779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrianox@gmail.com
Subject: RE: Bluetooth: bnep: linearize skb before sending
In-Reply-To: <20260905194725.284347-1-adrianox@gmail.com>
References: <20260905194725.284347-1-adrianox@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2862278287395036779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158824

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      21.65 seconds
CheckAllWarning               PASS      24.94 seconds
CheckSparse                   PASS      24.10 seconds
BuildKernel32                 PASS      22.12 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      381.87 seconds
TestRunner_bnep-tester        PASS      15.70 seconds
IncrementalBuild              PASS      20.20 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/709

---
Regards,
Linux Bluetooth


--===============2862278287395036779==--
