Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5121257A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546565; cv=none; b=c17MWHXgoFsJYXOEqbfWe5V7qZCVu5qkRv6WjTeu/HKYHQFAG9W8obxWPZTu8shAte1WJzEJHEWUbz0RFuzNCqgKTb59XC1en3SnWMeZ67ryMUhQinwHa2a6NvSrk5SiXrJ1MSXUTEzmV/FQNX3r+7nIi91Mp7qcRHCC3mVkHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546565; c=relaxed/simple;
	bh=nlcWKyxlD8SmN3XgyGc0JibkSBz3R70O2R5uHnnbgBA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G5eO2UaWaXQgkBq3M9Rl3uxViu7gto249JENrDU+E2oAvrn2I8q+ZmHfptqa+ryk6CB1pIRdXZjxE3Bvgb3kN3m/Z7ijvJd6HFsVFI1muJyrvFo6EUVDyOjbC4zDO72qOZJvVVS+JzrpaPypJZcYi7lysNh7mZh8sIVgD+wbqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da2bdd1X; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da2bdd1X"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e8850b09eeso8997131cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546563; x=1763151363; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+c2AxRDHS/Qb+7/Uv9joU79OXJhT6eZ7Fp+IpOKvFk=;
        b=da2bdd1XufIkmYpnvnp+LSD8Y/DqXgcs6SArX4wVoK3+PoAPT4SFtw5x1Fv4HfVsqP
         dRhIzU/H/4sW6D2oG864oiq6168W1y5lvq9GmmaqoFBE9CdRwj1Gh9bw9D+RvJAINsrZ
         Gwaml68YFNUyese/gV1hjm2Vpjtq+7Hryn94e71BVb5O+lTxsgvx5Y24g3PJnK2kBBIk
         JiVcel1pk25X96XHaTPV93D4/CfmvS/tI4GZpuQ2GacNtXU8/rUcoAUVr3LRvTUVTwFt
         078U0yr/LcEJbgulx4tbrg2F1ILswZkM9A9MRXlZvNdTWe5AkCPsKBEdlnLWup+5h43q
         B0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546563; x=1763151363;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c2AxRDHS/Qb+7/Uv9joU79OXJhT6eZ7Fp+IpOKvFk=;
        b=io540Osdo+jqNjhuxZfvTanr43jaK+js4e63iwnpBJNbNA4VL4ypVJHH2ixZiKILdj
         ARdCZ1VO8IWIhOEa9BKfQdCd3AYN8uicy5tMT3vUcEjyKx+ajLd8OCYWKDoaXmwT8Oj5
         ihlQ5thDCiFm9rhrvSytyNRCVMUtVvRcIC0cpB3bjZbcDj7vbwAcdk3HM3MnOunwSvTn
         4CKQuCOHlz6dRQelU7RAqS1YUbRgfJb4M/cLILLLSj5tq91Em7hfw12BzWqlTi7eLRFV
         zZqddsYAeU5MkhmBmlzcq/8vRQXxKCofhEoZ32g/4mXSU4YByYdWW5Y1obzhU8ZPm9Y9
         gjUA==
X-Gm-Message-State: AOJu0YxQyf+OYrg71cbHniQsUL+OJPxOo8spf8ze4fDdRvRjAk7tb5iG
	zd6yt7MVJHjlnfW01hhoyhvND3Uhug8jIwFEhSOFsj0tKI1zpe+lqCE5JQAQKA==
X-Gm-Gg: ASbGnctg+2Ku45T7MGAP2789KV51yx6Um6H8vUh04ncgmZrJRRZeSrJ3p8rTikFqZkn
	VKVZt1Q76etowZ+pimeMLc1czS3hbbN51SSGDvtQdJJy+v+bNorxHFshPcB1zGPwuKWBEF4ao62
	nTViewBrDl7TGQvC3Pos+H1aeDpx5Ef74jmjKwQK+NkPIL6AFNOzZCw9+Nk4K5mIwm4JBriN7lT
	fvwM9JgiJ1jad9/fqI8/Y9fCuP+Yq6PFP00j3ycoYSfdJDyrkPMYdfZVGfogzSHF/cpZmBZKRiI
	0mXKgvh5Yr3pvEbYe2m98zAYi6FVzzkDkcUy9DNvyCwIosJYBgfhPDhoOeLCPir4rTUCBHYUx1V
	zT/VrNqqGPkrML272NsrWOUKiGt/1xQgwUToq//i8WNKyz51DA4haLwfEGdiVzaaXwfTS7RQG2x
	DpP+LbCQ==
X-Google-Smtp-Source: AGHT+IED6sKlbvDWSyFva/SgSg69XwV++1M/OkXGPOeJvj4ezfc+0Ph3im8eEvb0WzVsjPZ4+riClw==
X-Received: by 2002:ac8:58ce:0:b0:4eb:a683:644f with SMTP id d75a77b69052e-4eda4f7ef55mr5191511cf.51.1762546562684;
        Fri, 07 Nov 2025 12:16:02 -0800 (PST)
Received: from [172.17.0.2] ([172.172.158.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238929abbsm1635336d6.7.2025.11.07.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:16:02 -0800 (PST)
Message-ID: <690e5382.d40a0220.d39c3.067b@mx.google.com>
Date: Fri, 07 Nov 2025 12:16:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0991152920573477855=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] emulator: Generate PA Sync Lost
In-Reply-To: <20251107185428.1161318-1-luiz.dentz@gmail.com>
References: <20251107185428.1161318-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0991152920573477855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021045

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      19.96 seconds
BluezMake                     PASS      2849.56 seconds
MakeCheck                     PASS      19.97 seconds
MakeDistcheck                 PASS      191.71 seconds
CheckValgrind                 PASS      239.64 seconds
CheckSmatch                   WARNING   311.36 seconds
bluezmakeextell               PASS      129.85 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      940.00 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:461:29: warning: Variable length array is used.emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0991152920573477855==--
