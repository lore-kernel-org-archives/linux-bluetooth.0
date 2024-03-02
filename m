Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222F5680
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709400635; cv=none; b=GHUpU+6n10Dng8OUto69KsBrOvoFkUQKhLZ6Hkuktce3uWb5/8jqupAntOe/bKU54JtKvKPP4bX8bjM244DAz/0beepMSUJaYpzS3qCZMwJ0oVzjnGvvNlLDCq/xpCSWf39ADsAF9UC3o6L4b+wFnW0Nr35dZoOmlvyAHuf6Jto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709400635; c=relaxed/simple;
	bh=fu7mnMAOQNEb7XPIYetqXUkfGa+VYQy84a1S4Q5X8jg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EBoacC1CzWJfwAwOnFyTj6ZBkvqhAXgcjFXnS3Yivz15z3p//jZtxJM8BMHMIZpb3k1fL6xdcxNLII0yp/1BUcVKz9QnheBB5D4lpMob6oKgZwpzTWYHZq2Lp0cq9gms0fHp5NX0Yz+enNW3USr+3lQmGaAH1tEWdfnOVtEecOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2b/eLIh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2b/eLIh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42eb3a8f4bcso18648501cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Mar 2024 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709400632; x=1710005432; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X/5edLXiV4kT0DAZjhM6fbKrdrtTugDko/yJ5HjiYzU=;
        b=A2b/eLIhIYx13cIWGD1OFbQ2jFbAngIPeiL5Oe3aomRvQtGo6bhmsnm8F+kuhz4q0/
         tyBK+sRfTn6V/inXjdoA8H01DS2z+a0KR0YnG9VVkXU+BCWguWp2/gaYb4h3tevHjtrL
         slOmqqUulmBnZhiBTCMO/lNID0tXFp1fEN4iU+SvuykPeQnLPy4196SiS2pVY0SFHRKN
         TPsUs5P/DMKwTiIpjeuQB0g0+TALoq9W5hDaQgIYlf/nc/7sSH1e2zDeRGw6RUNxO2oP
         nYqZuk0lJwqVoJK7L/J9RE3y1k4d9WQCuEpWBy627UKXDv23jSUUqfdsEr1H8+xxr+JT
         wIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709400632; x=1710005432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/5edLXiV4kT0DAZjhM6fbKrdrtTugDko/yJ5HjiYzU=;
        b=We3YOv4bt4vQkcJkxE5u1WzeCIwTII8LyPRLsjKensiBKYV6sy2yu6Nlfaewj/QSSV
         Jh/Zy91NXhurSXiScrL61fj1sxMZ+Vy5nC1vDKHwGHafS+iqENAgeUseVdHmo1PWit1u
         sSc/ewuprR+s2fsHp/WaVnVfQXUYhiUWsieq3zqzKpsjibVsHN5aeRBDu+MLeIt8Ipq5
         wHa9/AEjDWBfL1+hpfZVpi78S2CZPqJudGVqa1TtJKQOaJkNKdN4BPU4DaReQxSThNcV
         /uzLW5jGK0xZ+8z3f71nHD0aDv8w9J7Q7iaNv0rh6u6x2ZHZGOmgn+npJw4ahrPVIct7
         I5hg==
X-Gm-Message-State: AOJu0YySb5+CdgXGpdhq96vFhlPTa8xC2cyDSH20voP5CYClUENB9Lg4
	l1TkG1BHgo0QUBWglqKDWqy0wihVXwPT5cngMwh12P6e4px78cbN07RH6HTy
X-Google-Smtp-Source: AGHT+IF+s0Q6NY50KkMarQVudr2rNOGmPTOBKBB5/FF6wQugPc0omlOIzPVPk8k6qhM21VRrLisQsg==
X-Received: by 2002:a05:622a:196:b0:42e:bcc4:2959 with SMTP id s22-20020a05622a019600b0042ebcc42959mr5036859qtw.4.1709400632576;
        Sat, 02 Mar 2024 09:30:32 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.207])
        by smtp.gmail.com with ESMTPSA id z22-20020a05622a029600b0042ebe0fb234sm2515455qtw.52.2024.03.02.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:30:32 -0800 (PST)
Message-ID: <65e36238.050a0220.44669.be27@mx.google.com>
Date: Sat, 02 Mar 2024 09:30:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3333442512471525242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix use-after-free in accessing skb after sending it
In-Reply-To: <90576ca2ad6b1c3e24c585c734cde44bbcb388bf.1709399114.git.pav@iki.fi>
References: <90576ca2ad6b1c3e24c585c734cde44bbcb388bf.1709399114.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3333442512471525242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831811

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.18 seconds
CheckAllWarning               PASS      32.28 seconds
CheckSparse                   PASS      37.65 seconds
CheckSmatch                   PASS      102.16 seconds
BuildKernel32                 PASS      28.12 seconds
TestRunnerSetup               PASS      516.85 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      33.64 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      117.46 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      11.26 seconds
TestRunner_ioctl-tester       PASS      8.24 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.15 seconds
IncrementalBuild              PASS      27.37 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.177 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.270 seconds


---
Regards,
Linux Bluetooth


--===============3333442512471525242==--
