Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24C2FC43
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJmD3lCT"
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C29C3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 13:23:06 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7af20c488so72567957b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699996986; x=1700601786; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlQp+IwqxoyHuvPcWChWpmDeJC+JdtX+sHqpPNohNuU=;
        b=UJmD3lCTzFQSlZqtm2ejJ67x+bGUnAfmNLHt1mvm9TKtJTtf4o1DX2yaMcfR46Qw67
         eIXlto6tCbgzBjUw5GrOCzeflYxOgTMq3kHHuziRFr/OMSENWMlTmejZcIM0j/EKmnAE
         u+mcaLg5ypvINUaAvpg4QmUfozPlMlqZ2XjH3tXdA2VLPvzt3vlk50m91QCqP7BB1O2t
         q+WymqD2Ok2uxvDxTHWur2ZAK1yR2tiXjrkq1tT0E8bRRtpbHkaGlO/ZLWIhkMW7aoKi
         kJQYQrQYMCYKvuRw/Yjm3bFWXjSaJmZc4HgDnUKZ9nPGRjymyH/mfjUeySBtETVHz+tu
         z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996986; x=1700601786;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlQp+IwqxoyHuvPcWChWpmDeJC+JdtX+sHqpPNohNuU=;
        b=U/wfEMnZ8izWixnzMqNfA2WulQJyOJr47Ed9/+/kJvCrm1w3B8LQLQ4J4fi327KqhZ
         TVovnNUzp2Zmoium2kw28R6K2+ks/snb0b+87AkHIFcyg5AVRmr+qJ1wnZ01OCOTthD7
         DAyryKCtGDxnuLrmDnXW5d9mKFSWD0ZUjkPOIuUrxBZAXuuV5n7VO3mWjbpVs7LKpAL8
         2bBpgVzNX8NmYbuCmbiHjuZO19wx0qfbzdkEnBHKVVl/XWmlFIt9QzKbuVn/sHH5b3f6
         a4jGUy5HTGypHaeIyLvNMvz4sPYOzU0RRTHuXu38kF6Lz7RJ7Ha535KE5pVHuPUKT05N
         cgAw==
X-Gm-Message-State: AOJu0YyQceaWEF21Pz3uAgeOesEVgGxB+x4yn7qAZU8eFwHrSRiB+fKc
	1CkC3mGhy/Z7n4C156gLgkdDlPvK3r8=
X-Google-Smtp-Source: AGHT+IGsrNqgdV/eR17Yw0IDXacWARR+bUqI2/8TT/UDLC7nAEAebiZTHH035v33tHzkcFe/4mXkwA==
X-Received: by 2002:a0d:db43:0:b0:5be:ae71:d708 with SMTP id d64-20020a0ddb43000000b005beae71d708mr11498386ywe.4.1699996985924;
        Tue, 14 Nov 2023 13:23:05 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.229])
        by smtp.gmail.com with ESMTPSA id u3-20020a0ced23000000b0066d20f29e5fsm3223010qvq.35.2023.11.14.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:23:05 -0800 (PST)
Message-ID: <6553e539.0c0a0220.2a654.c384@mx.google.com>
Date: Tue, 14 Nov 2023 13:23:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5745580328792294034=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: add Retransmissions in SelectProperties QoS
In-Reply-To: <f1ac6b52c30e002400c2a0dcb20ead18899695b5.1699992657.git.pav@iki.fi>
References: <f1ac6b52c30e002400c2a0dcb20ead18899695b5.1699992657.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5745580328792294034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=801152

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      24.09 seconds
BluezMake                     PASS      554.10 seconds
MakeCheck                     PASS      10.29 seconds
MakeDistcheck                 PASS      150.48 seconds
CheckValgrind                 PASS      210.30 seconds
CheckSmatch                   PASS      312.82 seconds
bluezmakeextell               PASS      96.32 seconds
IncrementalBuild              PASS      508.80 seconds
ScanBuild                     PASS      897.31 seconds



---
Regards,
Linux Bluetooth


--===============5745580328792294034==--
