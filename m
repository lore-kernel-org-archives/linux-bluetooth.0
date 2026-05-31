Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FB2D5932
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227238; cv=none; b=jYouRcXmRnk+5qa8KoqUIsCUfTVLdBB6JDPUyjp8OOMqXmhtnTTI3KGSCFQz7QvPh3f+JkTiX8LHkJvuren1uhhPNNGZUP9s8F3KfS7elmfvm4T9lf8YyHxR2IJHIjudfgEunwfMIUOlPQ67HY8jx91RbK4yuapQ6AfbS9i/mPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227238; c=relaxed/simple;
	bh=96TK2q+IRbBYZNM8gBb0Wrajqlu/EMetUfuCM1V6K3I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rLGz+sR1ZIya6gBfVWDEUVBkej6Qr/Zskr1uwvm6tFUXD2BD39B8tA4Q6w64b5Ii3zcm2ppeAvU0+qEqeRmleTwYCDfi+ij2YWTT+ZqmkjDzyv55eW3AhbbRf6QrVn+9tCt3QIZ9h0qKMwv4t2faLoAkP5W5iV/OYYUj2o0eg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYrJaItc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYrJaItc"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304ddfcf72cso3089797eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780227237; x=1780832037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2qbvEUFj+Ps7aPnNptD2KS//6Giu2Mgwe1FmQi2o+Jo=;
        b=nYrJaItc3o51wB1VUFxatIax7ARINY4tUs9rnTydMFDU9GsoOg8B7ZcnB9wgiXJ8Cp
         pJve/lFfnpMrJGsSL1WUuQINezu1nhOoMjDA1ouGc8S6tClBQ0QfcnIYvE14I4HC2sOi
         vW/2TXYvDF/rIfTffXKp71hmZYTQAp+wsMS/UHiVfTkbHiDXJKP5VYnycrYN9g6cSN2w
         KCr7WBa4m0vUzboObklUtXmxvyk/SDiPVISS95WabsYivxf9V3aM14XbSYUAAP768Usq
         Di2l2YZ9CrLFjwKHZLqtS8MWGZLiXYHaugBxxOpnxwviqf9P77S+j8B9jo4u8rVSg1V6
         ae3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780227237; x=1780832037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qbvEUFj+Ps7aPnNptD2KS//6Giu2Mgwe1FmQi2o+Jo=;
        b=Xx2z2sMEKYoGi/Yd96U8RY+gNsKKdcExCu1mRmgqRUdC1OMI6zUBupJ4sVxiQRU9KG
         RKrIMWXs0xcgBZnKE5fNrO8zSlNKuvU9PqGnjRN4NCpGxBcE/o3iDE8w0mmIHGfgxqk/
         xP6KWkhg8cx1EjrENE5epeMaWoiqfqVRPsCZ4yQ2LZzEbA31mi+ovA83nxQpdr4z1bX/
         6sfvy946qQJK9GgF8dDMGz6C8yViIzRNqAOd8SS7FIbUjiSHtlxfri55f1m2m7IBD/1r
         uVxGj5wjaDQN8ZexfyPv1Pv8ssyUjVTB1ouLpLebYuDqo52nek15MVditTVqy4mO7yfk
         gT4g==
X-Gm-Message-State: AOJu0YxYMigqPN9HqewrAauYry9xiVb6JyqJ6TPOvDV511HdkgkAx+E4
	9jpRqxdZOdheReBYukxtltJEZ/ayue2gaosXJ99cuNHWyqplHqvw6+VXEKfhJj9b
X-Gm-Gg: Acq92OGKO0P7Qeh88tyNCrGRyy2u4QiylDqRk1wYxCLVb5ST/+2wUKCmMbVXsjQbu8U
	rcJiWWM6M/XgDbgfFiUWXgLqqz2NdbQzPOBeuGraC8HeSvwOJFdsuSgI27L/FQmInciqDxK12yW
	kvGRfXsXLu6fa0fgjj4A+G9hcucgbBMelDtQ3QjoPby/bB82q4zofJfKhORuacxaFuYip9obcJ9
	yHBnzGj7LNe+zKXEfkbg6PdTZXm+37KiWznN2ZG2Kh2q7rIJJRtcpTAagh1SIShQq9s4LhiORXZ
	ybVVc5zGE74LsZ+7GM8YwI7oWrtjz5D7NnPuOsynqd9j95Xbw9zEPUJ2Zx2im2Gujk0MuUD2w2U
	fmarOXO8WWSGh9ux2k+Gm2xwNEq2OyCtKWd0hzloa/HfWZXamK6X711b0DrksIRsqf5L8suBLOm
	JqRJn7ynrGwpEEuxpe5v5Bm07Z8YBLD2fPXsc358v9oWY=
X-Received: by 2002:a05:7301:618:b0:2f0:5605:466e with SMTP id 5a478bee46e88-304fa4fea0amr3234071eec.9.1780227236514;
        Sun, 31 May 2026 04:33:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.167.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2efb4esm6279459eec.8.2026.05.31.04.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 04:33:55 -0700 (PDT)
Message-ID: <6a1c1ca3.9fe3c139.aa430.8e72@mx.google.com>
Date: Sun, 31 May 2026 04:33:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6354584578268857688=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: advertising: add property with advertisement Instance
In-Reply-To: <20260531101754.3325247-2-michal.dzik@streamunlimited.com>
References: <20260531101754.3325247-2-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6354584578268857688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103543

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.42 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      665.53 seconds
MakeCheck                     PASS      18.40 seconds
MakeDistcheck                 PASS      248.36 seconds
CheckValgrind                 PASS      295.58 seconds
CheckSmatch                   WARNING   351.80 seconds
bluezmakeextell               PASS      181.90 seconds
IncrementalBuild              PASS      650.96 seconds
ScanBuild                     PASS      1039.64 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2161

---
Regards,
Linux Bluetooth


--===============6354584578268857688==--
