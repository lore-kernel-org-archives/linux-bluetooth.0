Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPdcOhxE"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EDB128
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 02:05:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4257988fd5dso4370281cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701943558; x=1702548358; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MgC9Xdv5KvxKk/02vdaHho+36pL9zifEp0pEnTy/ek=;
        b=LPdcOhxEftla2pUTCLzCAKPMV4aN6efXbIG6PngBODHQxPc5nfRKso6/K/20A4cG5f
         2SQt6aSU5qQhfwnd+vPrkupiI8WaZ/0Q4vyi2pwhcnwlbInosopCLV0yY3+mH4hWCuUh
         i6jw2uFbOw5H7xOxkNq6cyAXMTdOT/x9gfQ7/9i+UuuoQv7nIIPCLFVxMvYyqTArzN0a
         l+EVvJlZa8W24z7GVWZ7sbVzyHHkvsD2Pi0SPvxPidXrDsQEjdxFT9bGJoaLmiU5k/x0
         3Et3x3gK1Afds49y2Ppp18uxeUpERg7qyHzE8biBjxp7WwawCQ5+zZLlYd9Dw1pc/ADX
         0kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943558; x=1702548358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MgC9Xdv5KvxKk/02vdaHho+36pL9zifEp0pEnTy/ek=;
        b=vZJSDc+dbJ4B68KqG6gBejCknSeal33C6pwcOns4vxeoj0X9r/N06wxIryKqfaJiE8
         AtLC5sxEfieneunSEAgVuMHk35Z7CqId6ZB9TN9LZanAZLZMWCR5m9F5E+m9xDI+41QZ
         lTy7KGLMVdWw1DIVB6JnH7ug6jLcfEZPvyyjH/DI+foz9rX8enFpivDgKg9b4Rjy2iR5
         BhOCKY68OPRJy3Mru/lud80IHW/pBBiowk1Qsqx7RUlweuE0J8WpVk+uXjH7Z0JOzueA
         SbQFvm1pXrSWu59lw71bAMENjI/eriRG5bp//mcJMuB2UQlGquN+qWb1dxGGbb4tI9KJ
         65yA==
X-Gm-Message-State: AOJu0YylHXWra7i3XiCbV8rkBzRxlrOGsbSm3xfABy8RoCVu+bFNp4U5
	VQ8pKzrCneZtsgM8sIT3ta0iDyPld3E=
X-Google-Smtp-Source: AGHT+IG2SDMynzk5zDvu/p0imBQr4wSNnzlr/4kMOV9rKW5wLRySUlRlVfO4KkIcnBCrvDZ8NuYbCA==
X-Received: by 2002:ac8:7d85:0:b0:418:af7:e001 with SMTP id c5-20020ac87d85000000b004180af7e001mr2563636qtd.41.1701943558659;
        Thu, 07 Dec 2023 02:05:58 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.98])
        by smtp.gmail.com with ESMTPSA id f8-20020ac84648000000b004254b465059sm357883qto.47.2023.12.07.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:05:58 -0800 (PST)
Message-ID: <65719906.c80a0220.58542.0da9@mx.google.com>
Date: Thu, 07 Dec 2023 02:05:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6183955299097093358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastif@axis.com
Subject: RE: [BlueZ,v2] Pattern match on service- and manufacturer data
In-Reply-To: <20231207090902.884270-1-sebastif@axis.com>
References: <20231207090902.884270-1-sebastif@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6183955299097093358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807780

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      23.75 seconds
BluezMake                     PASS      702.56 seconds
MakeCheck                     PASS      11.92 seconds
MakeDistcheck                 PASS      161.10 seconds
CheckValgrind                 PASS      220.23 seconds
CheckSmatch                   PASS      325.83 seconds
bluezmakeextell               PASS      101.97 seconds
IncrementalBuild              PASS      643.92 seconds
ScanBuild                     PASS      893.00 seconds



---
Regards,
Linux Bluetooth


--===============6183955299097093358==--
