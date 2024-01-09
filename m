Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E593BB24
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDePQSSc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783269124a8so130819285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822948; x=1705427748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCMtQgC1AT5Ci2r2xuX0GcJco4v3mVtSHTcmD5JFgM4=;
        b=bDePQSSc0JkBF1SwNMe0d7cAloTYBrVs3T2If1YHA7ddBTdwBeu01Fo1hsSatZN0uH
         LNLd/kybZ7yHUIDBjeL+2P2vavhhVU9f6dO6/VIntUgv+Qv+FbFuxp7QmYWRON/617Qi
         +hmcq2iJeRqNQLS9qBAjwSkxzq+zAzWnN8xQm79E6rZy8cOqRWyG89QTZqirYE6XEKiE
         TSax6dGd8nInNW9UOGFrTICRdZuPUgsydEjFPdSbdkdf/mnibyBt2QvF8ln2jCasTgm5
         /H/0VP0+z+RCGAiJKFDbXcWWOahdZK0Xs+xrW+HOX5n7/37/IPA9MG5qpVg9RnyemKtB
         PNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822948; x=1705427748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCMtQgC1AT5Ci2r2xuX0GcJco4v3mVtSHTcmD5JFgM4=;
        b=NTGW3aNh3YRZnr7bD2xkMWSDH0jHzFkZBvhcTSylKTQYFRWnUdVKEea4ZlbPhdjGJ4
         U/LAQVF7SuqOeMUXMKo1tDtE/BSzFO4ngoxRtd+9dQqsWrXWZ0YJJEXy9zeVrIL3ryEH
         LCWFz9f0wMqO38s3Z5G7mjIcqIi7AU49U69euBbKo50v9qNoNmoGpQHEmUQiCaWorSpm
         GOB8e4+zflcFuxxR0KAUqRxkyZyBZ5BeWa7dcGQH4E6XDBURpVg5za2kZEexLnbjHKng
         LzBPN8BcKXut5HjSjBEufGCWjWCSv1bmR95BcRibnzGlZi54OjVq/BXlvz6LfeWY0sA6
         gl8A==
X-Gm-Message-State: AOJu0YwW7Z2GLXpXLyCGq+1eTS1lXNkG1/H0NXoARHYFbIkQDTiMx76J
	kqJ/Y9GlxGOG44cub7pWRYuPhC2E/Ik=
X-Google-Smtp-Source: AGHT+IGRV5++D0/WJq+ZiFlGFtoXWsCa8wb2jLu6hQzL3Fsaf9VW1kGSDFv5clKhRkwdHc+3CJvYcQ==
X-Received: by 2002:a05:620a:b06:b0:783:3237:f779 with SMTP id t6-20020a05620a0b0600b007833237f779mr710748qkg.78.1704822947976;
        Tue, 09 Jan 2024 09:55:47 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.209])
        by smtp.gmail.com with ESMTPSA id g12-20020a37e20c000000b0078327d52206sm970154qki.63.2024.01.09.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:55:47 -0800 (PST)
Message-ID: <659d88a3.370a0220.f2f4b.553a@mx.google.com>
Date: Tue, 09 Jan 2024 09:55:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5932456328982867859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_event: Rework hci_store_wake_reason
In-Reply-To: <20240109153041.403337-1-luiz.dentz@gmail.com>
References: <20240109153041.403337-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5932456328982867859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815440

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   WARNING   36.03 seconds
CheckSmatch                   WARNING   99.10 seconds
BuildKernel32                 PASS      27.23 seconds
TestRunnerSetup               PASS      431.79 seconds
TestRunner_l2cap-tester       PASS      22.75 seconds
TestRunner_iso-tester         PASS      46.87 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        PASS      161.82 seconds
TestRunner_rfcomm-tester      PASS      10.68 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      12.01 seconds
TestRunner_mesh-tester        PASS      8.81 seconds
TestRunner_smp-tester         PASS      9.60 seconds
TestRunner_userchan-tester    PASS      7.18 seconds
IncrementalBuild              PASS      25.99 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5932456328982867859==--
