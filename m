Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEB20C494
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689215; cv=none; b=Kqe1CCwZR9+Et17p1Y4bfX43VmjA6W87K2hk5Z7LCyyPTLisfaYKsaT0QLjpmgXUN4cmRuS8pKr3Yw+9xWZ8VedoMYicKReWFhk1HGb+CZkjKze1vdAeFX0eX9ub+6sV9Ybu/wFMUuNfAg+DyXjXavcGKXDqunlSIbElhMRMwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689215; c=relaxed/simple;
	bh=FLH4UOlhP0XuIyXKEGuJCKhfxOxXp+A7HixQzLXYfe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ugVWT26lE+9U4rtz8z1MAvAkddVbLIB4n3bNIeGGa6XBNKVx47qvBR4FsJ/U6Tr8VgSxupq1QroPbCxNHp5/MaF+AbsejIey7kFsCVKjNlMXaqyG0alOpPCY8WdOWHwwF+kE3875vgME0fgPlaoR91Uwtu9txYRCBEhvDXMRwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXQNgmp7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXQNgmp7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6ea711805so823103185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738689213; x=1739294013; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dzBX4XdV95pWniSq9iIfYUH8asN48cH9PXocp5WLiiE=;
        b=PXQNgmp76wUNh5SLegPZCpyeerKbzuPPxt3YLYAo8prqc5k8DR0xYxHghD/oCWWI/P
         EtO+Zg/G/luAz1pB+5/CGaEGUc+6Cev+NHCE80PEr63xw89YL0cxw5qY3bAZN5/bG5Nm
         EbFz/fHSq/b8FFZRa3Beq7UGLEHthAWKX7cudbSN1oA3ooMY9i5MJuNyvvRj+FmPDETW
         T3zdvHzMu+Gz1I+QdNmz/rOB663CA8nNmi3HDCj5s42oqqdg329GxQ4mQ8fTPDlCzvCS
         vCPJm9g8Hr/F61ByH1oKLMBbHkOiVJ2ib2Ji0TUa6JacX8RwiiQk5XvYHJywDA2PPydT
         XzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689213; x=1739294013;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzBX4XdV95pWniSq9iIfYUH8asN48cH9PXocp5WLiiE=;
        b=du/yexYKII5lBTANc83eidhHw/5sjpBMedQjZQpg89/H/x7h/LQ1eUHxmAgwxcgvH8
         NzVZzzwGEuOXutSc0IZwKR63cEMGXxR+rbFXQmjfuSR/1z1+RprKgZ/VRQEqTGa+GdhF
         bBs7HfY1C/7yAcxJtBiE1pFyyLYc8++VLpGfoW3Qb/s4CANk4GxPRJy0+dyFrO/j6n65
         4hG7+tspqUGic9pFH4VAo4kdWVTdKH7oy57SwJdrde27q3N7NRKMvA0odmkS18/sliW1
         nadibKpbnfIYp21Imlr8toy5Gp8dxXnff8VlEye4/2lMPzxNCkl7zkRjJ70iZnwPghRV
         Mn7A==
X-Gm-Message-State: AOJu0YzI7H9AyXGOpSc3OIaSWc9DUUIr9YUnsn0oTiOPMrR0mqcDkdl0
	cXPaUoiqu3vUV2OV+A1i6GB/aAk2T1stCatyB8YM4Mh37EzSLLVOusNYWg==
X-Gm-Gg: ASbGncs2Q0FVc0nSyH+cpHQBASLos2kStqWGS4uujx10Mxi/o1ymMr2sThG0NwLNEmj
	AuwGIYs9Qajxvwu4sVWscDoJ0yQCLfZF0UxZ/XFjsD0CRatplm/kuYlAf64XwvTD+flRDObJ/i4
	WMjEIUNPJ+DQq/gLqTt+efCS/tH7nOCJVMsBooiJENl8KvCnO/o4wDsoGI/wwkmm05EQbszY0UL
	JBkIdoqZI4FB44arIePE3UITKKg1WUnd1H1EJhjFJ4IDIFEzbl7yAAqb460i3iIPPqe1FC1vZJP
	RllSMe9kpfxMMBdz2Zxu8aDk
X-Google-Smtp-Source: AGHT+IGeo7x26GwHPAWu9YgJz+u6Ls7z00UMivhrHP+tktwS74lbQt4ZT7xtwVSFCcT/tB7qQvFQ6A==
X-Received: by 2002:a05:620a:278e:b0:7be:8343:df2f with SMTP id af79cd13be357-7bffccc9b7bmr3783926085a.11.1738689212085;
        Tue, 04 Feb 2025 09:13:32 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d9697sm659269285a.55.2025.02.04.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:13:31 -0800 (PST)
Message-ID: <67a24abb.050a0220.3ba384.7560@mx.google.com>
Date: Tue, 04 Feb 2025 09:13:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7830079821858578952=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/2] mpris-proxy: Add mpris:artUrl support
In-Reply-To: <20250204154020.95539-1-frederic.danis@collabora.com>
References: <20250204154020.95539-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7830079821858578952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930485

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.64 seconds
BluezMake                     PASS      1494.27 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      158.02 seconds
CheckValgrind                 PASS      213.47 seconds
CheckSmatch                   PASS      269.90 seconds
bluezmakeextell               PASS      98.34 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      858.96 seconds

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


--===============7830079821858578952==--
