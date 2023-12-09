Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNL8OWcj"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AEA10E6
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Dec 2023 03:30:35 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f642b9a22so14644485a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Dec 2023 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702121434; x=1702726234; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgyWAhFPocoUmK4dadxbJFgFSFy12RtCaKLYyc9799Y=;
        b=UNL8OWcjl5EODFTWjXh3ONsG58q0SPvRppTkvbhT3q4aSd1V21CFXUsAMwsEpJlp7Y
         NKDBgs4kYn0JUBYw0m704SFlIVgSY3u4pi7D2gmCDKIWNG3WBc7hkRCJ60RCZLjlrN3V
         RFXQOBPe0NOJyAxb+3ruMJtBjOsWKWZV1Ed8w8bmKiLrZ9TNot8+fR5haWFVrbYP97Is
         3dwss7664DqqzwawhJlzayAEUtbk8t5xP1PavOtBKo9h/Yg/oc7tDaC1rUv4ZaSCL32b
         iyigUSZYTKUzVJi/yAFE+A/o8qMIKbN8IlHnPGSVgI/tCeqgkLGkCSAvdlS16OmGk+Bq
         vH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702121434; x=1702726234;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgyWAhFPocoUmK4dadxbJFgFSFy12RtCaKLYyc9799Y=;
        b=aDRc1FoXC1AgGXzfZSYlMZ3BtKkiadAQZ8HLYvMxtAFGseQTwYau0fsmdd2F1ZE+aX
         103Je38iK7+Lm//C07Hz8O3JQpH8zi+0MurgnU9VsWyOBTAVFEpKnIsMMJoOxYXkpzTm
         +m4RjO0CDOYvhmV0bU41Y9ndloN3yYt2b5254zOVOsatg7BOWI02i3xGDdZQ78wUTL9I
         3bCfwni5eC2vPjc+fcSTmHzeF2hTT3quBmkNAjW/w+ZluezqCzF51fi16wA/xleXl2l1
         2QpluNVEH4UdRz12leiFZds+gDM4Gw2JdtrkQzdjCemvC2IrbbSDoBC2mAZBr1mEThgn
         0Hww==
X-Gm-Message-State: AOJu0YxYk9RZeUsmb0LsGuUF5kLgvel9gqP7ksRU+hE+YQV3XJ6vL6+v
	KfGT9ilM17sRLYxZESt+zm9j/F2EkTo=
X-Google-Smtp-Source: AGHT+IGj2BZFuVDqfPF+Pk+usiEcumVZp2uLcEKlM0hs59AlwrsFL6DVarEV8dhq8aKDVY9vYpiDsw==
X-Received: by 2002:ae9:e106:0:b0:77f:34c1:3eeb with SMTP id g6-20020ae9e106000000b0077f34c13eebmr2132256qkm.25.1702121434283;
        Sat, 09 Dec 2023 03:30:34 -0800 (PST)
Received: from [172.17.0.2] ([20.57.13.212])
        by smtp.gmail.com with ESMTPSA id qq6-20020a05620a38c600b0077dc1476413sm1337545qkn.131.2023.12.09.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 03:30:34 -0800 (PST)
Message-ID: <65744fda.050a0220.55a3e.6adf@mx.google.com>
Date: Sat, 09 Dec 2023 03:30:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8239771611131286851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, v4bel@theori.io
Subject: RE: [v2] Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
In-Reply-To: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
References: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8239771611131286851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808455

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      1.39 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      26.92 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   WARNING   35.03 seconds
CheckSmatch                   PASS      98.43 seconds
BuildKernel32                 PASS      26.94 seconds
TestRunnerSetup               PASS      429.62 seconds
TestRunner_l2cap-tester       PASS      23.37 seconds
TestRunner_iso-tester         PASS      45.83 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      162.57 seconds
TestRunner_rfcomm-tester      PASS      10.76 seconds
TestRunner_sco-tester         PASS      14.44 seconds
TestRunner_ioctl-tester       PASS      11.75 seconds
TestRunner_mesh-tester        PASS      8.64 seconds
TestRunner_smp-tester         PASS      9.63 seconds
TestRunner_userchan-tester    PASS      7.28 seconds
IncrementalBuild              PASS      25.21 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block


---
Regards,
Linux Bluetooth


--===============8239771611131286851==--
