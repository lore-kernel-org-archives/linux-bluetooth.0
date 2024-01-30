Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37A67E6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614948; cv=none; b=g8zgXh2X6frfU4wTFq45f4uU5mn3LtsTe36DBmJQJcdjs73eyYZE6pbLPsOFYYz3sgdaWtq8JkVqsq/fno80tIO/0YjZA7r1r5N3wMwvzP0sFul3bNX4+nLc+VU8gurzmoYsQ+CvRoM5wv3IVwdT6kFlccbT4z/8TQGKGbe8Cq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614948; c=relaxed/simple;
	bh=XN4Z5uHRBw3K+0LhHZ1LH34M8dqQMdHttDy7aMZc3UI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gYew0BlcMMtRwm/8TTxiZwhk2qEGAIS2ryfsY0BsgGyTRJ4eYHqHqwl3JTqwpyFWB38ZbgDk79wDYC5pJTeGV/BhCha9GGt4QkMIz4H2odpIfdKhybTK/zL0Z8pP5M2KKFSGi9pYj+UZLmV8Am7kVSZgt2oIEfiWS0FT0P7uu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7szrZ27; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7szrZ27"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783f553fdabso153096485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 03:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706614945; x=1707219745; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mfO9w+OGjh3J/rGwbd0lldlMr4gVLqN/OtxiyJC7g6I=;
        b=C7szrZ272CPb86Oa/+BMvp95hAU5mweMVHz4PIDZ2Y/lqa+hP9H6cJxfVRv4bcgKWE
         IdE92zluIWH1dmzRTNiUvC4UnNKgjca7lin41bpicWK6JguMzYl3IYA9HriUEZ7vWBvg
         ZdhQKdZfo8ITetDkDK+856r/mvX28hlvTmaLMDYdKDJM38uF6Qww4uJXKBv5Hfk7ZqaE
         p81e6ITNYfEawjFX8IRrv1D36GZ1YSZcA0vhoI2lmHVm/Q9W0uyK8D/aeNPE/4o609tc
         0Ez7HMs3l5wDtfLaQ7iqyuA6CmeN/tMnLf6WTLmQUspix77dP6zMaD05B1Gsnl2ixxjp
         s8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614945; x=1707219745;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfO9w+OGjh3J/rGwbd0lldlMr4gVLqN/OtxiyJC7g6I=;
        b=hpiTeWtLEKV9He8D7PzgU5tqHBRY2ZupNwxUw+Cm7r+CFqy6ansB6UcUJietdGAUQb
         IsYY+/9M0z5eyzNIdlMhLpVZFKpf2WcOuseERgQ7kaewf8N95icDOpBoj47M2KkeDXv2
         Qgmzd5ihnRGFuBKgxzDQOC3c1rqnGpYu8ZQ/R68F8Nl2ffWGzTXRuWX1VMc2cId1Rn5k
         r+faWwelB7LeSM2kx7zohRq0v5XiislvHkFCq3gun9at67h4Z8X+NkQAM8a0P/vblOud
         ZNiZznA8ccvMNe367GRqUku8wxWisuwMJrPsTz6OYm9U1nkTP2X8mm2FhX6bBCCZszxS
         PhYw==
X-Gm-Message-State: AOJu0YwFfCybLaQFmTp+93uVHTcz5ixhXgYElp7xDjIWmzkx/9RBYCcc
	B4OthkHR7RF5bbzOxION5fp3A8819muvosE0TkBVq7jJFn/KmjRLgc/d3Tan
X-Google-Smtp-Source: AGHT+IGTyu9vBdtAxq3B4Q7es4g67PCOus190u4irVZDqhINVslWdbbTqfrmlCk7lLoclIbg3YdhNQ==
X-Received: by 2002:a05:620a:1669:b0:784:45f4:63e with SMTP id d9-20020a05620a166900b0078445f4063emr702327qko.73.1706614945530;
        Tue, 30 Jan 2024 03:42:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdgnPHlP4v58xwil2SN36M6SxARCNXFYUENSnZLVKf8As9V2sKapw60OHj2Psf7DW5O2wZPxejupc4p7Mq02hwvAo=
Received: from [172.17.0.2] ([40.67.141.241])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b007840ceacec0sm362600qkb.105.2024.01.30.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:42:25 -0800 (PST)
Message-ID: <65b8e0a1.050a0220.2e10b.0f4b@mx.google.com>
Date: Tue, 30 Jan 2024 03:42:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0204569632278494477=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] Monitor: Remove handle before assigning
In-Reply-To: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
References: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0204569632278494477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821233

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.40 seconds
BluezMake                     PASS      734.57 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      166.71 seconds
CheckValgrind                 PASS      231.79 seconds
CheckSmatch                   WARNING   337.51 seconds
bluezmakeextell               PASS      109.66 seconds
IncrementalBuild              PASS      1351.96 seconds
ScanBuild                     PASS      941.39 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1867:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1867:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0204569632278494477==--
