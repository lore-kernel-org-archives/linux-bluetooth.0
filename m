Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114D25CC79
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127962; cv=none; b=gRlByXwwth4XZi8mQekjtMCeoNyM1XysWrChzoxHsK6NGQT9fHk3Up53OLIfaUSBvviNWFPrjvPmwg3dX12O0ZoPaolhceFilFdNmCrxpr6vyG2wRJyQgOfGL7Ol3X2JyBuSeerD+eyRkab76uNA+BK27SrtIAtxp7BRZ6yJVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127962; c=relaxed/simple;
	bh=tNnvR9e+3EL15N5t/wVziXRvuc66NRBbFVjTW71zRBM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i8gW1KrI+oB9xgohxpEZdxV0ocwBwdgcrVUoQMSWebbrxQ/xw1x/VbIois51SwUbDDVpTeFC+8357zca5AU6T5f07aLOfm2iULnP7Z9+hwAqEP6Ztdb16Vj+qMqYTN3TcGnI47ZMeYJVx3/QUkOSUEzETuqsGzV9T7bU/P/p8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXioRPuf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXioRPuf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed66b5abf7so33495811cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763127959; x=1763732759; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RAz+q2UVgKWzju16RjSIbiRNVqoocwERCOEYZitkmkU=;
        b=HXioRPuf4S51g2vaMBJrB/A0uh+K2akqnzNpXagmgWDiue7mfs933WZGH3+iXB3yiQ
         0IskTNR98k2rb9NuiEmRVhImzVLNyaR4YFXjmnYvhumTU3t3WdWk0UaTieFKpqkqM8ok
         3hbnKAhtzIJYmeGq8ATohpAUs7NkniBF+qtlKFTxf0Z8+gmYiC2RD6rJRRw86tKUA7nd
         G2bmvD80ri1v0C/u1TLCqhzKM8DVZcN4lbYou6TZMp9R2JEucuUm9crZFn8CFWAsF97J
         rHGgcVCbWdZibhZ6UjYU6hoEKoZ1U7RZ7U/wj7IWyji6iTKKGeXeyr/wuFMubtSVt8xm
         TUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763127959; x=1763732759;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAz+q2UVgKWzju16RjSIbiRNVqoocwERCOEYZitkmkU=;
        b=TSHPjPxguWbj7ywIgRNW87r07jWj3un02wS9ruOP2gtnHOnn2FUmSlXSXLLv6pcemE
         Xxr1wFh6speBqVTGDMdK6THHCZnSc/1HPvBayE3hRx0tZwZphUzikEoPtBy7y6kG4CcU
         POQq5hmPGJRtgLWaIz4Qk7IAea8F2yNWgDKM0fhQcfimiV5QMSEohgNzVPpT/ZT/f8Cz
         OLYKZW4KQES623/1R9UpikGP5fwiGF1vY1ds4KPD12KwaeHc/zrood8Ai8G6kYaEliaV
         Wdn7Qba1qaxAOZC29LGGBRQXcjjGZbUffyJzczkoBNzv9qqMzSWoXuNRgJN6eT1BuZrd
         0QxQ==
X-Gm-Message-State: AOJu0Yz5mak0CF0Znut9vc+jU7GTbEqfoCvyzg0Psy9Qhq7Dilym+Cpg
	sfRtcaoFtTrqGymzHgFzbT4V+6yHAJePy2woK8LVv3trbSnCt+Wlm6XlPInvew==
X-Gm-Gg: ASbGncuniQ2qXisR6Vj0a6T3Mei904/kxxx8duee9zX51yk975dRBDn9ds+gCptRun9
	i4Ksec3ZevRUu7AvxIv0UgJ/Xs1HWAqU+QdMxAdg9ciBe3CthT7OufWl/uaCOqkuzNoT+kPZxQh
	qDG+sLGPlWnTXkwuuL1RrD0qWVi1/B123pcPCCuAqG+5H8lF4f6T407AoidhDIyXCIZhJuzlf/d
	1IUZyMbj2S85y5KhP9YW5cjyxucmLlyasKFdcvEA+Hhfp3sgYt6LRKO0OjknqJg/0+CziFlIQDj
	Ob7N6hF3PsQu8Nb/sZQsbKvzEc3mNzP1BWUWeCUCfTE5xfXwMG8XvKD/FocT1csCp318wDxQXQG
	D86aDkBythxcU2l9CecKpLA6anVqY/V8h1gVzvKdiGfBs3e2J5XNB8w0BukCxhU+wsop++KKdoo
	hfN+7q
X-Google-Smtp-Source: AGHT+IHzdVakh1PK015/wAO4tkovGbvWEi1hMu7GTus4j0w6ilcb7ODISirPk0b/VHdN1Kf3MuYYew==
X-Received: by 2002:a05:622a:f:b0:4ed:ac88:3142 with SMTP id d75a77b69052e-4edf1f4e9e9mr49317881cf.0.1763127959066;
        Fri, 14 Nov 2025 05:45:59 -0800 (PST)
Received: from [172.17.0.2] ([48.214.55.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3adesm28503741cf.1.2025.11.14.05.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:45:58 -0800 (PST)
Message-ID: <69173296.c80a0220.30f9e2.7a79@mx.google.com>
Date: Fri, 14 Nov 2025 05:45:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7128119754372190595=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v7,1/2] shared/battery: improve the display of the charge level
In-Reply-To: <20251114121140.102190-1-r.smirnov@omp.ru>
References: <20251114121140.102190-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7128119754372190595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023520

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2633.84 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      185.97 seconds
CheckValgrind                 PASS      238.31 seconds
CheckSmatch                   PASS      311.05 seconds
bluezmakeextell               PASS      128.73 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      912.27 seconds

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


--===============7128119754372190595==--
