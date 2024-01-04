Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CB2137C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msT5iWr8"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dbcc5d78eeso256332a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 04:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704372026; x=1704976826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LpZIzDpPBL8JaPvbb76IoQCo8vyX3VR432pT+wINv1M=;
        b=msT5iWr8RfJDvjAogjzpOi23bZ6AZOT4PcFSHvdi/boVeG0qL5Uhm0v8eGFGe3Ev1u
         MY4+yZwp3OpIehowI6kdcSXJ1bFwWc3ogP+JMK4kTF1JAaTgtK+/dQ7jnPDfAh0rN/8e
         H0KaPK5WwYoSk80nnGaS1BSZ1JfwYzw1iHmj2mg8RNePa3bWBV29JVACbV5T0LGZsyIS
         Vjua1AuAEUMLcC/Y+QTbQWsqJ2LKdT89foVcJVBwyEzsSKtHRiBHgOuUkm3ft9xA9zWV
         BPoRuAsrc4Jg1Xuuf9tSb+XOZ7C+vszTkVAKGoyqGG2k7QtAZlS5bvjeK6ftAH6dJv0B
         EGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372026; x=1704976826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpZIzDpPBL8JaPvbb76IoQCo8vyX3VR432pT+wINv1M=;
        b=VoI/VbaosXJR7wqu/fjOfZ2uzjMOSG8ANIVmo0BudqghbkioN7bLsXMaMapZPQA0xL
         A4eJzXa82tGCABijot/21LhxHOlEmdPU1OwHF9A+PErRqNuWRAz8IQcGfRLI0a8vIBv4
         MMYWzPW7qEz48hfXcbv0R5LP8+h4LiiM6VrKKIOHQWhZPrZYw0cC3xEbVn+dIMd1qs6+
         TEH0nZesaEGs0Or2ZmurGv5JFo3hzLHjuf2kFzE2xygpy3SJmzxFpZ+6UxMvl5fnLUAz
         NiTsEJdEirStvLChGseS4lwzJ00dTiBQG57xBwBGk4NfBF+zh7/GJlM6Ehcn6lWwlTjz
         b3cQ==
X-Gm-Message-State: AOJu0YycIyGEQhkmf+R4pipB84zFzvn222GSyH98QN5RHPeW64Axhjdh
	Np4vEVrvvW1aP1RuPN0azqRu7Pj1AYAQ1A==
X-Google-Smtp-Source: AGHT+IF2oWdBx5JQkFBYQGCSQq0h9Q+SbeOpLcDvp+mZskBOSt3/f1aw+ZpFnRkobTOmCIkbrq6zBQ==
X-Received: by 2002:a05:6358:c60f:b0:173:8b3:71c2 with SMTP id fd15-20020a056358c60f00b0017308b371c2mr324079rwb.45.1704372025764;
        Thu, 04 Jan 2024 04:40:25 -0800 (PST)
Received: from [172.17.0.2] ([52.225.77.223])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a00239100b006d9723bf48dsm25052149pfc.10.2024.01.04.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:40:25 -0800 (PST)
Message-ID: <6596a739.050a0220.f0ec8.70c7@mx.google.com>
Date: Thu, 04 Jan 2024 04:40:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4273290193979658421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Avoid potential use-after-free in hci_error_reset
In-Reply-To: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
References: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4273290193979658421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814331

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.16 seconds
CheckAllWarning               PASS      30.93 seconds
CheckSparse                   PASS      37.00 seconds
CheckSmatch                   PASS      103.01 seconds
BuildKernel32                 PASS      28.80 seconds
TestRunnerSetup               PASS      454.51 seconds
TestRunner_l2cap-tester       PASS      23.83 seconds
TestRunner_iso-tester         PASS      46.40 seconds
TestRunner_bnep-tester        PASS      6.87 seconds
TestRunner_mgmt-tester        PASS      166.66 seconds
TestRunner_rfcomm-tester      PASS      10.79 seconds
TestRunner_sco-tester         PASS      14.23 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      8.78 seconds
TestRunner_smp-tester         PASS      9.67 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      25.97 seconds



---
Regards,
Linux Bluetooth


--===============4273290193979658421==--
