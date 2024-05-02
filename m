Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284516FF3E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672579; cv=none; b=qE6QeJGa03UfEzmaxNNYLgnmijtK3X5UCXDsISQCAHJmJJXYWlNhCT3aq+cWdOX4VZ52LUhvuwPJu7y2v3xBYNMewIo6+pRfQ0wWlijP1Yk1KsIZW/HQg+7P3lu3ZBFBQ0MjvTo9qrj/7+4R6GyUW91W2nB5/q6pABWFQFAKVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672579; c=relaxed/simple;
	bh=jIYVxgptU5PyMEW7BAzi8aQg4pS6JDTTBpcvakKwEwo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UmxbEmNzDBFF2syAoNQsrh5+9G4a3z1C7dQ0g3D9x/smYWfqQ6SO8PCwaM21Eg2G31sVvX4Ii5r7YYubUnyJK1lzhbPVYrNCL4saMrdcM9wCSwxZuW98ZCKEDYBdJE6fPYEVNlN0X1Nk1gcFCvuWK3bVktu4fFbFb3ygmgNCAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFe2xu9s; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFe2xu9s"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43ca9047bd2so8301111cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714672576; x=1715277376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LuMvGEgyFeKyqqEou2t9cN2mvxBXtwcY/+m3n9OPobI=;
        b=GFe2xu9s0I1Qyg7FUWtDCmbVtM+xv+TlqCv9vX+XhsKt3JaH/BFZXvfcNUxg8xiywQ
         ZrxcL3MxFBjvAI+xkViWlUJtI2gjCRxfUYs7chLqTkVxFCxnrI6sZcYCvzNPZ30Lrf+U
         d1Gh3K9tJbfOzUuOfJD6vq2ZGQqVQ7OP+NZikyNwWyLVlQFI6ZNzcBYpGDQ0r9vFXPBf
         Do5wFAQ3+B7BaHTOhV8m5QbZSm558qFSiBRi7ybxI5cPN1Elvj4b7EWdTZ9S0ORamDu2
         atzOQ+pEYCem0D2XvPH2vQCeLe76+CnHYT2m4+FApgLhv7TAzc+V6dqM21+sBw2xsCBs
         kaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672576; x=1715277376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuMvGEgyFeKyqqEou2t9cN2mvxBXtwcY/+m3n9OPobI=;
        b=b/FJwb0kX1xhtE7FMporjmP80Y0rgP/RwvXD5otgaq2+rsph88ikKqu5xdURQ+3ibN
         AmAaBfcXWnxpycATRIF8HBfo74Kt2lBvQ3LRMacRLaaIdnzGiBFHPXepFP/MrjychMjc
         vzdnHLBzXrABY3pm4R7KDHI6fHum16yHCU546i9w0MjfJN8KwZc1xLnw69LORKj883Gl
         Pl1AtpU7MAJDcCvAkSzXZjXrlnWH4jreInPJpwC9/axF8soDZp4WFMh6xb14wPzeUKu/
         lMXALHY3tHL6GzdvGND4DNUoAWZDVYiqpgpUbiMwAmLkrNvRTH4GnLsXaWpQM2Pu7WVe
         7V/Q==
X-Gm-Message-State: AOJu0Yy4xDHg4qbt/mq7F8iWY1EK1fOwoH7wgdlRwOaEvrwCtNjIvLNv
	HLxmpbn2aWpAEHGfGS4paXeX16FYD5VgPREtJnD2l7x8McBCRAWaPmp0/g==
X-Google-Smtp-Source: AGHT+IEJ5Z5ZmgMUcevLmg43Pyor9JaB9IQBKTv+X05vGsYkNHOU0IdW9G1MxGC1beuMxRYICMibkA==
X-Received: by 2002:ac8:5dd0:0:b0:43a:a0a3:61c0 with SMTP id e16-20020ac85dd0000000b0043aa0a361c0mr956269qtx.26.1714672576589;
        Thu, 02 May 2024 10:56:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.46])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b00437a996ca44sm675353qtb.21.2024.05.02.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:56:16 -0700 (PDT)
Message-ID: <6633d3c0.050a0220.7ec76.2e66@mx.google.com>
Date: Thu, 02 May 2024 10:56:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6858804261184799521=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v3] Bluetooth: HCI: Fix potential null-ptr-deref
In-Reply-To: <20240502171709.1280128-1-iam@sung-woo.kim>
References: <20240502171709.1280128-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6858804261184799521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849978

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.08 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   WARNING   38.13 seconds
CheckSmatch                   FAIL      34.78 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      520.97 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      30.93 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      112.87 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      15.19 seconds
TestRunner_ioctl-tester       PASS      7.63 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      32.57 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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


---
Regards,
Linux Bluetooth


--===============6858804261184799521==--
