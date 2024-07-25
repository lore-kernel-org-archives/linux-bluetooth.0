Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392C13DDB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918051; cv=none; b=kQQUbZElLhU5su9l/lbN2D4m7/N12eVgN+yIZlxk8qy39lTsVuPkYzRaJEkEzJK+SFQ9W4ppCCUWcNUXWdbKimK5k6xxrlO1nazPFCctAtY1AAH4lKZIBV8dYqKuZliCIVqDufh/C4OBJeAyer82ZYhSiLkjf87x4ZVVxfQ9baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918051; c=relaxed/simple;
	bh=OvG25UBi5xn+2USdSf9kuMVtrczclYDo/tf6KlXh6j0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EgcVOt3pz8RQDBfu25X61k12J3e1OFoxjXEfz/39LkebQUocFEH492eEx1zc7rOWN8Q+HdOMfgvJKFrdly3w89iK7y6NvBCUbhIvns2MuwIJDjXEw295neR83rGYMVNMMUdNWmtlu22UHM4MOXnSih+cKZafaZHMs1G1f/Gt9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHYxXtE1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHYxXtE1"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d42da3baso58915985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721918049; x=1722522849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8PyeHKyjz0m8DRlnoL71sYrKGg/1bm5T4u5Z95+4cZ8=;
        b=hHYxXtE1liYWB5fIft8nuBOEt2GHE5ONWEpKn1tnXqHzAQREQpgfWDFW0SJ9BsPWLg
         rD43ni3p683g3DALGXsbHij/RtUJbmdwyB52/6JgFITnMK8TcKxOSLDq098GzaGf8taG
         cQHIWIpex40z7Os3ElRtNgnOAak/Uth6aFh8gHsuc6amdP7EloZnj57YA2ieFsz5GMvr
         t05KJ0Eeo6F/wHNgJKrQajASf/fTug3MExcwyjISTZWv34ezQzw37y/13KxF2ZP2hF8S
         oKB5FCpG+GLDyrjSglp3tROpE4DN03dk7GMrWYPqf9Jqpzk5hyKHZGu8VqoICgfZld+s
         pk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918049; x=1722522849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PyeHKyjz0m8DRlnoL71sYrKGg/1bm5T4u5Z95+4cZ8=;
        b=YtmNhUB0RRKBJxKaXVrDR48x/DV50TciADSXEkCGuCqMM2kD6/dzlsD51Nt0UHIHKD
         2sdVIE9F0WL7+N22DmbmDlIGDRBtYfaLcQDAsc5Z8T4coh0Bhbu/+vGnwqtryfYMa/Um
         CkDGqe536/SpY0zVdnmj5xG3iLF+eSIHHYb8vOELAHBS0SviwbN0sAzXKA0/3RFaZIKX
         eciepbrsdOjkNb830Gn6MJrvqq/1V9I67URdamRYR140KWq66M5te0nrtmLFyzYnb9jZ
         rEDu5KbqI8Aa7orYiojRUthO0rMWJhsLz/SkZ4cgryo8p7qprfufa7QsLeVCJ8X3Moc1
         JgEg==
X-Gm-Message-State: AOJu0YySTCCQGwbQz69Ph7EE5WxGHSHXZmdLZDcK2e16BilGihgMGR91
	mkMpXKCRXRRnWRRVgsybJa+eWnDVMtfmr88UIksunDMlBFJPkffdXX6XNw==
X-Google-Smtp-Source: AGHT+IHJ/CsKkTsySraq5/mlA36B61LbIeH+yvvw/zVfrpncK32Rb66+EvhmXNRZp+SvWqN7JKqeRg==
X-Received: by 2002:a05:620a:45a0:b0:79e:f9c8:a223 with SMTP id af79cd13be357-7a1d7e13c7dmr210941485a.6.1721918048735;
        Thu, 25 Jul 2024 07:34:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b46b4sm87589285a.53.2024.07.25.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:34:08 -0700 (PDT)
Message-ID: <66a26260.e90a0220.1d0b5e.26e1@mx.google.com>
Date: Thu, 25 Jul 2024 07:34:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5075876852380683137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yskelg@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: fix suspicious RCU usage in hci_conn_drop()
In-Reply-To: <20240725134741.27281-2-yskelg@gmail.com>
References: <20240725134741.27281-2-yskelg@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5075876852380683137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873851

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.69 seconds
CheckAllWarning               PASS      31.92 seconds
CheckSparse                   PASS      36.93 seconds
CheckSmatch                   PASS      102.67 seconds
BuildKernel32                 PASS      28.92 seconds
TestRunnerSetup               PASS      545.76 seconds
TestRunner_l2cap-tester       PASS      20.45 seconds
TestRunner_iso-tester         FAIL      38.60 seconds
TestRunner_bnep-tester        PASS      4.97 seconds
TestRunner_mgmt-tester        FAIL      122.62 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      15.24 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      29.77 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.194 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.898 seconds


---
Regards,
Linux Bluetooth


--===============5075876852380683137==--
