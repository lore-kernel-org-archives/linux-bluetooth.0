Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81922D78A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTF/+yx3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-781df3bc08fso99923685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704462175; x=1705066975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGK+p9L5/NS3c9KfzD1L/3JHhpUTS78KTmVzwgXSRT8=;
        b=aTF/+yx3ZrZ0fJBEABYcTnf+nYIq8B3fOREvQeTHPhvD9UAgjiWoqCzsku93kEdEc2
         2RY0NAQDF9lo7eNzN+6AoOmYAwOk5453lL3Ps4j6jmoDRY1CxJWQoNYiA8Rd0I/cr8eg
         OwE5d5y25lWnWQD8d9f7MA84CXF6Jb63OjkgIi/NijJs0M7oYXFtYkLc4oMNJxiHbZVG
         eq3nWu0aUQMs4XHq+6xjDtd2XBK3WxD/VrxgOGBh31cLuS1L/M9LkLMdKz6h6ooMA/I9
         7rOwd9T0F/iTwDePmXRS0rdmZBMxiCMMe1LYAVDcR4TIBNje8buapbCGMenqNdoRAyib
         LsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704462175; x=1705066975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGK+p9L5/NS3c9KfzD1L/3JHhpUTS78KTmVzwgXSRT8=;
        b=bn7rVWD1Ohn2VVJGmHkAf6wCC2tL0ivW0IYuStTDzuEOb8rGlLNeUaXs04vcH75rmy
         M6ktcRku4uZEXx6+5oiaMQOlbVaDR01Zsp68kH5RQSdIbgFH0tite1ar4GsAdrj3FQee
         DvIOOeo2npy9fs4iGGhlUokURiNzITR2ww874nVE6vVVhlWiVl1XsjVSWgB4Q4lujjQo
         G0Da3L1Xwjy6RZmZzkQoQamzwbWYYHNbx6wLmolbeANRrdEs1Lrd7Ww13pX9sihaOcsT
         4fByg4Vk6jJmSdHPaCZSSmf4THrjS8k4ooRWOXO7wv38udKXsyhBls56RT5rxiG0tdB8
         b38w==
X-Gm-Message-State: AOJu0YyoBg+MthiYLMhJgIUp+IIZAxIGkTFdSxQqxRNj/lagiLRNmBYX
	CW84ft929BlUAWQZhg7wJLvrdhsC4ds=
X-Google-Smtp-Source: AGHT+IGbhoVww11ZEDZYJSgLyRI7iAEATR7hym/dxuhTV8/7w4689lfhqwB/qfI2qnen/HXTZZLWyA==
X-Received: by 2002:a05:6214:21ce:b0:67a:8e08:60a3 with SMTP id d14-20020a05621421ce00b0067a8e0860a3mr2193185qvh.45.1704462174727;
        Fri, 05 Jan 2024 05:42:54 -0800 (PST)
Received: from [172.17.0.2] ([74.249.5.110])
        by smtp.gmail.com with ESMTPSA id jh22-20020a0562141fd600b0067f9ab3564asm606181qvb.68.2024.01.05.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:42:54 -0800 (PST)
Message-ID: <6598075e.050a0220.dfbf2.1bb4@mx.google.com>
Date: Fri, 05 Jan 2024 05:42:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7628940223505490538=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] shared/gatt-db: Fix munmap_chunk invalid pointer
In-Reply-To: <20240105123404.151860-1-frederic.danis@collabora.com>
References: <20240105123404.151860-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7628940223505490538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814647

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.72 seconds
BluezMake                     PASS      696.49 seconds
MakeCheck                     PASS      11.75 seconds
MakeDistcheck                 PASS      157.81 seconds
CheckValgrind                 PASS      220.34 seconds
CheckSmatch                   PASS      324.24 seconds
bluezmakeextell               PASS      105.42 seconds
IncrementalBuild              PASS      663.94 seconds
ScanBuild                     PASS      912.32 seconds



---
Regards,
Linux Bluetooth


--===============7628940223505490538==--
