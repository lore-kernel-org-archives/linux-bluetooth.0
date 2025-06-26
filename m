Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE7201017
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942164; cv=none; b=esqLlyibTDkG8saMiyoybiSpzP02Uu40YBv5i00WMP5OgZyw2g+EKy7QtCa3fzQ1UI632j32NQa6L/08Qdp2qT+XyufC9HLoFHRwiJjBz27WxK10YD/vjjNrlv1M/kbiaoTw2Lu9Pb9NkWW6OsXUeijiAysD0dQzCMulRLDlA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942164; c=relaxed/simple;
	bh=xVTMvDcLjGmUYfyjW3lVncgfOnVGMYkFq5PsWtM3ETU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lMmq63I9/wLHYOgd5VYtMRwKaVBlcTTIbiqNZ5YG9B1W3E+WTCBnYBDLz1fDBdAjm9qHNBc/LuTa3JW8LOpcpBSW7oB882k3JqzdQw/7t0GBzrWUuDET8B1RhuHzT+bZdlWnPSlYFSJYqxhp6lQquoVGONAo8k0WEtE9T3KV3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHeBGrff; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHeBGrff"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a585dc5f4aso11209961cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750942161; x=1751546961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jqffagXshdX7Rwi5kU+p1euKG9kS921O7CCwjuhEXBg=;
        b=jHeBGrffyZmYv2SHQOxyiIjRd8Nd4KD5r0szC7Ev1FzMZ7edElGAdMnUlSfT/LvbQ2
         CNzLBv+aZ9Fac/fkXDZGYAujxYX1vhG86N+zus5SRlD47BoX4JZL5c2y/lTv8eHUDpUe
         VP5p1hPJZKezoGu9txgBhbfto8qmkj3VpuLMYp9zyKUpctjq8H+fsro1mSdrzUOEiNPN
         Mk/lvXoFvfkjV13YiW0Qc+bnrnUy3paWQP2EZ0WxY50K/X+GxT61lN7rhavYOJ92Lvs2
         +fA1WsAmEDHzWOo0slO9siufCjiR7IGZjWnY1lA82ipYerU7el33eVEFqki6QUrKFAA3
         awlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942161; x=1751546961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqffagXshdX7Rwi5kU+p1euKG9kS921O7CCwjuhEXBg=;
        b=ZHjHUWXLoc58y/xI+MuMTfFY120hATdD3rMgG2DD8I+GtvihwTihvi+imWEHMhjI5F
         TFEtGw2r9aNRacbURtkwmYrwmhncTivM0RO0luAhF324aUrSNV3JlzC46Q3CeLgMCvhW
         1LFvdr442P7mpZeZRdxUDMB1anwL8552k1Rxo/i95T8HfGsjDBZ5nQHC9pihb+bbDiDR
         D7mR2ho2mRbhS7bwZBtySFgsiiRLVERZVFoE1HXTT6LVAiK/MPM+y64bXeg3D5IZDgRU
         5thqYVkcLStUOfZKEYfUG9a7NP4N24TOE8dQXc3USxp3CwLwrN/JvHwaI7biPkiz6usj
         rg4A==
X-Gm-Message-State: AOJu0YwAicPE6oth2+kMl7LFVn9xZ2IMqbbAGpUTy1tCu7VtqrqJrgXv
	Hh0Gi1UCA833cg/iA+s1eCPPb5wUBpHd+QtAAlCd9vI1BHSSbPHx7Kxo/mjUkg==
X-Gm-Gg: ASbGncv9mKuyD2TF8rq6Mac020U0BMBbrPIGsR5oQaJB7EWvaWgZiYrijKDj5+F8giF
	j0SBvlIfxwW1keoMj9Q8Dz33ZMCcPIjmwxgp/IeRa1LGC427OLv+2UAe9TeGwuS6NFyCSBlqeGa
	kL68CvrKQuB3JcRQ2wsmfnPlf8fLMtFEnFSTO4jJ4vniKkBbHfaIOf7+gyprCKKxppXQvs+QNqx
	3DOlxYCZp7oIcwih3F0bf/YT0MgIIznn18c18NHoFgPKBY4dg43eaEFpo56Zzre5WnPBHMa7uEw
	m27zpF15jSJOVFfPG/iZk0w48ssnHv9mGoehc0zBu/5QuLJlfy4jpz5/svpOgf8WdbaL2vnrJ+Q
	6Eg==
X-Google-Smtp-Source: AGHT+IH3eQZPhcg8jnHrx2cqPrq+OV5EN16L0oQIxa+53UiVNDBpo+dNEEaKSYl5Va9vJVFp4eT7fg==
X-Received: by 2002:a05:622a:a94f:b0:4a1:3b18:598a with SMTP id d75a77b69052e-4a7f280f620mr55285331cf.5.1750942161416;
        Thu, 26 Jun 2025 05:49:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.71.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a77a089ccesm69827281cf.78.2025.06.26.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 05:49:21 -0700 (PDT)
Message-ID: <685d41d1.050a0220.2ccfb4.99a2@mx.google.com>
Date: Thu, 26 Jun 2025 05:49:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3095319125305508141=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [v2] Bluetooth: HCI: Set extended advertising data synchronously
In-Reply-To: <20250626115209.17839-1-ceggers@arri.de>
References: <20250626115209.17839-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3095319125305508141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976186

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.74 seconds
CheckSparse                   WARNING   30.34 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      474.26 seconds
TestRunner_l2cap-tester       PASS      25.46 seconds
TestRunner_iso-tester         PASS      38.37 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        PASS      132.07 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      11.61 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   0.48 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.180 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3095319125305508141==--
