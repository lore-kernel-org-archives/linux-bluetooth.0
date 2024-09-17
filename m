Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EFB46B8
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726534841; cv=none; b=gicBA6j1Y3ynZ5V5pSSrbqUSYjhFOkiFor/a13/ElaP2HBqCgQMW0hAHI0drARZ8i2VqHmBwrXC0YAZ/EJkE3ipInF8qmz72bVELaBo50yEVb7JbrPzLmSpAOkXsaWEMjG99BumV3DUWOmSiUSFu1r+phudI6EKyEp6qXP/Ms84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726534841; c=relaxed/simple;
	bh=GyCQGRmQDUpeDOEdOyTxA8y9H6ul/KjXTxsJYz7xxs4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eg9IiDRSh07P62tPFPsiFSGQuAe8cLxzSK3qR94Q7fdsYv2BNdvMq1yoP4OEmmAGtTiRu4mxCKF5HJLBH7Bm9LBrn5cwum7GkjjKS0E/FfDf3g2W5+BkAVIU8iak7Uph9CvADdhTqvoQzQH0MiX4QYbQrtyZj/cfmaxS6Xw6UIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyMz4XFR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyMz4XFR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206bd1c6ccdso36017915ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726534839; x=1727139639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PsczuJGKIOjdk+zSOErwUPKD0ak7Cs5XCr7UuAoh7bs=;
        b=OyMz4XFRD4t3uQvuA/Jx+yrRXJv1OHVl7X9fcS04CWrmzFINaYj1/K0ymj6AzPJIwJ
         eBmfcWVROXLXfjQDF8n/rC5Dsok5YT2N016OTJkJ3VYDrjJaVFGkIz2zvNGZb/6tRmrz
         AzoMa/yktfWxwo2cgxpalb7D4FL2LQOIKipVMTLOALu3+RGjy2ys265esGHCJt2terXB
         inyM1pjONBGDj3HtPMiKobVmXub/QqnRAixuivMDKoDmJBD61RncNpJdFFB1vlygx9TP
         oPOvGILLzxpzu5Q5JPrCUJfke5akWtw7vyvSa4vNKTle1INdHdGRr6zwWqDdjgZTYEbG
         Nf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726534839; x=1727139639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsczuJGKIOjdk+zSOErwUPKD0ak7Cs5XCr7UuAoh7bs=;
        b=Ronj3tobPBxilhPKnknOMvJALX4rpbW0/iSvLT95b7od6vmmTVEis59moJ2SRYcUgh
         k2e5OrDH+dPcttmQkdwWBVlbe/Egp+2jrMRlxbwUVDW8hv6aFg3DVHusUsPGGoCkoZxW
         rt8dTneHTQftipacnpUxIpIaI3rmqT+2cndKGrVK7enyrHB78K6iBVbzjw1gvHKRCxA2
         Mu0BGtDeereBt9//+tNoe8QsNwqVGOc+pBsuYX+UoYw1+q/eNRlqS9BeKaSkuRZNNAxP
         5c/BBeH0DndYxx345ogWaqjxxqOJ0Zrq0zTQpY5Tv3plxKXWTYyZfZvo84sqs2V9zvK9
         gnEQ==
X-Gm-Message-State: AOJu0Yxy4HdSfI/2im1V2W41t1do38GQSeccTH6WOjtQ/BHsoc/VTa2F
	nHflao5+Gyylgm6F2zlqgAr+gFaMHNmSS8By7KD0cLYjiDB7ERJ503dLqg==
X-Google-Smtp-Source: AGHT+IGiVB6jWrwQ13oTMhRyMmgcO6UbHmOc5TiVvp0C2XmQEy6rI1437Jc52W+LY/ZTnk8VnSPOXQ==
X-Received: by 2002:a17:902:ce87:b0:203:a209:c5b3 with SMTP id d9443c01a7336-20781b4271fmr199926285ad.6.1726534838743;
        Mon, 16 Sep 2024 18:00:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946016a6sm41850745ad.99.2024.09.16.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:00:38 -0700 (PDT)
Message-ID: <66e8d4b6.170a0220.1f8f99.dd42@mx.google.com>
Date: Mon, 16 Sep 2024 18:00:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3058365279735570315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: mesh: Move local basename into utility file
In-Reply-To: <20240916232744.1618862-1-raj.khem@gmail.com>
References: <20240916232744.1618862-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3058365279735570315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890794

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.83 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      1681.32 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 FAIL      8.85 seconds
CheckValgrind                 PASS      253.18 seconds
CheckSmatch                   PASS      355.93 seconds
bluezmakeextell               PASS      119.70 seconds
IncrementalBuild              PASS      1425.61 seconds
ScanBuild                     PASS      1012.84 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'mesh/missing.h', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:12146: distdir] Error 2
make: *** [Makefile:12222: dist] Error 2


---
Regards,
Linux Bluetooth


--===============3058365279735570315==--
