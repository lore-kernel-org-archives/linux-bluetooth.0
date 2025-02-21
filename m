Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617481EE00C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151972; cv=none; b=n8kT5e9NQKbISvRp8lZ3ahNiZzINs92SYw6f6lxFhGgYOM6aKSpochseU9WQiDBxWGivzZJdLYVaEiHjaGw462jVMSOhWCIoT5fOJTOfEEBG0xNRRZKn8rFWOWymoSIrNseNFOVyjdx+DN9IfM+9fpkzBGw9e6d79xMiVRKsc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151972; c=relaxed/simple;
	bh=jGVF9ydUb3QITsJBb2+nlxgvGjHze/lZT3kQHQWzaas=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hKXdDBxaq7dx52NCSKTZzc8DHE1Pkc63cl3HFACKrloTYuu4u2S1vIyJ+GbAErMT4KKb7p5XwyqVACg5PPdRYbqndemHfMuPT9pCMwSvLLSTnuuQuLypqfsOjLdxHJhyX6JUrbVJBbvHG+fbxafcqB7ZC4DQlATocYRJtFAruBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIOGNEtQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIOGNEtQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e6827984b2so24866336d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740151969; x=1740756769; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nt69IgIs/JjmjPX6Y0D/byjonWSDO+M2n7TNzicv9i0=;
        b=PIOGNEtQmlhzlFJWnLgJDaRFE21uELoG6mxzEEqGHqU5QU8S3L3lL0h1h84RfzODm0
         kTgEwXiUeOVXj6AxdnzHaA5fHvOhwYh99c32M953VBfpa97hbhXT5dy9ehx+1H3wpkBv
         lvlwlCX5Ub3HrcgHg19vS3dB8cApfWyE81RC/zmHvxj6/AgtrDAW0GJOZDwLYfU2wwrq
         p5y+t+LSfYvvSDT1vO8T+IxbvBZERK3ZMUhAtzcjSVYGOdWSRowLsfsz7Mce/RrC1i0R
         MVzXS7XAqj5hGHvXWUML9zfYmsXmq1d8i1bJXtCyl4HFBS2+uTUefuTKi/Cn+L48bx2X
         3uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151969; x=1740756769;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt69IgIs/JjmjPX6Y0D/byjonWSDO+M2n7TNzicv9i0=;
        b=G9vfAqKvZ4il+kun2ZZCm28ksSi0kElNbAAFmhQg4Zp9Dk7XBs3K636rUQA2M5qS68
         5TIaLPLJ+061oS5IBxN5CM9VlBJeM698pdLq0FGl7a4LP36oSfYKstaoQQnNhH1qowgQ
         yvARC/fRw/TkGStjVKLX16XLAjfqPHT6TeAdh1EN0wVK2gL0hq2yvU7M4TkC7EzJxNcv
         OyDw4vkx4t0XeHyVJBgA6uddCCA5BhjcJVTCXvIRDP9wecEQHKABNtxklzpR78qhHRwE
         zAa6q9bwlMOE6RuidLc+oiev4D85pSTDZ2ORmCSqyuMry8AvqwfrQAdfH8oqc1oD8x1E
         f/lg==
X-Gm-Message-State: AOJu0YxDaUMkvtpQXWPBrIe6+z6mr1sTcwmEvAAsjzaqMGJnw1VQf5BZ
	VvjifOz1vhleAQKGYAvT1Ch136ZiSJ0N7odlexz7Eqq7skb4XtuehPFAuA==
X-Gm-Gg: ASbGnctWmHvJQHmPZz9/MtMgotIYikJVgJe8Pn25ZTFz6ONqndGl9DZ3v0WjpOiUfVc
	M/tcoevH3FmVeuWL49P2OtTSy4urKZsEVMvOq0zZ+VoJkP9H1UYC4Ws232GSsrRPb5+bwbrCfY0
	thV4DPLCL8XtkfdQf/0oVNAfxglRXZa4T1JghVmlko8OnL07a+5xT8ShS2pSEz9YYth4vnnrUxv
	SsIHfK9RGaBGiwWmiDfn4AshUQgnxfh7ZRb6QEVafvVbs+klCoWyNqTeyotlh2sHYsiTRDdaQkS
	jrEZIJdoqxQ9HPnAo2WjoaJrQtrj0WBX
X-Google-Smtp-Source: AGHT+IHkDE++SNQ9hK/9Is1DTOEIksvwXBIDwKkjUviVpTKcYpG43sXNJCEdJVb8VaOlYXOZ/8lC3g==
X-Received: by 2002:a05:6214:c2c:b0:6e2:4e1a:bc82 with SMTP id 6a1803df08f44-6e6ae976a48mr46155436d6.35.1740151967951;
        Fri, 21 Feb 2025 07:32:47 -0800 (PST)
Received: from [172.17.0.2] ([20.246.77.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e66983bb45sm81887126d6.100.2025.02.21.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:32:47 -0800 (PST)
Message-ID: <67b89c9f.050a0220.2c01d1.3c18@mx.google.com>
Date: Fri, 21 Feb 2025 07:32:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5052645908736207698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/4] Bluetooth: btintel_pcie: Setup buffers for firmware traces
In-Reply-To: <20250221144245.1012686-1-kiran.k@intel.com>
References: <20250221144245.1012686-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5052645908736207698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936457

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      6.39 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   PASS      34.78 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      429.61 seconds
TestRunner_l2cap-tester       PASS      22.93 seconds
TestRunner_iso-tester         PASS      29.43 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      120.75 seconds
TestRunner_rfcomm-tester      PASS      8.44 seconds
TestRunner_sco-tester         PASS      9.76 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.41 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.37 seconds

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


--===============5052645908736207698==--
