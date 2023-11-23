Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEND8PB7"
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36214A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 06:56:40 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d645cfd238so567745a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700751399; x=1701356199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tlWSmrLsBBcgDplBzHaJlij7G9hirSYopk/lmF20YA0=;
        b=XEND8PB7FE5c6f9KuVwgaM53JEIwcyF3KjBkLh+gHIDXoctozu5tIi4iNDBhRfsrVp
         8s09budW1g4P7knO20WruWX279GXwJjvMN10HpEtuU38bpDRrJ2+jNC1HzmCt6gz6U/+
         /kolNhaRzH6Y79DQ9TIOAYNqtYXKnN3mQ4CQ/cNpxMMT4+K9qGr8xrG2PB0YNwiGbqSJ
         Fq+8c8oXDKbWFKOj11OXUT08oOT/A9mfhnRdNBLfVEw5Zn3Hs5pD29eHMwLJLGiQBmUS
         rjALT2HcLlIBRcIBcUU9S5sMP3G/iUj6DK5UskiJj4YcCTLwAonLNfoANZKlu95/OCZn
         857g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751399; x=1701356199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlWSmrLsBBcgDplBzHaJlij7G9hirSYopk/lmF20YA0=;
        b=SKvaGbIU9r9jsnqBfqIMsWmXlYGW+L/xsNncotmqK94GdZlkli9YTJzhnZ22D9jCbe
         PsDux0yPYM2S4FhSaSmhnU7foZIHbDkR3LaEEGj7G+lLwh+n2Ll4XE1PgNxZMqjQ7ATk
         U8vxYksJZ0zgfW1wPyCu+MQUJ5i953J4Oeom7TwezHSGdTpyire4yipFhAcuj2K2KMEP
         sMEulPzWG5fWInFn8aDsqv0sWrMFyENyt2GuYDEJstZBRZi2iG6Wz+FLVWtNQkTRC6A+
         GsKkJm7xaBDZN2ophyqlD4siLtJWFEKbcig20pODzxxHRpQfPvncqtVX94hzbtoFbpkj
         eD6w==
X-Gm-Message-State: AOJu0Yx7hnEvkmm0EsQp1InMUwcsHUH8BarYYnQuaRI3lHXLUiIUNmvK
	Obw9jNHKvrli87YEw0pvbSF0XuzhGgo=
X-Google-Smtp-Source: AGHT+IEnn7SyJfaQcfhkOotkcyMqmHxLxWbjmKKh46YyHuXpHyMhZiVydHRu4DgIuarhDMHNYosYaQ==
X-Received: by 2002:a05:6830:1143:b0:6aa:ecb5:f186 with SMTP id x3-20020a056830114300b006aaecb5f186mr6741694otq.7.1700751399277;
        Thu, 23 Nov 2023 06:56:39 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.19])
        by smtp.gmail.com with ESMTPSA id pz6-20020ad45506000000b0067a0f025156sm85329qvb.38.2023.11.23.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:56:39 -0800 (PST)
Message-ID: <655f6827.d40a0220.ade93.07b2@mx.google.com>
Date: Thu, 23 Nov 2023 06:56:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2637227078569360582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: Bluetooth:btintel: Print firmware SHA1
In-Reply-To: <20231123143550.2436697-1-kiran.k@intel.com>
References: <20231123143550.2436697-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2637227078569360582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803732

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 FAIL      1.45 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      30.26 seconds
CheckSparse                   PASS      35.44 seconds
CheckSmatch                   PASS      98.88 seconds
BuildKernel32                 PASS      26.81 seconds
TestRunnerSetup               PASS      414.87 seconds
TestRunner_l2cap-tester       PASS      23.12 seconds
TestRunner_iso-tester         PASS      41.17 seconds
TestRunner_bnep-tester        PASS      6.92 seconds
TestRunner_mgmt-tester        PASS      166.72 seconds
TestRunner_rfcomm-tester      PASS      10.85 seconds
TestRunner_sco-tester         PASS      14.58 seconds
TestRunner_ioctl-tester       PASS      12.05 seconds
TestRunner_mesh-tester        PASS      8.84 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PASS      26.60 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2637227078569360582==--
