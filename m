Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484211;
	b=z+QFGbCjwD8osZMaegnmqXukzuZtu6sz9gIxYIjKJCbha5IBxamlRjjIazEsn9uYYm4a
	 xjEnUO70H3mEGnk9JlNiHRM4e3xIF5XUNPijku1DVp/STRbrpfoPkMkBxe4X+YgXdzTV+
	 Lxc8X8eecITiFQBYfYS/xwE/XYYFh/c+M0/DnTDnMUU/fKgPM+KbzKSKQhnlTcwYP/4wG
	 20i1cAB4QE8iTWUbEaptxpLYX1fQ/mb+icFX0R3zo+J/uAGbT52vzVZ9EBRDPIM5xvs/I
	 tfmOBxIZ/trnSh+xFfvHJPzGyu5VQJuvmX8zL3EvdHh58F+QN8rkphZEmQYsO6ZqX7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=phZ3/wAVdcKHh5uB27l9bKN9z/XarVuqiPGQPZXwWeI=;
	b=XHbwM8lyUBJTmS60JPODRYIi5/bG34g6Yl/hTzsSriEwXOZmW4fKCACl0ds2DbdoAHxQ
	 5Jbm5lPY2AakLb9AwIPS39KV4HhcebQjG82jEpgcKOA1hb37OjdjWJ0tCOe/zLM4uxxap
	 PLrpv1WTRT+PHrG4duJKr3e5lWsx+zvdzC+Kbf87awjwYDXnoaqpWlq276LJ6dVOXP7JL
	 DPS16I20UpUuhgiHoFlGiBPHwc8c0dQ5vxQKZ27AqcFSZtG/zYBTIPorwEt5V+MqNA85t
	 YbVYKriy+GSgyoBw6BadtnqtxNa4bMKhqW7ZPvU5Tq6aMPJIOiSdCF95q8kzpQfdRnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=01zr2RbA;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C2606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88C2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=01zr2RbA
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2683027b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484210; x=1796089010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=phZ3/wAVdcKHh5uB27l9bKN9z/XarVuqiPGQPZXwWeI=;
        b=01zr2RbAU0BM28Vk/Y9NFDulsNcezaRyvp90gisA3ll8c++Y2DNq7//i+65142DaX5
         QnT7rOb2LD6X7z20LUXJbzdwdo10W8OkegDbb2doBjGVCdop/LP4PC4eF0a9fFzRL/6p
         8KPcybIi8U5TUB3DU3u8JZcYGZMKzMvwYrkNa/P/6WDUFd84xJquUb+KJbKwVFa3cbRN
         tBN1755O9PZj7DMpNRhZx2JI9n4Z6K7tSrrSLqsnS9hrPlV6NCe7Xs+elo/43Eqi6jK1
         io4Y2/KIdkcNpGL8DxFllIbAHHVr6AqgFCb7d7dmkXletVS7TiLCw7GRhz+MP8bmgtEt
         q3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484210; x=1796089010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=phZ3/wAVdcKHh5uB27l9bKN9z/XarVuqiPGQPZXwWeI=;
        b=z/8K5M5WQ9iTHIqTHEarI79muDXh8acgtl50DmMuXEwFbsakdfNAk9YdExfG1sY4Ps
         d1Pgz8aSx7xGLbMkLyr1Z/BBNs+rBoo+YnFd548ZaLnGW40UmVizHKSFfSHleABbly6n
         7NcQG6N1e56erYH75zsGgoiXuK7VIOpxR3Bvos5DvZUgqdpYp86/vjY9VyXOuNvcYBSr
         4Ff26g5hNfIzYxv4CckzzuFODLlsMfE+sg7wNOUWPKwsKXyMrz09pdvGSe3xKf6FqHwV
         wEL4dt2mfinP5V01ufwtQapqFxbeAXX6UKL9LrQfzfE30ao2qM40NA2DMpaQy5PCo0is
         +eGA==
X-Gm-Message-State: APuU4Z/QtAXlOjzm/a+d0fF0s1MQS/ryYaXKYquHIeclijJ91WZCi1zg
	qnxAs6KqWjO52RjudlHsqMQh9/X13/JH1W1jdq7JkPr9DGqMXDYpyXdORye4/Q==
X-Gm-Gg: AZFdTZeP81qcuOAkTTUb661D3dQ+7myO9/nvyDTXNTsKe6sNn7bH3eXCsjlqcSsndtC
	oigDMZGvrVWhS/E9RkMCXNMxBTHw/J2XOyJPLA3J+vo96bFeaF6s+7Oae64t/mXAr1FgcPv9OrX
	HxtkrFnh0Cu8PS1s8mDPO34LojGCZ203NPT5DU9c2DJrAvpBh31gsUyzcgPIeJZP4XMwPV2d7/C
	70U9377sA+M2oVJgLuvlaTu4srXHR1kO93ems4Xg7Nv/FnQWicY3YXU7Ygwbm/U4JSS7CKJDRvq
	t2KUWBRi3h2CgUgWIu5dpuWYq4Ro3+bU7HN9uyHtjrTnDzfL/Y0tcOVXpIgGae0F9J26AdP6g8f
	cqtPxRspAvMcpc2tapat4tDTwdDOcfF4d1e0Z2mYYcMwiR1BK2GRbcgbX0WU96YJSR0etX9KDSP
	GC9LT8pyVitMS0aXSMcYfDQNPei7ZuukzPjpf85wEc7QcXAP+XuvnW7HDdagaZy9STs3yvd3JaR
	u0HG/h1iUd7d750T2JjcL91X+EpQnRYnu0UPZfBsmew/V+EaVF0DYV2Np59y2Bj9jtjlvByJ3w8
	jTIIAvxfpIS8zkgSJIhkKX6Hg/zfmP7gJgwefA==
X-Received: by 2002:a05:6a00:1818:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8c87b4efad8mr12702288b3a.15.1795484210004;
        Mon, 23 Nov 2026 17:36:50 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-18.us-west-2.compute.amazonaws.com. [3.42.157.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cbe173453dsm3067887b3a.25.2026.11.23.17.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:36:49 -0800 (PST)
Message-ID: <6b04ea31.a9f1f356.38c09e.659f@mx.google.com>
Date: Mon, 23 Nov 2026 17:36:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4410863865304866080=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2] adapter: Fix discovery filter RSSI and Pathloss matching
In-Reply-To: <20261123162240.387240-1-simon.mikuda@streamunlimited.com>
References: <20261123162240.387240-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4410863865304866080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219836/

---Test result---

Test Summary:
CheckPatch                    PASS      0.21 seconds
GitLint                       PASS      0.15 seconds
BuildEll                      PASS      13.25 seconds
BluezMake                     PASS      201.94 seconds
CheckSmatch                   PASS      182.15 seconds
bluezmakeextell               PASS      65.55 seconds
TestFunctional                FAIL      962.14 seconds
IncrementalBuild              PASS      202.53 seconds
ScanBuild                     PASS      694.65 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2885

---
Regards,
Linux Bluetooth


--===============4410863865304866080==--
