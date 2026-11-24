Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504122;
	b=g69iQarSpthlOJSd7FLgXfMTLQhnG3uTmck2vvICrCHidjSlD8fWkbnk105IL4iMzCqE
	 v2nI8dzeTr/ZYPz+5Wd2GU1omTmErngZMbvWtNlypRp2eNwpOoTLbhDv+K23aahDfDvPO
	 e6egSkbn4Q3lbz3VOOvq7dmTVOzd2Q8inMmkF4imFcKK+I0XL4NGbKplyo2U4qQ1hPl8/
	 m4R+KG1actPmcGmwivX32O6KPqRjNct777+B+W0cUwE2s3ULwO0cMB4d9SWM5zPajJOhQ
	 mUaurNuqt8E5alLK0jXVEfrd3zxGb8w0uQUXePnM9Jsir6WOyU4WYr64PUkVZ3VrA9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ginmaOGHwnme/2+7oX1iTiv0lYdQqlSEeVpAEDn/Y/c=;
	b=PM91a7ob93MTZl874xhWaYlgd+3tfXvwsLgyIGLrQOJsQIfX0KD1aaqz9LtdhndHZdnk
	 yYRKRwgx+Xb0XFNnmWxGxkxPrJx+2+qntYtt/chKWqmWiHaztuoe5nP20rOdLYSD1J6Ui
	 15GW2JL3QmjgaA9xWMeGv0rJCLU6YGYRu8CbecRTD0CATIbNNISSlJ5ufAX+rurmuUfQD
	 mjxm/B9h0OahBDaoE3GJz8+DrBbp7klxiihmZv1hQ4b/ASQuIfSt7qfS+7Y61YkXMRWB9
	 hPJqkk7FpcNU6kLWfCgOE8hKkKf7a1Y1padUW60PKWVIiTyDp9ehpo32GDy3yIYVAUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezf0ebje;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A8606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezf0ebje
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9213eb1f3a7so35665376d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795504121; x=1796108921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ginmaOGHwnme/2+7oX1iTiv0lYdQqlSEeVpAEDn/Y/c=;
        b=ezf0ebjee94Hkhq1THzUe7ZI8ZFskv72Lgv4dADWjfArtyh4Bu8BUCpB+GwIRGYU5R
         gEe+3fuNFMZY4hEjousVoLlptcuQvq0rGhVpCZGXllliFZpLFhCDfFjnjSUmWxpdgs9J
         iHajt8qMpBBEeCeb4RfEXlnqHKL3IVA1xfEeIRpiEL9xIBT3s+29ygGXE1m5tKdOleO0
         O1ylgChh8lqKATxE4hrMsEpdrnNN0bmZS9PPsc9zoINMZD3vo+Ao682U+W1LREDW3UQp
         vES3ijGuq1gC3R6LTy+FCsvAZbJJiNDY2DW4SrfUL7rVaWk/EBiFce9v7FuY49/klvFb
         iWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795504121; x=1796108921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ginmaOGHwnme/2+7oX1iTiv0lYdQqlSEeVpAEDn/Y/c=;
        b=k0e7xe5yZFtsWXu/6AqlXfnxjBvljX2oPu8HS5Yj43H2+klnW51LXyJiIU5MJA4MtQ
         eZVFIkMAK2ZhhUFuRHBIil/SdlbM2AMFUSRtVoT0VJ6SRxQeZVsvI2ykp+QWbHJ6ehZ7
         lsCWzqGc73m1NqrTlUx5/l9QTHfAcbo3tgD1x75uMGCZs/NRUQzO2wCbJlvjoCqWXOS+
         1wJ2NjKbg3tpq7crrfcSeFnbPMg/VjhZ0wmnkMNMOiSY8b7FNLBbWWXmjA3RMKTMaWt7
         196EY4S45+OwOtAGD4nurwxKJLbdJ+DCkij3dzUOdi3XVra5iIGXpUUawsf5tik+QqOk
         3fFQ==
X-Gm-Message-State: APuU4Z8d407D2zbVhpPnGoocNVNlYxzRUaqL37YAb39OiQOVIQe0Szy1
	dWuHLRnBxaxG1WBxb/8BrFlwvKD2p6my1Jyuc4sMEKPJjqj3+60/5ZtQGE66vQ==
X-Gm-Gg: AZFdTZeWKFXhWBSDByiepv7ret2Y0frOyZI/nmzMVrFhJ8B89hPsVuycv0w2mjkwFKI
	nR3ydaVaYawfF5M7nzXd8UB0dRwUDu1dJwa6CZNlhqAQSPMYqLstztgoDjYcezwITr2W245IAs6
	P5Q92DSHiAgbUDhxOUej+DNzjFYAOLl+CgSNZLbMkW7DxsoA5PMelKqokcWAzOOxw17AMisfIjk
	THqqkBja6w5Hd8sUFHLpN7ZbUfuqx1Jz8vPdyNFTgFCQ2RcVGskaHQsn4m3fwa/wT567NhTkXTb
	8YQeLEMSMtT+UrFM5XLMRgTtp6m+Jk2wRiuXC0bPjVte1JbDedhUpICcE0wQh0odIfKRuS7nkRg
	AF3R7uklq+1Tqv14980LcbJ+HbSSf/5CQljGzCwGMRem62vFvLG29ZzNZKBFY/WBN76KxynYPrK
	Es/WmUwhsm3uJCB8sOWr2DZChuDnIKO6Jx/BDxcDkh1kzaCE6M7z3vxU0+HcibUaHnvaxOux/mz
	sfUXzUwaEgSpSiDcVh88lBIexDBLFyxmfJI4ZAM/W/OKWaPMt47D8pNvca6kOOP
X-Received: by 2002:ad4:4ea5:0:b0:91f:191d:f7be with SMTP id 6a1803df08f44-92134ba1fa0mr242587606d6.52.1795504120999;
        Mon, 23 Nov 2026 23:08:40 -0800 (PST)
Received: from [172.17.0.2] ([172.172.237.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24aa8sm127291206d6.42.2026.11.23.23.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:08:40 -0800 (PST)
Message-ID: <6b0537f8.6f623023.40198.ccb4@mx.google.com>
Date: Mon, 23 Nov 2026 23:08:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2340248483220131845=="
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
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v3] Bluetooth: btintel: Add UEFI BPMO support for PeP
In-Reply-To: <20261124053812.249973-1-catherine.l@intel.com>
References: <20261124053812.249973-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2340248483220131845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220377/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.41 seconds
CheckAllWarning               PASS      35.66 seconds
CheckSparse                   PASS      38.42 seconds
BuildKernel32                 PASS      30.90 seconds
CheckKernelLLVM               PASS      34.59 seconds
TestRunnerSetup               PASS      749.50 seconds
IncrementalBuild              PASS      29.51 seconds



https://github.com/bluez/bluetooth-next/pull/1211

---
Regards,
Linux Bluetooth


--===============2340248483220131845==--
