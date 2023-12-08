Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4t15rio"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DDF10D2
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 14:56:05 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f35009e78so122816985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076165; x=1702680965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i3ifbG7dMvH4G2tTWrfqv0sZQWusIpuCgDCUUL4lWVA=;
        b=B4t15rioTR3IWZm5SgIUGokIVa4oUfmvUp5ve77nnspPJzKsrnNlPSozncNY90A/kJ
         F2sUrFsyk6sr01ZX2f7iDc9GCNb5p23o9UA3HywJIbCXEfZSoXeixlpMFs1J1Tezjtzy
         oLz0rfYvfXgZzkvyPlGtRh5vrpdeobiWyiVv3CZ/osnYe5yGyCHbyWZrbpPJcc/gCqiK
         SRXAUAeALcI3hWSUzjdNa6ngiVrWS6dMoX903FUSDg2GUTNj2DQf1dzL24ulEukfiqt+
         GJfpE4bpQshFQyz0jhLKtItCf0H5ArKlexlNv7oH93f7Xv4//FBvTNuQ9vGbzGOmqiFI
         i3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076165; x=1702680965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3ifbG7dMvH4G2tTWrfqv0sZQWusIpuCgDCUUL4lWVA=;
        b=ttXOxyrKc7PLGJBKnOXsp4LoLyvO1gwEXAXxVzvG4S24JzDhgKT2xnNbOmhxPNz6IL
         qGPmrWkWmI2HFs9T7IUcS2fF6oJyd4DFDz6gsGwJehW5OrHsDtXjiUjnQJVrgV/Z9Q6s
         fc3yBeBTKuuxgFL6z1msLFo58iGI8nBZpnQEvrEwZPofvXO1m1ZEX+C5D+WBpECttFA5
         JWACk1Z2B4rr/R2ZBR46AWS1uqU41qxyu8bpeiju7G+I1qghXJuSSeSPLonUk87F4Qym
         Dstxkdp05FuiycCtr2pqMnDRUgb4kcVNk9gBDzm3AG6k197Wg7Sj7g8cUlbOJit+i03F
         D7zg==
X-Gm-Message-State: AOJu0Yz9z+qoIyfwU46sgLMr85ex4YWoqDzNnaMDb2K1pKChsxrzoCq5
	okj+KTcebJSapOsZ+5mrA9zkcBxiqnY=
X-Google-Smtp-Source: AGHT+IGC9o+SMSusux1UC/C3mQ41wleftMvSdu7AlUDYHKLdcRISt2XnZ7s+i/L4F5r8SS1TB9MzWA==
X-Received: by 2002:a0c:c582:0:b0:67a:a6c5:eed4 with SMTP id a2-20020a0cc582000000b0067aa6c5eed4mr645115qvj.1.1702076164885;
        Fri, 08 Dec 2023 14:56:04 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.208])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8455a000000b0042387bd254bsm1148320qtn.9.2023.12.08.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:56:04 -0800 (PST)
Message-ID: <65739f04.c80a0220.255a3.6b48@mx.google.com>
Date: Fri, 08 Dec 2023 14:56:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3162618329258440966=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis
In-Reply-To: <20231208222843.70028-1-luiz.dentz@gmail.com>
References: <20231208222843.70028-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3162618329258440966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808406

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.49 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      35.45 seconds
CheckSmatch                   PASS      97.97 seconds
BuildKernel32                 PASS      26.65 seconds
TestRunnerSetup               PASS      417.49 seconds
TestRunner_l2cap-tester       PASS      22.75 seconds
TestRunner_iso-tester         PASS      46.65 seconds
TestRunner_bnep-tester        PASS      7.00 seconds
TestRunner_mgmt-tester        PASS      163.20 seconds
TestRunner_rfcomm-tester      PASS      10.75 seconds
TestRunner_sco-tester         PASS      14.58 seconds
TestRunner_ioctl-tester       PASS      11.90 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.82 seconds
TestRunner_userchan-tester    PASS      7.31 seconds
IncrementalBuild              PASS      25.65 seconds



---
Regards,
Linux Bluetooth


--===============3162618329258440966==--
