Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+iZRSdz"
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A455AC
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 08:17:34 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58a7d13b00bso440362eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701965853; x=1702570653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1UsB/JkoLRErU/d1Y39NTC8BnND2ohNhj3mftRkirk=;
        b=S+iZRSdzo35t2HHhXtbgO/LmbKwLX22QDlIfyeD0isMJPcECHAMXz1q5WrDUMicIyd
         thOgaarZzJCeLpoCukdfTMAOlh9NmjP359PvTztawLsMs+R7TVFwAYlq3curJd3MTWf6
         9NT4NnfwGIGuCBtxrowfZegZxktEAjvUPz5QPIkm/x+i4u8e4oXuYpw7KybMJyDYpDxW
         UKugAiT6bUzT2yk7xUVx97C1uSubpYt0uD47yLYWv8/AP9j7bAE3MIvkaoSIoYcYVopY
         5E4eJw+fWX7QkeFWjP0XbZlPqy0Jah6UYPCjELaSWW3iqXfuSw/mGUpTvRhkwUKMSPCF
         CXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701965853; x=1702570653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1UsB/JkoLRErU/d1Y39NTC8BnND2ohNhj3mftRkirk=;
        b=apegbr0OE8GLdoMFGCbwwj0ddFqEPg0AYC7coMNguyvDKhfM5ndZsNOa7M79w17n4Y
         K/3s4Dv9T/KNFO6IAWiGTNdqG7e/1xv/UToLyoB/yaVgw/O+JcCjuyEmyPp7V2b9TMAD
         5B/N1tITX6Qw1X4Ua3S26ckfYR1Wb5uUxpwTffyWpjqAEgwP7sTLrnk/Kf45oWzbjyux
         HFD4ZR4BPRO/FANvTqrgrdnL5ligdmWVybVRUOjH/LNsGXl+A8RKRO48WCftnHw4wEMN
         eSEIjg+nwHves8oAcLTMIQb2wK82pKltksHTjtuUw5NIsUcsO4DU0HEkHlqelmU9lzvr
         YArQ==
X-Gm-Message-State: AOJu0YxXAGdadpQPVGwu5WAjaVOAWoV6qQqoDodxIUxr126oV4RjwYkI
	QljjkA50XRfR2QO/TIjHDxGWytzmLcM=
X-Google-Smtp-Source: AGHT+IE6Usm/qn/Q3IHiVeEIlwWjST9FAHCR+/nAG1bFr0eTjLCyKpGmWbn/QqzhFbbPmZ1ygYLotA==
X-Received: by 2002:a05:6358:919d:b0:170:87e:8325 with SMTP id j29-20020a056358919d00b00170087e8325mr3653242rwa.26.1701965853120;
        Thu, 07 Dec 2023 08:17:33 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.99])
        by smtp.gmail.com with ESMTPSA id ph30-20020a0562144a5e00b0067ac5a570aesm16931qvb.109.2023.12.07.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:17:32 -0800 (PST)
Message-ID: <6571f01c.050a0220.9b55.0258@mx.google.com>
Date: Thu, 07 Dec 2023 08:17:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7680027446835787229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stu@metanate.com
Subject: RE: [BlueZ] Fix ad_clear_data() to clear correct structure
In-Reply-To: <92D4BD44-91B2-4D0A-9A43-AEAE5DEAA963@metanate.com>
References: <92D4BD44-91B2-4D0A-9A43-AEAE5DEAA963@metanate.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7680027446835787229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/advertising.c:757
error: client/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7680027446835787229==--
