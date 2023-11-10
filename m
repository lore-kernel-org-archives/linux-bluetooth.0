Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BC3D3A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xals1/GW"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E578118
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 15:26:32 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778a20df8c3so168796185a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699658791; x=1700263591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WIiq11UKd1vjdssnFafNcolt5qzAyr8LcRLJeHzb1co=;
        b=Xals1/GW3PqEVtYErYrSn7awvnPRBtIeyx9y2cOUvi1DqDx7NW0Sf76naO8zhz+NB7
         z1f1evnsrYdYgqScSAMuyOQaRYAtLYYtxKbIAiiCNQlyrifb1iDqcx2K00Fcz4OurxP9
         qY4kBlEuFclTHiZfsxP84ErmjJji8QedMbxN29Z+VtbC8kvtGqxAT+WdikgQ8O1q2ZRK
         D2YN8OF3JHwVPuZZ4tVuZnT2jOjULCfOabEAEfYr0V4YDtQuf/wKLEnsEcvEOFEoZX8R
         L5HCbIQGWyzI7uXciFWS6LXqNmIz+pWPzMnVEUf0eisyOglOEvj/rl0RLcpZ80XTBM9j
         wf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699658791; x=1700263591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIiq11UKd1vjdssnFafNcolt5qzAyr8LcRLJeHzb1co=;
        b=PBT0HLFt/XeOh6OfCh89fXXyNVUCEphMGQC3FlHUQh9fBDcOKOq0vq+dTnljiP65D5
         MFah2wf20iGhaIPJU5WRoydGjzVDH5vjuCmr3nxGTpXqBgHGFOnAo2wXNCYlYirbRvqm
         tZgNI0E4Dv1M9xs41+VjhpB527DrjNfi/BrmR6/wfyxiHWbo4l7eAQ7m3E2z8eojIn5P
         sYaVYMq7MwsZMUj+Q5XsXC/spVS9z9Rf1IJiBKw2GRduNqyBjp2M/FsP8VcjMs7g6bSJ
         fasxKQ6keCCxVSuAriZFCi+72cBLhwgdbID4WhdIYQnJmJyENiUpOK+Xq/T28fxRM12T
         SV/w==
X-Gm-Message-State: AOJu0YwhssJrZEJB02uJ9LlCz6ZjgiyNsa9SJ5+Wg5YeMvgtkiyuGX1z
	p877dHE+X7YPW+ER7r0TmPzHL/FZA8E=
X-Google-Smtp-Source: AGHT+IExLruJozvj7qzspErVzvQB0enSWCLYNIdml1zXJ2A99e41LHPpLsyztJ3CoqGxMlBOs/t0PA==
X-Received: by 2002:a05:620a:284d:b0:778:9824:4b7a with SMTP id h13-20020a05620a284d00b0077898244b7amr643753qkp.69.1699658791034;
        Fri, 10 Nov 2023 15:26:31 -0800 (PST)
Received: from [172.17.0.2] ([20.57.76.173])
        by smtp.gmail.com with ESMTPSA id v11-20020ae9e30b000000b0076f1d8b1c2dsm154861qkf.12.2023.11.10.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 15:26:30 -0800 (PST)
Message-ID: <654ebc26.e90a0220.fd5e7.0b88@mx.google.com>
Date: Fri, 10 Nov 2023 15:26:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8280290151096060464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] bap: handle state transitions with old_state == new_state
In-Reply-To: <e8a45a4796f024825318996d68d1b92ebcc9b04a.1699652713.git.pav@iki.fi>
References: <e8a45a4796f024825318996d68d1b92ebcc9b04a.1699652713.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8280290151096060464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800330

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.75 seconds
BuildEll                      PASS      34.80 seconds
BluezMake                     PASS      1042.08 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      215.61 seconds
CheckValgrind                 PASS      334.61 seconds
CheckSmatch                   PASS      421.43 seconds
bluezmakeextell               PASS      136.45 seconds
IncrementalBuild              PASS      839.16 seconds
ScanBuild                     PASS      1335.98 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] bap: handle state transitions with old_state == new_state

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (108>80): "src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x604000039a90 id 0x01 handle 0x000f state config len 42"
21: B1 Line exceeds max length (118>80): "src/shared/bap.c:ep_status_config() codec 0x06 framing 0x00 phy 0x02 rtn 2 latency 10 pd 4000 - 40000 ppd 4000 - 40000"
27: B1 Line exceeds max length (90>80): "src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: idle -> config"
32: B1 Line exceeds max length (145>80): "profiles/audio/bap.c:ep_register() ep 0x60d000006910 lpac 0x608000017520 rpac 0x6080000183a0 path /org/bluez/hci0/dev_C9_C9_76_21_08_4F/pac_sink0"
33: B1 Line exceeds max length (128>80): "profiles/audio/media.c:media_endpoint_async_call() Calling SelectProperties: name = :1.604 path = /MediaEndpointLE/BAPSource/lc3"
35: B1 Line exceeds max length (92>80): "src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: config -> config"
42: B2 Line has trailing whitespace: "    "
46: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============8280290151096060464==--
