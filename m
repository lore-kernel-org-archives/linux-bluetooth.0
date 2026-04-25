Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED833D6C1
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777127016; cv=none; b=uxL3ZzJx0X6d18eV3CYFiVzeCWwqPr5wKNPuuybOPcb5kYUjXWY1I1EyQipe1C7mnz3/rkZwCbm/OuUbW/vbKL3ZPt4Fpv+qOdd502uEAevn+vEyxprxNDYdSIbZUQ9v4LVxSL8kvUj2GCPzzW8u+w7hy0gWmebhguquxwbDFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777127016; c=relaxed/simple;
	bh=7DCNnDph+P2xor3T10awohAbFMhR8kafC44PE+q5GpE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RvSMMrrLNrKZnzvpgmE+dHqgbgzSDk5fgI/GabMs1rDwQjOtBDkSfC3RKey3jBLEQfGIlb+Yrh1AWdMPo3Z8vg3rbVRe4+iUtlzYGLXnGo2eTDB7+klquFnu2tIdmJtIoH9Onbbnf5dw0W27klm6/MCvSao2MOqBuzS5sEg86J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6h2zO79; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6h2zO79"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso12081791eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777127014; x=1777731814; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tlt9urkRxZM8cvVxpJ9zXNjs9cHf/EFJxXt8bMpEhFA=;
        b=n6h2zO79aRBWT2dwxfExaUa6eT3xN0AXflLnBZhlkViFP4pSK2Wgn107oL8IQMGoaO
         ihqVVzR7WIQ8o1m0cDqkr/Z5X5edScCAg99DlAPYe0rvJHLBrAoPtzpYM3Ce+UEITGQs
         E2KYQm1IacHvTIiJpbPvLuZP6tTtxq/EvuYrX8RWLfLqeqqs3QkqRFagog/Kn/rGK3KG
         6GEw4Vea2DlVpgesPOBlPxRLISOjXn1/k5xzRMULnbBr/WvNpfz/V4CCheFtqj6rr/W1
         D3Awly68pz2SR2RUW67OxfB3wWefOcn0LYuQMFQpKu8ehkX0i6bxRPlr4aCmWHW7EHun
         10Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777127014; x=1777731814;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlt9urkRxZM8cvVxpJ9zXNjs9cHf/EFJxXt8bMpEhFA=;
        b=FKN37rx08EJgg/0HZz9wRoBUe2+6BFlZMp6y5/Q0Eo7dYGCOyJ42DZ9jwRH/w0igB2
         xTccWM0NAi41EZ28G+rS+nTjCcSgNUfDncSLzxzD6uqCvq8WmRFoOWpLUiL3+FGEyIlT
         ciS+zkNDE2u0UTrVFTiYWLPIamADwhUy2KJdNPc1+CTnrrQJlhhcMmr6DukagFzHnkbq
         DX1CxLlfd/fSmWFWjb6Wyb4gYXte9EksEmx8NzXyCDQaeWWvoU3KseDmCXuJ0IlNC6OA
         LnC6tJnTeeQwJImA0t/SFhTKAKCVDP7ZQdr3HlE80gHFY51JBECP2aRMNawoUcYnRRO8
         Pjjg==
X-Gm-Message-State: AOJu0Yyw3CWHeTUuFXwwlVv0GRJEcJJMS41eHA3k6Jqz+7QhwAqpwKmp
	dU/yySLg2pWcgdx/mcZWYLC3EogojeYm6ngcUcWMHzZwDlbPAskkxNNmbSDVNQ==
X-Gm-Gg: AeBDieu+zVz0MBCMlWicPB7gaADTxveuiPh3qC18/ykP2v6FjBsk5KmprupqiU11XuZ
	RD9OanV7JUhOL27C0qdUu0W37M1vL/lkfl3FghvBZWT8wS7ELRW6y6ghLVLrSaESp+eoGDxc8m4
	mXdsNqrA6mfw2vWPEQMFE+2gNQVTxCzTJtppJvP+8AUJjlIudpZ/2OEeqoDIIvjtYFcTWKtTzP1
	b1DeZYVVqgJnsMSAgP1yQjLM5Pbb6XTjwxkBQ6c48FoWcIxvU2s1qlTNTIU3BhWFqoBT/PrSyNO
	4BMWb8UeOpaJqtQjwJNyYRYnuj+bWpOedHrpvs3eHzJzX6T8cb4KiMvBNF8Mca6oTxceMZWYg3s
	v2pT/YaV1GfL8jnTyid1jJfwUm2KhwTOcnAilK9lulLK8EgXPXn0ToInLH6ZTu6ETsAAW38Fbng
	JoFCSJkMFkVQGG4gNRfiIzGN1hD5gCSzY0OvoYUi4+
X-Received: by 2002:a05:7300:b807:b0:2ea:d965:a4b9 with SMTP id 5a478bee46e88-2ead965a544mr3409971eec.7.1777127013625;
        Sat, 25 Apr 2026 07:23:33 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.5.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3ce1sm34545508eec.4.2026.04.25.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 07:23:33 -0700 (PDT)
Message-ID: <69ecce65.050a0220.355219.7cd1@mx.google.com>
Date: Sat, 25 Apr 2026 07:23:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2684199483573245099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
In-Reply-To: <621d8a2b651aba8e3c2197017ca94f06ec77b824.1777121590.git.pav@iki.fi>
References: <621d8a2b651aba8e3c2197017ca94f06ec77b824.1777121590.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2684199483573245099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085490

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      27.85 seconds
BuildKernel32                 PASS      25.95 seconds
TestRunnerSetup               PASS      568.80 seconds
IncrementalBuild              PASS      24.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
26: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/124

---
Regards,
Linux Bluetooth


--===============2684199483573245099==--
