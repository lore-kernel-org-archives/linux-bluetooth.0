Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B251170B
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Mar 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710106653; cv=none; b=G62FH/F6E2ansbHwVAgKutK/tqbG3wWMJG/eNEW5fVNAFKuYL58Vqj3GRDgfWf+Is3i/meFZG6Pi4Gr00xbF3zYsVo6KcM9jJmSQnDXzDWB4rkIuUwwgIurGFrUCZc3Q/aJwG4/fS88Iwp3eA93Vk2nfkBxh/onzaBpagCSdXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710106653; c=relaxed/simple;
	bh=hCRPqU14EsmPhy7yiu5ismHZ2uBGciZNh3OzfE4jThs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G4lfnMw7TtkHbcjs/EmQoQ3l32f07TR9CjdkebCYLKvrD/RqqADVDR2hivpFUS1BZmyTFu+YeHcIaJ4C4xIvlgErvwdec4Y8IWhIhEPSNRdxI3ojTzjmxA08ws5HWs5umHAeMBUITkf3WdwKCazVenNF30GRhTv4kGLcsUGsslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a93rrRNi; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a93rrRNi"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a1bc321852so1598086eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Mar 2024 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710106649; x=1710711449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5o6a/NaaoSpIGdoCxKD9yqKIjX5bOq9lJ14snhW5ntY=;
        b=a93rrRNikCl7ZZqY6uJeqPlKSGxALGibAiVQsQdeYXen98djAsKuSAhrfmS/gfd0wQ
         wyeMiIPnZwyOC/Q2W1dCzPkWEyZ+GYzO9iLNjjEztV8FPhBLGydzhRor0L3t5colFiYc
         QlUyPURDRbXOts5RVu+3LPSz505EPRkmB1fbGouQiX9JytBgKZkRPKlKzyr6aLied6QB
         6Ts5MWTBHxEP8VwIlJSt6b83Kw6qxwkYJpQvkoC4+NzTkhKISvJBpdcdsT7lafviKXUd
         g5Xb96cEuN781t+WWBYmPMSbuATJiIdwGcMRHiYFhY12KN7894vHuiXWEVXQ0pBRb8Jb
         LLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710106649; x=1710711449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o6a/NaaoSpIGdoCxKD9yqKIjX5bOq9lJ14snhW5ntY=;
        b=tGy3XpRucU2mNKt/7c7bQy9E80cSbCTga6j58qeaWVPIyI4PjST1wc17F8vHGyDJ4H
         I+nqKDCdaCRIcg7wgjbT9g5wysDkCPPggv8dtrE2KqOhAR9HhVxii/1hrw5xcYlF9tKq
         4wR15y2TZseEsOSb5ouT7ArzHsoosNL4MtblVU5CquN8YzTlaMO7JUga/hKakvRNLNP4
         mW1YypNZrFEMR2cBqt48aRqoNsNWa8AoxZbjidmH4BErzyk7fyLvv8B10/LdDX7alWYn
         RXiAS9GQvbIhdylrB7eKreEVmlJgVo3ZExm0dbYSoCaCcUovcqP5cvUGvyQ65KzzN1ZR
         A2dA==
X-Gm-Message-State: AOJu0Yz9WkJJypeoo7RLGdWROtkFa40sWEViu4xOQAmmRfvkJxLEfLCd
	RU7RzqPSe7rZE+QdizmVK4Yzjr4+Zw7iMA8d5wfKT7FdqcJcz9tm+UdK/RHm
X-Google-Smtp-Source: AGHT+IFkVxG/4d1Zh87ECcclFitkiuQHV7fMZV1fPP7JNPtGdxRb/NahfjeDVGg+M15vgEM5KaSUpw==
X-Received: by 2002:a05:6358:52c2:b0:17b:ac0e:a6ba with SMTP id z2-20020a05635852c200b0017bac0ea6bamr6826114rwz.22.1710106649447;
        Sun, 10 Mar 2024 14:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.116])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05620a31a700b007883687ef00sm2109589qkb.69.2024.03.10.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 14:37:29 -0700 (PDT)
Message-ID: <65ee2819.050a0220.9c982.5255@mx.google.com>
Date: Sun, 10 Mar 2024 14:37:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3665874825877543114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: fix setting io on linked stream
In-Reply-To: <09755693e7900757286d3dc9fd181f8591c21a19.1710099560.git.pav@iki.fi>
References: <09755693e7900757286d3dc9fd181f8591c21a19.1710099560.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3665874825877543114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834154

---Test result---

Test Summary:
CheckPatch                    FAIL      0.54 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      23.86 seconds
BluezMake                     PASS      1602.92 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      171.82 seconds
CheckValgrind                 PASS      241.37 seconds
CheckSmatch                   PASS      341.37 seconds
bluezmakeextell               PASS      116.55 seconds
IncrementalBuild              PASS      1448.04 seconds
ScanBuild                     PASS      957.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/bap: fix setting io on linked stream
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
bluetoothd[588207]: < ACL Data TX: Handle 2048 flags 0x00 dlen 11   #492 [hci1]

/github/workspace/src/src/13588192.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13588192.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3665874825877543114==--
