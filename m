Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD01A8F95
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964253; cv=none; b=YaMVPGHuFD2bPcKvpmY6yv56OCCZzuqjdkY4Q9Z8+4XcpytTGirOVtDqtLZlGtX+cd2iYMSxAQfsyuo5TeKcwe5mvS9Nlp8VdfkiKseY/2HhcG3c5jzctpPAgtR+fo8alNf2yfRGhnBxvnXeoCPaCveNKXAOiL8KFs2kSOi27+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964253; c=relaxed/simple;
	bh=TLvRLMW4Jjh7sKWDnZgvr0mjYej+LhmAhRHmIsNfesc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mezXwrMTqwOm3gStdCzAu1otoONzatwuv4lM67ql0Dxri83N4Gu2vAsXcFc1sam7VZYAqNbfqciFkQ3I6578TTq5WC+7d9MN/+G18sTHKhTtQhOlomE0mOG5FcAApGIGSwdNDK0sbhQ82S2R66dHyRLnH2IHN0uPiXn65LgPJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E015mxjT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E015mxjT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162c0f6a39so46679375ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 06:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734964251; x=1735569051; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5HVqvl1Zgk6XYa7iCckjfxkrSJbpYJGxACUozUph/4=;
        b=E015mxjTV6HDrBi8JzsAEGdsb4RyWBPoQNFOcRFxWY8AxxBP1JXf4OzZs8kbpttrlw
         saDfgje/Orw7JutP5vgL6xDKOEDcWDRj5UrbEoPYQa/JdpKuXMD+mli8E4ei+FxTkKSl
         HDyJ1KqclgyurDRWnKYB0tA6itkCCt4AcjOrXXVcM4zYJMlHBBmbk0AEW7evqWCoUfJa
         Z39KIXHB1jCOtUW2akwlkBOL4nxlZ0X7b8LKOdgSf38SorC1eNnkP4bOYFgLfcOhypwO
         lFdGHLoicWrYDBRu5vVmYe+0sYK/aQ76rbCyrntWIpstHs9sWhQvo99JnDTkubTs7bIp
         +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734964251; x=1735569051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5HVqvl1Zgk6XYa7iCckjfxkrSJbpYJGxACUozUph/4=;
        b=n1S+YwaKFRCTsadnuxBNk+4hg7ipjdJ8IQEP36Q9gTDeoDum9vDXrRYv+zLCoxJV4w
         P/EbLzqFDDQsDaBw0UKCDCv41a28XqwlPEYOX3MUqc2AYyqkohMaANmChlHTZG0tro8Y
         BGbmPdF4580B9xFz6I7SG24UyofwPPeMIOrs55Yt3QJSZrL0si8i+4DMVhmJy2lomnCO
         c+XtcrNSiVAO6Q6dBvxE/SV1UEl9Ex+wx/5Bb7tl/1JuYgRbRY6CcQV/sIFhnMayrnV2
         2aA4YjjwqXhUGK3LgSs/iYTV6KUh/VQFrnE5rnSLt6teoFtI5eJhxhaMS3ZNjjifHtAM
         ZQAA==
X-Gm-Message-State: AOJu0Yz66/PAPkOFX0B3YKr/EN5cZTzrcCMs7QXYs1oVLCtNjIbZ2Fq6
	mG/XfJC/hc5LVdnyHS6azI40NwcdT01Us+T4THu3I2S9Yd+jhlsVlPaBgg==
X-Gm-Gg: ASbGncsY6XObvkecwWb95oYIOens0OOySwabaDFP1FWbl2QWWRmYLV/hL1j7UBjKly0
	t7s0Tom+0yG9mPS43lZbb+NA/K37KarA0Mc7lxWVuaYvXIaT59qBc6dpPMDPHBEIW0G7ibBjSIi
	dfLSdVZ0OSH+jULy63oQ/1tI/IYLfeSpcXALqFuwUryFwMj6Qx68A2oWDyTD/fpKFqaJEYt7EUP
	j5pt235wYI1YNTqQReheDAMOMr9a9ZoTUABjj1I7lIyk8Fr9Vg+rL8ncimVn0o=
X-Google-Smtp-Source: AGHT+IE3DlTBQj+de0tRGMlbXR0uPHo/x7O8eMKteyeo3L3nlvu6jO0C+mnDVeKs+fiDZo3NyK0PVg==
X-Received: by 2002:a17:902:e5d2:b0:216:4676:dfb5 with SMTP id d9443c01a7336-219e6d59e98mr207806765ad.21.1734964251257;
        Mon, 23 Dec 2024 06:30:51 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b77sm74099745ad.242.2024.12.23.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:30:50 -0800 (PST)
Message-ID: <6769741a.170a0220.9a61f.5739@mx.google.com>
Date: Mon, 23 Dec 2024 06:30:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2427367420466561621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20241223135700.22660-2-quic_janathot@quicinc.com>
References: <20241223135700.22660-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2427367420466561621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920408

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 FAIL      1.44 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      30.73 seconds
BuildKernel32                 PASS      24.47 seconds
TestRunnerSetup               PASS      434.98 seconds
TestRunner_l2cap-tester       PASS      21.80 seconds
TestRunner_iso-tester         PASS      32.04 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      121.31 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      6.96 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.54 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.172 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2427367420466561621==--
