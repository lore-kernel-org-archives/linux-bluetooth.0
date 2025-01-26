Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FDD78F39
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737918794; cv=none; b=mJKTl0maxgI8fdZCIZyxjckFeYuSNr/ZO/VTxjh0KZo1V/tsMcTHs7dbawgrOhA8QqpOGWd7IWKxlJcv5rI+W3QnfEJWBBBTneXg6rl6uaXuCrKERRakvpYADcA3SNNapKPOTmE8gP3YN9wHtfaUWGDeojA8r0c0MbdIfJIMf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737918794; c=relaxed/simple;
	bh=xqjP3sHHn+1tM7bqc79eTIuL5ixCy7yr7jMfKplFuh8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qJpDFNHnWsLGddrcE2dGBlUaMbf6TjHAxQA0H5qKkFJbmpW846R4bp7DMRni43TSOY5YTdL5SllcevDVOUQOd84GXy3XQsffiA7rzsr7oTmYYkSsEXNRLL7VC9UBMG01czkQtiBB8IiIEcV6dQFsTyZksFWjFtAc1WkCOH3BDNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYVjJh12; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVjJh12"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678cce3d60so39395581cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737918791; x=1738523591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3XFN97bpea5UMFQ5D3TbgyDCu0t08V11WgJ4f+NpaNM=;
        b=FYVjJh12MTZGTSRRaG7rvrsxuoxvo+jx5iIqnDpWqMWXt2vd7C2jpq0Y875E5wpjcl
         x/5t1V6E/PTp+MFZIYJZqYcInY9adtxSShAUeMcbB2Yejoa561W4rnOjcW2AJAV/3+KW
         mYB4OREGl4dgF0y++Xy7GvmwMWh4Mzvaoevxvs0X04HzHRkIfpBScKdxYXaU0lYBK5ch
         pps50GrC/EAMj2Al0fJS6UidwCsD+E76Xomr2dBvjmevpuXBWVYsc6zOJoCaURdNZaGD
         WUNMcVEhRl66rqzpNDG9ESEadWrN5Gctlh6qh+nPvxZbGd15WJHdJN94xCYXm8At3pxv
         6g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737918791; x=1738523591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XFN97bpea5UMFQ5D3TbgyDCu0t08V11WgJ4f+NpaNM=;
        b=h9zLfhri4lD3OAh7jZyIwtV6QG7N1VKqF7OdkeWhc+1uEWXQ5VOVAl7ldHBi7hR/67
         42wy2rKZWutw32c9Ec7eBIKjTzdVqbSaXiyxJ+zEgU2PyA21B36Y59IJXWEBr2/Z2hwB
         1vW3ocfynwWmvJOtEFX2fTvk3xewyQJjK/c9ZfTr4gkyef2p8a7aLgQjPnjtlDpWEIwU
         RkRSUSvIYWNz3ME8IMkAy7BrM7yCrWPMDnsNFEd4M2XvJ48+E+ruX2Xo6y7b3vi5k7Gj
         WkoUYV1DErpRDQAuz20Du7Oumf25MBu9apLplgS+GiQp0uuujvyvYAppl8fE/0PRwco1
         3TBA==
X-Gm-Message-State: AOJu0YwLTIxczXXdhNAAZc5/BtAw4Rr3GP3i6Dx2WjhypIO6RXhLmSkR
	RRuvko8dyvYPrEx6RmXrSZOgk7kTI+8ucvDYRbPXwHVPr0cfM1U+7qBnWg==
X-Gm-Gg: ASbGncu5NuKoafi5+BTl6BkBjRcRCZTuKcoovpfBedr5Mypad58YGSN9EmQUCs8TCxl
	h4kxenmhPXJqf5tSZ7JeRvFlYNmBmXr+CH5bSZIsUdHvW3tpscNwXgfS/IlHmK0jLS0UqMwyLvZ
	95nxnk72hPAjg2k6mGTLyPWjjNj1pWajEzKJcGFUidU2NSy1Z0/oc1QjpvCcyADImle5Hz3Tm8u
	DUP5kkEDMtrLe/69R3xlbGE+v3r80Zv3LSvwz5BC/cZmAGCzns7p8TN5p+C3Sic2mXkMGnOYh9Y
	m/2jqlrhvg==
X-Google-Smtp-Source: AGHT+IGoN2Ti065c1pKMAr/bRsTfrk25kW0bVIIZmNv6orIaGry2Jr9r5xjj7bSRfzVNARUNPfhaig==
X-Received: by 2002:a05:622a:4c:b0:467:83f1:71d9 with SMTP id d75a77b69052e-46e1286bcc9mr537894341cf.0.1737918791083;
        Sun, 26 Jan 2025 11:13:11 -0800 (PST)
Received: from [172.17.0.2] ([20.246.78.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525abcfsm27753586d6.60.2025.01.26.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 11:13:10 -0800 (PST)
Message-ID: <67968946.d40a0220.96e8c.b1f8@mx.google.com>
Date: Sun, 26 Jan 2025 11:13:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7267911960298024520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/vcp: have only one volume change in flight at a time
In-Reply-To: <5b7315d16822f8ec8b21ec124f82a1b90ab66ae8.1737913576.git.pav@iki.fi>
References: <5b7315d16822f8ec8b21ec124f82a1b90ab66ae8.1737913576.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7267911960298024520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928415

---Test result---

Test Summary:
CheckPatch                    PENDING   0.17 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      1520.29 seconds
MakeCheck                     PASS      13.25 seconds
MakeDistcheck                 PASS      158.56 seconds
CheckValgrind                 PASS      213.16 seconds
CheckSmatch                   PASS      270.08 seconds
bluezmakeextell               PASS      98.28 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      856.85 seconds

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


--===============7267911960298024520==--
