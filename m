Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18324BE45D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064723; cv=none; b=RNYuvFQ4oucjgJlyHrQinyaCEZCsthAECuUVqckQlDld8hxFq+u9pZBCAMYzsNLKGT4dV8lnV+PQ5bBWAAauJj1KWcaD74+RHTzR/PjqN3bnKjZaXFlZAjss0TK4h5oJ597cSMOasVc6mU+npwV+GAEufG57M5+rOhZgLOAZl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064723; c=relaxed/simple;
	bh=CEuhgPF9wru89QbsQTNWsAMxpH7aO6iy1BPHsVTlnBM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=urabz3WQKHoQ++KCaLnCrD1hfRgju+wV8bVa7M/tZwb0lRIXZ1nk1D0eYRYXctNaGQ/aS5pZ6m4sPZyyXjqre7YUrkz01Y4IMvBcy3RWEnvbR8Uva6CPLrcE6TwO4URKJlwImdmpFto373cxG+K9FMLNx/LjwvSsJLjb/xOrj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0k4csxD; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0k4csxD"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c3d02aso144112285a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064720; x=1789669520; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ys017yK/gMbODkMQ7D2b4vTO8xFgMwGyu+LiMy8YDZQ=;
        b=N0k4csxDzUtghHv3YiPBpM1E/L4qeU8w/GltqG3FcEE7i7Y9VgEYJzfdlfRzfUw6CH
         ozfYCJYnPi9jdXfmKUz8SQ8bXTF9zCO2cTxkdufmpacffHiSIdbXhyi148qd0IYNPJit
         Vhuolj/7YOp0Ppv1K3ceDJ+uEPIo6KInIO/eISHbaYjOyud+mJbcBqHnxJ/lxieiljQJ
         0+uf5Kc1vqS2fC3QXri9NSAXQqyHeLFuVu90fVqGOHCe+s/lA4HhVqjCT7ew8wQEuC4t
         NMZfOQ/fJag9J4wG+GerWIIuKD8z2LRLZxuFYfxS93lTfgp+L/GRV6NVURhIJvW4BErg
         RczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064720; x=1789669520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ys017yK/gMbODkMQ7D2b4vTO8xFgMwGyu+LiMy8YDZQ=;
        b=ouzUJnfXknEyEMXZ6Kryplcd+lH0XriTu7vE68I/PXklY2j0OxbypM2oOyjf90XtmI
         NueZzpKivmHnAmcOZ3lEK5i6xVP9mnuM7R5eocl++LlxUM4pepi2RErxWn2MsMa2TQj6
         9NXFGos849DmXRTXR/yMFGaHtWs2Cm7I1dOgNfGkqdX0TvlSLYn+a9Qh55y9StGS8UXa
         EGMc+1+rz0kihmH0tM5eaCFS5t9JDVf+VDoboUxT81OQ6za5n0lP6h6Wczmo4P+0w0v8
         TafB6E3ejT247yQjhhVXkBM0txKQ7a9wij3r+TDjCJNefs575ElLhGrNvqJy2z3iEW/h
         04RQ==
X-Gm-Message-State: AFuF++lUexfkaD3x1MqrGDVuJ6PKrEWxRibqR8p/Ec9xSA7EAGngw2Nu
	GfNS+EmjtsMp4POTpTLbpKA5077V324Oof83J9FxRcHe9GIdfachanI0q+tb+g==
X-Gm-Gg: AYBFou0qt4q99Nxn2uSjTpG+2lv5FcfbaSZ6824DCr89N+abgN1NpwVsLjK/wVl4SFk
	8QvDCqR6Tb26LrQ9knmB7zHDu6suLf1ZsNEDkaHS28b5sPlyeA0hUlKvV57aAO0FtwZ7xWp4U/j
	c8h19cl8ASyn8b+Ad6PpJtuh22TSKJhSxh4MSFgI4tuT1Rzk8ZsxnyapLxETyoRqlmiq/ke6SBw
	7Fl6Sy/nILFLjuFlik336vbR2GEkRmcY8eWUlRA1Mj/zFaPwZdPqBxi02poqMOYFIMvIVIFBj5T
	/e9l4dToHKY7E1t6hsoPaQCGQtam3bZPBFAglfuxR/EnN9x+/zy7cHlHllXq1i/EAset28REA5M
	T4poRtTKutY8qf+YnxcSl6+F9bLWR3K8pWagovy3KaFHmXaz7eJRmK69yH1gzI3FmP4bKo11zUx
	ZvCTOXDCOz1xl9tfeEbnzCgCMcRq9oiPSYI9Fhb9w0C8ylys4aABFtHn88ETOhi3M1Htw7945YQ
	diom5i4am0vQ+3Ziw==
X-Received: by 2002:a05:620a:271c:b0:936:9253:897a with SMTP id af79cd13be357-939e8b16f5fmr97166285a.9.1789064720257;
        Thu, 10 Sep 2026 11:25:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e948717fsm17081085a.24.2026.09.10.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:25:19 -0700 (PDT)
Message-ID: <6aa2f60f.a86f48e9.3a86da.508d@mx.google.com>
Date: Thu, 10 Sep 2026 11:25:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8111228520699766814=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [v2] gatt-server: Fix integer overflow
In-Reply-To: <20260821033214.82863-1-zuohongsheng@kylinos.cn>
References: <20260821033214.82863-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8111228520699766814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149440/

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      19.47 seconds
BluezMake                     PASS      354.38 seconds
MakeCheck                     PASS      6.89 seconds
MakeDistcheck                 PASS      140.18 seconds
CheckValgrind                 PASS      145.94 seconds
CheckSmatch                   WARNING   277.41 seconds
bluezmakeextell               PASS      90.59 seconds
IncrementalBuild              PASS      368.91 seconds
ScanBuild                     PASS      1032.26 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2512

---
Regards,
Linux Bluetooth


--===============8111228520699766814==--
