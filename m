Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6E1E48A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIedLinh"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbc648bed4so594672b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703702070; x=1704306870; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=81u3azZJySIBJRm1SM3IShRi6dubXWK3D35FZ7Xj6os=;
        b=NIedLinhLpqMSMZacU+ATDd5t7dlGGJHKQgIT9sijkXtAaiqXcoTB2YzLUgwzq00Lr
         RB3KDPaPfgOFfBRf0GK0jGuEUjpiLRaZ9C6ecyPNjAVfixc0y9SSW9N/jm7SkYPRV4qx
         QmzTclxhibLrlAl4clffi5N6KSAsGQlRgNQ6e7DeNIXorHfs0WcohjLhwYjrTefMDhoe
         r9DPOKMJH7jHWrREVqtv2Rbmic1mNwh3HjEBHJviTasgh17mxngo4WsK3wIe2JpomoUm
         K8bTXaaELxQoixbRORSvhxTJYRvkTJXyMKI5wtVMr+uYHGAriWY904UmLpu6s9NHhqqt
         KaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703702070; x=1704306870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81u3azZJySIBJRm1SM3IShRi6dubXWK3D35FZ7Xj6os=;
        b=VXnKR2KZLX0sXR8nGBncJz7G0PvnwqXWSk1RWdH+HPaspswcWdWUyHvaPJERPI4/nF
         Jak9Fp+Gl7A54rxFLVifOD26Y7Csz5fkpwwmL1905BEiJxe6QNz38pcEbQRwc06fuKYp
         vANiVLGE/Ff09Q9dd8tMmkSAxD5auQTke2pVMUKY3zuf0WD4v/YmmJ3am0/R0+ox+xhC
         enWEHC54O7rdRa8k5stYfU8lciRP5LuFDdFHrhvd0Y5Us1v0bKxoLUbcJhDP6R72/zJd
         FARo3+ZdlXHOSLPVgmKlmPfpEdxwUMENvHjZLwq1ICeldZude0qFJogq5pcEa4wOB/VG
         zjjg==
X-Gm-Message-State: AOJu0YzFmhFb/6MAFpPi4JV3yhah1Tzq3/OyXII2S0rumK17Up2nf8GQ
	4dax1/SG2mnG0vNZwtlz21ObJSCFyKc=
X-Google-Smtp-Source: AGHT+IE/Vjl/Za2CDCjI0FRMNeZ5D9BmSTa/SqjBIGBkmtd/j6YBu4N2IyN34c5G8fgUzqb7CybXRw==
X-Received: by 2002:a05:6808:d4b:b0:3b8:b063:5046 with SMTP id w11-20020a0568080d4b00b003b8b0635046mr11145804oik.71.1703702069827;
        Wed, 27 Dec 2023 10:34:29 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.218])
        by smtp.gmail.com with ESMTPSA id pm12-20020ad446cc000000b0067f82678cebsm5506582qvb.12.2023.12.27.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 10:34:29 -0800 (PST)
Message-ID: <658c6e35.d40a0220.5e611.02da@mx.google.com>
Date: Wed, 27 Dec 2023 10:34:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2329784217225988214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix device-address endianness
In-Reply-To: <20231227180306.6319-1-johan+linaro@kernel.org>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2329784217225988214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813083

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.83 seconds
CheckAllWarning               PASS      30.66 seconds
CheckSparse                   PASS      37.40 seconds
CheckSmatch                   PASS      99.70 seconds
BuildKernel32                 PASS      27.34 seconds
TestRunnerSetup               PASS      434.37 seconds
TestRunner_l2cap-tester       PASS      22.76 seconds
TestRunner_iso-tester         PASS      48.67 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        PASS      159.41 seconds
TestRunner_rfcomm-tester      PASS      11.22 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      12.03 seconds
TestRunner_mesh-tester        PASS      8.75 seconds
TestRunner_smp-tester         PASS      11.73 seconds
TestRunner_userchan-tester    PASS      7.16 seconds
IncrementalBuild              PASS      26.43 seconds



---
Regards,
Linux Bluetooth


--===============2329784217225988214==--
