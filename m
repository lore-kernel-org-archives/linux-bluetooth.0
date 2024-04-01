Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFD2A1BF
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005106; cv=none; b=tHOkZhl7EeIMQJsEe7ABGyg3kLgCxuZQDylMDPJzG+aZdsxPD97GzwiRG+GGgP6TmPnQVJNd1Zn2tiaq06kFiqWkH0OA4eDfbtPdScLVpGxzbpZFUtsQJ8kJnIlu0S0WUytMPOwtq/OPTNwAs4yzjf4bsIBAhzRCQ+bbuGietiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005106; c=relaxed/simple;
	bh=qF4I6sC4UZ22hurU43cwgZLlcAYdlii3FvzmqkdqWxk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dDojDtN2X5JfMsJUsUt307664g8kqVIIxiUPth1es/QlDcI7ivvh5n02rikdIdix7ssXpcdAXWyqj0LybIcqkOje4Od3h1kdw4gKUsq26VKoSGRZij+rvFlyvI19vMuKcrH7fHW6YiJOKEcVtVJRh+bTvuPFL9HlvxeCi0o/+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgKnJf9v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgKnJf9v"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0025ef1efso29479445ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712005104; x=1712609904; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rsC+jxKLh+R0a1IWFkl0/AXiEs9VDMkHIdYd8/jwpQY=;
        b=jgKnJf9vAXfycOAQRd8Jhk0V+3yYrrTDBhlbwYFAZj+zsff7d4CN5h7kM1W7e2eZOG
         eKq5mGGmql+eObLmpQw+EriiMtXtvUiVG6g8slXKxTiWGhUUW6UBzn13KLTxHlrXfG1P
         mQlXppDIoqc1emTtQVtlnXogBpA9P3wJg+k/QVizgG7jBlTyhRdXhfTfI1Xtcwshptvz
         MUbBGQUpesi3U0DXrKvfE1ikANqBiVNntWL5rvJ4KjvMPNIkPTpeaf2iiqmGI+NOUv1r
         WhmY/LhjiPjJtSovx0PyFdWCbAuYsSKJp+qMowaCtMaLqi1sUL41+4wQR9VYnvqaFDz0
         NSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005104; x=1712609904;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsC+jxKLh+R0a1IWFkl0/AXiEs9VDMkHIdYd8/jwpQY=;
        b=nqCp6E3t9A+0PFi1DjPDysq8zczkmBEKgywSQkqyrOA+FriAxRRmps3IE9o/fdm11w
         HNooyBz64KTEEKRgwPvYKPl1RMXFjhqbeTlpkNYlNWbownb/hkxb/CJytcf8Eco1SGwm
         iI2pKhmIxA5qk+nsQR1SkTBZ1+RCA2k5n9u9FIbjw7q1wVjYlezVdjz/NTTRBuqdvAYy
         X+d0wMVXMuEi7MlTWiUVbwaGgZQSKaguz8iXasqyAaPozwl1cnQ0MuQLkVaZD15nTX5F
         x56T5TNq5YJvRJKruuPaDtYy2gD53N2Iie3Yuj/8NHoa9KrMXX1EQb7VBEYMWdUpgPsv
         74rA==
X-Gm-Message-State: AOJu0YyIJKyoMlW4azwocC80jk/UYMLq7xohgI7XwL0cgyEpEtiAu9XL
	19uzNzn2lZa9fDxgBz7jgXnhXzIDdEx4/aioCfIqyp6/7BxAXI+sN0h+nMPg
X-Google-Smtp-Source: AGHT+IFXh5kjYbJl34wLGBrBsfNjYkvlh0EIGx60xfrI7L+35bzhpvtGGGcVPh8B/7RLJvceKIG4Cg==
X-Received: by 2002:a17:903:120c:b0:1e0:972f:de7d with SMTP id l12-20020a170903120c00b001e0972fde7dmr10248301plh.5.1712005104413;
        Mon, 01 Apr 2024 13:58:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.170.226])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001e0a7e5a34dsm9475198plf.81.2024.04.01.13.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:58:24 -0700 (PDT)
Message-ID: <660b1ff0.170a0220.5b9a8.8278@mx.google.com>
Date: Mon, 01 Apr 2024 13:58:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2000959063642395789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btintel: Attempt to reset if Read Version fail during setup
In-Reply-To: <20240401193515.2525201-1-luiz.dentz@gmail.com>
References: <20240401193515.2525201-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2000959063642395789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840347

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.11 seconds
CheckAllWarning               PASS      32.99 seconds
CheckSparse                   PASS      38.45 seconds
CheckSmatch                   FAIL      35.93 seconds
BuildKernel32                 PASS      29.51 seconds
TestRunnerSetup               PASS      520.57 seconds
TestRunner_l2cap-tester       PASS      18.07 seconds
TestRunner_iso-tester         PASS      30.82 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      112.55 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      12.96 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      28.66 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.172 seconds


---
Regards,
Linux Bluetooth


--===============2000959063642395789==--
