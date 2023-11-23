Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5b3qp+b"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C958D4A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 15:29:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso852168a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700782189; x=1701386989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iVyX8CLzCr0ppA57gbquGQ8XAlvcB0bVFlQskoghEk0=;
        b=i5b3qp+bFomThDj5nBVrUH13VL356/U8YTaILIFrEG0VHry2gQkduNJsAGGOTiSvdM
         bfXGPGQhyy5t7KT5KsvyZReWFNibg9KX0xuVB/wcYkW3TuCiyuNTKVH1gcyu2YPURrey
         Ek/3f4tK/RF0KkKeY+tildJ6Q1sLTXmitCh9z4jZRdJYnXv5Ozyg7MKJoXjIJu8vs9fD
         WmWSH7eMgDVm/Rq7S9aJu6cVi8lte4NhGjY8fMEpWwg8QL7RVCJ0blZRzilHPe1WAWE2
         e4E5AqgVkwYJwwRI4nd8UmtB9raH8FBK3+H2lhR68oFGkoFrjb3kDxRvKamwrIl/4tCv
         lR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700782189; x=1701386989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVyX8CLzCr0ppA57gbquGQ8XAlvcB0bVFlQskoghEk0=;
        b=jmOFpNZW0NC0Jie2XlBpT8VJnMzqoZpC/VBFXzdFK6tuVoE4OjOrgzrXn5B+8AhIJ0
         ka3jYa+5FK+uyXXuwmuvBrZDhOmilRbOs07e4wzABxvKo+brOV9pgFDnzmPstL9t7QTd
         7d2GM4cBGOWbAKJ2fhBHdJafI2OTsQFMePz9jDyyw6LQYcrq/V0a3PJABpLyrake6ppO
         5leKmyHRYX9GULXhLMOuQ/SyCVJVP1tRVRhC+48dLSN4bL5tOUJ5Fmb+NF8pDom7tiMW
         92z48N6UUYgK2LLs5Jty0dRFvMqvCRVaKoXtIcqhmGr5FRs06rgxEWat6oirjBo8SdSR
         Qv/w==
X-Gm-Message-State: AOJu0YxHlD0N2tKgaU26WMLw8WSHph18YLxjUwc2TICyKBzD7IYuY0vi
	yYZ2b3a73m1E5ZWapUIhw1ohiaPQpcE=
X-Google-Smtp-Source: AGHT+IEqoiNPXTcHY4utYmMvAuW3h3+MOhl0rQP6teLwrvThFODgNe3TeOkQehUuBghIVG4D3bbJ3Q==
X-Received: by 2002:a05:6a20:d904:b0:18b:9149:b69 with SMTP id jd4-20020a056a20d90400b0018b91490b69mr1366805pzb.6.1700782189218;
        Thu, 23 Nov 2023 15:29:49 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.3])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a0400b0027b168cb011sm1914064pjk.56.2023.11.23.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:29:48 -0800 (PST)
Message-ID: <655fe06c.170a0220.d2fe7.55c8@mx.google.com>
Date: Thu, 23 Nov 2023 15:29:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6372741055978926894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for bcast multiple BISes
In-Reply-To: <20231123215935.73501-2-silviu.barbulescu@nxp.com>
References: <20231123215935.73501-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6372741055978926894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803818

---Test result---

Test Summary:
CheckPatch                    PASS      2.13 seconds
GitLint                       PASS      1.08 seconds
BuildEll                      PASS      23.60 seconds
BluezMake                     PASS      530.26 seconds
MakeCheck                     PASS      10.76 seconds
MakeDistcheck                 PASS      143.50 seconds
CheckValgrind                 PASS      204.29 seconds
CheckSmatch                   PASS      306.07 seconds
bluezmakeextell               PASS      92.68 seconds
IncrementalBuild              PASS      2423.59 seconds
ScanBuild                     PASS      856.29 seconds



---
Regards,
Linux Bluetooth


--===============6372741055978926894==--
