Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF26745E2
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963233; cv=none; b=eCfXNRDDqClpxmbeR83EfrTIWl1MbBDPSWXQbM24ECgXykQWNDbFjmusKDr+r6naIn6AgZ3cVFRQstXbcjOt/ohkSWoXZyKJm+eW/OD76VUXfCM4te9W0xFgUpUpPqApYFyfqRwl51YhlHP9pT4Trm6S0TJ14V44kzzJqPYa+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963233; c=relaxed/simple;
	bh=3pGRc9EwOAdV5YImt2Weouw1Hz71daGwYOMIwCoOB3Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qYaemsQmNr5cgU8Z5MYjlqUzUlRGYI0t1rvwC9r023uJm2TBv77RBfLXNBUUacHC2ceywv1xjbOln/PWNc239CNUJGh5h2q9vO6rKpyrsus7vF7G4Z7vE93KFo7MGoAWDPCseC8/PqqgjxA892jq5TwbOPaMJkYOu+CZzsDWl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlI2nqRX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlI2nqRX"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso1327440a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718963231; x=1719568031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/edxaWrQa1dIi04VDAUtkaLmsqlE97LW9ZovnTv3jcY=;
        b=XlI2nqRX97VutBJ67m0yoiGvUhkCPpsv7IroIJjxQxcU2zisKqCWEpTd2stOVE5r7y
         auCsK50/XI66Hi+hnwwSIQ/682c++ijwxDUD7HCDkWLCco+gEpcONvFT0lTzHuy5jtpD
         UmqYIO+MjXhv7OB8sBs2TF9jK/Rwi0ik/64J1jt5omcJjR2nv/DqdoWdFqKbiyuZNlNz
         vSawp1bkoqBVJbzJMFNE9p/6G2+NEbuseC+iFftFLG7dPcXU3GigawFJiVuvFa1jQf+9
         N+RwTyR5osBk4TL7xNAEK/S/zDipGFpOb7prrzK9FyFokb4/oi32sUti+YR5zJ5TvrJ6
         OrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963231; x=1719568031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/edxaWrQa1dIi04VDAUtkaLmsqlE97LW9ZovnTv3jcY=;
        b=TKrtEdoycT6c27CmE3EbVG9DrSTKV6SRR+KNnCeEtOnqFmU8rzjoC2qWjp4yxgwlbU
         Ptx4WN6uTiUfkq3Bi6NC8hq5FcsEvkuaZ9H/fBlZSdOi9sbIuT60a0JtmzEVE9wlusvE
         xXmAb27J85kb1592uCJ81Dwycrx8jYkqxQhCS2de9Bwp5HGKzypiYpgVexxF7pVQKL3C
         0aUcIK0/gFiPRJlg76193td0WKopD/8ipzIwgG/pZfNSe/6G+1kcIN0kBsyX6K7i4cJh
         WvahOEvkkEWHaUYUUDZ3aQ2zYybJKDokZxpbdzX865d93NM1ZOV8AzX260LHe4MEWbFH
         7NTA==
X-Gm-Message-State: AOJu0YzG+F5kmqQSPSkwuRqyERroH1Fd1fnysugozLQxyqRP7hIgHtSw
	gc72vbRvqMrgEiepHsfPad0BMEwHtbMzcoSUoWVEXOcVk18gvGyGu+X6fw==
X-Google-Smtp-Source: AGHT+IHi13rATloBM62M/YVG9zOK5FtI8C7J2RGq8UrqzUBaXLsnuRl8OVKhzg7EZJsWh+n8VAehYQ==
X-Received: by 2002:a05:6a20:4d92:b0:1b8:1be8:7ff5 with SMTP id adf61e73a8af0-1bcbb5cf159mr7393734637.50.1718963231295;
        Fri, 21 Jun 2024 02:47:11 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.14.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a8e466sm1146457a91.32.2024.06.21.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:47:10 -0700 (PDT)
Message-ID: <66754c1e.170a0220.b0b9.29a1@mx.google.com>
Date: Fri, 21 Jun 2024 02:47:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2627820821144695390=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: Fix null pointer dereference in util_ltv_foreach
In-Reply-To: <20240621075517.22576-2-sarveshwar.bajaj@nxp.com>
References: <20240621075517.22576-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2627820821144695390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=864176

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      25.08 seconds
BluezMake                     PASS      1747.58 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      186.33 seconds
CheckValgrind                 PASS      260.03 seconds
CheckSmatch                   PASS      358.23 seconds
bluezmakeextell               PASS      122.82 seconds
IncrementalBuild              PASS      1511.84 seconds
ScanBuild                     PASS      1065.48 seconds



---
Regards,
Linux Bluetooth


--===============2627820821144695390==--
