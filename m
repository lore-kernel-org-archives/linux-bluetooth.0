Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igTaAKil"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F22D42
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 04:40:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d06d42a58aso29594325ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701780056; x=1702384856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dVzrBYSzH6B8OfAzsfOtcdnXcTVGQ4cHaQDUbDExTbc=;
        b=igTaAKilnHzJFuqCbc7LR1DuQCf4IpMFjArPyfFG2K7ubNYifFInrweaRADgWZbMYZ
         kGzOoD+Y0Bfn0vW6PiGrbl9rwR0v21apphFYDXfe1iirrFaYHVljKqN5Z++dWtKQ3iPe
         U+x7A7R48jBSNs7pj/F/Sm1VZKtFo8SnCKHfUvjkar+mxxkVQQTE68fR+CbP8GuXF7rR
         7tvUmmRNt5dteZ+fGaELh9L4PpWguNXn1D8szThadcDjwL5zVL9MoYMVoGgTpD2vZMn4
         hixX/Hyn/Ud/ylC0FuovSPIngnGPSgp/46EM6eEpaQxGcJtd6sXoiT36QbD++ARthLD4
         86sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701780056; x=1702384856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVzrBYSzH6B8OfAzsfOtcdnXcTVGQ4cHaQDUbDExTbc=;
        b=BTcvzT+da1TyFyKWqRZXG0FXLKWMm3bQ0Q6PHva5w5gTMudLeLWHd2T39hchpILt7Y
         Hd8v/S0SUUKONL8Y0ADW0XAYbOvkqN9oT9BfxUnU7BFYELSoFnc/HJVypIHHmhTr5kwY
         VAZv3y5sHByMebw9F/72ih9ycp8gIlzaXMkaw8kcRjDkyAv544AnUwBoU5mClQ3lUCjl
         z3JSRLOpfk7fRsrh+0sEFTCMb/6mfpCwCM+U66zpctz2rFTEKBNLYmcPg4MIHBqj9ymT
         ilJqSg9v6HNkh3Gn4x+e6uJhYTTzdZ2W+Ebyj6ceNRgmvYc6ZS0hy0Eu3G61gtoOs2X+
         fGIA==
X-Gm-Message-State: AOJu0YxbOaPjr81aUOcZPViL3r+6LikD+TI2PZw5ZcTcRz74/anim5vQ
	oC+VGOSgSgNpcni+/sIkG3cP6hm2C4Y=
X-Google-Smtp-Source: AGHT+IF4h7GwpaPAE4I1pvsKY5A9+ewjrRvFZaaPDd9RAaOrP+wytkWPpZ7rb9AnV5/lGWTPMiDUHw==
X-Received: by 2002:a17:902:db05:b0:1ce:6589:d1c0 with SMTP id m5-20020a170902db0500b001ce6589d1c0mr6406258plx.46.1701780056534;
        Tue, 05 Dec 2023 04:40:56 -0800 (PST)
Received: from [172.17.0.2] ([52.157.3.107])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001b7cbc5871csm7334873plt.53.2023.12.05.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:40:56 -0800 (PST)
Message-ID: <656f1a58.170a0220.48bb1.373c@mx.google.com>
Date: Tue, 05 Dec 2023 04:40:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1736772179733716039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: Bluetooth: MGMT/SMP: Fix address type when using smp over BREDR
In-Reply-To: <20231205114924.834626-1-xiaokeqinhealth@126.com>
References: <20231205114924.834626-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1736772179733716039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807009

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       FAIL      1.58 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      30.08 seconds
CheckSparse                   PASS      35.30 seconds
CheckSmatch                   PASS      97.90 seconds
BuildKernel32                 PASS      27.38 seconds
TestRunnerSetup               PASS      417.74 seconds
TestRunner_l2cap-tester       PASS      22.78 seconds
TestRunner_iso-tester         PASS      50.71 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        PASS      163.21 seconds
TestRunner_rfcomm-tester      PASS      10.73 seconds
TestRunner_sco-tester         PASS      14.48 seconds
TestRunner_ioctl-tester       PASS      12.04 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      9.73 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT/SMP: Fix address type when using smp over BREDR

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B3 Line contains hard tab characters (\t): "	BR/EDR SMP: Identity Address Information (0x09) len 7"
10: B3 Line contains hard tab characters (\t): "	Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)"
12: B3 Line contains hard tab characters (\t): "	Store hint: Yes (0x01)"
13: B3 Line contains hard tab characters (\t): "	Random address: 00:00:00:00:00:00 (Non-Resolvable)"
14: B3 Line contains hard tab characters (\t): "	BR/EDR Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)"
15: B3 Line contains hard tab characters (\t): "	Key: 30cac11ec2bbc046a3658f62xxxxxxxx"


---
Regards,
Linux Bluetooth


--===============1736772179733716039==--
