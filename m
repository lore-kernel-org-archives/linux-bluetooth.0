Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D637CD31
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300820; cv=none; b=Ctl74R9b4+Gv05N/SYVg30lNnnxKwi6Sg1dgrbwMS+p1SilWX3C4tSjunSmO0KzYDShc7Ii0pxv4bq5d6i0BH5Dhps9Kp4jDIft1yOlZqpQjIJ1tbDZhzgxF0XdsHKgSPUdPYJqWIepDir4kyjkZBYuPZD7qOtWgq4J9CPLq+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300820; c=relaxed/simple;
	bh=gVMERtSaD7H+XeVl/GyuS/rBaTID3AOulnJSKhk8UZU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YY5bLV2EgrwRYI8n1fcEEX4XjCMVWrNuwX917Vg0XpCBmdGvng2X+KkfC1Mrcbi6y4VetiVWYtz9NHymV273B/bnhblDhTIoHHe55rPwAQmPJdW6uTP8hwrEi0Y+qjxkCDtcn2pUhilk/MTfyAt5h7qBpsUupwtKom/Uo0A+/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjrx3CaZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjrx3CaZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01089e8aso33172481cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300817; x=1784905617; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cQVTrwtxys/r4ZujG9sBHoBPFPS7yOUzK+UPeBl9WqM=;
        b=hjrx3CaZgml87ZIg0kcjgfFeeiwDtClYuCoFfDMW1MQue25mkVq26h938OuSQuYupJ
         J1sVDEJcgVgLJ9CvmsFdwyBcfTrslhJrWBEX2MSQ5s04ieQKpi6IgKwjqwEtedFok3Sz
         OMEHfBIzKX6luC5Q+Nk8i97N78dRwphc04CnJaiXbmmPoX+GN90y4F0xnZD859PeOKq4
         ocfII7bg8tEMX3ZOOOftX0Bb3Ne0ZKdz59M/LUT3t7oTX+Qgo55V9tdgAu6hUhybprPx
         XqPrwieZ5VTg02MmiL0vhU68suDounrRT5uoD+rYJfFzDdXJoJJBgu6JaVzyhFNxyQpa
         ZYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300817; x=1784905617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cQVTrwtxys/r4ZujG9sBHoBPFPS7yOUzK+UPeBl9WqM=;
        b=flUCvydRwXzGxAv00z5729+wUerqA6FQ899C6/VBFRabTMlbTRQ89w35rqo41uZDVG
         0OhnOuLqs1+gKJfZaVOLWJI/O+hnewkX0uFqEcCHRJ+mbkyUd/6ddebZXT69It8Gaj4I
         Ua7WiwBX24geoMGpReUHxKO7Y1vjhSGhXmS7RFvX+styJC7rzFC/65H4PEugISyubEM0
         5WDFf/ugdCiaNGaHOCJi2yjDfY2nfRy00pyuKGg5zWP4C5nRqJCWaDl9j/VqlAVcvRS+
         Izf6FTzrI7XrlggR++VNisto9kWqBi2S5gVIC928/CnZN1eYSE+gSanWgzWqIbz7VUDT
         CBRw==
X-Gm-Message-State: AOJu0Yx1hkACD5eVB7Bbuo0/4cBDmQBM/XHU4V10a5djlYK3yy06HwRo
	yA0fTf3tavsOToNWZJbDg/BypDYNkHMh9L6wnDmoY3DOMjFvi4bNJVpQ/c5qpQ==
X-Gm-Gg: AfdE7ckbyvE+D8PR3OFEt3/PF5Ofmj7wzCuPo1ddMGPq0XNznqzb11Irx6d2BZ8WN8x
	p26aQbHX49WVElCrxsTu8j3M1iq43JL0VPOUAWxQzywS3F0eNMwb4quM8/MTAO9aufCucWlYJUH
	zApE/aoXrJuTTqbvtcAb3mZVqgJ3CTvb8TZ7KXWDx2eHrQeBRcOOvRzsvPmCrACKDa1XLubwa38
	VPPqeOhOdGvAlQTL2YWGHhidEZqY/y41UExNsjOtHrglVJ1vB8y4fpupcUDaGgHxb8zM9pB0QB3
	MmXxfT2WzZSkdvrjNY5OYrfzlupSzswhI7MzYrOjXvDqt1UD7WkbdKI/xsrFef1X4O0qYpg0MYz
	8ZjVqEkTtKD30Hp0AjYRsb6krkO0NGJ5zdOeUn6oXrLcJCIx89hn+Tlt8HRMM9iIyuByU6KOPfo
	ricya3P0tEBjZTAgMBlVIZ
X-Received: by 2002:ac8:7f13:0:b0:51a:8c99:1f17 with SMTP id d75a77b69052e-5213eb8266cmr26705051cf.70.1784300816717;
        Fri, 17 Jul 2026 08:06:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.182.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214c5cd3dbsm14420801cf.5.2026.07.17.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:06:56 -0700 (PDT)
Message-ID: <6a5a4510.99af2db9.31eb1.2410@mx.google.com>
Date: Fri, 17 Jul 2026 08:06:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1157715241976912695=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: CS: Add create_context support
In-Reply-To: <20260717133503.3711396-2-naga.akella@oss.qualcomm.com>
References: <20260717133503.3711396-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1157715241976912695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129618

---Test result---

Test Summary:
CheckPatch                    PASS      1.93 seconds
GitLint                       FAIL      1.31 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      539.63 seconds
MakeCheck                     PASS      18.60 seconds
MakeDistcheck                 PASS      159.70 seconds
CheckValgrind                 PASS      230.06 seconds
CheckSmatch                   PASS      312.23 seconds
bluezmakeextell               PASS      102.37 seconds
IncrementalBuild              PASS      557.25 seconds
ScanBuild                     PASS      974.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/4] profiles: Add create_context param as part of CS Create Config cmd

1: T1 Title exceeds max length (81>80): "[BlueZ,v1,2/4] profiles: Add create_context param as part of CS Create Config cmd"


https://github.com/bluez/bluez/pull/2329

---
Regards,
Linux Bluetooth


--===============1157715241976912695==--
