Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A415599A3C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892152; cv=none; b=b9gN1ud9E7qqdnJj/w6gjrYHS0DFbsB8ayV7y3IS15sPLiizwLngBDFbtTt23M8Sq7VhdjlQZnjtRl0MLlB6zXf10xuT/yd29+HiHUieLO+mWQ4dhvtYkti0NWIKfi8mHZBMe3gzUT7lE2xODjI2RdLZV+TZUz5hfeRAXHOJ+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892152; c=relaxed/simple;
	bh=IRSYT3njWvgFTCnzGjwRKOQFJva8zUcZgkk6WwCPE/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QGeXpUyXMkysGW7YTMx6/On2rYUExUMf0OzTVQrvCOc2G8PusNaqLg2Mv8fxAW6xvK1Mjg8s1GxWkp90l0vsaoIVvM7rZhoZvu1XVQ6j/7fpC+JZsAhbjBkJ3EB3gCRtL5Wj6DO8AfyDe5Jm0IkQLveb/e0rcp9z+pRW1yISRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPMj+Csu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPMj+Csu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9309d4ea213so523046885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788892146; x=1789496946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lp1vLkWfldCuJKj/bZNjeGSfHsrpPjgwyQQCjW223PM=;
        b=LPMj+CsuEx4gwyIYsxSKjm6pad/80YdKsDsm6qWCTs1XDuTZES+kITzxq1PCOmAoDa
         TFv6xhCngKK+gMZUoj4PpN7gm8zLxDjI9ryXT3yDCY3vbhE+mZZxYlase8L9EyGQfmlC
         LU0f6tdpYIj1MuoypyX/+nKzJdhlDWUxT19joy6b6i/8+jh9LaWBUrCZ+Zn6TYcsxbpw
         bVOcWZGknI0jrRNpmdmFS+9CT35ky9tbi9EavWlqKNtJJhL43FMxMAQ3u5cbhBhMufXa
         cXyxNw2whOQgoOWfYxEfISuaWKUvBsArWZFobUK3zKUSGlQoqINwsDF1rEKJ/DAgPezs
         l+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892146; x=1789496946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lp1vLkWfldCuJKj/bZNjeGSfHsrpPjgwyQQCjW223PM=;
        b=nxZQbl1h72s3Ql7k5YyU6mbJQjujP7N15rxhTGnRNVM+lnr5DR4KKa4s5Sr7X8LRUz
         9SPcYBi+ECUedDRXzdte8IVCxXzzKVDjAyLNpVMSN6jX5pZdLzwr6sI3Rpt4WcZ++Agy
         e6gJYmBNf/E2Ojk2HelSTzvrja1h76sj0cS2vfLycbCLiEX8+3/KHflS6GcaikNLoRmp
         Bh6BLO27e/TVrFPuOm4DaFvDVJBhZ8PDdwRIa3RLs03p40nMORo9HF3OESqqKhbYTmG5
         kuk/tCyZkReeIN5e++9Sjpg3L/KNSp6s/0Yr3ngNRyNC6NC8V2syBy18FqsEIpfDEB80
         DxTA==
X-Gm-Message-State: AFuF++katNBAU/rQQAmDxHgUzNVx0M7rQdiJsAmNQNjSJhEKWbx/TtNo
	hRH5smEcS/v2rTymEPoRUj7x1Uo8o2YOcWgdLQ5k0xldsQYzcoEt++NygAvSCA==
X-Gm-Gg: AYBFou3ZtUyFQPz3fzugIEw3ufcAojnMgVAPOCRLFj6+vFcN0+utQjPr3HVaRFLMyoP
	NBUsxgr39kmXxBANkHvu9HmvKLGYqUvwnqNx+YOi6e+U5hvCKRmrBkthdXWt/dG1y7e5KOwwt5G
	260+d/1iJtTTsibVcqg9Dhr2FQdowIpGbqvr+TRUFOX9a6fSaCnvn4a3HAJYro7up9pZ/A47c+f
	ACG5zTNsYpjmm6QnIXPMk82n2Nln0utnPKerCzlf2nlyM8TcUBe2oIjzmrHcavBwkbmKaVaVJJF
	bDarLCQOiT4COgE7iv+cwGS9m44+W0bTfS2qfzxK3Br0x3TRUuuTAP4fJDVMKh6xF3nh5dpjYis
	uY7z1ejQayBKILI/T2w8h8UWwB8jVaRg8Hg51X88AWJP/rqa+O7JMrnRwYoAUSJ3ARW96HWjfeT
	Kc2AHE9K2Wn5HWKyW9KQSXWsgRek/Jg7ZzFSCwAY1/xcIPTpGZUezkLMsG/TrgoGe5lkUl
X-Received: by 2002:a05:620a:84c1:b0:915:de68:1802 with SMTP id af79cd13be357-9398072a174mr3167724685a.41.1788892145665;
        Tue, 08 Sep 2026 11:29:05 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.177.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1214241685a.4.2026.09.08.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:29:04 -0700 (PDT)
Message-ID: <6aa053f0.e0290173.8636a.7c69@mx.google.com>
Date: Tue, 08 Sep 2026 11:29:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7395772149866101150=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAS: Add support for on-demand ranging data
In-Reply-To: <20260908042727.1677501-2-naga.akella@oss.qualcomm.com>
References: <20260908042727.1677501-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7395772149866101150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160130/

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.02 seconds
BuildEll                      PASS      24.10 seconds
BluezMake                     PASS      997.05 seconds
MakeCheck                     PASS      1.20 seconds
MakeDistcheck                 PASS      187.40 seconds
CheckValgrind                 PASS      185.81 seconds
CheckSmatch                   WARNING   360.04 seconds
bluezmakeextell               PASS      119.78 seconds
IncrementalBuild              PASS      1136.30 seconds
ScanBuild                     PASS      1181.38 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2501

---
Regards,
Linux Bluetooth


--===============7395772149866101150==--
