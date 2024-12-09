Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52D14B97E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764582; cv=none; b=ad1YYFvLoaiemfuiJdn1p+fkDuJsUsKp2veOBp+8ZwjjQVOK1qErX2kpZf+qOMEn4qCtR8NB+tsryW3nA2J/hTmTqt79HLC1E2ANS7GcAF9x5f1tgfkD+HRnNcqgsxo6GTE+2fy7qcSX8e4DsRKoVhVHuHK5bxOb75XQRxc19eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764582; c=relaxed/simple;
	bh=A7fslpTnpdpOg/tlmHgsNC22kQzbNKoguda4VIKvJLI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R4CKQcwWS7nvqLMj8TCXI/nWlAv3oCTHFpYQhW03VdncwyWGZjYCJxAC501oow5vK+86Y/DLmYUyJuCsm1LHVbmeJvyqN89ueS6VNgCpD/xd6v60ZYh7XgMjl2g7gRiBBtTEukZ1VhkLxJ5/K7VdcNWtU2Ormxk7swM9lQpsXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+u1aWGx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+u1aWGx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6d24069b2so113649585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733764579; x=1734369379; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B5PRp2r/85sNdDq9Hkfks/7ekNiMeQNdIML4ldNmOrU=;
        b=c+u1aWGxGFZ8TImpp9W0OoJ8NTzOKggMBvpdnEfTlK8qwhFyQLAWihuvRK1yhHt2dz
         pkukj0mZYPa51UYXJg0fGp1CyKW0Y5wf3+i93lli9HYEZyFJd+xn/BWH3P0ZWsUKIbMJ
         uJHNdeCnv7q+vr4qxOSJ2atJpm9dwyGWjXqD5HshZUZZvdzft52jjzQRJVd8K1NPqF+i
         sBWfoI5zu1d4hYueetKGFCdVIx4HCnAUC6ptsNbz2hVIK/DmYrmzoegavWNoczz1nvA/
         gKl9RKdb/RuaTbeem4jorYtvORV6Pa68AM3/hbzp2ARiXkQwAl6FtaeNIN9uWvZArs1s
         aYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764579; x=1734369379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5PRp2r/85sNdDq9Hkfks/7ekNiMeQNdIML4ldNmOrU=;
        b=peNisZcSZFJoFT19EcB42Qa8y1258jdMkU9s9M0/Rfyfl7sGF/0IpnIVQKiO2bQ9ig
         nJQHGiM1LaJRAitHp1h7MBb3xLii1m0ANQWznxGoL7wI3sotH+xXKpKKU6BF+iRT605Y
         VC8Id+LamCIlzgTEVmbDLGqW4D3V+rrjFw/Yl6ivf5nBT8E9WwPnA352WkHvF6+yXL+G
         6uRio9M3GFAC2IOM1518Wi9YP65FHId5qctT438OY34SMLzmxAaag6Me9PA7BR3c3edf
         ADTCx2mPD0e8/t4u00+nZuSzA5h7Hgvqm+mBA2z8wpzsk4KhrAdbtDi/m31RrEBLCcMi
         eU8Q==
X-Gm-Message-State: AOJu0YzknLkJUl8sv5P1PPxA4nXiqzzjkC03ENZWf4NIodt6dYQbpL79
	K88wg6TJ+OQT1eo6OuV8ZAaT7EaPzP0rA5/0IxfHQQ6Y00D3VLrkrrA9aw==
X-Gm-Gg: ASbGncvt+lXxVed70/52+PelSE+FYTERQFrHN818K5wS1fv7nZJYrr/OWVLRwt1RDRr
	4JuWH/6j3Yv2OFOSggVSPy3MtcYhu1dw1rdKcvq4IMjYF1FECLJ3pLGuj5UKPwEMORIcIVibpg0
	QQR/tAWHAPrU3GNtUME7FcNtimUBy7QTA+MRlHBZxxdSZ+9O0MpjtsqgbLCv2pyS+oQpYrt1pTC
	S7jLHa4r8TbOB3L/dNjv8VyRU/WU8pRw/CGD/7Iax4+8uMUauDbszPmInY=
X-Google-Smtp-Source: AGHT+IHHce1mmutei0bbbrVZPXY3dKQAS2e0yGyTopA4KdVrDtMnX6AvNm7k/h0WqTCD8tYr7+dLbw==
X-Received: by 2002:a05:620a:2618:b0:7b1:12f5:7af5 with SMTP id af79cd13be357-7b6dcdd0b44mr159791085a.3.1733764579404;
        Mon, 09 Dec 2024 09:16:19 -0800 (PST)
Received: from [172.17.0.2] ([172.183.154.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6da48fb2asm60990985a.17.2024.12.09.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:16:18 -0800 (PST)
Message-ID: <675725e2.050a0220.3b9aca.2eb6@mx.google.com>
Date: Mon, 09 Dec 2024 09:16:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5508995201687658684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fiona.klute@gmx.de
Subject: RE: [BlueZ,v2] Leave config files writable for owner
In-Reply-To: <20241209154043.105358-1-fiona.klute@gmx.de>
References: <20241209154043.105358-1-fiona.klute@gmx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5508995201687658684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=916026

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      1567.34 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      157.37 seconds
CheckValgrind                 PASS      211.81 seconds
CheckSmatch                   PASS      270.84 seconds
bluezmakeextell               PASS      98.32 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      844.36 seconds

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


--===============5508995201687658684==--
