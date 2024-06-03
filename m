Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969E59B4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421101; cv=none; b=KJplhrc7fEGUuATH/hYuvEVoMy7VUzD1jlGzR5C+EqX2m4abKBeZkwAPYE+yDu5T8bBdG39kKJ3N2eTOZi3GlK30mAVg6WCUDdd32D9Jniqf5hAk1nC8tqcGnln/klTqwDJv33ay7bJBXyhZz/fIYHtF8ZCjL9mgVQLVEBBBVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421101; c=relaxed/simple;
	bh=mjOZoQusAEG72l1HlEML2WkWSLo8+ld0iNaFIfqePek=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ODUBuiID94o2wbt5s9ZE9S28whgrefE1VouM5Bv62BACEZsmcr0v9xYtYx39PwZTBhp7QoSuW0nWvJJX/0KHcmQqb9IlYGof8nJadeUaGknMKGeijQM3Y2xIyAV7qW458TTvXqc/ppdptq7eZUB4X/WGhnLUOuJlbNbcuh0rUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGk7x/uB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGk7x/uB"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b98f49e27bso1712089eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717421099; x=1718025899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mGA6F90g0ENSiiO1WvzkZGG3IQT+yi38SiNOV4WirM=;
        b=bGk7x/uBGfzK6twM2Kc4lDZ+HViz3XxH9bnbWo2Vie6A/Sk4IecxhefqNyWeuAOOtE
         YxUSY/u7NND26aoSmJ7Y05zd5hT+tAwHm0tVUVEfYyYkZ6qtOvRHoW9ArkzG/wfdndF7
         utYcBlSIt5XlYMyFXxb6B7WjQkUpmRMr6iTYarESoFcD9I4/dIcnzFNqi+HjsN4K3/w3
         YWvpj/w/YkEwF96wagzj4f95vWhezM2KcOpcFNdnkTfi0a7PZzBNjWjy80h3TolXqSGZ
         KoedfvSjZ6sggiFM5Yh5s0yw1xATZEvgncXiGF+DEPX9LHE0BcWJOxyVt57B66zbr9Vw
         0L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421099; x=1718025899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mGA6F90g0ENSiiO1WvzkZGG3IQT+yi38SiNOV4WirM=;
        b=VTHAyQAJPDzqfY4paKVf/ww9OIt59trL3LRHmKxRFbFhJEnjO0O7AkUYeQXCiDvlsN
         vl0gJSTjyfUobj1m+OYluNshW9BkvdBVsjrwaA/gRysgQdpF1NJ6R7PTzmG0PfcC1IHL
         PeiPVPj8pOfRzsVPhR1yvEsYvo+YBO++qOIeugLzhJPSynQ/SzFtT9aFxkOhpOYte+5i
         28/ZOQ6nDl+jlWmj0RQbnR5mZRoyOZ11hgFldcDMPhakQHiFZbp/lUigS6jd3lKOWcpR
         TGxFOKFBxhuAynW336wOzZ7sTsSMqin54pH5lS4yAS4tmwdYaIXWXwAH097S2rViuN69
         alwg==
X-Gm-Message-State: AOJu0Yznb+FzAqHaup0V8zy81x0ibs07Z/di+rXb8GBZVGD5QZjhuhWi
	YuQpTsXqYzrI2O5MYvpKqeCdGlvLbneI8QQHW7qroQZFYLz5h4SIQqBsLg==
X-Google-Smtp-Source: AGHT+IGVGHLktln3UxAGY3UZoEhy+bur8KZV3jQDXmwAJLztU1Qr7j3RE8tPREwePlj0P12xYZwoCQ==
X-Received: by 2002:a05:6820:511:b0:5b9:f802:ba3e with SMTP id 006d021491bc7-5ba05d3143fmr9665192eaf.4.1717421098662;
        Mon, 03 Jun 2024 06:24:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.121.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aed6160ee9sm27616246d6.110.2024.06.03.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:24:58 -0700 (PDT)
Message-ID: <665dc42a.050a0220.e8099.af67@mx.google.com>
Date: Mon, 03 Jun 2024 06:24:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1348727350356545026=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Increase settling time for baudrate change VSC
In-Reply-To: <20240603125357.3035-2-quic_janathot@quicinc.com>
References: <20240603125357.3035-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1348727350356545026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858290

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      29.93 seconds
CheckAllWarning               PASS      32.48 seconds
CheckSparse                   PASS      37.91 seconds
CheckSmatch                   FAIL      36.07 seconds
BuildKernel32                 PASS      28.59 seconds
TestRunnerSetup               PASS      520.82 seconds
TestRunner_l2cap-tester       PASS      20.30 seconds
TestRunner_iso-tester         PASS      30.07 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      111.73 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      27.70 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============1348727350356545026==--
