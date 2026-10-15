Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7635DA78
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048470; cv=none; b=n+WqpCOgI30ejph8n69+i46dIwhSBGKnzGF+KT0QdVpuTiekRC8yszB/mumAt6C1fx+HgW80FsWH8xjg1+4f83l4JHWGkTwiOVNKelYHP4jbMsMxWeXAtCC1+YTtQB1he7zYswASU8NQywrlhn4UfKYVwIVurVByqMSxNU1Tedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048470; c=relaxed/simple;
	bh=hDKtSS08q2pyu+RDo8NqAOxIFILk5x04DtE4agl+L+M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dc2gl8iq5oCoHWm0wk5pYIubbUSemuKuIE9OkQMfTIc5xhSR78yjcIBkB3vYbfomyXhEz7HjK+ptBtwNcdopyMfDIz+fnSZO3jq3+S4RGGrsUtPN8VTzvl+XycLao7ZdhdhAnon7TQWFTtiFn1W2lLqOoim3nfSX3OfMqKk7Rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s52P/8c5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s52P/8c5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2740500a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792048462; x=1792653262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CYJgBtJ1SFqs651E/58w0EVCeLEXC4z75M+Cn1Oo7pE=;
        b=s52P/8c5fyWfst6DoIDcXisddr+ljZGCIYVwLalcHUTYTvgckZ/y/pqcuXNkXy48wh
         AaCK8h/psEAhsOn3hAWmFkN0PdURxzr+pvvwVobICCU+o56uaRRyEsfDHG5zzTmWA4Cu
         2bXrl1di515qiZDEbb//7fJ3FtDz3khnk0CE05j3yNDt+61ErWed5gVyoFnoMhgna/Qu
         esNp7dMEBAAMQ3JMM5HvRwCAOlDRsxiia9EE8gTCEIONmP1hu7wq/LExjYVgEipXHviw
         Glagv7JHAtwpGHBGfP/5oHtRbIsTqDV9zDulxawqCrAOMnp6vX4UDaN9qas2sjHQdbdK
         padQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048462; x=1792653262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CYJgBtJ1SFqs651E/58w0EVCeLEXC4z75M+Cn1Oo7pE=;
        b=dn8uFKD79VUijQG2H4Bt4p7Mrvq2mWbTw1YhCFGpSGn4CeG2wm5W5O/avXykqJ1FmL
         uoJ8xC24T5ar+Sx4yUOKj2WhSD2SXY3Kpx44dv8nJYroRV/n5YsICx/9noXsGP4CMqhx
         Y6h2+Mqn+39B0dWv5C1/F0t2r9oLvV+NrlD61HzgNs9S1KUa3s0ZYFJvBVCpj4LrN4VR
         N0Uw6R9zninVqRoADN38H/KIWl3L9O5ceCPtrzbus3jcBfLtRvGjnCQH2Gh9NN09toUu
         XxF9pFqqTunssuzCakRNVhch5hLtPQUXVt3lnDTDHsHmdmFdjEyfEGCJ2CJ48QwR1ILo
         ngzg==
X-Gm-Message-State: AFq9FYI9mdG5Ycaia1+SxlMeqMlg6mahHofewVj2WlBUuhl1DaMEPeTq
	SGpjQ95b4sh4jY24Bs9doE/6Dmp1XaUmXNq6MnmUZjqiLNGb/7yVogk2d7qEUQ==
X-Gm-Gg: AYBFou0si4AZu+eTEP9gKKCmjZPkqXrxrah0DEUOEQfUOB8s1fHMdqrmka/Do69xwjf
	nhb5qRPxLFaF2UTq9f8oV7NoUoeUQGuFP07npN+KEG7P7gwkflN080Ac4N564jADGXNvJyR9hYG
	0B75GwC0zNkSQjLIBlSvSnbGjqQ9sghLUqk2mZQ3rEhcl4VonFIh5oxWTPOq/mVkz7nb614cVKz
	7jKXaq8rmOHdaAaOf0ZI5v0UehDEJp+vy+0VnNF9jh0JERnuwCLwO1zhlh6yBQICdZBhVauUxdM
	Za4mU9se3zVJlbfIshH96dmg8CNrC6jeHBk/R3W7eFfxy8WmmXEkv8IzTDb91QWw0ekA4WMfYEx
	gWoZag+bU/oR01ZYse0jfY0Px3Qe+Jxkqe1WmVZn+AbbMqJ9bkus5E7eRxUDUw+qZkfZ3CxHNHN
	G+8YPq9y0CvaDs9t6SXxSpHN+ptVI+4Fjd5xKtO30D7gwYkFJmTSAHWylVQvWglurhcjLzeKnCn
	hmM
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3ab3a9f2d87mr10489872a91.21.1792048461994;
        Thu, 15 Oct 2026 00:14:21 -0700 (PDT)
Received: from [172.17.0.2] ([48.200.98.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm3061852a91.3.2026.10.15.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:14:21 -0700 (PDT)
Message-ID: <6ad07d4d.a438010f.f3b39.f7a9@mx.google.com>
Date: Thu, 15 Oct 2026 00:14:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0764784072707984782=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261015052018.129971-1-cochcoder@proton.me>
References: <20261015052018.129971-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0764784072707984782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186119/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.19 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      29.55 seconds
CheckAllWarning               PASS      33.62 seconds
CheckSparse                   PASS      36.37 seconds
BuildKernel32                 PASS      29.44 seconds
CheckKernelLLVM               PASS      35.99 seconds
TestRunnerSetup               PASS      700.63 seconds
TestRunner_l2cap-tester       PASS      13.57 seconds
IncrementalBuild              PASS      27.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Keep credits from completing security upgrades

38: B1 Line exceeds max length (82>80): "was split by the VM runner; corrected space-free filtered runs are reported above."
41: B1 Line exceeds max length (82>80): "failure) and combined 134/134; those are historical, not fresh full-suite results."


https://github.com/bluez/bluetooth-next/pull/941

---
Regards,
Linux Bluetooth


--===============0764784072707984782==--
