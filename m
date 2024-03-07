Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1C130AF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832754; cv=none; b=cE8I4rIBiPfOJBYAnNRq6FTfqlUUb87GGwD+wbfLTS4WxuuPStU84BmRRCw4225hZj7sZzf/RkIVKpHmU2gsBea00KE3UL6AMxPQRv98qyAO8vSEEN0TQWdLsfflHQfrawLy8lzLNCtKythgEnEfOI6v6KfVSxT5V7Yd5OaB1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832754; c=relaxed/simple;
	bh=FlGBVXSyF5tuTLW7QvJLln7G4eBYcCnSUWxa6vFdz1s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=czf0rsnkaMw/niP3KAUTNqwAzh78EdA7lEKwqinJpNObr2FNqwpcONmsboFoyNuGjPQ94NxkybIXWfVY2WcyRHij3FgvhKf3Ncy01GxYLkzAFBG+U6eFkPpCKMkeoegFXDWde0eQfzy2IA0RK4hMByZK67ODojhadMTUpn3vIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds7YHsdh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds7YHsdh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68fe8e20259so6514746d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709832752; x=1710437552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hTvN/HVGDsl1gzz6hYWkBygiOp7JOY4prU/Dom7pN7w=;
        b=ds7YHsdhiEbdaD0WIZxci6fif+jlqhVsIYNkYiBxSXA0dOZYxYx/fukGyEzmYTEfQW
         EhjBtXc/2a+qTWOWu3Bq8xiAL3h9pu75TciejDuS6hV/0klKYIooxTNvwQkSczxKQ0TZ
         MUd3V/XgjslR8L9RCReFaE42/Xd60PN8n4ZezushZgdkz4bBpl6aVbFMyAj/uC6TZtJO
         e7jgE+oacRjE9Hy8PNA47mIzA+Ga5qNQT1QqXAT+7YRHeDOCaQ2nsXAUsfq6jUefnnVn
         VCaDK56xR60QL6WQ+L7zxFs9qan2HaWu6m6qZtkcF0kMbIBqKGQ6sQZfYns3mj7nw3x7
         v+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709832752; x=1710437552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTvN/HVGDsl1gzz6hYWkBygiOp7JOY4prU/Dom7pN7w=;
        b=TRpMPR541m4Lg/N7TZ6Fb6Ij4oO1zjDi529AraMLLy705/a/tw8Wodc9Z3tq28sBop
         ejh7FKF9wF4PuT70ZCnvRahqmkdrxpqOzT8JHcwijkH4gttr1aD8hQSGJzNQ6F66raye
         1EZHTlNQY82+NP4gXWi38Jnbyf4B+1tJXetYGUuA/pzNIql1H1bBD7V8SDmjkFrrqk8P
         o6SZNVHbcI5PnAwdvjP8xq/BDSZnp4Lz38fhtKc0+XnXBGiJlWT+XiZygD0m3dz5iEHI
         P+ePZgq5tuJ1Wf31mKdMcM7vZnSAq9MyUbbVYmKCu17Y0cld/A1TtftLlUVqVgTYQR5Y
         u1Pw==
X-Gm-Message-State: AOJu0YyEHIb3gbpW2EYVDYTzHBpSce3yB9SgaWyKoE5ca7bakPPUL5/u
	y2ApA0kBwJ1c9Ledp2F+H07tdnJxiVJrRCbZ73PWQF3rgpWo+ch1492fADTd
X-Google-Smtp-Source: AGHT+IHz7j19IyLKzeCPuJjmijMmsW7//tS12f24kn3g8CDE/vAz9ppoogqxyXWjbr30hlkB40Bmvg==
X-Received: by 2002:a05:6214:5144:b0:690:9d74:77a4 with SMTP id kh4-20020a056214514400b006909d7477a4mr3604940qvb.9.1709832751753;
        Thu, 07 Mar 2024 09:32:31 -0800 (PST)
Received: from [172.17.0.2] ([172.214.180.15])
        by smtp.gmail.com with ESMTPSA id nz7-20020a0562143a8700b0068f71daf86bsm8887752qvb.43.2024.03.07.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:32:31 -0800 (PST)
Message-ID: <65e9fa2f.050a0220.d25f8.6632@mx.google.com>
Date: Thu, 07 Mar 2024 09:32:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6031448936501337080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
In-Reply-To: <20240307170110.4096559-1-luiz.dentz@gmail.com>
References: <20240307170110.4096559-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6031448936501337080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833501

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.51 seconds
CheckAllWarning               PASS      30.26 seconds
CheckSparse                   PASS      36.20 seconds
CheckSmatch                   PASS      97.88 seconds
BuildKernel32                 PASS      26.69 seconds
TestRunnerSetup               PASS      504.76 seconds
TestRunner_l2cap-tester       PASS      17.86 seconds
TestRunner_iso-tester         PASS      28.12 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      112.16 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      10.81 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      25.54 seconds



---
Regards,
Linux Bluetooth


--===============6031448936501337080==--
