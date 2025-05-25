Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159872605
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169179; cv=none; b=S0MsmdbX/q/0THaq2v4kRPleuSTnzTIrovRgIT6sZr31WHblU0xD7csTY/0/RA/XtIkUDoS287zeu4vsFO8AzMp8TT1++B6+ZG1rqwI3zSTm7i9E25WlTGfivCg6RPFeiusAlkpXzokrYvzrXHy7khdEzrtvZtvIb/N86VQciUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169179; c=relaxed/simple;
	bh=AN7258j0rMdqqdynMHWo/iDYZves99oYkasDa6SJ0Nw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lDHMs2iDWb25oJwBQs5zos9LWnVVdO+vFNE+F4Z/CaaRPj9v91j9Ss+WDMb3SPx9ZaW91hkd0A0jC+SIV65QXm8Q+agSHLw4iXcyXEXadg23LuExZ8LcqKrB/Taqo0GaxmYhuLx6d55ZSr3W1jNnZZH7FQXJPAxrUgrL4kgv9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joENa+XU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joENa+XU"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so14098916d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748169177; x=1748773977; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oQJd82D70nQ+AuIrty0yltfThwZqNW6foGatpWvigyg=;
        b=joENa+XUDONQfATgLgnUwCU6hGHe7SxexQaxxwhF7vhJ+Gpd5CI577XHlKfKzd54YT
         tLv4laLz7vw9NMGNzXJty+iD1gtgyc/VTSAUgnvyLGQpU0EzTTkY26lcfWBfU9Ntf56d
         7EcMaEYYPDNMIE5UfLpd/wdNBRUaeGu7GL3zCWM2SeK9GShdJpQZXVP476WjTFbv+BXe
         gRFlpHfkbBPr7GCdUKy6Rj5AB0MZYfLleK9tW7qXiDO31h/SFX54l1gjYfDklev2RoEK
         5n8jU1B1p2bd/Skd+dRAV830vOGiRsE3tbIfp6pqdczm57CGJooZ8jB2NMGjQJRlZv3s
         H9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748169177; x=1748773977;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQJd82D70nQ+AuIrty0yltfThwZqNW6foGatpWvigyg=;
        b=Ta8QCUDjBWyGzmisNSTHUWRRnlZ77WWANtPD8iwSn+IEfo/cfuiBrIvbQGTgg1nqXW
         T+FZACzTvJbIaVa4rULcHdjp8hW1UZBTH9DJGOFRZHgdLWQl4+n//i25ee8yYktLt4Il
         0V/RrR26W1nS7/Obw0djnJtwH/vJ3HKOGxcI76JDVz6tkfYQN5Agp0AqZqZe0dd8f4vv
         s9GzIa3SJ4hlhMsbA3o0bXwsp7W56Q1hDhh5zBu55pbL95ZHDdh9SKiB5WFT65o1qnd4
         Cue+scTFKcjasAeL9yp5qJ98MFgHrqBS8z+AzvBQxtzg464V+ojR5i+Fp2L/gBgSvybA
         uaqg==
X-Gm-Message-State: AOJu0Yw6HThfPMgxFGSf+muQgWWUXwpMZQD5ROVhDfExH0cIpk7AKiE/
	lbOtj6Aptb8FnGD0rzAdUd9+Pe0jRXJoG+7X0nRBTPd5/hjsFLR3w4LVn4w8uw==
X-Gm-Gg: ASbGncsFn2afYoFBkGID4GD22Qj+VXAq8GG67peyY3oKfzps0WOvdXVqis1WoMMcr/g
	MSofYeM6Ract0LS1mvzF9InZO2sBy6KhuDnD0u3bl+ZHTSWoU2dAGxd63Bp2QPGcWZwskFRBAU8
	W6XYFgQzkw29aMHk2FwqzCQqdjAIhuRcwjWhJHvXoPnW7AtyCrVfIHMGVd+M4xodr8MzCYx4OLV
	6V+hT5+iVrj/e/kuehOajAA6iEGLr8imvlNK2oV0TrTjkW6jpNmvQ/YU/Q3S1ak6vErba0oaxD7
	Tk28lTsmf8Mfrz6PATH+GQB6o30DCC8ku6ePyvAGAsfyW4wwoSiVVxYZ+A==
X-Google-Smtp-Source: AGHT+IEq3o0YrM9LFTM6Hbv/qrr4ufWGXH5m0hnWKd1RwaPL2GAZdmeiFNTSvkn1S3B6EfZTSSJWNA==
X-Received: by 2002:a05:6214:3013:b0:6f5:117c:76cf with SMTP id 6a1803df08f44-6fa9d2dca14mr93535886d6.40.1748169176600;
        Sun, 25 May 2025 03:32:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fa9e11d873sm21515406d6.85.2025.05.25.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:32:56 -0700 (PDT)
Message-ID: <6832f1d8.d40a0220.160896.4647@mx.google.com>
Date: Sun, 25 May 2025 03:32:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8917223754812087232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel_pcie: Fix potential race condition in firmware download
In-Reply-To: <20250525101619.530255-1-kiran.k@intel.com>
References: <20250525101619.530255-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8917223754812087232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966204

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   PASS      30.17 seconds
BuildKernel32                 PASS      23.88 seconds
TestRunnerSetup               PASS      454.99 seconds
TestRunner_l2cap-tester       PASS      25.38 seconds
TestRunner_iso-tester         PASS      39.81 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        FAIL      131.41 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.64 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.19 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.38 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.230 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.166 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8917223754812087232==--
