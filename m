Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA014C98
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746262203; cv=none; b=HnSiMVaW3cFlxrbaWxjS8cR69MduJyYBTO0FPps3Q6VVZwUuNzxyXDve/H4JHqeyyGRG+1WiX1+1ErjKaX/yJRyBjrOx7hRaV4Xvqj5eq9QOojmCK9lNavta5aI9R7PV2DxtDdE1my1I8EkFEInC2WVtfCDQXqoNGp65mKKlJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746262203; c=relaxed/simple;
	bh=HKDKu8L2pBiyvysu301tC8ZWPmA8ut1L2dAKwECaP7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mukGMIwJFsFEpDnKJE9puTf+x1766r6Bt0nQNgqDf4ZtcphY/ywHZdHk9wSSvmiUOaQPCAnOlImX/JWYI0sU69K2kVtqWpf5rDcjPlLiAUrM4KuqeBLdSktnvPGB5kcDydDCqcCRHKQXPs22b/Ai+5iq/YWylDZNG3xBD5gP348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di5P9bUK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di5P9bUK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4767e969b94so63825921cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 May 2025 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746262200; x=1746867000; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NNnH44nfOAW/Tax+au7skrn7duQmoHTJOK4q5MHxbG0=;
        b=Di5P9bUKQ+Cf2BHbMaa2WRdj3kO5MKj/ZzoVOPaHQEV/zK+u4Qkk2qcaDQ5ULNJYYt
         U9ZwbJzNR3HFK0ZL8OIE4KkjjiyBJeAf9AmNAKU32IXQbvr+2exrcdUAS9v1sANwbP7e
         DgxTwuY0qS3fko/aVC0KeV3oagZ5Y0SBlXYg6SOV/qKEgPioVN1ZnN4vlQxmC5tu3FW4
         0jJyvTJPSS3oB8ZxqOH6oqudHXhqg+98Vrncaslsa6ZqfLDKfHlakli+ZKpgaQZI9POn
         DhnAy+Z7YSoI3Tb2hQHa2WT/chSxopy3vwlBReQ4hdbrJZJISBy6HRtqu6WFiYEd8zsU
         1fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746262200; x=1746867000;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNnH44nfOAW/Tax+au7skrn7duQmoHTJOK4q5MHxbG0=;
        b=uVMsjTeWWOmiHQ/sxl+oH5AaFP1ViluCH+jpI0YcHkb9setdYU7C9GXNZ1CJIzNKS8
         kIt273Ai8AJ08+mi/sEd/VNFyyqRhKe6+QDIGxUUE2/Da2S/pymoObJeCwM84TomAoKW
         SqgW0MZk0Hs/AvueyyVlx2VU7l5CmWwvsUUzSE9gyVKTBVesdDapWXC8f4aYh+aLyJ6U
         R1Y8AmxecR4nl2bsGYUAcv7Gy9skT+Uw03HH5Uh0+8z+q2rDTt56ZOIAdFpQkuLl96nQ
         75gI8hmcSz4Bh/+35SMANTa4+b2UcphqTh2V5nmj2F/E1qM6RRfHKp5jIqMSl2hckdVS
         aUDg==
X-Gm-Message-State: AOJu0YzdVnKYg/Pg+8QiEfGD+VcfO6yN00z9Nm5ij7+va4iXS00+nt98
	rl0+MiSi54GvGFyH2KQ8DxwwUfVawa+zmswfjHqDTZlvciSWgLFyQTV2bQ==
X-Gm-Gg: ASbGncuviixxj5tN6u43MhpYV5K4v1zPWq5qm9ooE7mjlL7w/XZERmYsJub8MVoix3Y
	0yY6j/zMDNgi42p/h8qvVCk6JCSUkWJe4NduEPjtGmsA8Iq+3jiSpX+SmD1JQiYwgXk4+kG/sOd
	RxxXVK629GRY24YVHuXc7sjivZy3IiiCm+9fRbkK+bamV+h1oNrAtgQuzd9BWHizlQm7oZ2WN4K
	gY4JUeU4sed/+f0RfEt6WmUJq/CsVMTmPi/qiO+bXkuedLRswYavWX5kaRTpyAFpoRwamhBMD8F
	bOB7PC02yJlNPRt2Fe9EJPXkrKKGdd6E+oYSFAzMOmnNrw==
X-Google-Smtp-Source: AGHT+IHVqfTAVNjMONQpVVqh26bMLP6LOJj2tnjBG1jsjDVD5AAShtDSVwIeR+5boiFrPmjreEGQTg==
X-Received: by 2002:ac8:59cc:0:b0:479:1a3f:f1f0 with SMTP id d75a77b69052e-48e00e67e71mr4417021cf.41.1746262200674;
        Sat, 03 May 2025 01:50:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48b96bd11ccsm29676071cf.40.2025.05.03.01.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 01:50:00 -0700 (PDT)
Message-ID: <6815d8b8.050a0220.cb31e.163a@mx.google.com>
Date: Sat, 03 May 2025 01:50:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7926001589493267915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v4,1/2] org.bluez.Media: add SupportedFeatures
In-Reply-To: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
References: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7926001589493267915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959306

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      2626.66 seconds
MakeCheck                     PASS      19.91 seconds
MakeDistcheck                 PASS      198.02 seconds
CheckValgrind                 PASS      279.34 seconds
CheckSmatch                   PASS      308.92 seconds
bluezmakeextell               PASS      131.38 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      913.02 seconds

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


--===============7926001589493267915==--
