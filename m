Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGLnT58j"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC8126
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 05:46:16 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77bb668d941so279863985a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700487975; x=1701092775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rtF12EvQBJq+fxVd9MKrUl2bSNTd6d36kRCvJ6hTWOA=;
        b=HGLnT58jlZPslC2D6X8usE8T9E2OK8xTPnHKEI8lvV824lOE1WDwXn08T8UF39OXym
         yOT8NfqSsphz1E62yzXP7ohnaltr+R7CNKOm8axMdb3SByXh9+TMS9zCmM+17a+49ak9
         fUt+J+Ez0/6KDADbjzyutkpDE/e4sjZ9RiRV5AmE/Mj3VSUYS6w4pwN+9vzWvsIDkxXf
         SEmHhjevsqtJt1jWOJhAf8ooi5sJbKpX5aLL2WV/igHOClT4ln/90uWfUIJfF1jzYpic
         TJCvG640tkWkAo/LqONzRi1aOltGufoli3oLLdW9gbhdPBU6tDlaNgm3IKF3VG1C0jGe
         DOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700487975; x=1701092775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtF12EvQBJq+fxVd9MKrUl2bSNTd6d36kRCvJ6hTWOA=;
        b=CzyceQWH5JjsXFXv5dUKnyZcqAp+LDRMUZZpSZIPWtFjrR/IJxfYhBEpeT75wa73Du
         laNG/TfSw5D4KSPnaxBzEH02vSYsrqdw8vJesFm3DUkUFYPNPWxFc105kj66kwXYNTkn
         nUGAceWNO7YO6/96Ynjcfqao8ruzaDW3O1DOUrmH6TzaA3xOCwVMzVwqsiawNuw4U0gv
         GstLRSKEkiGOqyF87Tpc9IUPV9AGDiwzmqXP1eURpBwMr9Rw8jk+ELR/68/Wd3bnDdqG
         C1oZKWCcKm9iIG3ywdE31KQQ/PPGdPjBEivsbMc63b8y5Zom+ZrCdnXGv5n7ApZHiFJo
         0NDg==
X-Gm-Message-State: AOJu0YyYjC7prlgrYHrndYOLUNYOpTxdqQpdoxy1kgpdNQsIl5/iD3QA
	tawHloAyodqPzbI70dWPb6V8iA0WDzc=
X-Google-Smtp-Source: AGHT+IHuTswLKZDDAY0QRiE3zuGYmryvyG+GHd12egCMdhF89utgWF9FkisgkCy04dS6JGktk9oNRw==
X-Received: by 2002:a05:620a:2150:b0:77d:4b31:f954 with SMTP id m16-20020a05620a215000b0077d4b31f954mr2918270qkm.60.1700487975271;
        Mon, 20 Nov 2023 05:46:15 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.180])
        by smtp.gmail.com with ESMTPSA id g15-20020a05620a278f00b007743671a41fsm2659723qkp.72.2023.11.20.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:46:14 -0800 (PST)
Message-ID: <655b6326.050a0220.d9ba2.a2c8@mx.google.com>
Date: Mon, 20 Nov 2023 05:46:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5413037440578099825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for bcast multiple BISes
In-Reply-To: <20231120120831.5353-2-silviu.barbulescu@nxp.com>
References: <20231120120831.5353-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5413037440578099825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802457

---Test result---

Test Summary:
CheckPatch                    PASS      2.94 seconds
GitLint                       PASS      1.60 seconds
BuildEll                      PASS      24.82 seconds
BluezMake                     PASS      566.79 seconds
MakeCheck                     PASS      10.34 seconds
MakeDistcheck                 PASS      149.21 seconds
CheckValgrind                 PASS      210.70 seconds
CheckSmatch                   PASS      324.89 seconds
bluezmakeextell               PASS      98.43 seconds
IncrementalBuild              PASS      2472.22 seconds
ScanBuild                     PASS      890.17 seconds



---
Regards,
Linux Bluetooth


--===============5413037440578099825==--
