Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D488146A79
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669812; cv=none; b=BtKvVKtJVHz6bjEPZc2ZRJU+TIcFrJPm2Qf+49Z27eK1NJ/8Hiqdt8Yr40z2RWnL0iyBPvJ67dgyJxU26GuDrd2W0wMZQp92+3Hko5QgcKuNGyiEq6ZrykXVuM5nswLD6LLkadA3UiMjlLJMrhNAIfGt/Z+yLXG/4GjY68ncLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669812; c=relaxed/simple;
	bh=9SHDjfbrdcIR9psivjtB7c7WTkVKm2ekcflac7BMVTM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cDyswuFWBhUYQpIIqLFCrwWa3X272tco0ctaqGLRk6/TGmtPJTST/q26DNjSYzPJd30KqmSPMDbGWjRFkHYRKpA8LEuS7GR8VdVXEgYH1EdcwErYhakAG2PUrGzOxs8LU9ICtW4oEiCmTLbfDE0pXrJy84UvSWiboZYUiOWVvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av5d5Sil; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av5d5Sil"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso39237436d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669810; x=1730274610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mE9V1FsbhFB4H/a2N6icMnUHi1jtQlFh6KSV6c1dhE=;
        b=av5d5SilAwzG5h1KpeWJ+toYFhk8V32DwQNWYnQ+XVkIEf/qjebYC6MucgOmB6hz+7
         vHzyOplMDwhrylQ/3bHCOT8LNxmKs3bYtJcOAVTalohoSjzV/HlHqDYI+M40vjGrgMsY
         it1/9fnUUbA3NJ5MOH5XEZFhqNatwaBbOd8V+4Ij61KhSqtRKHr3rMWx61eLzRggWuwE
         D+541sPqZr95uvdOONc/znoQ689UJwSJvMdR4nzASUA9dWcJsf0Blm2x75qddRb7R9bX
         JZ3UotD4e+XLd+DlcrUsamD4TSwISwYoBdBtsVBbLknUgtslT8tcz0MTFOnEv3+m0AjT
         lBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669810; x=1730274610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mE9V1FsbhFB4H/a2N6icMnUHi1jtQlFh6KSV6c1dhE=;
        b=EhqknC418LojvFIRLo6d5jmHtHuxKSNKZXORdwXryUjgxbgjSTNjr1bBqLqLb9aduP
         42lTkmPrmFQUOy618RURo431sgJoWMOSrBzRPddX9l/04Sw11KwaaUSVzm5X4TUwAy6j
         wMjUsctqpPdnDyWXzUXFMesRmR3u7smR5ZTivckP74Lh3GHlBT1xqq/LUcv77zcQc0ul
         0Z1DeU+OPgluGAhFsDsxsf+5qTFxgsiSym5me0U0/uLWm6JLYQ1ga/oRwcOcpos1QD+G
         2P5c6zTpnagw7yz+fR1R9AfsSkWdgNmxNTi4lQfvz/7t+s0erjPiQkPZHFkGOIywAcH+
         nsPA==
X-Gm-Message-State: AOJu0YxH/1FATZsJwA1xwUD7ABEr2QBvjZkF+iHesFgUqTS6VwOJHFCx
	7KKQRiTH7e3DnQZi4caPtfi7Fam0xNDpag/KaGJbhICK5hhr4ara4CVLgA==
X-Google-Smtp-Source: AGHT+IHXNVTujGmZJubqMxSXEGg2YzudGVxuKGCZlzu8vcRZ2Vsq/ODnpGwymCQhe7i1Ev+vQCR7jg==
X-Received: by 2002:a05:6214:3289:b0:6cc:8704:9bde with SMTP id 6a1803df08f44-6ce341a4b28mr19394906d6.24.1729669810116;
        Wed, 23 Oct 2024 00:50:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.84.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e32f9sm37208366d6.112.2024.10.23.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:50:09 -0700 (PDT)
Message-ID: <6718aab1.d40a0220.bd593.c155@mx.google.com>
Date: Wed, 23 Oct 2024 00:50:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3915149411288178132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v1] obexd: Add system bus support for obexd
In-Reply-To: <20241023061518.535790-1-quic_dgangire@quicinc.com>
References: <20241023061518.535790-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3915149411288178132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=902065

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.50 seconds
BluezMake                     PASS      1700.36 seconds
MakeCheck                     PASS      13.78 seconds
MakeDistcheck                 PASS      180.35 seconds
CheckValgrind                 PASS      252.38 seconds
CheckSmatch                   PASS      355.80 seconds
bluezmakeextell               PASS      120.79 seconds
IncrementalBuild              PASS      1497.61 seconds
ScanBuild                     PASS      1021.22 seconds



---
Regards,
Linux Bluetooth


--===============3915149411288178132==--
