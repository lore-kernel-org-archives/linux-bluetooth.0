Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EBA2D29D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221291; cv=none; b=KW2Op4YuVQ/KKPiKZ2Nu9X0J8ui+T3TfmqknXF3rhvoC5CVdciahXdeLW+cW/8LZvovMBuI4ZxEj5tGWVZ+49hQgqCIFL5hBCl73MpYbnDsyg+ZixJvQj1xz6sdHG/yCLYAjeKE7/Syoa5fMfaYNuFG+3r/lAxyi93hkeQWlnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221291; c=relaxed/simple;
	bh=Vygkoc5zMv6UuxyVN2IvGIhDWtrCMV2qlUnMbMh3wnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V506ltpMx8+7WqZPBSm3ti9CFIe9XMLNUQtp2N9/ONU9XK8nVhcK4reEeyvlBzLtqxd7RyMGiUmQn4pqQL//BvssSKCevJ3G+bStG1h8kATtlyYslYuQ8Pk9Cgdo0HySO6OYWZl+i5nJ1KnxYZNyjEuyN8DXJRXbGJCeKiG9d/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8obkoQw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8obkoQw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b523fb676efso1147074a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221289; x=1758826089; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ERVBlhyj7NFVn+5ykwzw/cHBolzTWHKcft1ti0Fksds=;
        b=M8obkoQwp7MqTCvjrDqPSIRGMKmSZ27q5Z2JK199ntENRgjQPqAU0BBP24LU7vsevv
         TKYZsK5vhCQHnkBRJ54u3glQA1PcAVevGKMuptYMzSnQFnXzVFJSBcpdXqwI1/949XRX
         vkzVCHOhvU2n5+jbMRQd/wTT8BjhnjVVcIX6JSBNi+pm7UC+ppE8LoorJtCUEEXqncTh
         6cCNNfpzrqR1X6hblWlSzINCovU0KGSzKxmHR6wa5tR1aj2GKti1J3assnNgLn9sDA/W
         ozEPQHi3g5XotrPPwd0ulD7BHHDTg821EjYU074yx2wmmsuEJFlZ0rvsDjniVHbhJ9Md
         MPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221289; x=1758826089;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERVBlhyj7NFVn+5ykwzw/cHBolzTWHKcft1ti0Fksds=;
        b=RvluHTH4aIPESTAtRDC2e0Rlck5K94gBtb8BH7kVHJCf0pJuWaRT9qB2fBY81CNfl0
         w2XRwTQHXlo+JAXHKEsuOf2qgd96Ug+yGcIOivAqllG2o0j2XVEJD9gDlaCmLpiJtxmO
         XOcUCclzN8Nr+qmyK62uVB8l1Dj1UD6SxWOyxmUvA6+eDIsn4+Zy5luCYVnJ0XjJmiJs
         CrZV/VLqNk93BLE/RM7fMQEFyiT/B6YEGvzkyk/TZe2Zj/ZCPO1iT0yM4rBcfKO+mO3V
         ALDNLnbejNiodnnO+aQ6gjcelP6Kf5UKBduA8/qS+eu1EH27QuOwSNmhwGcUGqv1W0ES
         clSw==
X-Gm-Message-State: AOJu0YxadqYCk8HsdrBh8AII9msgU+VKnNZpBIcdMOfk/a4JfKPJsHbw
	f4oWhxAxPc2rwc0Q7zBsJofc4Bl6YamscOg86hrxe1YwCpu+2w+2bZgoS06E5Q==
X-Gm-Gg: ASbGnctd3nL9eDIK7uYhkdznzDCNB4BK+Cqe1gaELVFbaZjPIHZHKFg/5QHcZEiYdH4
	9cRFhcL7/ASEr01mO1UObgxJBgVtnLz2PAUyTDJ4/luiJvHoqW0VImev0csoROw+00Fjel/HxiU
	jzhCfKXOmYpFIIbDufMBJ6LJdy0CTwWYKCahzx3Dexh8PdqNKZb0XZ0xrCqu/rR2ELj+iNOdAFp
	v1EuqUN+2nKyqy0hIA0HZUmego+vxe9b/5440KHKS+7iJ2c8mMf5sdPsPIhomCSZ00Dyb2VR9gX
	E+1CS20EOwQiClhWInrv0g1z3+149jc101NeNIwPiQzOi5SBFedtDxzqvCNDT3vGT4j97y+pNIc
	BHkgBjmCvFb2AuwgEgUa6WBod1FMx6YJafY0z2GiNjb287yTc
X-Google-Smtp-Source: AGHT+IGjAqEiRs3FUslcoWet+M9UTnIB6DavzdAhxZS+t9yLk9F/GnW4MJwAqRwL/WYQb5elo8QKXw==
X-Received: by 2002:a17:902:dac2:b0:25c:e895:6a75 with SMTP id d9443c01a7336-269ba4f020amr7739985ad.28.1758221289246;
        Thu, 18 Sep 2025 11:48:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.209.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033cd5csm31564675ad.136.2025.09.18.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:08 -0700 (PDT)
Message-ID: <68cc53e8.170a0220.3c5b59.fb66@mx.google.com>
Date: Thu, 18 Sep 2025 11:48:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8066143972004828216=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: fix pac_config_cb() error code return
In-Reply-To: <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
References: <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8066143972004828216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1003939

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      2785.04 seconds
MakeCheck                     PASS      19.86 seconds
MakeDistcheck                 PASS      189.94 seconds
CheckValgrind                 PASS      244.07 seconds
CheckSmatch                   PASS      312.08 seconds
bluezmakeextell               PASS      130.50 seconds
IncrementalBuild              PENDING   0.46 seconds
ScanBuild                     PASS      933.84 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8066143972004828216==--
