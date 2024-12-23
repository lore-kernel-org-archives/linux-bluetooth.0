Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1B1917D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957037; cv=none; b=ayjCqNA3cKGIr4Ahb48JSb2pBBJw53v5ByalQwxwGwqC8dCpHIBmklRv9QBfeByRNzjff2bSm0t0XKTo9Gbu2ktQDb8Hl+fxS5R4ZYM3HcGNWqjUdt1RHIc6UCOHSkE6aBlFgu1AbUy5crNpg+C3h8N/yxtSBqd85Rwe+QdGfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957037; c=relaxed/simple;
	bh=wNbk9nkJTs0fMewmObN6M1Xokzc7V2ded/17hydAH60=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NKFy/99tj044XC7c2iWyD2mqUWYTN3VXFhM/LZnwKorUuPKg6KE7/OmtmtqC8M44e3fsCDy1a7plO28ekAT7QXJ4jAZEFIqN+12o4VsgM02evQDpJ4ArIEqkYL89QjAEKHDlqArp67JnR8fJfAIVN7WE0jGNFP7oY++ufltj2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqYw0cii; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqYw0cii"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216728b1836so31882025ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734957035; x=1735561835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gsy5T6kNSJXeEv8IvDs1KZzVF3k1fu2Jpo0BGQuV7Q8=;
        b=JqYw0ciiXJfqRFVwTNqm/FpbBMXQymvIlHCqN22QjfwwGDWaf2sVERbSp9OISvR1aa
         NoTIa87s58hwpJGZ0gsH7uMoLb1AegHmm4pn/HmlZPpWeOEbSBVLZX+jXJFuDJqGJwMx
         a4m6Nafkw/PWf8cHBs9jU0iK5bzGOan4Y8/NbG5/ZUBiiPioKno1h0r+qS0wsn45pDoQ
         eZMwJFLnPMYL5i2QUofPLnDgSyVGiIer2KDAFwc6Biv6U1vzfnYu8CSBT35hm51Tveas
         yLgF9HFG+ogMngEgu8om1dw7ZNlw+cGmldr12OPIz7qK991gapJr+8ZQYhvl7pyE7RgW
         zI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734957035; x=1735561835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsy5T6kNSJXeEv8IvDs1KZzVF3k1fu2Jpo0BGQuV7Q8=;
        b=HF2kOQW069CBfe+rp+WelXxFASxbGyAFmxP74NLb3hwo2lexeo2HdS+9TzpGNRHSOR
         vxIsUdW/XGAaFW3MrsEVMIGqbntkaJrRRtb8G2x2AlILh2Rv8sWs5Z39JrNKKyvXTeEV
         0bve8D5CPkNtYsPlCjyA/h2kP/z20bRtWV7pIpSn8tuEHTQU4Ps0wMmaYpxNbmu4XVnn
         9QRiouA0fjPSfp0TbnQQVb9oe4cKMRrtX855qet5XRh9lJ6PD819hcOgSnCDCL4jop1p
         6wLas8KnaBZsr8p+5vsVPuBCiEnItPklPlMT4qwdNuKQVroDaxFe/6UteyBPkNNbg+Yk
         0q6w==
X-Gm-Message-State: AOJu0YwCXgx+BfygFgbpCr/1GXA/wbV/Z++6xZLT9LreQDEW/RbHSUFK
	lRXX2WNNlFL29wHSZziDyLiy3na4Zhuu05GBalXerfWOHbbBrj6/L5KNfQ==
X-Gm-Gg: ASbGnctPmPIoyVhbMOjs6CcfolmlMYNr/TMP1HXbRa5qA6g+yqGL1VLhKK+rv+ZQr7z
	rZcXaFK4YYUEsEVAeneBd7fV78wJQBbRP0+DpdQy8k4yrj5UUfQpGSDsVeBrMbeViyWgKev7L/5
	qIvgU3QAF75jHA9TjEB8/fi0FDirQo5pH8XFjY8E5H+JYixpmz2jl77GYaJx4i/Yr2U/ogQ+JAl
	XYQ/W6Oh3K+EmiRP2pBmxyah107Kv3X59Ue4P0ci7lKLZjvEOxehp//S/ur7w==
X-Google-Smtp-Source: AGHT+IFRk3cOSXiDUGw3iZJ5hEHi4ZOnUG8geC/Jgx25LgTT0C5RHeL4zzj1XBzg380Ogsx0v0sUuw==
X-Received: by 2002:a17:903:2287:b0:216:682f:175 with SMTP id d9443c01a7336-219e6f42c4dmr186947095ad.49.1734957035314;
        Mon, 23 Dec 2024 04:30:35 -0800 (PST)
Received: from [172.17.0.2] ([52.234.40.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6156sm70170705ad.209.2024.12.23.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 04:30:34 -0800 (PST)
Message-ID: <676957ea.170a0220.284bee.198d@mx.google.com>
Date: Mon, 23 Dec 2024 04:30:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1311066956250938596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v3] Doc: Obex Implement support for message listing format version 1.1
In-Reply-To: <20241223112041.2657934-1-quic_amisjain@quicinc.com>
References: <20241223112041.2657934-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1311066956250938596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920391

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      1539.93 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      158.30 seconds
CheckValgrind                 PASS      214.24 seconds
CheckSmatch                   PASS      271.89 seconds
bluezmakeextell               PASS      98.70 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      841.35 seconds

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


--===============1311066956250938596==--
