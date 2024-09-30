Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89E198A01
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714504; cv=none; b=SAf13jKOmPQKhYvSc8Od1BCYILgAcC6vyt3KLe5dk+udBiN/2zQ51V5FY4PL2IxAUFI4LIHeBdhZxjCMZu62yfcI42SzZBNEyrHfbignw1Zf1/uJPICTNH3r72ZRK7x4l5iF14CQ/CGEZtpRfZFDb2+VWnXzgOreSjmaLH1mSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714504; c=relaxed/simple;
	bh=wQ0KKfj/Vpv/65TDDPTr8BARQFooBK5/PMuqd5VXZSI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LD0UN4msewCGqK2gxhR+teb/uPkiTetlNEJ2vUNp2tPLPStwY2rW1+4Att0qgXw8/2KB1l8adXzGvkQROEyV1G7uDmugutXwxCF8wrEn1xLzg6Ax8rQPbRZ+o+QYy0H9PMeZjSDIu/VsXBeIx/8su4SD9hUjFrze75Q8ICrOV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdIGtENb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdIGtENb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb54eef205so16853726d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714500; x=1728319300; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GfVsdlQU6OR8HO9AyeMdIPhQ0jooGkqRv20mo037jyg=;
        b=TdIGtENbm1JbTMjJFi91sIb6NFVJ81nbPR6sTH0VAFhM6RSKlR+dGzZRkTft8XukYd
         +LD9OCkVoKoe6DiEBsJsaUgUuxTZpApPYCaYogjAYkeBqfS/qbijSPU+WK9sB3b3nxLc
         kCyjyIkVFkB6hgQpwW1iFVhgpQPafT4tzkaNe1I/tkaJDM2EvmsiHEhZtYTNULhfNgXX
         KMk1nsHIp37B9Y4u6YZOXsM5Y7K0oz4kStBrP/fQrX7Ao7nqVa2uzQp0FjoZn/8KNmsQ
         F1q9jmrK9hH20NFqe9RkJ76KHuVuYKR/PiIg+wuFbMQH/kQ2g62yDiAsfjWX+rch9xGA
         xISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714500; x=1728319300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfVsdlQU6OR8HO9AyeMdIPhQ0jooGkqRv20mo037jyg=;
        b=DLcMy4hJ/RK6d81CD54KRUVY98lFQQSVsWJ0UhQTRpkAbiHJyc7pDq49AyRRU9kWgp
         vR084DPv+7N16VOSE/kx/iS8dHkScolh+eEDHYBEg2+woect9zU/cRQ/FxP837BjXALM
         TacIYZyB+EwFKjwPBTFT9EnYZg/CPC/7gX52X6iVAiYUz2x5BRqDgxFzsOD2mk3zQrhf
         4uq4wwFfF2CtAhPKygcEiKn7P8qfYO2vYsfKBe+Rwxemq2xpIN/GYNRVz/nF13xNuEuR
         3FTWatW+1XxFW+NsJlQVcXNcTD5B918P9AOosUCydADnfA3RToD1AwCKsJv4GDzbiexz
         lF0A==
X-Gm-Message-State: AOJu0Yzd1LWpdu7SwYOKFK6GHlSnfi33+l30PhxtumO6sY/GNJi6sih5
	Cx2iRWzdryvS7Jm6eZzeCvLtiAUfKwCEalrzT0KfDde7t865hM+A2+FVXQ==
X-Google-Smtp-Source: AGHT+IH6bLaIedyWHw7cvfXCPEK0YxmxIs3It/glOIRfzFLA6CMkE1RMxLPzUDdZ9q/u2/PQdGWwZw==
X-Received: by 2002:a05:6214:4a8a:b0:6cb:1b95:1436 with SMTP id 6a1803df08f44-6cb3b5ee149mr238588926d6.19.1727714500472;
        Mon, 30 Sep 2024 09:41:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff1basm41501066d6.12.2024.09.30.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:41:39 -0700 (PDT)
Message-ID: <66fad4c3.050a0220.2375f7.de99@mx.google.com>
Date: Mon, 30 Sep 2024 09:41:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2691215067875162719=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: [1/1] client: Update endpoint and trasport doc
In-Reply-To: <20240930145830.864663-1-vlad.pruteanu@nxp.com>
References: <20240930145830.864663-1-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2691215067875162719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=894120

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.61 seconds
BluezMake                     PASS      1601.56 seconds
MakeCheck                     PASS      15.11 seconds
MakeDistcheck                 PASS      176.29 seconds
CheckValgrind                 PASS      249.67 seconds
CheckSmatch                   PASS      349.75 seconds
bluezmakeextell               PASS      119.79 seconds
IncrementalBuild              PASS      1414.52 seconds
ScanBuild                     PASS      1013.68 seconds



---
Regards,
Linux Bluetooth


--===============2691215067875162719==--
