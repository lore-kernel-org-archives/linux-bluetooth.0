Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43334B5150
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448387; cv=none; b=NDTb5wqbvWB2dkEQ7gFcjR2SnYZlbNla3r4jbZifoU3cFUBbBAiJejHazrv5UOlzGbVowmiBTUAxARAvhtqMkbBnBX82yCZ4XOnZJXtGDCUZ1p2NAf92n6z8T1HFcPCe9W0QnnrXZodt01mYEBhb3cid0A7UaieOWvR+FKI+guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448387; c=relaxed/simple;
	bh=CciRGex1lEnFokvLoCnbPUo/LEAS/Zq8JUr0fLLE54E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IMP6xRcvmkR3HYK2z/4bDW9kFRY/DW6rgguqdrPMqZuRYMVnTsD9iSeyp+TWZJOFfIxTNcuXIrM1u6/zYGh0zdhBU27B/3p+alU6g8E6tBJkE+jXEBm+Ew5tW6SBkMnnhnokw6zXXPBF+nmySZercnBqoS59rG/eiDAcL935KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWK3hINk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWK3hINk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39647184c73so1106219a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448385; x=1789053185; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RiONuwoOoxBeOQXIqfb4U3yVonoDQGSwO7oAglTL4w0=;
        b=jWK3hINkRjW4wIGjl1vK8uRZ5jKAG0auxJGeqx30Hl6o5bIVvuc0upAKESAPisGrFl
         TIiidjwoFplTeg8WtyLyJT8CICqeVpwrOO4E8+WtWaMMgTJvSazy7I9BB4TnPYHN/GNX
         98sRpW+wyTLbgGyQJ5eBfPZhnWwZ+hBJipZ0gN272CyNcR9wpU7AurWUUjFfzEZotk3v
         Bo8GwOp/8pIe7AUYQyvE4S+0VxGhdzmbsL7A3CwjicZOySM0XpIyb/klvRnam98SsCd4
         ZFW/NliohCO96I8vux2fyaJxpU96qY7lXq4t4Ec0ehvbK+fkVVFDa8SRGe38MctVSmwh
         lPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448385; x=1789053185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RiONuwoOoxBeOQXIqfb4U3yVonoDQGSwO7oAglTL4w0=;
        b=N6YYqnJtDGqOf+dqdyy9xTAOkdpjzIzm5GwAeJ72O95Ve0q/7Z0LqdbTaVYPDmCHK7
         OqTBWvGOQTHgdzVxdivYWxgrAUPCICy10/m9aPIbxLHB8dKuRHJLA70HMp1xFmsCM7N1
         sQrvi7+CvN9IhOdiP/yTd5rZ+CUJE0/kbvD1WS6OMKW2YhWj12PaDszyysKJpUk+yV7/
         b27aNLXRmq+OuOBXv8mxv77RSwK4MIPyn3AaEHoEhCFEqbU0J8P+vYgCsyto4ctg1xD4
         P96bpyEHH5Vte1sh8z+XeZSY+GgIj49E5gieYQONzc7nkRqkaj6Ya/iMyUL6UXwLKq/s
         S9Gw==
X-Gm-Message-State: AFuF++ltuIzJVGC6YrEpi1MKtGNuDBxrFZ3lFaan3/OXC1w0D35mAEqB
	pNa0aUS/HqpUOV/nkMztRjHNqHC7X4y0wenLM4HCCR6hivtnfOFh8pr+yx8gNQ==
X-Gm-Gg: AYBFou3Ki7y7m4hp5/zLKwjJ+vE11y/dlid7CmLWUY0mHHhNE0wQEQauzEZ3XhgxpP6
	hX8E28tHXG1iHn5ptlXd8bthN0fZszVgEykYbwz1wCmJcqUXvdRn47fwDnvihHJLhw2u/xzePis
	kJtm4AaaTlGx8E7VWlAb0Sn5WnCWBL5MJm/0qcMHrAdsL4Fb6IvKaNVRf9meNhI+xfvK+S/1wIq
	/6AwzeiRLVcPzXuaxDi15Lmz3YeVYf7sd5FvqG8nwSP/MO53z9Pcd4W6raArqVuMhxgQnl2LdKf
	AzrZlzE/JITi3oe/kngnV/cySTGwWcvNmYdEt1rxZeC1XaKsIXkDM9/VGnQouiQgbzrKu5stroL
	7LF50bc/U4hxJ+xLVGnh0jJhdYRbleJwbIlLNidvhPyzUazC7ZV451JZKMrG1H64SPNF98wB9gN
	vBwmkL75edS0iJaXaU5qQfgDqjKBfVyIWBOIKfaW9iWNr+3YHgKOSqEkQkl8kCYoO492Vv
X-Received: by 2002:a17:90b:5587:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-39b086549ccmr7617268a91.16.1788448384601;
        Thu, 03 Sep 2026 08:13:04 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm266059c88.4.2026.09.03.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:13:03 -0700 (PDT)
Message-ID: <6a998e7f.2915925c.2fe3df.d5c3@mx.google.com>
Date: Thu, 03 Sep 2026 08:13:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6457040984165822391=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel_pcie: validate packet_len before skb_put_data
In-Reply-To: <20260903145102.54675-1-kiran.k@intel.com>
References: <20260903145102.54675-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6457040984165822391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157183

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
VerifyFixes                   PASS      0.34 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      27.59 seconds
CheckAllWarning               PASS      30.26 seconds
CheckSparse                   PASS      28.69 seconds
BuildKernel32                 PASS      26.25 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.53 seconds
IncrementalBuild              PASS      27.20 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/696

---
Regards,
Linux Bluetooth


--===============6457040984165822391==--
