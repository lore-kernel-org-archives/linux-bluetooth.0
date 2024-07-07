Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1D2C87A
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jul 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720366487; cv=none; b=dBErY7Ro/1HmJ0sPyx2pk+ejumbK9AyG5ASdMEPKS0KbNvKUHHHl2r+GOlHQcqGzNxO+2/FL7D3uYZSez5qeQNFtTDM+0O2uzR99gPOdhdXRBN+93xFgWPvzyWN4z5S+pspdWb+YJqK+T1BiuGkVxFvcGmLwZ8AhuNtRT3KDq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720366487; c=relaxed/simple;
	bh=czWJwkPefVNXMNScEll/hiS+Y/fCUnZiUD2mhBCybe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sSsjSC9Kh3SiZpRnmPpl2RbY/U+pmqtVXFf207sqMIw1d/L78ClGaHD4ZgHkrlP+EyesPbda3rIvELJlcj1XvZfsUpeEVv0IDrjpjyN6BMxVEBHLnLfG1ypyjptg4cL/PK05ClFcLNqX/Z2eoI1CLDVi40oQc1WDdoACzSR3wIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFIR3JrK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFIR3JrK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-655fa53c64cso7081897b3.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2024 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720366485; x=1720971285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilk7L3bi2mh4SauLPMQbGC6+qQ/PCkc6MJhW3/7JoNA=;
        b=jFIR3JrKhW/GglvLxUaNpPPhcjN/m7HSQj+xmzBA1SQ6QCokmzDMM5fjF8ZhBVExsP
         V8J3AzgNtNyjCryxu+4Pcymtu1YlDyl6r1ZxLz23+jYYVUJigSnKu9LamiHYtharQYj/
         qx1HLJlBFVwO5kLkFBF98QTGo8AdQmnVwgTu8utvDWB4flexbjghRvMP/DtewYWvtFgJ
         zH7qAbRsWwsXjtnenz0INDJR1/eTRoYgJXgUt8Mv/bOZl0eD6ZkWVKQZLXyqrIzXldtB
         yTRINV0BFbrZ4OAOCdR0OJCBdP1MGpdi2KtcKBuyBQk6JChJVZmZsHPC31hKRXKiaYEx
         27TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720366485; x=1720971285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ilk7L3bi2mh4SauLPMQbGC6+qQ/PCkc6MJhW3/7JoNA=;
        b=vwr8fpnTo+ePfWhVFjnQZf7vZJJU+4QIx5iX1n1vONAZs+lNiU2/oZCobSjVF1oH0l
         6bulfnEVzTXRCg0byWunZj0T827ErJOQpdqZHXdrad+b0as+kBCaDNRgrk4b6ShuHWfs
         pOPE5zawIPK7yGXQwW0hn2U71wGRiu9lEp1WMHZv2qGACk8NdWyPiChATHB+3HebJG2U
         nksBVO55qv7oiWfJPgNMx+bydzbVCwMMWrNvGHi2fx6K94mjIjhUqDWG7AxoegW02d75
         OFmEl4B9Bfoh3s69nV3eCfQ38nUkdo49zwh0oK05W/R/xR6daupXmSwun9BbgSOxfQYy
         +htg==
X-Gm-Message-State: AOJu0YwdwKU1TPImzqrqlCH8RzAQE2wSZmCQSuiZJTUStGdaoLkGTBdz
	dGeF+JtOQJTLKR0O2fwIsDMKj1lQfUhsZlWKe2DFk8ubfb87jwIExvHBeA==
X-Google-Smtp-Source: AGHT+IFGNfrJKApV6rF8GPTkpHb98/seMviKAqUeeqwJqgxUWPhfUrv0eH5lUgTxjsClnuTuCFDiig==
X-Received: by 2002:a05:690c:f03:b0:64a:bd29:c5d8 with SMTP id 00721157ae682-652d718ecfamr104305337b3.2.1720366484753;
        Sun, 07 Jul 2024 08:34:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692ea2c1sm985470085a.95.2024.07.07.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 08:34:44 -0700 (PDT)
Message-ID: <668ab594.050a0220.62faa.4515@mx.google.com>
Date: Sun, 07 Jul 2024 08:34:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7442653096463254884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gudni.m.g@gmail.com
Subject: RE: [BlueZ,v2] client/player: fix incompatible pointer type
In-Reply-To: <20240707134641.2906295-1-gudni.m.g@gmail.com>
References: <20240707134641.2906295-1-gudni.m.g@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7442653096463254884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869076

---Test result---

Test Summary:
CheckPatch                    FAIL      0.56 seconds
GitLint                       PASS      0.44 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1618.93 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      175.72 seconds
CheckValgrind                 PASS      251.40 seconds
CheckSmatch                   PASS      353.51 seconds
bluezmakeextell               PASS      118.99 seconds
IncrementalBuild              PASS      1381.03 seconds
ScanBuild                     PASS      987.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] client/player: fix incompatible pointer type
WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#117: FILE: client/player.c:5150:
+			err = getpeername(transport->sk, (struct sockaddr *)&addr, &optlen);

/github/workspace/src/src/13726014.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13726014.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7442653096463254884==--
