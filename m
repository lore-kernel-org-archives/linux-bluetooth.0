Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E92157476
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704840; cv=none; b=LOa8CTlCjagoC70t3Y6anN1t6sJsyZ8h98RF6lTeP6MWvCHqIGXTSr6yBCrTVqInS2qbglxL0HcinoKsitlokpf9ytgajbMBpzWLFO9FxQUcGltKm6Tfj4bIBNiZ+WPN0eh+cyaF5bV6w1ZbvuTXGoiiY4ZGnjlC8i5fNRcdeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704840; c=relaxed/simple;
	bh=7ezDR5rPn5OXqZ8KE32g4FYSOfOorwMzfQx55A8kVuw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZRctSatRI/4OWSBqeFy12RznUH9Bd2xpnLDv/Nt9L9+Bcchy3rErdWZQhNv3YDmGbrQjYAyTfVIua97qufetc6jQS8kRx8WE3azPvf1Z4zcKcpGf7skWUv/D5Awk6V4tq78x3azKkp6MqKzXiGFhW9QQ7kyvcgW+505l8vB6KAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCPVIz7W; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCPVIz7W"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea15e25a06so1849916a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712704837; x=1713309637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8LBkHdeRQj2Tum8/eg2qateociGcUprC4KKjO9W1oMU=;
        b=HCPVIz7W/rZcpEGB4QZsuCh/wpJZSNHvfkwtnqmIK9ZwzIUU4iATdBQtHBAVeZAHuO
         M7F/cX61mmjy7c/zrONGBYegtHWnRxKLAM/Pa0fkoXrb+0VqchRtHBOaWj7bh/7W0h76
         V9JY3XYT1w3Xj9RCxREJe/nYNkwhCW2nGHIkhoruBRhXD5wF82NNkFYF93De+mD4D1Io
         unNqItFiOL/2KxMyEwWHMPj0Z55Ctlb3WPcbZm323krZRCM3pm/eXHMrd8SypCOSkp7y
         78CktrFo7+NI8kZmVie1wv13joDDw+k9lULvpBY9bNpSxudj2VYxnOFBrOa68wOL1u6s
         TxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712704837; x=1713309637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LBkHdeRQj2Tum8/eg2qateociGcUprC4KKjO9W1oMU=;
        b=wr9YOcnzjw8UOgrfK60VIJyH2D/E6WzQDVMID689h928i0ZiKPodjLLHAstgXBboQ/
         WX/rX+zYMdo3E34PSvMvwtbAZSgPZ2C2SDQ1vgyN0X6cbI4KA7zTeF7E/B1lWJC/nq89
         6cmwlzAATFcuFhkvG5JxvG0a6DhGZw4hP8qdpKziPxHGLG6qL1lbqYY+iaoWNeGQlPjF
         L/XaDlBw914oZqVJum4agR0yMTsuK1FhI5wEzgkHJjHLjxMjSi56N4p81jf+u2R5b/0f
         P/Ci3KMLDhzDYYvTzYEMMDkUwjMrg0YVKn6op6JBfhPJVKwHr0ZMPt0Tt16TvwDWu8WY
         iaqQ==
X-Gm-Message-State: AOJu0Ywdq4MmpHhYXtT2/Lyk+3NnoeIM0DY+HfQMPy7DmT3RjIV3W381
	JzapnT+zfsLN70lHbSLDS7BmsUdLgZ4+q53JWgrmxsT7oOMZ2ZR25MgI99U2
X-Google-Smtp-Source: AGHT+IE60YoV3iigNMPf7dEdUUMYGK3cPOVMQXZ+uL/WH8nlSHMgYODF3PaVCDi/4bUukSyuzp+zbw==
X-Received: by 2002:a9d:6e06:0:b0:6ea:1e19:6b54 with SMTP id e6-20020a9d6e06000000b006ea1e196b54mr1287939otr.12.1712704837367;
        Tue, 09 Apr 2024 16:20:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.33])
        by smtp.gmail.com with ESMTPSA id z6-20020a05620a08c600b0078d6266e54bsm2757714qkz.9.2024.04.09.16.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:20:37 -0700 (PDT)
Message-ID: <6615cd45.050a0220.225aa.c16d@mx.google.com>
Date: Tue, 09 Apr 2024 16:20:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0931061588384477279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] shared/uhid: Add support for bt_uhid_replay
In-Reply-To: <20240409202720.3894858-1-luiz.dentz@gmail.com>
References: <20240409202720.3894858-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0931061588384477279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842985

---Test result---

Test Summary:
CheckPatch                    PASS      1.90 seconds
GitLint                       FAIL      1.48 seconds
BuildEll                      PASS      24.36 seconds
BluezMake                     PASS      1688.92 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      177.42 seconds
CheckValgrind                 PASS      246.86 seconds
CheckSmatch                   PASS      350.01 seconds
bluezmakeextell               PASS      118.66 seconds
IncrementalBuild              PASS      6173.01 seconds
ScanBuild                     PASS      1009.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,4/4] hog-lib: Destroy uHID device if there is traffic while disconnected

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,v2,4/4] hog-lib: Destroy uHID device if there is traffic while disconnected"


---
Regards,
Linux Bluetooth


--===============0931061588384477279==--
