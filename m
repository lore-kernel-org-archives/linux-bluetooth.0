Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AB1CAB3
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597980; cv=none; b=BcTKuMlu+xpBPc+rNM3ejp6Dc3Di09TOyTeeo50xeBMDimN3eJGzvNn/IXOoEAtuSoPECBvMccMrWBJ84Jh+cit+O1/KBlSymwaOqZc/R17O8+LEvwNfT6B22iBX4M9aWcadoBCzAxjQYxSYG34SdhC70kw+AadU1q/2nhUcbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597980; c=relaxed/simple;
	bh=xvTVJyCEm/7ItUVyQCWdWWCZ6YlBNmI6Uz6J51QRE1Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AC3VTL8DjDbcZsrAQCZafhTekPHgDqagyGgTq9P7jmrfRoP4DD9R9iSDE9o06O6RPF9IG2mXmoUTL9iknsGrS5PQuoMBAZoOCSEihRMMg79CbvJLYJSQE0RLy+r8rPEJML1/23NYNe1Wm6sk/+k6aZDzNk4xBQXisVJZD1hnR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYcg/7UV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYcg/7UV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234bfe37cccso43078715ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750597978; x=1751202778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EAVNoMcCGaUGZ4JATCErciDMq9xHzXOeLGT1ILuKDy0=;
        b=AYcg/7UVhd1BawZEkr6x96Ien3sKNjUYJUK8wCUS1f2cSyyKYZhkWkYCFydmbqQXSg
         tv7kPJTWfq+jZx+L4k/gf5/ad1nmrIg/qDoap+A6r0UAZoTM7r8Jyyh5TEnBOAXaHKd+
         ZW6zs94xLAvpGRMV89Aix04bsMS9l/dFr7NT0rJPciVWzTGx90CqwK/JLC2y/qdRZlmu
         rfQ6CBCgyLnvyYPqAM6dQHtWiX61S+DyvWNIioncpeGcOv1Yrzg8X7f6vjOyx+Emf8U6
         F/lMH12K34TP+8xBQ1SClQ4MyT9ExDKyQzID8N9EOmLuHX0aenQfK+X+6FBPQMIUBplQ
         F7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750597978; x=1751202778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAVNoMcCGaUGZ4JATCErciDMq9xHzXOeLGT1ILuKDy0=;
        b=crtc8bLJPnY9npTojgETE0hBL9NmeXn/6MCm8DlcCydWx/euQy/qxW12PV4RP/EMJt
         r1Cvk26mpcUNNHu7763K0FWh3NHE7ydr0OtSiYhz8gsqXZ/aVNnuwchrJPxJCxa/icsV
         j0ckL8rvtIojwgmQ8cl+xeyvAfeSk3XfbUyZdLEjWPWiBA9mCd0s9D3doRKXJl5irqqr
         iJqcdjh0Lp/vZ/YLVhGKMzZzRoLymWw9kp0yP+U/xmU2QkPRd99fyhMUcmDbQLN3gE3c
         RngLN8g7lS0CeOv18HrYYWgliNfNQnBrAoHj/B/eEJ25ERE+flhJKC05RAaXO70hzRVI
         WZkQ==
X-Gm-Message-State: AOJu0YyNHEc1Ly+uSXhaTctIKh7nATQi1Okvg/+PJXSSq7ZRlY029mmT
	X1zhEAC/LXPzvnxh4uC8ZcmJPHhW81HkS00lU+31DPE667itGFBZQRQnT3LnsSy9
X-Gm-Gg: ASbGncuy7mUwJYEAB3JZ0ByQMg4PLVZDpYgfAAwbdtdgHuNjVvN1JXv5xycTKrF0TAL
	/jsxsDiOVF/VlSfShZkyE75YDR+2GsiA9WLFCGabtmigNh/iO1x7n7Yz8EOiEmSM78lfqpcYz+/
	Yvrte7lrhZsDLoWaE1DQw8sAcKqL4kBPY3Kgv83P0Z6GOr+34oHqC6rAect5nBEvp7THWAvPftE
	ztoWPGk22YiW6Zdu4imgYjmN52VHsSBwN0xQ6LDlZsmV+ArL3ZASeON+Cqqkgc+oINVXUUQ7Zir
	suNtgndnAY1yYntBjsGwEWuIVPK+8o/c5AFC4bn9InbxpTw8hva6SdLkxUOdy75vFb5N
X-Google-Smtp-Source: AGHT+IGN4hiXn+1QmRtH9gXpDIat2tuXTOpXHsiQRVmWk07bB30TnDrjpInml/q1OR6boomYzxDgUA==
X-Received: by 2002:a17:903:230f:b0:22f:c19c:810c with SMTP id d9443c01a7336-237d9af5126mr147846085ad.51.1750597977874;
        Sun, 22 Jun 2025 06:12:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.88.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a76esm60134785ad.107.2025.06.22.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 06:12:57 -0700 (PDT)
Message-ID: <68580159.170a0220.351406.8147@mx.google.com>
Date: Sun, 22 Jun 2025 06:12:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5042818108469965413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: handle inverted order of stop ready and disabling->qos
In-Reply-To: <c98a6f523b122b47aaffb3ff6b59ccb236d76749.1750592769.git.pav@iki.fi>
References: <c98a6f523b122b47aaffb3ff6b59ccb236d76749.1750592769.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5042818108469965413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974594

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      2732.57 seconds
MakeCheck                     PASS      20.58 seconds
MakeDistcheck                 PASS      196.98 seconds
CheckValgrind                 PASS      273.63 seconds
CheckSmatch                   WARNING   303.22 seconds
bluezmakeextell               PASS      126.78 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      909.47 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5042818108469965413==--
