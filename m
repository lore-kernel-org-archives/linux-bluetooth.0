Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491B233707
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400337; cv=none; b=DGxNASmTgYzPy520alB+MH4S0RmRSNbkIXdlLaeY5X0sNMYFJMckvGCtWFoRzILzTJhwp3ax+t9rJa8uw+eBosDUv440OBwufQoCTqpimvXwanpTdDb2XdD8UlYOD6CCE1kbivm7QhCWKMI0vYu3O2h+DuSXnJvHcLvOzjPLwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400337; c=relaxed/simple;
	bh=nmYQ8F0sA3GHW0qT29ZdeFCZtXY5lh22ooZ1xe5nw9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eHcc47WFNJw2X40CQV7iHBpw5frCEqCMe9WgW3r0WzUj6zxh/O/ewQx3E5+Adw+Fj5c2yOcRapeP/o4GnY8dDEN8FTISOwSml0yz0Mz6oPFD2+RpH42cCiYbh8z9GY/mf+35PpPtiJO9dZnCGsVHynTpY5GeEdXybAtIhvjzRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzSh+9bF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzSh+9bF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22101839807so90936175ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 04:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400335; x=1741005135; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plyghipLnASJmEq44NILSv4euDkriedQTEtFCj1xSII=;
        b=EzSh+9bFQYYU4tWSnxz+K0BIn3HAAQWwBpyiIK2MWKHCzqQyfv/bMJLU6eg1f/SwM+
         0gv8P+ELKbD96VaElvBVzWWxbc56XnBDCDEEsvWCkCEPymQWRl/PX2aqeVZvOdVf/BbC
         potJqXwRXWsjxI3MNqVe1OktaKzhya06lkVul1MXl1/TDz12eO+gvGJQN8CzL7Kmlp1f
         bFIaSH5uzy8w9Tl3lsYqkZUJQiYe2P0Wx72pJiW/rG1tY2AWzD3i7b6df885UxojO/bX
         5nNp5pnF+z03YUTQNnGBZyReJq+iyMKLxpeqoRp6VAzju1lLjCEbb6KovrJUxYzUxOJy
         pCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400335; x=1741005135;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plyghipLnASJmEq44NILSv4euDkriedQTEtFCj1xSII=;
        b=ApMGMqyBcn1+JWsEpwtE8/9cWwt1TtjTrFHaL+fdKJYRzF0jyHICFDMbLnOmoZzHUB
         PubTXZLG4Eh6/hhwXfTPEFyP30RIU48WnKbqsvg5owjso2boXw95aqXCZMG5XYQgXJYG
         IGu/WpfR3QTq728T65HxHEvvcETTsxTa+HNc4gUwEmDnaM5qADES0+4IrPODVNU06yuG
         6HjC6I0fEvZzV6wZGKGMhbI7abkd5MLp2YeeKwLepKPO7QZuEk3l3uTFaq9EhlRs13vm
         58n4MsZKVkD5vBRdgagtlK5NJkTRQjagLZqZNu2BX6gXUab2sEgL/q/cunqQHp/6N2wu
         WN4w==
X-Gm-Message-State: AOJu0YwXp0xBKaqT6z2JR5M3/OMjM2kPeaAgtpjoDpHifOUZOu2wOd4q
	W4Wx9WUrfeti8ExIuBU2OWDcfiQMs1/lGSAec39hjcNRlGdXpy+/SoU3/g==
X-Gm-Gg: ASbGncsa8Ywb0zvZ57fYrkZZsxSbkOYi1YCBGTUWexXP40Gzc3DJrXms7WLbbkLyz9Z
	yfKFYqmewE+R6OUFZbIxwyc4Z7D62LgM04YByrGaRFR6WYCPPyc16R6g53h+u3ErpADnoEwh7AQ
	SqBqZLArL+VzFU1gsQ0ALvyMHVJ4hJS0CcSafk/tb1t+eC3bfZVcc5g8gjpyVqVydBheK86rja+
	2amLxqNNgQldRSJ2ydYiCAgVhTSe0DekoxMUQCgDni1W7l9nFwWQA/35mIpZ+qF0RA3MiBu+xQH
	2lUY8wRf86n6peL5K2n5RQzls+t546UO
X-Google-Smtp-Source: AGHT+IE8B0Fle5ubY7NE4Yb4b0t6TUg4yqGa3nXNggGEn8mikYquOOuxGXSlZMlXkNaNXj3QXGfFgg==
X-Received: by 2002:a17:903:19e5:b0:216:3633:36e7 with SMTP id d9443c01a7336-2219ff5f618mr213113465ad.26.1740400335398;
        Mon, 24 Feb 2025 04:32:15 -0800 (PST)
Received: from [172.17.0.2] ([52.234.47.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349198sm178612665ad.33.2025.02.24.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:32:14 -0800 (PST)
Message-ID: <67bc66ce.170a0220.1a4065.64bc@mx.google.com>
Date: Mon, 24 Feb 2025 04:32:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1900327961104774064=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [RESEND,v2] obex: Add messages_get_message() implementation for MAP plugin
In-Reply-To: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
References: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1900327961104774064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937009

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      21.05 seconds
BluezMake                     PASS      1581.86 seconds
MakeCheck                     PASS      13.35 seconds
MakeDistcheck                 PASS      160.30 seconds
CheckValgrind                 PASS      215.30 seconds
CheckSmatch                   PASS      283.32 seconds
bluezmakeextell               PASS      99.45 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      883.67 seconds

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


--===============1900327961104774064==--
