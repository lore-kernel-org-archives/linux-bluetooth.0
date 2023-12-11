Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wov8L/tM"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80234D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:32:26 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67ad891ff36so31812826d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702315945; x=1702920745; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6r8Gy2c58n/Cuf5rBNH7cfBa2Zk2ph2ghce45hKqPMA=;
        b=Wov8L/tMsbPRq8zgmW69LVCq7i+uBok0XYMirj7FzR8EQZZb6tXBmN50Q7If2bxv2i
         Glw+GBptMuK1YyPbYvKgstmFbeA8p7kvVI/Gigrav8nxNGPDK6c3StALJbSUwbMfdGEO
         oHTHUHORn2lPZ474yWfj9rholMmGF6d/YHjMsV2LXkiSd8CaAC6CUMmF2UQInepX+7Ln
         ttZN4fvktX8jWuyLo6OF4X8rLUsbnBOFl/LufB7t+/XYgl+xnf6h34jPri0vbw4SGhdo
         +Wh2JZR5aaJ5tRhDHaeYGsFrP/LN9RkTWrMCz5+lrpiIDqk5tTKdY71kgW2+xwVyWoOW
         M64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315945; x=1702920745;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r8Gy2c58n/Cuf5rBNH7cfBa2Zk2ph2ghce45hKqPMA=;
        b=BQKp6Az/7hWM7GPjzjCO531RZwYqDePJ7tt7c+Czipg3PWeFuVIhKiPAsyetrq2uyP
         JC2IkDonsD+BCwHx1AM7e2PQzNedRgUfT8KgwLawXLsTzqbOq3dKT84C2c5jdzkl25QV
         gn1Pa3+TwNSX4iuShGyKB7en/mOmOYev+iJGFtOa3iM/Vh1A/US7BCx13RSrCfAg4s/2
         b+vh7TGubdmOjwR9Go+7EkF4eMhly0/WRli1uEh6P7i5qMkKN/syTG9rfYp/U0GIE2mm
         6cjQI8hfkJmUYm7hHrrmJItXEBZEEnnESApv7dMtHdO/Bsmwb6BML4g+EdJinfcZrL3C
         Utuw==
X-Gm-Message-State: AOJu0YxVu3ex98K4zth6xmq7Fz4d+PzUIkJJCrnO/8T8MuiWuMX58S9p
	GRYz/P8f7+uBkyp/cJ45A0zO6UX4cEQ=
X-Google-Smtp-Source: AGHT+IERFxcaLQTixJJ6pvnHyUQJ0Gy/0QRZRyJrzhHekL0uQNX5cxn2PykfEXUD7hjFuVbj1w61jA==
X-Received: by 2002:a0c:cdcc:0:b0:67a:27c4:31f9 with SMTP id a12-20020a0ccdcc000000b0067a27c431f9mr5494888qvn.11.1702315945564;
        Mon, 11 Dec 2023 09:32:25 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.161])
        by smtp.gmail.com with ESMTPSA id l7-20020a0cc207000000b0067aa8e67fc5sm3416363qvh.84.2023.12.11.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:32:25 -0800 (PST)
Message-ID: <657747a9.0c0a0220.e34aa.ed36@mx.google.com>
Date: Mon, 11 Dec 2023 09:32:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1976161161231034954=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: Bluetooth: fix recv_buf() return value
In-Reply-To: <20231211164020.173253-2-francesco@dolcini.it>
References: <20231211164020.173253-2-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1976161161231034954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808866

---Test result---

Test Summary:
CheckPatch                    PASS      1.80 seconds
GitLint                       FAIL      1.16 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      27.16 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      35.43 seconds
CheckSmatch                   PASS      97.81 seconds
BuildKernel32                 PASS      28.38 seconds
TestRunnerSetup               PASS      418.27 seconds
TestRunner_l2cap-tester       PASS      22.95 seconds
TestRunner_iso-tester         PASS      48.12 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      164.48 seconds
TestRunner_rfcomm-tester      PASS      10.81 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      11.96 seconds
TestRunner_mesh-tester        PASS      8.85 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      34.43 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: btnxpuart: fix recv_buf() return value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (97>80): "  WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8"
34: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/"
[v2,2/3] Bluetooth: btmtkuart: fix recv_buf() return value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (82>80): "Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/"


---
Regards,
Linux Bluetooth


--===============1976161161231034954==--
