Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umj64FET"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26FAF
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:58:02 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77d85cf1ff5so247241885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701248281; x=1701853081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iD3nsbVzIDyrKxii3l9hB89dgPy/g3u11sLy+yW23K4=;
        b=Umj64FETqswHb4DfAf7sWz5l/ds7jZUXVNQQKESPPygarfcG8u3+1T9CFonNASadTv
         mEIZqXFEoJvtZSH24nZqZ6TSjUe/tk55PQRJGneZc59qiGqq9lP5D78ZVfckaueWN8UE
         bKVEMMrTlT/AGLZcTV6NggvbIoNjv3N/UcwwEJbsyDvy9DI8V6FByckK91miROLxoSgz
         7yxqKDtaz1BnMfXihiwfYdtl7anZVeSZvtTZxQT7k2U8IJzrx/pK7yMZhQYgV3WtfL1y
         WK8OIZgCZQWbtBEEloFNn+Xr4hwLUbXpguIDWZdpqqzf9qRENa4Lj5YNs46OB2L8sqmA
         8/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248281; x=1701853081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD3nsbVzIDyrKxii3l9hB89dgPy/g3u11sLy+yW23K4=;
        b=cVItGl/WJlectIVmF/W5pTgXgs+fn9Zm7viVVy1W6nO9emrorDMF+aUYJL+JAXfiIz
         HeUb7Q+gD5NYj1rrCVpMbB4cZ7tmLFgYASCtrANoMY/3+Wo/IrNX/H6j4q2V0ICTplxY
         QSYtfQbngte9My5xcLFxu/ZBmvxeFd8THVnKoNgA9MZUb3ndUbK+E8nw8TiM5qyZPOxA
         /7rmmaRBmRe1kiSYBAiK77/2+v7Nka0kkmrnlmo6yTIX/UbzuNVlNVkOaF/znpSHKKvc
         761VhtOqZOXJGxVGWmXFtUEZGfmSU5E8n/4CUYsUjFjjb3lx0E/lIq3PfMa+p/4FyuBh
         aSiw==
X-Gm-Message-State: AOJu0YyzBli3cCrFtbA/xBEKOXq7Y6qgNuQ7sVbgsIjf2bm0q8Kj9KLw
	S+gsLmZYvpI5Np57F8Xtx6QvsTpjJh8=
X-Google-Smtp-Source: AGHT+IG2nodDOfesEkdm70B7sl/oy3aTKKOvp+7ul9cDi3E+iqjyBvarb4LaeIUZeNfRtJEsNoTR9Q==
X-Received: by 2002:ac8:4e52:0:b0:417:9c63:391c with SMTP id e18-20020ac84e52000000b004179c63391cmr22786072qtw.52.1701248281553;
        Wed, 29 Nov 2023 00:58:01 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.244])
        by smtp.gmail.com with ESMTPSA id l17-20020ac84a91000000b004181b41e793sm5369750qtq.50.2023.11.29.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:58:01 -0800 (PST)
Message-ID: <6566fd19.c80a0220.72d52.5983@mx.google.com>
Date: Wed, 29 Nov 2023 00:58:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0486341780440539745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()
In-Reply-To: <1701245906-10660-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1701245906-10660-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0486341780440539745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805144

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       FAIL      0.89 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      27.36 seconds
CheckAllWarning               PASS      30.08 seconds
CheckSparse                   PASS      35.35 seconds
CheckSmatch                   PASS      98.54 seconds
BuildKernel32                 PASS      26.80 seconds
TestRunnerSetup               PASS      415.41 seconds
TestRunner_l2cap-tester       PASS      22.84 seconds
TestRunner_iso-tester         PASS      45.09 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      162.67 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      14.43 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      8.91 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      30.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v2,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()"


---
Regards,
Linux Bluetooth


--===============0486341780440539745==--
