Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X18J4CEu"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095E10F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 07:33:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d36a6cec69so2462385ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702568020; x=1703172820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CsTJiUHB6EqX1aDZ4pfOIgHhEpiY7UzyEMHxt/ZudKI=;
        b=X18J4CEuhltPo+X5qSd9z4/hUKWNhs5gLm2ayeE5CHbont6EiZJS62B+dfZPP8NEPV
         PA/z1c6gVqSP7IXEuDw56PyrT2hEp7P7p/kxbBJvMTjP/eWbtk07ZkLRZvRaalYb8ul4
         H1QMjPci64IO/gv8wgA+zCQKsPFI6zXsTezXgWMuxg2l8znIjibZGrHCJM6rVUQWBnyK
         fi27mrhDysFm5OmEdok85f52BsBdrLpHz1fgpiFBIXgqv2Lz5Qy6pYljWBP8H0PcrcN/
         /BP33FMeTU0o7SQfxic9EIvqzxwdBP8JO6nxoXbtsDtjAxSKbqBvcwvHZ2D6vpzenhVZ
         c9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568020; x=1703172820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsTJiUHB6EqX1aDZ4pfOIgHhEpiY7UzyEMHxt/ZudKI=;
        b=uhqmDX8r+ZFh3Pa8f1CiyW2xhUDc0h/TNDhgq/uzdIYv5BaWv+t/L8wudTQnvg6N51
         s3Q6u2/owrsa4DU+zDtfeb6Wx5b2BbBlu07ylYea8TWmrfOwEYd/b36tEjiLXUcuPW3y
         eNW7EPorA3wI1gyHVJ0ZdtmKkIcTfZicHnHjcX8le/mliG1YEXGbXDvoWUB/FAF6BzF/
         jaQ7HlsMfO3fm5m/DlQflwbBt+GJUSniB3Dkkyj9qmflPW+vteNeNCLRZZPWUQQ8qRHk
         VlG1gePPVfsxGQ7DZymXrydM7bK7tfuU/wDqUX/AlTUZN1zVN52V+gSO1ZMGCOV5JqnW
         arCQ==
X-Gm-Message-State: AOJu0YwnoTj0/kBuz8QZIQm+E3cfNbFfZJUnV0cLD6rvkLL2k8SeZda4
	Eb/C22HvnOfVpR/diM5mRXwglm/Rz6Y=
X-Google-Smtp-Source: AGHT+IH6Ipyaa+wX75KLZDPwYFmOG5bL57uyiZyhJFnKtKf3tAiBdXZwta/zgmj0nsZaNhHiHhU/nw==
X-Received: by 2002:a17:903:11cd:b0:1d3:2a94:cb24 with SMTP id q13-20020a17090311cd00b001d32a94cb24mr4129492plh.9.1702568019687;
        Thu, 14 Dec 2023 07:33:39 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.199])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001d0c4869725sm540400plb.97.2023.12.14.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:33:39 -0800 (PST)
Message-ID: <657b2053.170a0220.d825d.2614@mx.google.com>
Date: Thu, 14 Dec 2023 07:33:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1164967921502833161=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,1/1] Bluetooth: hci_event: Fix power save marking logic
In-Reply-To: <1702564598-3034-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1702564598-3034-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1164967921502833161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810094

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      31.20 seconds
CheckSparse                   WARNING   38.14 seconds
CheckSmatch                   WARNING   100.22 seconds
BuildKernel32                 PASS      27.91 seconds
TestRunnerSetup               PASS      432.22 seconds
TestRunner_l2cap-tester       PASS      23.62 seconds
TestRunner_iso-tester         PASS      48.32 seconds
TestRunner_bnep-tester        PASS      7.07 seconds
TestRunner_mgmt-tester        PASS      167.01 seconds
TestRunner_rfcomm-tester      PASS      10.94 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      12.25 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      9.93 seconds
TestRunner_userchan-tester    PASS      7.36 seconds
IncrementalBuild              PASS      25.83 seconds

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


--===============1164967921502833161==--
