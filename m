Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP6YoW4x"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8F191
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 14:32:09 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77bb668d941so383459585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 14:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700605929; x=1701210729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7a/CL+1nMN9TfMtfc0q2hpgnXD66J2jdEywkkc4ZQWU=;
        b=DP6YoW4xGvoAOOxF4ttu0J1nRyzsFAwWXjfD8Xkili0nnTu71uv6Tldslc8L467Ogn
         5tcc5UMtmdQfA+diORnUBHnEmI6+RSAAhfgW42XW+OXL8pHKo9XNEwDVzci533xousc1
         MrnB1jv711MWZO6uSXNPFZz/bT9duSGIu4vVY07XWGKpwdfJze8QSC0vUHvvvcFCkYsd
         +PmPqkOoQr4BD9jot6dkmJUvHR/zrxN04oKlm8xRvNmqoxQ+xohW5O6viNlnFfpHccWx
         v+jBVB5V2wqDIivaehLXaawpQplXtB6fz1Td/o+glQAOzDSVER+FI/3orel0w2Fny1ES
         rX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700605929; x=1701210729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7a/CL+1nMN9TfMtfc0q2hpgnXD66J2jdEywkkc4ZQWU=;
        b=ouKoAPZtqncETqOXbn0PWbs9N16cEJxvCM4EbhozEoBdU+NAjSDDovd5kLbQG/QOwP
         U4i0H+F3FpL39LohmKT5IKvsBzjnfydm/Idh+LLOaoC/usDw53EohiFUH3DNUF+puCkc
         YBEtjsYXNhf1IygzdFED9YaiyMnJgThvyzaY91CaQK2X6PiqvhbvXKaOz+jeZM+Kupnb
         PsGewN9PHwvCfzQGbPG2bjho1eEW7npmVW9UwDaQzxEzaGGmpnDCPhGT8389SllkIhbX
         HGu1ubwy1NUn9jouJLJLVe9kILHbF6GoiGZ2yzxILq0GvewjziG2BLwSsbLtJVUAueD7
         axeg==
X-Gm-Message-State: AOJu0Yz1YZ6aIn2mAjvvyehrd4hX7ZtPt//n0RobBv6RK+Bch1USZg8o
	8gR4u93tIayU2feaXetgF3zCD464+pjnnQ==
X-Google-Smtp-Source: AGHT+IHs6ZVhhflQDCN5LbddiOsDlPVMIBcLLi0l0NeUxJTJS70MLUkqfMZg7VvW0sIq+3iabExYWA==
X-Received: by 2002:a05:620a:1d81:b0:77b:d90e:dd91 with SMTP id pj1-20020a05620a1d8100b0077bd90edd91mr427843qkn.46.1700605928718;
        Tue, 21 Nov 2023 14:32:08 -0800 (PST)
Received: from [172.17.0.2] ([40.67.141.241])
        by smtp.gmail.com with ESMTPSA id q14-20020ae9e40e000000b0077407e3d68asm3957509qkc.111.2023.11.21.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:32:08 -0800 (PST)
Message-ID: <655d2fe8.e90a0220.49a03.34fd@mx.google.com>
Date: Tue, 21 Nov 2023 14:32:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0354715202566846329=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND] Bluetooth: btusb: Don't suspend when there are connections
In-Reply-To: <20231121213200.680095-1-luiz.dentz@gmail.com>
References: <20231121213200.680095-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0354715202566846329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803013

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.22 seconds
CheckAllWarning               PASS      30.62 seconds
CheckSparse                   PASS      36.15 seconds
CheckSmatch                   PASS      100.30 seconds
BuildKernel32                 PASS      27.14 seconds
TestRunnerSetup               PASS      416.53 seconds
TestRunner_l2cap-tester       PASS      23.34 seconds
TestRunner_iso-tester         PASS      42.66 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      165.18 seconds
TestRunner_rfcomm-tester      PASS      10.83 seconds
TestRunner_sco-tester         PASS      15.69 seconds
TestRunner_ioctl-tester       PASS      12.07 seconds
TestRunner_mesh-tester        PASS      9.04 seconds
TestRunner_smp-tester         PASS      9.86 seconds
TestRunner_userchan-tester    PASS      7.35 seconds
IncrementalBuild              PASS      25.95 seconds



---
Regards,
Linux Bluetooth


--===============0354715202566846329==--
