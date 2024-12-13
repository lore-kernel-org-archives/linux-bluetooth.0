Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29851BE871
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086026; cv=none; b=tGpaC/s7co0DUoBEHPCQxAWoQGhFGSG8FZmVR0enhpPfg9LuqsFTpsSh96+nimBsu3oNWPBHOA091tbCl4peCvX2bSo2tegf2ru8namWZsUPq1l76YWKZtjC/Plsw81IuKNq2Loc0HAtrf5EkObzOSC8skbYopDOUfWzRgBJAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086026; c=relaxed/simple;
	bh=vTasBbUv4mX7u1QFs0OeyHrDb8qkM8Da4Re/3XTS/Mk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xaxu9q/NeK/kMp+XLd8maNnRYQJBFQk2yU6mxKvl0zbFv/F3u4CobuBuc7OMdHwpD7V64XfXF9FRTSyxGusqlS5Z83odM/9FFh5B3YnaKPUmVWeLH0ECAhb/7AO/sFQXxSx6NlHspeFuXnpJGtbPPrqCgkRD/+fDfJukMUk6Aa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0rhYp2x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0rhYp2x"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e9317a2aso230197985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086021; x=1734690821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyW8dMZJmUXkXVS5lNfqhPWNO/HggfqdmEu2Xt76xic=;
        b=M0rhYp2xolKfTPtCASpbcM6XtEwEGb7Ul+jYfFGdw9tiMIlgfWhRnhe4Fyg2Yqmj+l
         HbWtJy1u3fd3sgwxbJbkgf3iN7+dTEFsz7UPsLu0FkwqE6S/UDM8e7fauraVyvRw5ez7
         UlkKlPPnjNItxPt+Gu6v6/yphB8s+Ff0JSQf6F2q4+ColvJEJjKzgFNk/z8AIWAZEEcj
         sV+9IQnIkzyZKKOXxHp/1ceqTsyZuC5l61yKKi4h/JM1Hzfwd7FlIn56gZ6rbb+/llHE
         W1gmrt/PDJoklCiYEFBG/kAXieRB8azQmk5pdsyc4gtHR1mlEYkxab/RMJZOvHetoeAe
         BenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086021; x=1734690821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyW8dMZJmUXkXVS5lNfqhPWNO/HggfqdmEu2Xt76xic=;
        b=rBeuqOvkW5gyyu1NE+DYFn27sK2QbJOTTS/zg9vU/MqcD9ddJk3BdW9q6Rr9vvmYd4
         /KS8kDEk7X/kJM38+fr0z+aLsK+DgDTG4B+hfkNEk+1dE4TfPg+voT9uPkrz0tYEo4cs
         9M1oGtBTMwM6058Tyskvp3wRvadctsCbExBh1U67VZ/p+HFf8esi5GN2VGeHz4+jfVLY
         gzRhtPJj9JMq9/a5BNNF9RovdS8ZF5BGgtF4bQ92zzySMDy4VMT/Iuuj1cj54FZjk1Py
         oYcMIFGoNNOycuGQ71OsYcmpk4ftFfyzR5Bk91sENZtdqCYCTuU+4JnQFWS8/mtZRm+b
         a0KQ==
X-Gm-Message-State: AOJu0YzZhdY9P9HBYZQnpml453yeWYOFzhzfXuw15mCWpBZPhJuhE8r2
	tG5IeaStgYjYUUQnOMDUR3m6L0IKYbxkgzwCayLZiZvaGrjduPcR0nkLpA==
X-Gm-Gg: ASbGncukcEkV5ZPDBu1gDtMoQfTAS3jVFDwaLRBEg3okCZo6APsEAIheOGbUC1uny0K
	W68koUnS1FPCBOFMYbOSvS3XI+5TnlOUBAE37TAUVou3LiL8Tla8jwu7ezSHBanDYL3PCC94bAQ
	M3twpk/1Anim7/oNBRu/0wJAc3mxGASntEtRsWN4PZWV8Br95UzlTZBMTUvEcN6UD16udgZsF93
	ZFU6eEhlRc2w67jfoRg2rvTqMsphPx3GiJlyYvYJrV67c5ZGxjI5QK/TaBNHTI=
X-Google-Smtp-Source: AGHT+IFMO7X9PDZktTRa+OML2OpAxL3CQqayqQaOA1CRp/kFndGmdxRTCJWvgN7BQn7XibR5UCS40w==
X-Received: by 2002:a05:6214:20ce:b0:6d4:287d:b8d9 with SMTP id 6a1803df08f44-6dcb01ad14fmr27009706d6.2.1734086021109;
        Fri, 13 Dec 2024 02:33:41 -0800 (PST)
Received: from [172.17.0.2] ([74.249.21.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b7854sm90952426d6.68.2024.12.13.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:33:40 -0800 (PST)
Message-ID: <675c0d84.0c0a0220.262c6b.25ec@mx.google.com>
Date: Fri, 13 Dec 2024 02:33:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2181322732936028118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY
In-Reply-To: <20241213094118.23647-1-chris.lu@mediatek.com>
References: <20241213094118.23647-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2181322732936028118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917527

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      30.86 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      440.79 seconds
TestRunner_l2cap-tester       PASS      22.53 seconds
TestRunner_iso-tester         PASS      29.90 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      120.81 seconds
TestRunner_rfcomm-tester      PASS      7.92 seconds
TestRunner_sco-tester         PASS      9.35 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.40 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2181322732936028118==--
