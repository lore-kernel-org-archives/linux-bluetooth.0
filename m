Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8955111A5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns/uSzMu"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-427e59202ceso43699361cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704205950; x=1704810750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qy2kgR+oXJzDC2YiOHeUDdgImZKfkUh2gGzSznGaz+E=;
        b=ns/uSzMuxWkKhmzulXHFAqMjJr22zTx2u6xKPzpUVNM9ldICOK55Ed+orwxzzKxjL0
         i5yHOzTOZaN7OkJPCvbeCDg000JYMk+i8LrRJHnZsx1UquTd1lHToI9h/gumy3Z+LZK9
         ZCpQg8piDg9pJ1wTPYyIQlDNKajQvH4P6Qmq4jqfbyuBKiZBj+R+Xjl4LwBuO47PHXfg
         nRRZdT0x3kqEQWqS1++G7KNK1PqNeitiSDAs6sx6yu5hmFT5DxdeRJ3orU32BDdFG6xd
         jW2gG4hqZAwYAj+rZa2xEmvDIASpbW+FgZ2eiOJV4+cOCd/X/6d/yt+Z4r6yhujxwLkD
         387A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704205950; x=1704810750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy2kgR+oXJzDC2YiOHeUDdgImZKfkUh2gGzSznGaz+E=;
        b=luyPrIJkhFqxW4XMo1UTi1q5rO88Sulahx6+5ixaWhqz+8ICNE6NTLvDviIPGbua/H
         2Al1U9drZAUktMw4EfeGyn0zb2bHBSuMSWPYLiwBq8+mrRKpqdMnRRavHUU2At9iCudh
         Ed8kO4rv0TXt27HI8teMrTaJC/Wq+Hmh1FDqzOndq01Q/USj5e6HG0brN4xMt+iWZD0Y
         uXha+LEHEIiIljlbYvovS3l9l3A31SltYhahDFhWDM9agZUpKcQaNdG4WtgmpMqMc2QJ
         zbrt9QqJqyIUM/NVTLmJ4FjWTTnR4WbsFFw6+NvUjL3ZDKPFPSUdigM63plO49pxpYcN
         KYjQ==
X-Gm-Message-State: AOJu0YzcwciCfO2BBdTTOJZnh5jVKdLLTnAJmcfmHGxSHOIgQAEiZJus
	Ej5YJ9MkSfAT4AQNzaWE9B5zJ2kaOzI=
X-Google-Smtp-Source: AGHT+IGuq9N46PPgLQ0TWv5tc+4TMsyZ7Iu+Hox9qOaDd9KrDDhx7KVIyfTdRzvCXwzy1O/s+71luw==
X-Received: by 2002:ac8:5a44:0:b0:428:19de:e631 with SMTP id o4-20020ac85a44000000b0042819dee631mr6334150qta.26.1704205950556;
        Tue, 02 Jan 2024 06:32:30 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.1])
        by smtp.gmail.com with ESMTPSA id he30-20020a05622a601e00b004181138e0c0sm12992949qtb.31.2024.01.02.06.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:32:30 -0800 (PST)
Message-ID: <65941e7e.050a0220.bae9f.536a@mx.google.com>
Date: Tue, 02 Jan 2024 06:32:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6056772975378347364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Power off HCI devices before rfkilling them
In-Reply-To: <20240102133311.6712-2-verdre@v0yd.nl>
References: <20240102133311.6712-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6056772975378347364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813840

---Test result---

Test Summary:
CheckPatch                    PASS      5.24 seconds
GitLint                       PASS      1.32 seconds
SubjectPrefix                 FAIL      0.75 seconds
BuildKernel                   PASS      27.69 seconds
CheckAllWarning               PASS      30.59 seconds
CheckSparse                   PASS      36.30 seconds
CheckSmatch                   PASS      99.67 seconds
BuildKernel32                 PASS      26.96 seconds
TestRunnerSetup               PASS      432.67 seconds
TestRunner_l2cap-tester       PASS      22.79 seconds
TestRunner_iso-tester         PASS      40.66 seconds
TestRunner_bnep-tester        PASS      6.78 seconds
TestRunner_mgmt-tester        PASS      160.29 seconds
TestRunner_rfcomm-tester      PASS      10.76 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      11.93 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.68 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      60.21 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6056772975378347364==--
