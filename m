Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975421C18D
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122196; cv=none; b=HZrX6ItjG0AJbTcjLyV8WqiH3NrzbR7PqYYxgOxXFtCL0LK0nsz46IeIO0kcC1ssaObWB/4lSHWcK3AIlvPSFiXkXANHaOE1EmIj3l4Blo+VCu490QMDSF7ljUnRnGMAbJ2/YrpJdHPyjbjcHrQIDH2+nafef/pchDD4EHAncis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122196; c=relaxed/simple;
	bh=EfvVmaUuXrxHhFxy7M5ao41Yok5KrY64BAJB1RF0cls=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pEqApMxyXlXQkcS2jwCd/Uf+ThSUppbxkNEJMZq1nnFwNi5WPtKRPLL/ncy1cNOzTvvaBhTv8edJQbT574XemluOtouKEzDvT6XbAt11NckvAt2OQyIkxFJnlc7vENIPg/738CAJyj2m+CP6tzb4nEQxk6Nam3YzbAIFfs+AGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmdo3E5C; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmdo3E5C"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a720e806so12532911cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746122193; x=1746726993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iq2SR7xebLXXF7Jel28Lx7n13iTqPuxvHtdAFPfZAGo=;
        b=Jmdo3E5CamtJ/7Oy/avcA8xDCrSOE+MyBVjE0XZti5naWk15Fsbm6ogwnCbG1kbZ3n
         noOJMtGrEKYgY3kg8t1T7WNA3XQNcld8EuX6NJxtXsHOBz/i51Zw/8jbsor868L0QMLD
         tXgIK/DlFYTvb6Zzzep6MoJSmgBYzsMjC9a1VXXbWLHZeOokZ2/wbp0+k0ka1cHwLEnh
         TFBZdBf6fU/rCH7/sPEvx8kIIgin5Sy8M6deSDiLoQAFdx28myf5DY1aryRgdxEitX81
         UwqOGPxqK5S0bwiiweNfUhpykdUxqyUnDU7UQ3CtRq5oRdzpW8in/gtcodpGtVzoRp1a
         6iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746122193; x=1746726993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq2SR7xebLXXF7Jel28Lx7n13iTqPuxvHtdAFPfZAGo=;
        b=AAACUb2sz/nRGL1w1c0xZWq84/2wYbEpQW6xd8Kiuo2P7BMt+pfRgfsIWHmXMrTd19
         Zn5V3Pj8+4O0fCx/huTOQY3pmBucJb02lqTsBcS1ac2q3lgZ2TjLezKUjJsAWtOQ4ZVQ
         DTufzmq4rft6KUnUNrCWxAESc66zbcgkDxH7KXFPqJsQG011PcHEq4VRrGGCjMLxSEhy
         sxIee9kEPcSCCWAJMZMWy/CFjMZhn3izpAqiknBCDdcGzkZTC3hwGC9botkoUhhYIchn
         AxyS2X9n9l5CJ9agD/qOif/MQcYC3txRnR0cpbi45a/TT2vi6D/vPDDCe90l+cfN/rh/
         Rz0A==
X-Gm-Message-State: AOJu0Yx/Qgd5IU/Ly/XzhY+0F8t7eIouXEsYQhLLf5/kx9Y5Emxx8G7s
	wV4wYXXuYKQe6u/UM/nw+dhLPH/7Kw6VJjyNHWqi9KfPx5cUB11UvaQjYg==
X-Gm-Gg: ASbGncvUqVZh39t2xf/cuLtEuXMUt77EEPE1vF60++B8CrdfVYwQDf0q4oxjgLvVudz
	ZemxOAqn81TZNlborcXj0izsV0XNZMDWS4kD9ZeybL0eDkswPgIisOHwCBL6zJUOIIKNlzhv3cM
	MfflnKbLfGvFBD/7smuzdOquLPZHtTKN84IqcM2sSJoCVmDf9t5s+mMjpW9vfeUjEmHVPJd0etl
	sJ64/ID0eg4WbvgT4RpACeDZ0/T5405KwWoYsBEGo/LVBk235VkWmQW47bJI+s3cJh1e36AhIIM
	N4ZIUV0oOTt4ar5uF400wnPzvUizZpxRTEdqtMB6JYHUM8Y=
X-Google-Smtp-Source: AGHT+IG19yrmVu5WhPSDg8Nl1uAF3nQlBEVtv3HbQy7RyQxo4Js2xEOsmLj+I6nXuocJc23uqzddlA==
X-Received: by 2002:a05:6214:f02:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6f51574ca64mr1840576d6.16.1746122191928;
        Thu, 01 May 2025 10:56:31 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23c3e21sm73230185a.39.2025.05.01.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 10:56:31 -0700 (PDT)
Message-ID: <6813b5cf.050a0220.2072ad.8a10@mx.google.com>
Date: Thu, 01 May 2025 10:56:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8738370248300089412=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thomas.perale@mind.be
Subject: RE: fix build error with --enable-hid and --enable-hog options
In-Reply-To: <20250501163536.1283827-2-thomas.perale@mind.be>
References: <20250501163536.1283827-2-thomas.perale@mind.be>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8738370248300089412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958828

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      2592.88 seconds
MakeCheck                     PASS      20.49 seconds
MakeDistcheck                 PASS      198.00 seconds
CheckValgrind                 PASS      275.56 seconds
CheckSmatch                   PASS      301.80 seconds
bluezmakeextell               PASS      128.72 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      909.76 seconds

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


--===============8738370248300089412==--
