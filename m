Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD01A6828
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116981; cv=none; b=FHZAmueDcBFmPf+bOjUucK8BbofpBMMh1BEFrmnHGLg7qs/5aFLaDARrXwrHnzxFoR/qvxsbZlWe9lL1/9gEQdBZS2yMsVOa4xryZDwzQlfA4g0fD6NYhg5hKKU4gp04/FJegvxSimc7MDmPen6PQU8cB/JqWyI2V6cIbiW/eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116981; c=relaxed/simple;
	bh=+Nt9dAaqaNaXF/Ci1oRUA+s8vdFoL/MVqkEPPN6pbe4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IGCy6yCGkHG555hlz5JYzxs6CfqbxwMP/4ZLVm/4QwdB7irGpSrktfPQdY6KEJoorYlm3JwgsTQnoPidaDEV0yLGpsN1ih3cnM0JlY3y7e4vkZiJUTM+EhlNJHB6phQnW5EhRrkCE4TJg6w0QrYxjoCTmsCLACOwM9fbVeqfJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHlf8tlT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHlf8tlT"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d7a3defe8so25273471cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788116978; x=1788721778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CrFmlJQ1A3m3uaQeLhnDsNrayD1++NqWPpB2JpLv860=;
        b=iHlf8tlTuLS1XpXcHSmOF70nLlP2MrMolxQx4cbyKd5Cn+INMSccu77CdlyKssZTrv
         Lq9LGs3sH/ayHVC/KQ1M/XBvi5kZlvR02b8UVg1ZyIcag/Yme8iruYdtBOAWolDPXjLF
         z7tzvz3CwkfJYM4keA91onsjIynReeXhuQV/3OOntWIvmOB0fV5rY/mdHX02yuyARxyP
         PAA93WyZU6YvUW2weg5LMdWywtL1i3JGDMIdLuCN8iQKyghF3hwaE+HUmKVGhZC4BEEo
         WG6td/gGMCfRp/Wdn/SmDw+xdmK/uShf6bh0kJXgSRbT2sGvbJY2LloRLs/fVdrur8Ua
         S1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788116978; x=1788721778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CrFmlJQ1A3m3uaQeLhnDsNrayD1++NqWPpB2JpLv860=;
        b=bi0nFUSpP4fLzelMF7EFg6UEBttN4uXOpgNkUsH7uODAwu8W+dKFaJvIdLvHG50vpI
         UhTEP6hv7x0f5bR+15hYHvqP+d7O4CJXmuZlcUATxe12ARJdVsCSeUSR/ZFKmvY8SRJ8
         o6xhKfCOmqdf5vX/gfqFuC6hkjGRBEHuyiqyDHRSJovc7nYeYLEQeyK2e7DPyfe/yGP+
         oYyAGHSKdmuQOebtHS+xvwJK4MVoAPQGcZivFDyA0GtHABKoKuYH2mghxSamVkC5te81
         MyYc8hQFHAL++/Vv0Ol2dLu8Ulyinl1FtF4M2SrhB+jn8C7wftJEUQaa26G1wh+SgI/Z
         TbUw==
X-Gm-Message-State: AFuF++mCIQGd4r1SZu3rMmKbLLQWQQ9FUruSBSaYlQ4QO60ZA5rn/e8f
	R5hnuk8nZAREVriElv1Wt9+t24IpJ/qK2hSa/QD2gzFoiN4dM7ZKWXLhu5+FsQ==
X-Gm-Gg: AR+sD12+pLkyxgMm4eJUQNANvWxs0FQ6Ntx4UR2kD1NWu6pz0LnMQkrDsFMZ7+APdAm
	hKwZfwFfHm8Q/12IGqYBLNg/JfAnmYWozV6GH18U8S9AWQYtn9vrxPzDUdebTSMJ/9fA9gZFZbL
	mK6c4bRZKu0ODiF9D+RvYb+jKVejYoDt+CwBtRdGsPyQ5+0JWwXbZwEjpaz9FUMRz/LrDm8U1IT
	ARKlPPhb1/PVKwmCVLQtXu1eW8nLsy/I61uDFRh4HAJah9CM4Sh0yzf7VnNkJ+QZvmsngUri0sI
	aBb1tfXMfDhCuaf/sAUEbA12Zgy7Ee233ipAqMPx3AEabP82VKlZS4qHUM8cuTeQ7pnJrjecwoL
	AuNFYQHhqwzHoYtqSsAleH80vYB0A6RwjPpr9HO4YjdhZXnTB3AWr/7oEOksFO2XHfPMg9UHrn4
	K3GacaEeotoKgTcd/DczsCyEOxWe7OkB2Kfivs0G5pc4r4c4B5Wid7YymmbD0hZ28H9ulH
X-Received: by 2002:a05:622a:1789:b0:51c:6b6:9d0b with SMTP id d75a77b69052e-52fb9459c8dmr271426421cf.2.1788116978421;
        Sun, 30 Aug 2026 12:09:38 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.121.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff73ae220sm39662451cf.23.2026.08.30.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 12:09:37 -0700 (PDT)
Message-ID: <6a947ff1.49dcfff9.1bf3ff.828a@mx.google.com>
Date: Sun, 30 Aug 2026 12:09:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0077739601619905051=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] emulator: bthost: add function for sending raw L2CAP sig commands
In-Reply-To: <66d2971217dc632b10049fef7a5e9e735715bca2.1788109841.git.pav@iki.fi>
References: <66d2971217dc632b10049fef7a5e9e735715bca2.1788109841.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0077739601619905051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153956

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
GitLint                       FAIL      0.68 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      614.58 seconds
CheckSmatch                   WARNING   323.01 seconds
bluezmakeextell               PASS      103.32 seconds
IncrementalBuild              PASS      616.45 seconds
ScanBuild                     PASS      979.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server

1: T1 Title exceeds max length (83>80): "[BlueZ,2/2] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:957:28: warning: Variable length array is used.emulator/bthost.c:991:28: warning: Variable length array is used.emulator/bthost.c:992:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2457

---
Regards,
Linux Bluetooth


--===============0077739601619905051==--
