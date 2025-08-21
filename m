Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DB312808
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808357; cv=none; b=Z3IW1VX5T9l7o9OLTKfpBMtzBQGUzbd98rt3+QWfOD7l2TmU0WPRFXy412zpMpgipZTpGndriSZeFcPcctY4gKN0gZZkjHIq4KaqGuTJ3/EDU79XmW1wi8zcSnIB9civJp4SQeT9Iu30isWKH9jSCOY+mA+20P1WuaLZj3hswvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808357; c=relaxed/simple;
	bh=KFInzZ/3OoqVkkZV1Dw/uQ7v17cldrTFbxh826Sa9zQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bfc1ag+HoNM6tjYG7Os/6RFnqHzgJV4WZygmxTZPJkpjxK1mbCSRwzYFGCoF1N2WewMmxwtpJrUtXhWQw9zoodeuG/FFSPClA3IfgsjQn09M09lrRuauiLqb7buMJhBAexvQxetxjPRzqUvpzcTEik/IudgeteJXWQeH9BFZcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKd1pTaR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKd1pTaR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1351021b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755808355; x=1756413155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KFInzZ/3OoqVkkZV1Dw/uQ7v17cldrTFbxh826Sa9zQ=;
        b=IKd1pTaRSi0+ZLhSyqSBYPFbQQqCTyld/TGN1AW8diDu/sEoz7JbJJib2b56Bl0LFH
         qJdzeYYa7BMC4OCLIEPykO5aaIGljZL1X7mNojrKBSIUO+dxzqxa6Eccs//HcbSHJzCy
         k55VJWFd5fklGtkTZzjCDdbIeb4/r924ZjjpquqAXTFO20Oh7fjUyS/PmvMBajdHmKhi
         aINSh/C0gpt35F1bd/tOaRqdww6JODafe0pP3hxoKy8uGoeU7Q2BLoPaCn5rDNug1Bx1
         JKAQEVIwU2OYzEdxQfEDNVboMtVR5SqOnGVL26Jux4jNQuoLtrawqpOsGkOIjzEYas+A
         aCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808355; x=1756413155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFInzZ/3OoqVkkZV1Dw/uQ7v17cldrTFbxh826Sa9zQ=;
        b=nQIA67ri8xFZvUKB0u0h4gCD16/mTZDKhwjAypaM2hevm/56P1aOMszTirCwCbzh3E
         hoqq2dP4IwG9GetugMKNOUW+tHYgCrHOXMT34l9p3QNNb6mrbAmVGIlx/YSU0RujqEyS
         YOToIXYJTOHfx6Koy9wEBVNZv6uJ7+dfEturDQAR4KO24joCC3Dc8AAufJL5nCNY5AbE
         YnQPgYan99P2V9m4VGvp5iDowYPlqhdCuag7P/TvrEHnKW3rQ4cW+lS77zXVKEuRM4cl
         N3S8RVwtXKD22t2VfthbM/AxXFXziBYy2k+9H+8NYBCPF0nD6Ur5W2BrPd4fnqgGLOzR
         7NlA==
X-Gm-Message-State: AOJu0YyKtOalZR/1rprjCzcMlBqg9FEnt6dCN2iDcVOBRzYhsfy8bOSN
	O9MOfF4vSyPdHy1Y4xy+sk2KFrV+xqR62Jl6rTSsgH1FAd8Y2VxP7Iy+Ct7w3Q==
X-Gm-Gg: ASbGncvhvi2yzn1v9lpRtrEfpi7jqmyqx4UtVlCmBFtmiv0F+Lf3ew2w8lbuVJ2rDnA
	qHKfdizKX2jJnlUIpN2BcwvSxx6ARU5Kfmey6kfeFaylWEcB8mGLt0jTcWwM2Z5KrGXTpDxuUos
	xnS9oPmTupmy+OwCYalAqWuncQL1vIzjpyZmcSkwmS2n0wdBJsD3EyhL8VowAJiJycjaizgCw7k
	2lJC60ahkvfqXVqSvrdfkl+FhglAnBXTIeMFZ3E6zeXm0xQk+od7f9pLJVN/jQLLHZ7m7SRO07X
	7/vl95tMdjLuM8rUwdSQ1tao2QR0pvVXwMh+mQK5hiRjyCto27To2uzPXuo6KV9OuCGO2qsHN52
	wR+Y4FXvGcQjvEKkduQ1WUUy0ur5VHRU=
X-Google-Smtp-Source: AGHT+IFdBxtrgEoPMBFi1IGTGlmSPgKc1s3Ev9N7xMo5l9uydNYxAkR+M5f94UceLrpUseBoY0rR/Q==
X-Received: by 2002:a05:6a00:a2a:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7702fa4f732mr798995b3a.10.1755808355454;
        Thu, 21 Aug 2025 13:32:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770300797d0sm303312b3a.64.2025.08.21.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:32:34 -0700 (PDT)
Message-ID: <68a78262.050a0220.35639b.1447@mx.google.com>
Date: Thu, 21 Aug 2025 13:32:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5189031996542681875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nick@koston.org
Subject: RE: [BlueZ] device: Fix device removal on le-connection-abort-by-local
In-Reply-To: <6C943D79-4B06-49E8-82C2-EC23F903F91A@koston.org>
References: <6C943D79-4B06-49E8-82C2-EC23F903F91A@koston.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5189031996542681875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5189031996542681875==--
