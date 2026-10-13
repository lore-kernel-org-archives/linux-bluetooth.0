Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478B53CA70
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922657; cv=none; b=qUVBley9RfvYGot9vFV/mfTt4F6nVVvFjkKPVITJGBt5HuCfxmLk5IeD8sw0ufj8IbwqKUiNDUsxAm37+nLKXD6ESeFYqKfMLPzB02zyzYRAjxQr0E4gT40JIjMMMHLa9fhKN8CvHTYrilVk/+0NQhV7K+UjuMNZ9ySXsCZU8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922657; c=relaxed/simple;
	bh=I4FDNuy1kKuvVd3CtiOaeZcBH9pk8NQRg7ahijtKY98=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u3f97sobPkeZUbXXIc786bolM9t+z6dZsMg1SID5gxb29v4EIR5+QC0d94eTUHyVTjqcxAJvMOoYZ2YY7I+68MJR7+2XHhRJB/5CdkP1svfJrRs62sbyBTKDgtDH1AJ6FvKOthDwcX0hEFBn7g+c1/9ZMdi3AFLyF0wiFjsc3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnsIP32F; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnsIP32F"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e64d52949so313770585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922654; x=1792527454; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+c7Kimm5tv4PRiO72JZlMyTg1z3aonucZwk+PxaSS0=;
        b=dnsIP32FdkigkXz35qfNqOPNfMHhtGeQb24cjHBj+6l0AJVs1BwrSjhu6BdGBdJs6W
         3HOU619pIij8YDluHbuXfMM0sigvJCLPR3zJ8xCYoBKevaMmJ4Y4Oz7qut266ytxhdXH
         tODKI49YWXPQdr9UP/lurZlnXJ8VFe1wRcoV4ZMyJfhdnz+zVX+SuxQ/adzwsAMwN+pA
         OH1FRm4U1gSZU+fBzvC7GvDE5ojlF1NfBRIBLSD+UFRiiOwej8Nkw5wuVo3RglaybRUi
         7V4uDRn2CoqDlKUjZOSdtowmeqU106FsOcZG3JqTpNxB3Qkx3lGDjKsx075z5Btrm4ZW
         rTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922654; x=1792527454;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D+c7Kimm5tv4PRiO72JZlMyTg1z3aonucZwk+PxaSS0=;
        b=hmMgNj46eUSudYH7fH/fxJ7UQdyv2/W2Ip6gB0zvrCkWAXh6Z6kCPCaE9bmz8CJRp6
         TjaaGE/31FtMhzZ3P1+jLpRM8wdOC7nlZFiQIB59NPMWwFxhQdUzZjsPl3XG8g/cPGkX
         gHgH3FTxIUvJxEx7CscieYN010n0ZZad+Lp8rGirvYHpZ9zCrgOymkpHq1fVDczc9maM
         z6f/mCX3VlQleAViGtAwbEwX6BUzblLPC9rEExYy9diH5BRmC0xv4/Ie2mt7JKpTwlTX
         BLUuQsQxSZp38iSwcmKE1E68CQ/epMscgzT0BVs72f1O8mk+49nBU7H0eNXcP6dFt/lD
         8x4A==
X-Gm-Message-State: AFq9FYKnFWZ+yfXclYkaiiFYtN++rio4+QiEJZG4Ruml8oEXemqCl4Uq
	5K+Q75X9kw39x9p+2SW5yw+2P5QPvasl/3fdqKRbwfeyDQ+KRPHD4i7iMMBGmw==
X-Gm-Gg: AYBFou0tJNoPeuofQbQ3r/UZr45rk7FRGpEOWFTZncQyoguZDb8/QcvTlI+TN+SRFSY
	tyM+nx0e92MUGjM+S5BAnhwtl+Vh5+Pmdgx9gLMms6uHoIgs+q9mk0Er2ncKbk50afQ4vGiwIbm
	EfNPyyiPYlUHZ8oeaskGtim1pk1fWqGJbTkl+j8XS+MfMu+ffng/E84RrqTFzXqwu/6f+ryz8WP
	ltYauikmnnUmQfPJWKrIQFpFwKHddeKt1OQp2mCH1q6mplg6m9bDb9u3JMsRPnShyrBf+YtXHCq
	9tmpu3eZsy1Jicp+0IEt41wTKiMS6uUkUwhvPCLWMNIXHiHoWp8m+n/JL12Ai2olnFj4wiBWlDN
	sa9vkc1SMNVRO+onTnaL7mx2VL7XdiD1JgXTk012t7th6NwK5+tGYdaRAw93xftTS/HH5l6uFkm
	OYUGipfZLH27OY4dix1m4l/obl3K69AOFHlJgfR3MFRuWkfoPBcEIA4UTib4BinQ1D+yv2B5XlQ
	Wbu5Mk=
X-Received: by 2002:a05:620a:618c:b0:93c:735c:2477 with SMTP id af79cd13be357-93ebd228f5fmr2260427385a.21.1791922654256;
        Tue, 13 Oct 2026 13:17:34 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.115.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5093213sm318167185a.41.2026.10.13.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:17:33 -0700 (PDT)
Message-ID: <6ace91dd.efb6fa4e.4b2a0.c7eb@mx.google.com>
Date: Tue, 13 Oct 2026 13:17:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6297264252284125566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
In-Reply-To: <20261013182627.81957-1-ajay.k.v@intel.com>
References: <20261013182627.81957-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6297264252284125566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185003/

---Test result---

Test Summary:
CheckPatch                    FAIL      21.94 seconds
VerifyFixes                   PASS      0.95 seconds
VerifySignedoff               PASS      0.18 seconds
GitLint                       PASS      1.67 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      28.83 seconds
CheckAllWarning               PASS      33.56 seconds
CheckSparse                   PASS      35.99 seconds
BuildKernel32                 PASS      28.98 seconds
CheckKernelLLVM               PASS      32.97 seconds
TestRunnerSetup               PASS      696.67 seconds
IncrementalBuild              PASS      31.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#308: 
new file mode 100644

total: 0 errors, 1 warnings, 412 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14886678.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/924

---
Regards,
Linux Bluetooth


--===============6297264252284125566==--
