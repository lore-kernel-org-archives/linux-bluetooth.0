Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85C3A75A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727542; cv=none; b=dZzaXQyrxIw1sx8hU7E+EDG6pstdMM4+pJOM5+fzah1B/gwC/1CvP55mI0O7VkV/P2/HnsueqLCkKl10x+yjQKPlj5CnnNdQZ8qj5/ks6VPD79OT8N1NTf0Hnys26hBxwXdnV0hmPo0zPaCC8HRPVCtOTrJqjShdZbJonOVIiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727542; c=relaxed/simple;
	bh=t0MdE7Y1rdbVKV29axN3QIa8d00LRDDpggvfk8+ESsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uB8RP/+Yti6SmG2BZSoSFhf2eznEQk7gsODwCAFSb+oI9Jy3DEyWQNLFCCgFLu3bVJOOapqrITqYE2eQCT9/fmelRGKH3uT5lVj3QWDsSUerwkRhDB+jdRukFL9nPIVqsmLnF+C4cymsHFXgInt2Fr72cYtLVqMrxBa8YtgaUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML9Itv7o; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML9Itv7o"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6c9b72so68936eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789727539; x=1790332339; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xbjcsq3FooraqgK29YfWSukPl2Gn6RynwxbaR/qdLCE=;
        b=ML9Itv7o592N9o9YKA43aYrrswNLRvEkdyF2h1LN5wytrssWYbbkq+R8A6Ahbi6Wwe
         PS1HTk8u2JMYeYE7Xr5IKKKcOUKl3ixh/mBz5fyCCm2jnK7t9GnzZ+/c7b1/fKYehB7l
         vCtxeimdkfrfaA/s7E5/cBS7TH8f/4tUh6M03uRl621XAB3ODNdEaiFHIx+CUgDL96vE
         UOonm6g856UrGrsnRTpgRzYofp13qRu6zFPkkJP3ytjhsyedYXz+CJdXmROIUT1ry4O4
         YW22URMb/OsuLrJmxFSfdWTHFQ4XT7yXymCLJIfNidqcW3RkbKkML7xmlvmhBK6rz+xP
         TehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789727539; x=1790332339;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xbjcsq3FooraqgK29YfWSukPl2Gn6RynwxbaR/qdLCE=;
        b=ARgf1a0EFDOnw5gdj6CU2iQ/svKeTWqgs/PywZyDQPY5nqalXYaWrQblewnHd1yJjm
         WH0UDuSvbCD4QBQISf2sjYIuXIigA07CszNxc8UIadVt5FGVrHHZlxa0TPKpSJgaSAnK
         IVeX4lYG+lQPZNBj8Hp1kL1tEOR5I7/yxmJn3Ram6Z/Nzo0qE05+UBrb+xVsiTx++HrP
         r4+fELEXpiXZqD6dthgcLagtqCl5xxKt46hPzT45tsJ8yxNZlkObxK6uLhH2sq9jVcD8
         +ctppPfuLBkK9yae4iY3azIwrCKBl7lkxgdf8RtyuMA5vzM/RSwpVLGvG/c8KDyKGCwV
         +qJg==
X-Gm-Message-State: AFuF++lrSIkipIYoS/LSSH109klNIv69xTSiAbUkjhEVoDBqC5MJ8ADH
	UTHnIpuEZ7+t/D4jQMSTUHDNUeJiNZkKdxDB2BVE7HxiHXD/uB36gwi4sJ7HpQ==
X-Gm-Gg: AYBFou0kFRIfGT18953pT9WjcIta9EkoQu7fZsTESsR8BU45+DIOSXDUwSzoMnge3Au
	iGesquOlbNkSeFkOlZrTGEGcAumEYMMJa2W75CZQAvjNbULoqbntq9Kukt2mmxrxi6VLwGfNiK3
	fH2N//3oYjZERN1h2/WqRrCFwCb2KubSuX9N+ZQ2fTJdo0n/5zPbw+m1agKM+UkoXUrV0zwohY/
	GSjnB9Z5oXmNU3X2evL6ErkNn1UweX+yXA2IPy+//BTq5ROgz1I5A3iEPVgSQUhYQee/oS3VV7W
	7AIwcZHq/HMDzVw94ymv8R6g1apZ0+R6GnZ5iZy/GhV2+HLfZMj31MoRJiJNpOH1nA/lQbSNX7E
	84QqgNSS48OE13AH9l/zq8OMRmsAt+utygRfNRK6ckp1/Pi1+4D8/SbyuUf5+ciF+4AVgi4DHAC
	Rtgl6fneGiC/ZOUk4wzHGSaMaDeMTSGjRZGLaFNpO/XdLVQ5/Oz6CiaH8cZEu4nzFyAdqekRsEy
	EplKg==
X-Received: by 2002:a05:6820:4b98:b0:6b5:ec3f:4988 with SMTP id 006d021491bc7-6ca947ba3d1mr1555854eaf.35.1789727539541;
        Fri, 18 Sep 2026 03:32:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.214.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cb0d5d63a5sm991263eaf.12.2026.09.18.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:32:18 -0700 (PDT)
Message-ID: <6aad1332.b9322f07.617b9.31ba@mx.google.com>
Date: Fri, 18 Sep 2026 03:32:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0967070924927583278=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: =?utf-8?q?RE=3A_=5Bv1=5D_=EF=BB=BFBluetooth=3A_btintel=3A_validate_DDC_record_lengths?=
In-Reply-To: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
References: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0967070924927583278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168432/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      21.65 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      26.42 seconds
BuildKernel32                 PASS      23.70 seconds
CheckKernelLLVM               PASS      20.97 seconds
TestRunnerSetup               PASS      499.02 seconds
IncrementalBuild              PASS      19.68 seconds



https://github.com/bluez/bluetooth-next/pull/789

---
Regards,
Linux Bluetooth


--===============0967070924927583278==--
