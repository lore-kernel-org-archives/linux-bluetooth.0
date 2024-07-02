Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D5158A3D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917016; cv=none; b=kVwj4R5bW6THL4+ErRdtZHgj3iJbni/nXvgP9gai5LhSkK/+IHloAPdPgYurcGr+fwzFUvG/ROL+yF1SoAAGgcxercCOKqAH7EDBa5hr2yT8py795btncUcs8cSk7oHJHubcVJlLVYMM8FvgUkiIYVgK1jFV8q/791oC4rUCXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917016; c=relaxed/simple;
	bh=4q31HOU+sqj/zeE3K5AMwfyeAgalSBaYhTtOceqbfRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IvLLw9Q+3Do8vvRMManoxaRVtnS7PMwc1hi+n0lypHJvRqQyOVxJD4z1SqxG8Z1mhzbKoLccmbIwJhDBYFi6Ozv8IAaL4MBSaCm3guykgTtIrfFSVzlH006k+H+Pry33Ld1daIn5hWjwXaOUnnnRJOf6AqNI1xzlpou2/rQlfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKjrbq8Y; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKjrbq8Y"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c04e6e1b9so294423385a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719917014; x=1720521814; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8mZNze8T4V/Qdc2EDTScSTRyFapJx758GiRhdUvzbj8=;
        b=NKjrbq8Yx8u4sCGqFz5o2tq8sZV9W2gsvpOFQwyd1Elxgpk+ExAkf2Dkk0uxAJDbau
         kWNU/XeabRi7C9mVVuko0Co+bpM3MGGWRCR9vdkKE80YIFohe+V3Z0+BVme8k/LtrrSz
         9enFCMPxohpu5gVHZV1Lc4tJS9Zm5rp2ZUAybOLAX150TtlwKbve/k+My0rUZP3D3rcr
         5S3O7NCb0H32GrGXB3XC5gTJzWrr01jz0zg26mkeV9nCbfg8OA6IIbbCYNEhQDORpVUh
         oOLTh3O5dlz7V6lD00AauYiBaADSGH2cgwK7O9OXGGJASxXTC6WxqBHwHzYw2HW99h6j
         SHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917014; x=1720521814;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mZNze8T4V/Qdc2EDTScSTRyFapJx758GiRhdUvzbj8=;
        b=dyDzi4gZ9tYUEGroipSyUdvRNdwXuggs3/oReA5wi5uBePxW07pcAtkw+46OSmiy6z
         Et6fwCxxzRF+FYs2kEbpS1j967+/4ZJW3CIw5ylGoEsaCefjsrW3zkc9qlvo/pnHLE8w
         FViNvvuioLJPDE2dQfBHvF8xF2qdxLUCh1OkG6TSaH1x/cy8Y2Y18vRo6VUq/HmAf1zl
         3GizGY/Ff0C+d75vEJtNIumqm/XTLAfoy2O/seQmTEpJ/fgkAFm0oOXHrbn98dne6ioP
         n/U+ZsEVD4RFuXkq3/biP5jqnpdOqlEgDdsiaMr+pEDE120JA+lRkRjfCCF7Tl50BtQi
         Objg==
X-Gm-Message-State: AOJu0Yw5Y3o3pww25d7ptpNoF8DRNzammO4KZFvb6NYhRT2WpzH9jlBB
	l//uOADsygq1MlRW22SamKqXvnbH70X0PMvf2AyE/Jy99HFemd5QC9sXDg==
X-Google-Smtp-Source: AGHT+IEygiFkxCYUfrYB1dTsWH17qmki/zTjONuyEu/pYTlKXSCQ5w/0UQ+5EAf+BxHXeodgmRXE0w==
X-Received: by 2002:ae9:e017:0:b0:79d:5b0e:fa9f with SMTP id af79cd13be357-79d7b9d5b16mr991231885a.29.1719917013747;
        Tue, 02 Jul 2024 03:43:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692eabdbsm440869885a.86.2024.07.02.03.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:43:33 -0700 (PDT)
Message-ID: <6683d9d5.050a0220.954bb.0d45@mx.google.com>
Date: Tue, 02 Jul 2024 03:43:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3029635667911663931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/vcp: add NULL checks to foreach_vocs_service()
In-Reply-To: <20240702084907.26066-1-r.smirnov@omp.ru>
References: <20240702084907.26066-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3029635667911663931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867449

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.70 seconds
BluezMake                     PASS      1736.53 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      179.86 seconds
CheckValgrind                 PASS      254.62 seconds
CheckSmatch                   PASS      361.60 seconds
bluezmakeextell               PASS      120.88 seconds
IncrementalBuild              PASS      1490.20 seconds
ScanBuild                     PASS      1041.47 seconds



---
Regards,
Linux Bluetooth


--===============3029635667911663931==--
