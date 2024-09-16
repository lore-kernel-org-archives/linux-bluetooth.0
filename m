Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB325258
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525655; cv=none; b=rBwdVH9Ed6zPfOml5exNCNnQ3eDmgbfMeNr5eiPJ8Tqu94RVXjR8iE4oYfaU7lSfR2fsLJUe54FiWriwfD5uiq4DK+svQQBNYNburHJMjkZyug877Y4f4RRPv25LS/WVA7+JAyzhpwXme4bdZF/Ze6CsOpawewIclrEkqt1ZRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525655; c=relaxed/simple;
	bh=+qQTbU0nBlkL7w0ySgdUSfa7qvwcu6vMSlG+uqoea10=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eLwYiQFCg3sMqqAI7YtjHDx19n193aFVN3ZzO0AM5zBosEz6hR/UhM/WQdSr9olNkhkecEimzNfnQZm1n4UM6MoQ0eanp+vE/2LGoVyhgp3K5QOePeGKSlmH8Kpnt4kr/ECbFi8AR/ixslqsilK4h4WYD+daDbGjdpLFw1ynkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQyOPEhW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQyOPEhW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so42763195ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726525653; x=1727130453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIxGEkjV0cncgSwZXbnJ8RfmVlwQlu+GgaEm2DqmG7I=;
        b=XQyOPEhWNy0wUe4odq583NaJCSAvWGjvsu3f9LJG72/CUZJFbLtVX5FA5hkqWFVghY
         mlM56nnFqkEYSdvtpH1NzalmX+D0gW6AVcWK3o8WGY1PlDqH3hqP7HEZA4i/V2iFB6KY
         0BxheLBWp5RXdyPcuQZM31gFHbK8P8B9o2iZplXnuA/vJHgqIV5EjfxCcYx+UzqH1waw
         TLvv489kYgV0Ie3tuJmjNgiDg3CmEldJz7EohPOhF+TzafEAzftTzuoDNkix89jMK3lO
         AY9BPIOXo8gQ9Zzm6gB49gPukOh0KrPPQ5gDovvIlb0Ko/LVwH+o/ZdF3lsGmKBFIF+r
         0f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726525653; x=1727130453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIxGEkjV0cncgSwZXbnJ8RfmVlwQlu+GgaEm2DqmG7I=;
        b=c55FvXhKNRFxxJAy1mwFvlMbsRRpXYlLX8MLD/TyMhrcWVMQn/m2ww6RA1835kK/vy
         V+ix8FJMfaOaQ4o2YtGc1fiHPCXM18AbTGHV8ydZC0i2Uq6RstZstCZ2TUIbBuAgPxHo
         s+Ydbx6/4iZtAhrKGzVJSsDr22+hOXnUULwd/sMS7CNwJhOUqgPfjiHKmBHA2uEZWp9s
         nfbBhxRn2cMPlGnj92/YizkhWuWwzchkKVfOjUk5x1ehExL/5Efw3RWsSUpD+GTbNVQX
         MLPmxH4u2a5ov10G+0WI1qqEEjbA4YGVFaocrc9jhXyPAua7KO0rWDyY94bzjMvSR0Ev
         V+Bw==
X-Gm-Message-State: AOJu0Yx16FNpJQLvkqlEfIs7VgcPk/yCc2l4zwzmNzg4KcpmIZdAllf9
	cH4Xaipawd8TxVvZhUJyyQkZZJ9f6LsDM5wLmxw03GU4T3k8Tn6EPLkbog==
X-Google-Smtp-Source: AGHT+IF5M8y08EVkI2wVkX6Bp93fBRhTaX6zhpEi4YUKqU9e0IJefwgZyTMG6/tPgh/FN6P+lX9AyQ==
X-Received: by 2002:a17:902:e842:b0:207:173d:d400 with SMTP id d9443c01a7336-2076e444173mr240370465ad.61.1726525652624;
        Mon, 16 Sep 2024 15:27:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794605721sm40869015ad.111.2024.09.16.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 15:27:32 -0700 (PDT)
Message-ID: <66e8b0d4.170a0220.94c9f.d381@mx.google.com>
Date: Mon, 16 Sep 2024 15:27:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8636172040509777263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/uhid: Fix crash after bt_uhid_unregister_all
In-Reply-To: <20240916202341.238735-1-luiz.dentz@gmail.com>
References: <20240916202341.238735-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8636172040509777263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890773

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.42 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1637.31 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      178.59 seconds
CheckValgrind                 PASS      252.10 seconds
CheckSmatch                   PASS      353.91 seconds
bluezmakeextell               PASS      119.54 seconds
IncrementalBuild              PASS      2900.41 seconds
ScanBuild                     PASS      1010.87 seconds



---
Regards,
Linux Bluetooth


--===============8636172040509777263==--
