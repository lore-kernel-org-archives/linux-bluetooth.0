Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBD2E40E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196337; cv=none; b=XVJJ77ekEo/a+Wu1F8hpOw97qda0XwveVvFG+w82PZjYnRFrUYB6wPyBt4E+UxdvW/tlmyzMWRdyK8+577Uwbb4CBRpy+CzNuj/pzWJMqWnhZoz0wUsn9BrTgfsOzbWeJVVrokKjJdEwFef+/1w18wV8g9AyY8M5Lu44Q8WdZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196337; c=relaxed/simple;
	bh=wq5PZwwGTZGFA1I2oFa0pk9RJIFCaxjqxdquKBEGb68=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n6CRWdFcnDRHd6B3oj0M8JU8SbYYQa8jBkvLmJ66O+jbwa5WIM0IfuPJiOxwSSOQH+31SaHumXV9PxUii+LLbCJnLVctvr4QSU1DojMwVmDGVKzo2jyX6hgUy34+RX4UPPJaVYScxA/4qknJ573sWJ9zTTZ0PfqbXQM6BSC4hcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au/J3jsH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au/J3jsH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd7df835a8so22209325ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710196335; x=1710801135; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nQGLK3YoButv0+fZKypgf1+PJAR//dofVch4Tpl4fps=;
        b=Au/J3jsHx9u+HgQTMWASwAZLAnXWU3VEN1mjLWnw/TqW2RZPpZbWnDF1JVdPL/oEgD
         fJ79Q26I3n+cXxPCQkEwK54RL8twOozOgFc9VAm49NRQgoN3xp9VmCqAX8+shYMzyJFq
         ru83FmAExmqV5oGRepPnklp+g1SkJtfgyayjrWkgkGqmcuXSxdP6NHk//X1594ipmdmX
         IKG9ndLQJII201wS/uTELZV37n6QVYEu+wxsUShbyj90+2rpAbo7TQm3W2k2vya/obI+
         u2pkszzbsjNwP3sJSFQFVPlz5MgZqNHiNXU7NPdoIQbQELcDYe54N1nLtf4+4uExVsL+
         HLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196335; x=1710801135;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQGLK3YoButv0+fZKypgf1+PJAR//dofVch4Tpl4fps=;
        b=KqQiPSUHBgXqe7egtBODyMnZdWus22TWbnoJ2GGuCBwbVZ2MI2fCh4rkT+BUceKUCF
         dmowE3jmlySxzERf7gHSv4TRvtikuSmTx7rGZvw50ezLeJOXGiYpuz15tl8M7+W6QgIX
         1u0lZy1Apj5qhaff6BepTuXs3cJX9DXJ+I+XhbcTgyIBFu/HQ/dwKmWrfWBGOHvGH1nD
         OUEg/3Xgdsio7IsE7Ahi+QhQ0CmlOdezf/F30z7fYIsNmNLsNkpoWAHINSjYwbyh2t8q
         FCKHxkLtn1KN9BPC11eT/0dl1i4LlXve+HJ/3jj1dwcF+9xbj3+fjVSgDvnpbY26TEFR
         ZIYw==
X-Gm-Message-State: AOJu0YziN34U6LpU2VE8U5BPme/JVvY0Nx9vh9LviukxFC+QswI0WvvC
	QNzoC1iwobEXQCntk6SrOm10o8tfk6sXgxsNkJgOGCJB4Yf/LcfQkqugIegs
X-Google-Smtp-Source: AGHT+IEhPlg/RpaC8Mtafz3Y94xhkONQa/RvO2mdTPhCAAycY9iaKo7aeAQj+3bSExe0c7cyTZ1k8w==
X-Received: by 2002:a17:902:ef8d:b0:1dc:d515:79c8 with SMTP id iz13-20020a170902ef8d00b001dcd51579c8mr8080336plb.23.1710196335270;
        Mon, 11 Mar 2024 15:32:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.193])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001dd2b9ed407sm5331558plb.213.2024.03.11.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:32:15 -0700 (PDT)
Message-ID: <65ef866f.170a0220.76384.eb74@mx.google.com>
Date: Mon, 11 Mar 2024 15:32:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0182236707101904837=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: RE: Bluetooth: Convert to platform remove callback returning void
In-Reply-To: <0707da8c41e85d74788733bc455275580bed778b.1710193561.git.u.kleine-koenig@pengutronix.de>
References: <0707da8c41e85d74788733bc455275580bed778b.1710193561.git.u.kleine-koenig@pengutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0182236707101904837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834459

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      28.56 seconds
CheckAllWarning               PASS      31.80 seconds
CheckSparse                   PASS      38.05 seconds
CheckSmatch                   PASS      100.92 seconds
BuildKernel32                 PASS      27.96 seconds
TestRunnerSetup               PASS      527.76 seconds
TestRunner_l2cap-tester       PASS      20.27 seconds
TestRunner_iso-tester         PASS      30.53 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        PASS      112.60 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      7.51 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      5.17 seconds
IncrementalBuild              PASS      35.48 seconds



---
Regards,
Linux Bluetooth


--===============0182236707101904837==--
