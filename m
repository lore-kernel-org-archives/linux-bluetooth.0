Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D917260A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792991; cv=none; b=h66dchmdRgB+T8jmvKFX5nYur3F/6CC9U08GWq5B9fX6lfeckdS3AW8gRYYDRXpt+7ljxWBIJBIAO5o8F6+8N0XFyZm2PMbZoWFcShkNDBIqlvlbjH01pwm5x3suReokO9QiCoIC4+f4iuV4jIMRZbQtSta9UQCJzYba45Ca4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792991; c=relaxed/simple;
	bh=UUBGzuJ3WQzaxcQH6+dEjkKSEXq4AzV/Sm/TLIwGXg0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oghLC7dFpuQ8b1A/3bdaggfHICm+zhHBTgKimbWlKpWOE48KULBMoB8g/cdMFF22XNSt7Q2uqczPrqTcD8JTZ3xvgjwHxAQxoOwHpc+LJQMdIzegIeYPH+AqSbxF8t9d+FYIDNiCe1bHMp+PW5Pyt9CMNQqzkuLNBMLg9D4QpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1X+JUho; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1X+JUho"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5029901389dso17600001cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769792989; x=1770397789; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUDQOjEj8t45apNf5Lk+yzBxEucH57rcvKlFLwjyzpc=;
        b=G1X+JUhoC8T6qhVMhhhneTTNRqvuDngxWoL+ON7mW+4nJuXWom+8H/iRaufwi5xsui
         1r0G6emt2N9MEdMNiFpScLWgTMUJKzrpI7c8Xe1VuvEScfNAXufn+MBarjq3fwCB9BrA
         9v6lrqwdFh9ON/S6R5bve104kCrrH9T9KMT3BiPmV/vZAY651wZMpI6R9bjfv+mJvs0I
         nVfVkLqNac6ErpoBK+eLErQkbGJ5+/1gEcwYICuU6bvlx17W2SqQEipY1fwheGUMTph9
         hza2PwBJZ+dJHwNkPYntBI2cPmcXynCz0XDzjdEID5ETbMjB92bqKbB9rtp1tJIZYej5
         iPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792989; x=1770397789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUDQOjEj8t45apNf5Lk+yzBxEucH57rcvKlFLwjyzpc=;
        b=Sr2RujCmG9Bq/WA3igXzZNj+DpoFBOk2/aqHYKGm2EztJLG8SZkUcbZ1Pj8PAb9/px
         DS6IlQjiZmwxBF5ud5VOwFy0299ep+Ou6yF32anJWRB737kw020VUfJvCbz4sMGO0rip
         0/HqwsXXdh8jhxf64ikR0I8tNGN3Mi8hMFbd5ku5KoFapHjsT9d/EOpAt93MnokTYeFI
         Nkddb2JWmghF2AW7qb+cSTQL8kF7sXG1Z+qn+YZbUtmkhReqzNL7zbQF2/B53F8ISlMf
         ByA02vsZ8ClXkEI6WSbphesK9E+9YIbv5/ttGIk/m0tYsUqRRntW4RKSk+j7KYOPY1Pc
         tYgg==
X-Gm-Message-State: AOJu0Yx5QsyCCp4S/15JO2Lmvav54m3JkEM/Jehd3zmZTEvR0R0PDfrf
	NP4qrIq27PlIQED9FVl5lg93XkkNt/fnFxn4zMk4vQ61nUaCQ8UTnNwMvnXDiFU1
X-Gm-Gg: AZuq6aLQ29/Lf0bblfgxwR9JnbyHeeZu99BWLhffvvk1X3PDBKI84sKWGItlLr7Y1Kq
	Rb/CRL5AMDr4w3/V4mEc8dJ7NVN+dbI6wEXhZrhLi+LE9CVl4hFddly0qzVJeo8UFEp1q/hnvcp
	/YjYG2Ch8lRFJQlCcyXs0tWMY56SWRWG6ElVBbqFc8VtMg4FguZPpcwhGwvs681Oiiwhe4c6Ggw
	kVT7NlSZuS/LDL3DsO+vYNKYNXeKxg4iYgGcchlbZ7ljcPsr3eYlQAhYv9Ne5CVq3asx1L54tbD
	Ao3gchBjhrjvS7gktpp1Apl4br8mBS4/5l5W8cK42kK7HbaeTkk1IsRv+2teBihc3ZuwnRABB2y
	lrmxj0mxq2TL2PiUZHL6uwX+ZF+XnDPUagXHI3ID2Rz2hjCrpLgVtU7y2elGtqK+ZuRw5TyW5pQ
	AwU4wGMKxDf5qGPaPM
X-Received: by 2002:a05:622a:1351:b0:4ec:a568:7b1c with SMTP id d75a77b69052e-505d2188659mr51770071cf.21.1769792988527;
        Fri, 30 Jan 2026 09:09:48 -0800 (PST)
Received: from [172.17.0.2] ([48.214.53.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm57431071cf.29.2026.01.30.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:09:48 -0800 (PST)
Message-ID: <697ce5dc.050a0220.1201c.ca1b@mx.google.com>
Date: Fri, 30 Jan 2026 09:09:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3800240881095217206=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] monitor/att: Add initial decoding for HIDS attributes
In-Reply-To: <20260130155637.1150573-1-luiz.dentz@gmail.com>
References: <20260130155637.1150573-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3800240881095217206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1049069

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      640.73 seconds
MakeCheck                     PASS      18.18 seconds
MakeDistcheck                 PASS      237.68 seconds
CheckValgrind                 PASS      289.67 seconds
CheckSmatch                   PASS      346.94 seconds
bluezmakeextell               PASS      180.44 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      993.59 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3800240881095217206==--
