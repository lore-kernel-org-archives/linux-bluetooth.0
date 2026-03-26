Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6D1F4174
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566414; cv=none; b=KyDYUETx/5jfKXegG1Acxn9AY7UfFNR1rUH8394CiFjgwffyxo6aXga1WXBQT6YXktyusTLv3/hbqXhsMmq4EVkiZJ6PvB/41loURQ1VKvjl5kjH19shnk6gzVO7SuA2GLgwEQUs70oHyOTeqqNb0fNVdXdTt4TlobvY8uo3KqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566414; c=relaxed/simple;
	bh=G8HHpNR546tX4fzGI+zwMs0+m2WODS48kGQRPAW2lXU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j16L5JRtWjeN18HW2RI5g3v8GJx8iFLlprdW/tMOAQBlILNG9AkFUAq3REqVgWWGgWqVcgoy6vRd0V0JpFUCmn1aDY9xpT7d+0TBLAMBD+FmzlcZ/2OEGdL9qlAqRuhW9SGGEqiRurKfflhuXNzk5p1rIAPkVKhsQNCS0atADhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUtxCSH6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUtxCSH6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2b2aa276so13545261cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774566412; x=1775171212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nFunlyFYIIj5YusIh3O1IK9A+MeRwyXa9ZmgjB1lXXw=;
        b=lUtxCSH67QMHS7RgSR4LFQTHhap1+g0OC3Evk1C1uI+WIUMvYKpVIqwe+9JN7b168+
         2y0yU7OUqMPxwJbip4r2W7RBF+mkHSf+liyy3vipNyTgwuPRv/0Tp6NGEBPd+9HxF0dn
         6iQ5peVzul6sbzAwg+65nq3KpPh2SKaxYVQKj3h0f2ZdUDivJV4qTbT+pKv6kTPyIZ03
         IDzWEfnPYfuEeIobbnVyZN1weUQMPkp+uixL4cImd5H4Tq+QBCgTGIPJ0ixn3Y5fva4p
         gTN5zJ5HB3s1a85A9k2F5lG7rANPbxpDv12A+TdRB612UKzVsYlRMWQDZiLq0As7u2Un
         YByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774566412; x=1775171212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFunlyFYIIj5YusIh3O1IK9A+MeRwyXa9ZmgjB1lXXw=;
        b=mMtLLs7WSwUb+WXzLdsUI39wiflZE8zdMpPzy+O7RiygYraKM74Uyg5SILXGPP1F05
         ghmqnf0Pm5sykwk/71n4tFpJtMVh3MXiQKlQxQ22+tqqtuxSqvFgKdhY5qlAdznl9hsU
         wHeIbyeeyPJcUmmY8wVqfVaS6Qu6zK6ewLtLP47ZyarB1BdIrFY+LM4AhY/T1x4N1E1u
         0rcY7yQt2Bip5pal7pP9cQtmqTnC868DF9CgiBoCJqj1nS7QMnQpzaiM8EJJspk89sMF
         958wLydyXonxIU4iQZUzM8O9R6KQFc8h2w+HbI3VJAssaPScRP3wVzzqyd1gRKU47+vs
         84zA==
X-Gm-Message-State: AOJu0Yzd0YjnI17PVl2uIHSTYR45KtUMi5Cm5k59KBfW6sSiXmYUDk+2
	KPwPrYofvj5FKJhJGFkp4eWvoSeoM1k6tjri4XGZQ031C7R/cR+fW9O26PMP7Q==
X-Gm-Gg: ATEYQzz+ezcwSiIJbz1Qv5NtmWG3mOdpJi3JVK4K3Mz0sB0CncoUujLxIreqPUZS1Wr
	NMyYTKEiEgkfU+KBpWKP7F7cNMvaCaZkO6OydhJSu1x6DSGJ/FCzHjlweXucfN0Dbd2Ko4W80kL
	lRUDE2ZKYwZHid4koeUCrW3A3lcokfZQLFEWPOV4fnWA2t4qWNiVnUpUNFkW0sD+wrjlVSuoQuY
	ZJS2Jt2v3bcHjEo//imm8SicL2y4YyuJG+spwuVE/hoJ6UkkQBFm+YXXrivpHWameDJHKPoAt+I
	ZNLMKrFe/y1IeoxVgmP2GIEhZxwXdbf9aisLQnVT6cmBLrqs5vt1RM3NTu2Xif+paJJLsGky4kD
	/rN/8f8nghNMtscue2uACbxx7vzszzopp6mct0lW6s0ab86w3kWfaDZn4rhcKusF2yAYW1Wb+OU
	5kAMGeR7NBi+WfpJKDt+w/4h4ypQ9VAA==
X-Received: by 2002:a05:622a:1e1a:b0:509:3cd:b22f with SMTP id d75a77b69052e-50ba385d0c4mr6015871cf.23.1774566411760;
        Thu, 26 Mar 2026 16:06:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b920f6eb0sm35783661cf.5.2026.03.26.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:06:51 -0700 (PDT)
Message-ID: <69c5bc0b.c80a0220.398550.0a0e@mx.google.com>
Date: Thu, 26 Mar 2026 16:06:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7308472784130120961=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Document bidirectional (Source+Sink) ASE flow in LE Audio
In-Reply-To: <20260326220634.923877-1-luiz.dentz@gmail.com>
References: <20260326220634.923877-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7308472784130120961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      642.96 seconds
MakeCheck                     PASS      19.08 seconds
MakeDistcheck                 PASS      243.18 seconds
CheckValgrind                 PASS      290.98 seconds
CheckSmatch                   PASS      347.40 seconds
bluezmakeextell               PASS      180.29 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      1015.75 seconds

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



https://github.com/bluez/bluez/pull/1989/checks

---
Regards,
Linux Bluetooth


--===============7308472784130120961==--
