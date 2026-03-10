Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB22D592D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166475; cv=none; b=rElbh8xLOYYHOv43FheuGPKdT+StMOUJKdZJCmMHfmZDlpvokE/HcA7d95DKsD7Y/Pnzm9oS5R7AmV+yuGNaH6h7eJGxGHzUYniAaprxr8JyDHuUcz2XqVtXDSn7x2rgff4U8H285JDMSRamWidfqgOO7c1DNKp66dnw5oRxtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166475; c=relaxed/simple;
	bh=2BIyXEQnZCrltB5g+TfFs1QM4oIeK/8PPam1hr/PNKg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=edwIJBfNNPbDny+KxYP4bNzMqhto2nz3PcfXswY/MuiJFbsSwgIzVd+49me0nhdi48XV118gfSS2FZDP38RzMUzOhFdeLQCTT0mstjxmNFIVAmQwmRQ1atKXrR9TtnGsHn8zKFXgvQd3LHIZpvknPmrVSsQEaCps0h7wyHVVdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV7S9xWi; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV7S9xWi"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899d6b7b073so147839896d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166473; x=1773771273; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NTfjISq5lsgl6AJbW4Nezwz0TBG6hjYewjX/q1HhCY8=;
        b=GV7S9xWi4/3Ohmeatr/02rcUlPxQYPvdgK24cNlHI8tiAUNx002E6qBRx4+CTeBvfn
         jOGaTm0vnZhBHq/KtYSUaFTZGr0lmBdanTFHjDWAG1rx0QlIT4OlyeDV4FXBmGOQAh1q
         mlCR36jccIgrJYbYG5lZvwhXeiCTT6ADDs2gZBSj/78degT51QbjqSVwEBhHEyioJoNd
         l8LmXFaW9TBO3jZU+wdCG7Q+kv66rj3stgm34uyOTn+NPqjwrWP4a/MNrUlD44/o78L4
         OHH6PHzbRX+DKEmYwGT+6fImhJKtPHw0ZKBcpSz16l+00yhqTOHe7fzcI4DVM4C1I2WV
         4ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166473; x=1773771273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTfjISq5lsgl6AJbW4Nezwz0TBG6hjYewjX/q1HhCY8=;
        b=P2e1yi6ERAAdp9vIfqd0i3xPqyaKFqYWOJmm4J78d1yz4SX0shlFpM7Yngz8iRUdoa
         +Uwe/ncU3g9KRdXzliz/80MSzNRrICiBD6Vhb2cYkqoPUbwNKVdM0LjSBhkEl/9qQxPz
         On6SUPjCERgbZh3f36mrIjax44EA1Z9nsjq94dmlKwAgOyn9T5BMmJK+gOxp9jOyQWl+
         21+25fYG9bAWwS6Qf/ieT4c+oRFnSt6vu1+s57YyPpt0GAyxrHcDXrQEz+ZONgsaK6We
         hqp6kea7jxGidrXVv/pBIqJGty1w/ij0JeYjUBsbNGjRsto4PGUxxdl/P1hkqNQW1vSR
         QwrA==
X-Gm-Message-State: AOJu0Yzj0tOJ8PQ75GIeFGIfb+P+5jCtEKCbEJ8ip62tLCCLHLfUptZH
	yyQxQB7s8oqoLOPW34DsuUJ+oZP4nbVMwH5VJdoipbPd4hnGhkLcqI1Oicjvyw==
X-Gm-Gg: ATEYQzzZcUNizD5ZX8/0va/VypjCS+J95xvqei+jZX9Xn1RrzVCmGCcIEbImVUS5oeA
	pr32N0ulk9wX4N2hGpTiGd0J2P6I2aLVQ2n4jWqJ/S5RUM6P9HVSjZ7o5f9fcYq3+mh7M1pg1Y4
	EjhlP/k51l3LSJ4t0S2oc/oZXxnBROFiYdV4qtAn+Gizy3mQIPKMwvHo1geqOTD1XnLzAJ+2ZJV
	W+GF8pfQo8YtNF65NlOwaINA+SdF3OrN8wHVnZa9Ukbyes74dchjCMuhvZdO/P7yfM0ELwVIltn
	18rsCGS+/fmfkn6EWYOA8SOGJo1We0BsCvYykx5F0q2gHxMGVY7ha8SQJhn4igaKFyIz/RGZ7Lg
	eEONysEJw+GMNgS0ymBcu/Z1cCVGNxsb1J1ka4J591dc8Y5EerV2yd4TIXXvG65HBP/mw27RojQ
	ELDUgJjyYfxmybtr8sNwpF8uamWDY=
X-Received: by 2002:ad4:5d4a:0:b0:89a:8be:9d34 with SMTP id 6a1803df08f44-89a30aa01cbmr250115036d6.37.1773166473359;
        Tue, 10 Mar 2026 11:14:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a1817dsm22840536d6.4.2026.03.10.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:14:32 -0700 (PDT)
Message-ID: <69b05f88.050a0220.38469b.c0bb@mx.google.com>
Date: Tue, 10 Mar 2026 11:14:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1698601737060023487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/6] doc/btmon: Add GATT database reconstruction guide
In-Reply-To: <20260310171126.342447-1-luiz.dentz@gmail.com>
References: <20260310171126.342447-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1698601737060023487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064536

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      21.10 seconds
BluezMake                     PASS      654.39 seconds
MakeCheck                     PASS      18.86 seconds
MakeDistcheck                 PASS      249.05 seconds
CheckValgrind                 PASS      300.85 seconds
CheckSmatch                   PASS      366.23 seconds
bluezmakeextell               PASS      185.89 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1050.33 seconds

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



https://github.com/bluez/bluez/pull/1953/checks

---
Regards,
Linux Bluetooth


--===============1698601737060023487==--
