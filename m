Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628A2DC760
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029063; cv=none; b=QN/ICy45tLeNWcDGCefyElPAs1PC985FymFfiIqlabdeHZwuTl9vcaqT4dlKlL8LtHuA+Rfrh4ZxsaRuzroVRk0fFkH2sQyyxXx6omIO6Ubgk/7YoU7mOZHCFj3ycX9/SVVsUppEs8v5wv1DNWKz1cKMhRUz6WF+wefRfQXojf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029063; c=relaxed/simple;
	bh=AimL4rfg/eSuhGZ3wjEPe9HpKq7TKT4u+/2ENF/QFBc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M2Ars/87Mn5QyTeYBtcJ8ZCXUlUBL8WAgK2Ve9xdzx9Fnji/G6P29WFlv4FYqWuPFWB2Ujp5XVlx8CwlJOOPm5va5HWMFtFkkH0VMiNmJx1kLvnKa8M4vLdpCHz5LgXYSMOIo2HBM3LBREVMLQ0vL8AsDPtidDDnoh9yQXWlg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUq9rYIP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUq9rYIP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c542ffec37so891870685a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029060; x=1746633860; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2RWBjJK9ifS/KJOePxF/lId3jtbqCH9464jlt+4GSlE=;
        b=mUq9rYIP9POF5vdlwe3xJDS8lLVUpUS/lKh87WLjU5lk4j7isib3d+WsJgBJCmzCn+
         SpUGTHI9uiD6ydtspu/FdMTS0u2xEQ9XLsz/l0E0GNGSfG4FhLSPOFS02dwRLrL6R9Gt
         vjXgmxHCPcvJMFRF0DsY/rTIohDXHVviTkyLVylIS3MPiorQ8kDnu1FX3RFEDz+NghYO
         V8XHLY5qhrsaiN4RpPiMoK1Z2Ypxu0VTXCmSyU135j+St1FCajs26gS7dfzOkSBSvCWN
         6AhbfBje5KHHo0lbA6o0bjHTbbKOMhq6npKnKfv4P6jH9vzUvB9mUo7Mge3Brzx20OIF
         LLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029060; x=1746633860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RWBjJK9ifS/KJOePxF/lId3jtbqCH9464jlt+4GSlE=;
        b=VBYFzX+St5Nc/oMkxzP2Yt4KtWpI/nPUdVGbzW/qUW2puN7/6668DYlCIuGuuSLKnf
         1CGiKKsGMgbdn0Erb4lVrvpxiI2p5CH02BOM85l0idfmqTB6uahWZ8MJScljjWgeS5hL
         n8ekpQsLT2/YBfFzBWrEBUCyLQ/hkqJuEsrd2ROud4hUjkEHntlKg62YkB8tt6STd0X+
         6De9Zn/UbJPyjoM2x2wmfXTS6Wdg2/YAH8Hr1WJKk7FS9/rwT4mm6fQ4WNXmHapl3vLK
         LiB03empH9/Sgmd7uc4sYSzjlVs8avZOZpuqGgVwkNxMTaZxzOEaZ+UMsYui/0Fofklt
         y44Q==
X-Gm-Message-State: AOJu0YwcMmML0TtZvC3XWuLsTfDRWzqOoKaDo83FdEBF+t1tWlwMBtAM
	y4B4LDcfonLTEUjEzXilKZukYsNk3UPoPibJ5Jf5Dr9JbIMWLy5Uy/mMHQ==
X-Gm-Gg: ASbGnct/JYBHciWapGctZwwGiItjg8UaRblZl9W8g/PInI1z+eUYM/eHH4n13lgxmKu
	gCm4MmGFMzkDIfw4N+mnOgaggAm0p3tNNq0PFyNFqXjrVJ+/zz00SCPZolJcX6apWFkyKS5b2EY
	pbpisPhFWW6+2+lgxA+YGQnPb0/laprERq7gyTxv4oJ3X5jf086jGCgAIrEKVUz5He4diAohxNm
	I5vtxDoNfDhJWWkT2Wy0FRCYxh8L48nOUbZuP7geWFaduVQ+4HcIPaU9PZ1iboTA1UhtjbtOBkP
	UPTX+C1uctdVl4SILOWdipdvMA+pfNjxFeZcJWJ/TgP2t10RzYfiEPvh
X-Google-Smtp-Source: AGHT+IHfGYO+3fJ1TA9lEhWIMDp1NkLZ3fT+xVGAdMOdSg7iePD3xXlo+0KLYpQCpcNFydko34RaDg==
X-Received: by 2002:a05:620a:2801:b0:7c5:a5cc:bcb9 with SMTP id af79cd13be357-7cac76d6e69mr545822285a.56.1746029060216;
        Wed, 30 Apr 2025 09:04:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbe651sm868827285a.47.2025.04.30.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:04:19 -0700 (PDT)
Message-ID: <68124a03.050a0220.1a9d62.c8ff@mx.google.com>
Date: Wed, 30 Apr 2025 09:04:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7823024712760563050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thomas.perale@mind.be
Subject: RE: fix build error with --enable-hid and --enable-hog options
In-Reply-To: <20250430143610.387300-2-thomas.perale@mind.be>
References: <20250430143610.387300-2-thomas.perale@mind.be>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7823024712760563050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958549

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      2747.95 seconds
MakeCheck                     PASS      20.77 seconds
MakeDistcheck                 PASS      202.64 seconds
CheckValgrind                 PASS      281.15 seconds
CheckSmatch                   PASS      310.47 seconds
bluezmakeextell               PASS      130.71 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      927.24 seconds

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


--===============7823024712760563050==--
