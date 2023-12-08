Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJOcK8tS"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759CF1738
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 09:56:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a91a373edso13253826d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 09:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702058211; x=1702663011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/YGxFpdU2fngc2B2EXhkFzW71zVjVlPFgK9l3vVobM=;
        b=WJOcK8tSRjlYt8gDODtd8oMK/JJ+OWIxFUez35JjIj6CKRNsOdtO7LU4eQrme3cdtJ
         7pW5oSomqXX+c7WqTEZTJBJg/C/GEg7h60VD4LDJkTOGUtdS78rgnZ/Y5ruZNkbddiN4
         1ZBj7XArDTsBrdKJ42l/9Mb/nXbAnTvDTQdJQAwB1A4irn1bhDk6oGmBjoEsE7hr8Ivf
         d+0tNLoTvKpe64Ho+W9GTxRJcGql6pVi5mhg3N1KTBkC3rT5UbXEFdCyWJpG+qdnwSGF
         yLFqHsbIfVzPEXkLnKHs3hAjivUBr+YDX0qeeEMpYfC2u5YIZYM1L/VWPZ0iT9jYEwzy
         aZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058211; x=1702663011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/YGxFpdU2fngc2B2EXhkFzW71zVjVlPFgK9l3vVobM=;
        b=IU7dHpuiAMOxEKLVx00jxJ6fqIWklmqxVRZ88yi9/ysh24l/VlftjT5zXtShwEbP5i
         pf2RTtkJ4f0PinWBpUkWM1UKTIKZThwSNOs4GZ6uWXrDuoKsxNPLgtYO36piFHPc+p7+
         TKU7O4aGKGt5AWcvdn3BAboFS7/HMz92/znkty1l2iLaYERoPF5c9tg1l5VJ3BxCrqY/
         SuktxbfJ5kSHTMaSxzUvlt59Bl2BrPcd6sOgoESqK0L9hLNPpvX+EtgkHPQldCYZMuZx
         pZ+IaGe/hkNJtyrwXuYVi/3ReMd6CCT/thuA224v9SBRmY8VkrrIakk+9BQMDK4yDirj
         hjiA==
X-Gm-Message-State: AOJu0YzZtxwz1mbwh/yo3o2g21zUDM0gTBIOqF0cgiTuqE8eT1fIXMsV
	TVNMhGgkQyAMK0jZKLTS9D/5s04nFes=
X-Google-Smtp-Source: AGHT+IHuX8IPXpPWARvOrLGArEhRbmfUBcFJCIzdI3PilstFfnzQ8S5BxQoiAhN+JXjosUjYXa31mw==
X-Received: by 2002:ad4:442a:0:b0:67a:b5cf:ff29 with SMTP id e10-20020ad4442a000000b0067ab5cfff29mr387778qvt.51.1702058211481;
        Fri, 08 Dec 2023 09:56:51 -0800 (PST)
Received: from [172.17.0.2] ([74.249.6.30])
        by smtp.gmail.com with ESMTPSA id dj15-20020a056214090f00b0067abef04ce1sm957573qvb.107.2023.12.08.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:56:51 -0800 (PST)
Message-ID: <657358e3.050a0220.fc2ee.5fa0@mx.google.com>
Date: Fri, 08 Dec 2023 09:56:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2885649012162638382=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: hci_conn: Remove a redundant check for HFP offload
In-Reply-To: <1702055834-18008-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1702055834-18008-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2885649012162638382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808336

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      30.56 seconds
CheckSparse                   PASS      35.92 seconds
CheckSmatch                   PASS      98.80 seconds
BuildKernel32                 PASS      26.81 seconds
TestRunnerSetup               PASS      422.30 seconds
TestRunner_l2cap-tester       PASS      22.94 seconds
TestRunner_iso-tester         PASS      45.47 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        PASS      167.73 seconds
TestRunner_rfcomm-tester      PASS      11.47 seconds
TestRunner_sco-tester         PASS      14.60 seconds
TestRunner_ioctl-tester       PASS      12.41 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      10.05 seconds
TestRunner_userchan-tester    PASS      7.31 seconds
IncrementalBuild              PASS      25.60 seconds



---
Regards,
Linux Bluetooth


--===============2885649012162638382==--
