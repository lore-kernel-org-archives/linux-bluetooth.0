Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdp0f5N3"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2309F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66fa16092c0so13527236d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700494409; x=1701099209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/H89e9S0JLJg6oZlG0GBCjpW7dzA4Nx6FSX4Wa67OO8=;
        b=Cdp0f5N30iJhDGrayknP7pD4lagv+nVWTZfXrGEHMhuDN39ZkGvcNnVA2a5Pv1ZApl
         qdEsHVwOedDHDkNsmah+8Ui5rXQZ98+vzuSWmjDXsUAz1sYJ/qjmQtH1smBBdUyx+KXU
         EHRgd2+7uymy6mKwK2JHl3LYKA6TZStt/5c0xgV0pGobZgzs2vp+mhdvkMWImeZmFRc6
         HvBHKNqambJnXitjyBuPceD84bwb0wKvUJaizj/aIaI/VucT/2qdPEaXgZ14AkBO1Eog
         J8wVGvSJB9sNJLJqQLZhGvp5G9+1LlOXRFSk+ZTOv56Nhss9MsE2qPIVsohA3c2YuJe9
         rTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494409; x=1701099209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/H89e9S0JLJg6oZlG0GBCjpW7dzA4Nx6FSX4Wa67OO8=;
        b=hykFkHHtSqwLOKmxO2ZxEIHEGkTqlwyk9EH4x2G7pSnDzqfS7Y2h96cw+qgNC/NWE3
         UZMszenYhq+3RSWYljY2Hb0h5xymtn32gtF+G+oTqKuR6xRNhotKM9RO2sbAAPF6W92Q
         arZ8lguhHpqA2Mu9kIn+fAObRBgk3DxDvC2V8mhEFhhtUWUTmMC6Lai80eZRk8qP0t0k
         gddaLtqXskSSCfr0Zs6sA1WIfGeoo9dgB82pd86MmzIdCONfM+bL1R3Jygsa889t3EoE
         HR6MbXd0B2s2gEcXWjwbLzqO3PIBFuNDQ7W+FQ+eNPw1JOSaY8RQTcNZyuzNOFCTf7wL
         X0oQ==
X-Gm-Message-State: AOJu0Yw3N9cHj1GyVkKAl6RWiqv5IvdvSzjImtKwboL7ma1O8vu9C4Dv
	h2SJ2ZA1sF9fwO5RFBA36XHOZ6ur2/Q=
X-Google-Smtp-Source: AGHT+IE+E5/C68VYUtZ2O11FqrKUdS9xE/j3KpceN5AB2H41kYcfJEGR6T9YVzr1mTWm3hfJrudGpA==
X-Received: by 2002:a05:6214:401c:b0:63d:3bea:f663 with SMTP id kd28-20020a056214401c00b0063d3beaf663mr9597719qvb.47.1700494409305;
        Mon, 20 Nov 2023 07:33:29 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.206])
        by smtp.gmail.com with ESMTPSA id g9-20020a0562140ac900b00679ce5363d2sm1705690qvi.141.2023.11.20.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:33:29 -0800 (PST)
Message-ID: <655b7c49.050a0220.1f7cc.6105@mx.google.com>
Date: Mon, 20 Nov 2023 07:33:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8178733089400221915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
In-Reply-To: <20231120151039.323068-1-luiz.dentz@gmail.com>
References: <20231120151039.323068-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8178733089400221915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802524

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.88 seconds
CheckAllWarning               PASS      30.85 seconds
CheckSparse                   WARNING   36.12 seconds
CheckSmatch                   WARNING   100.11 seconds
BuildKernel32                 PASS      27.33 seconds
TestRunnerSetup               PASS      423.24 seconds
TestRunner_l2cap-tester       PASS      23.05 seconds
TestRunner_iso-tester         PASS      40.89 seconds
TestRunner_bnep-tester        PASS      7.07 seconds
TestRunner_mgmt-tester        PASS      163.01 seconds
TestRunner_rfcomm-tester      PASS      11.40 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      12.23 seconds
TestRunner_mesh-tester        PASS      9.09 seconds
TestRunner_smp-tester         PASS      9.90 seconds
TestRunner_userchan-tester    PASS      7.48 seconds
IncrementalBuild              PASS      26.48 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============8178733089400221915==--
