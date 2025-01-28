Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39A25A641
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070608; cv=none; b=qT+06pTKJ1wczhdR8CLfIiPSnHSPtBMYQ5xhbFV6co9LYNKtU9rEhXhshIWqVBOIyLBic6TVuXLqHc/7shUeqUiQtekf2RA61LAzUZb6r9sQz2V8g0VmS3jGIEcvOG0Jo+cgNQoptD8I5oBvjUxcDqHItCc0+6jiV89F06TR7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070608; c=relaxed/simple;
	bh=3+FN/4HhBUaDJvI+IQPVCDl2kQzSARBis2pNz00b/7Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S1loHTQbg3UwwwOqSLyjAXgavUfGWlZS9visInGGIC4qIsSTZ0cPofCGoy0MvpLvW5tXDv9zzWZYJ8L51KxVoWECFNK1k/G4/N7uiUkjJ8aoT32EfHucY+egX9R8iCaWXUEqrG9h9tMAh5Zu9mNBO8gM6n+cmWci2S1FivqNM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi8yqCgs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi8yqCgs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216426b0865so92347525ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738070606; x=1738675406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WSljmPKgXPYeKGQhcbVdXIKsEilfZJnbqXWAPTqepQ8=;
        b=Fi8yqCgsYDJV6MWUJJ1HizEpyqnMXGouj2vjfxW4GZai/WQv/AnWdosJVz7AiNmvAc
         3l+iOCo8HWx5Kk9tXCCQQl1kTXxAYGWASGertfa1FB32NFYIIm+a28ZLP5DXRg5f+7zv
         52eWRFdtmRhGuuQU7M0bFpLY74169rWapOdSWft1Wt7pdPWaI+ZItwJwpvCmpm0OgLP4
         MOK4klD/FWO+GNj0Tq2gt/K5I7myA7PlGky4TxaPIHVrvjjDys0+YMDdzsM8awGebK/o
         yuH1r3lpNPaPdH9aXR5tFPCJB+Ka77+t5+Z8W43cqBX1wbpLc9j+hQKQy7ITvjXsxv/W
         uNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738070606; x=1738675406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSljmPKgXPYeKGQhcbVdXIKsEilfZJnbqXWAPTqepQ8=;
        b=B1JCw1Ffk0jyRuQcgq+iIXmwABArN5nrD3zWJG67MXGtbwZCnLmSSeDsNDQsVD/R/W
         PgEiTedoMxaq/QoIm92JZWkNiCY5slZqnNexVpJa51TrmpWf9aFsrJAEEiotDvHcbhvz
         81OH7LmsH2M7LhDw3HZpycE7uYo2RsE32CbkQkkBLLPN+72WWkrYVAEFxCjtrMKTVS9A
         VSEQqZKDphRSiBCPw2tvG2/X421AFHqzKKxTkLpMMtDAnEVOgd3/neFnTlxL2/7KXr8E
         gZXhNIXvKNjHEyXvpb6cpb+RiFSxuN35Il03qYT9kHiDPz68Zt5gI2b+2HvxMsxut4uh
         qFzA==
X-Gm-Message-State: AOJu0YwXlo9OR581qxGqeLPraeGFjY0Z0HPWJZBG+/Fctb9EaErxedyF
	yUTM8wYu/5n02i1eob9QwrX+vSnL3GH/AXMnefcp4qiA8JPG9jut9yXTzVuu
X-Gm-Gg: ASbGncuG2gcpCeS0OU9/J/+YF/gJnhrgXhameRpSwYHRk0khlkdicCuhJlkBGb3WLLu
	w5hom2zhSedstsf6P5PerQPqZrUn4LqcVZyWp4qH8xIsw7deaVjn9M5bqsdInhYRDDm22x5UNqI
	pS+cav5uwynjAcmHbRVz7IPETMqF4bglP6uqtBRJsQ71n4hwqORAwVyXdivKEYNsn36zLd1ILXS
	ID5CeqbSOclFjRT0hnyY37TWzv0oKQgEKcIyB5qdek4K1Cz9xNTipyhpXUpsw0PTFXOA1q0YLlU
	T1++FJPSsyJuCTdzn+RaHA==
X-Google-Smtp-Source: AGHT+IHBSP3pD7dyiuoA3OzKqUi8crKymD/07uoOmVI+1FCyFYCyaLHjYCUbFcbDBj7OcmOG2fYJIg==
X-Received: by 2002:a17:902:f791:b0:216:5294:619b with SMTP id d9443c01a7336-21c355f6c65mr609713705ad.47.1738070605954;
        Tue, 28 Jan 2025 05:23:25 -0800 (PST)
Received: from [172.17.0.2] ([52.234.41.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424d562sm79868015ad.230.2025.01.28.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:23:25 -0800 (PST)
Message-ID: <6798da4d.170a0220.2dbc9b.8e2e@mx.google.com>
Date: Tue, 28 Jan 2025 05:23:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0298136615615383322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: [BlueZ,v2] device: Clear pending_flags on error
In-Reply-To: <20250128115659.23655-1-ludovico.denittis@collabora.com>
References: <20250128115659.23655-1-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0298136615615383322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928815

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      1497.09 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      157.10 seconds
CheckValgrind                 PASS      211.54 seconds
CheckSmatch                   PASS      269.38 seconds
bluezmakeextell               PASS      97.18 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      853.18 seconds

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


--===============0298136615615383322==--
