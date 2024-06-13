Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDC149C6A
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304299; cv=none; b=MrJuMpG0i4+qLZ3Q+N5kNo6fNIkdmsvHHuxVxgp+g27jNCRZXpkOfLrJZKlzgXn8Sl9/IGGSzlfIjvtWkU72ZPLKe0Oooi9HWDZid/Mzt6U7kshHgQdkX4rikQF5QV9RKuKwUxuYN3Sc2Gow0ydiaNACvodDnV/tK9dhSLuZGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304299; c=relaxed/simple;
	bh=5hQkTw/sjui07XM7+tKHVe2UxmrUlcJt2S2AyfZn8XI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A5VeKkldIlwTkzL5kdCwHjA+GNX5oY8XpZBtzPZPVf+sY4w9rfgOcc+SNjVzdDoU/Mnaoy3V39aSQpaUJFl7DZV+YWv4pDtvYbK5cPpHOM3x1Luo+AIV6NYqcPZ7Roz6oP9zDxhasGGDO1T6/156eTtj65DwQhG+AXnzawf3h1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHOOe287; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHOOe287"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7954dcf3158so89767285a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718304297; x=1718909097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R6p5T/Zex4XAvQ3elpXE1HtKqnCQHh8J+5bNjU4qHN0=;
        b=KHOOe287zpoIFeLWsByghe0MqKcRFsXqmOId6/2bpiEddP77zv8jAPE80uK3iRxalJ
         AJRAzX53lIgQQ3ujY9Z1cCn/yJrGOvsR9b4vhtTn/eY+Z5w7pAcTaCLi4Gemfjhgmghp
         5Mz1+d/54IZCX66JblkNuyqCQykgqhjg4ffBBVBm16sR7FA8dNuT95GhGQWhFA7bt4S0
         OgKTHhffEBjWlVBjwzlolGYUBNKNrIrf4+V+sP3fXN4FyrckWj9piM0swU3PSerRa0ha
         h/IP9NIb6ohke9dVaf77LGA8WYf5yBRgp0Vz9bvuKn5VoxVVBcdRNP48xp0ph8+0/li/
         i0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304297; x=1718909097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6p5T/Zex4XAvQ3elpXE1HtKqnCQHh8J+5bNjU4qHN0=;
        b=Cl9N5PulApXkAVPMKEhveUTXiidCOJPqTNSY9xi1ULPhNJEd83h4ukh8hXQZIBajVO
         lr2M6M9TnS4bp4pNI46H/pqZDHCfuPjQYOaAl+E59YQSPgV9eCnSF6tMMmz23hujfbdX
         39g+7MyJ3XlbVzCFnLdSEnt6WGPoQ0NVXUEgRh0mB3joKjizAaxuQzYGet24gI1xGYOy
         vQyRiFwbPEynYoyDS2awkxYWIA1+3A7wAsSSalJbCeeTS9jALV7Uot41kxriVa3mUBGx
         snt1YPMAk3VsZ9uWKJ+AEPP3F29cLFRuN6Igi5yPd90orMWBOMnNVe+QPe2uBJf8/kOf
         i4+A==
X-Gm-Message-State: AOJu0YxoBWg7AQCDcm4PDiimt9hlvT/OnBmErwJlMrJhrKbKcd8KW5zm
	T+LOAmIfC4BlymfrZFww2Ck1P1g498BC9X4QXiPeC5uqcHS0BPc+5xPUSQ==
X-Google-Smtp-Source: AGHT+IFwreR7vc2gExv5bo/axD6TB/dGWCeQDzHDA7JUcDRaPJp1oLYjLFZflybd0Q0tCiBq4EWGtQ==
X-Received: by 2002:a05:620a:404b:b0:795:4c8b:3f62 with SMTP id af79cd13be357-798d24380d4mr41397485a.36.1718304296673;
        Thu, 13 Jun 2024 11:44:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.106.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc7f3sm75616585a.43.2024.06.13.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 11:44:56 -0700 (PDT)
Message-ID: <666b3e28.050a0220.16ca7.31d9@mx.google.com>
Date: Thu, 13 Jun 2024 11:44:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9160957731156128613=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Fix marking device as temporary
In-Reply-To: <20240613170313.1596181-1-luiz.dentz@gmail.com>
References: <20240613170313.1596181-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9160957731156128613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861741

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1779.73 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      178.01 seconds
CheckValgrind                 PASS      251.64 seconds
CheckSmatch                   PASS      352.13 seconds
bluezmakeextell               PASS      119.39 seconds
IncrementalBuild              PASS      1681.50 seconds
ScanBuild                     PASS      1031.29 seconds



---
Regards,
Linux Bluetooth


--===============9160957731156128613==--
