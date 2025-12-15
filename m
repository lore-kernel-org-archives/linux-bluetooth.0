Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73D2874FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791797; cv=none; b=LQxOLFJ9Wo6ds3s9c6Q/cCtGgKN0jUPfej0JVx/0kyhhpLr8n7qktbC+yICYdoIQnK1BJsNX96yzPpDLrT88yiieLCTYCpwkS8dNJu0CrxJdGzxH5GVYKzYp2ffLVcE469BPlH6sBJ5Gh8XylYyPbAQOSHzQs8SzxDIMs1wIgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791797; c=relaxed/simple;
	bh=Jvhq2Ja5UXpS59JotyqEupdP8+K+AzAqfSWw7wYm84U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m3J5LR+P6jB9xB4gi1E34FAU174ia7p4s4bO9XhM+keEvI2K6UVWBckcfuJWzI3g+xuw/8k+UrQdaiDtQV08Kcli83QECQWCuhdw2Yt+FUro9+HeQU5gA3DyDC5l0S8bpm5ZiW2Zn0iUwT/4X3rG8KRAEpCnWjkomAv6UN0uInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV1B8TvR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV1B8TvR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b220ddc189so444153985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765791795; x=1766396595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UrME0P+f+llu5aOZHjGgZj6QS/Z/RMmd4VdIVY3T9Ps=;
        b=IV1B8TvRzCE1lPBhVrGjkJxnZvfaEYhv9mdMYOqIxtD2cUNHN9h0HwfK8TExnv9SVw
         IyGM6HouR0Pj+1XS3Y03J6HDVRubJsoE9WeE2ZE+cf9np+Q2cmTU1ZyfgAy6Ms2EqWql
         Pn27nxWmkOeCxh+bp03/hZU8rjgUg9uFFpAvGpgQyScuXFXooi3k5vrdS2roaCPbxT7k
         Y+dSve2bjoLjY8ftGsC10VqW9dX+DykMaZdY0Mo2vsViGptHLxyxtHO3okZHjJs5iFic
         /EK/MQPjGYumZ6voH04t7wVUnwyoFJML2kOwq3ukNzQ4uuNOyChLy6Jp0NCQYUN94RZH
         lEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765791795; x=1766396595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrME0P+f+llu5aOZHjGgZj6QS/Z/RMmd4VdIVY3T9Ps=;
        b=iuBrr4ntuTrXhYJskMDulIF7fR6fO82UYdlI/MfQfMNhPzp1IxblDZZ3cdbyeTVr7k
         0Zqv/ErxeRhCSVkFBJJ0hmsD3XcBNaTMqUUchCkFRAIGPQksGb5+1b3d4fizN7TyDFKq
         MLOpuAo+MQ4Z5HvKFfJS8FE61NPqrupd5in/2c/0DD57LPsHmsK0HIjyKI6XOrKVwMOj
         6CuKTW++vVgwLudZR86Gq3qBjxICcZf7xoQmkqE3zZIGpn8h8HQxj5RWQUYN+om//kru
         Y9gouC6V9h2y5CJ5ZDHMPbg2D2vSd2VNW+PzZrz75CKCUy+c9DVB5DYGtEgET+kO1eDg
         +QOw==
X-Gm-Message-State: AOJu0Yz4cWn2+CoyRG/GQz4S4KtECbqGLr6NQR/tqz7xhUimGwvpC1MI
	O+APMckiGpG9E04aAz35FIi72cBcnLUlMU+g6aEpv5PSvNXBEDQBnQLinKQuGQ==
X-Gm-Gg: AY/fxX7l95OTTApBfOqv5+HcWkFxD5nnRWRk/+PsJXAqy0IAvddy7sje69vziPkqttB
	05DOLBoEfd64ppo4OneWtB5Qj1zvQ0lqa2FnVYH7qbKrPbqijPMoOpd+3X+nRbIPXeL0Kq1N9GI
	h5ymj6lDVn++Gn7iypvUAXyQ3b8EX1x3HyK7Rh64qyLmVHn8kG+Xqu7qeMr4KFKNR8dm7qFSN9T
	MkOhSX2xgQN/ZIPThfx66I4xxkgJ/sUBBAeocnY3Kg/Jdf+lKUbjSLRinP8sw/LEVEcL0sLSyJc
	ZtIlh5/7IIF+P+jWhZWXTTXc2DuFNBXtLsR6dTTm7RRtXuhL7m/nCfaR7abMsriSi+jCoxWZLkU
	LQC2YlZsNVYP30qJBKyYkxwo+Yq+A4+N3g2JKMh0DZDqmo7i2PsSVeW+mx8Z2ZdRKj2qDfkWhhW
	uwGvqUcfymj76WuZGqEgE=
X-Google-Smtp-Source: AGHT+IEV81J0r4XIqcpbw7jdmN6HyMWkItgNJE+25dD7S0UwVvBVSQRE/aEelK72PigcewJE73b3Uw==
X-Received: by 2002:a05:620a:29c5:b0:8b9:cf85:40a2 with SMTP id af79cd13be357-8bb3a2531bcmr1335297785a.54.1765791794732;
        Mon, 15 Dec 2025 01:43:14 -0800 (PST)
Received: from [172.17.0.2] ([172.177.209.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4cd34sm1024053685a.47.2025.12.15.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:43:14 -0800 (PST)
Message-ID: <693fd832.050a0220.2336a3.c3c7@mx.google.com>
Date: Mon, 15 Dec 2025 01:43:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8079752980804263692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ] client/palyer: Fix QoS 32_2_1 in lc3_ucast_presets
In-Reply-To: <20251215081912.1245-1-kx960506@163.com>
References: <20251215081912.1245-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8079752980804263692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033107

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      634.65 seconds
MakeCheck                     PASS      22.38 seconds
MakeDistcheck                 PASS      243.50 seconds
CheckValgrind                 PASS      303.34 seconds
CheckSmatch                   PASS      349.04 seconds
bluezmakeextell               PASS      180.90 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1018.02 seconds

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


--===============8079752980804263692==--
