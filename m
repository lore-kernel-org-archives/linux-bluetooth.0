Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzCMXwN9"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFDDCA
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Dec 2023 23:32:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce3373be0cso1463164b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Dec 2023 23:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701675149; x=1702279949; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw8W3g1qocnebgGFdY09yIc4iOKAr+IJ8a9E+HDNrVM=;
        b=jzCMXwN9dfWUSLICfcMoKhuxKNgVmaEk8RkIjtYAl8e4toQ6nNvGx2Tf1hEOYcunxZ
         y0r2aLxALKeXn4BErqhMXEB556b14zRhrEMxfkmsec1/ruQmOK4tMruDhSe+GjIX11X3
         B3/7O0uxLd+Ix2tgAvGEVv9l5r96dliEJs/lKEnJS6wR+3zw2aKxui25aPGRr+UfJCvN
         Fqqgm/Kiinl3MyNYz6dZAReMXLyeDmL/VhNzv06ohzmUTYImE9gsyYy0j7JO+4ukkb4E
         Db+gSYRYq995aaTMQLo3Jnjk+tZrFYlaLA8ljX/WWGBe8P3LZq9sBC71I151RS10oY/V
         PS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701675149; x=1702279949;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw8W3g1qocnebgGFdY09yIc4iOKAr+IJ8a9E+HDNrVM=;
        b=XdfJPbnpC8y7vAR47aj0kgvvU3BeD2adwqbTyDrmHC3y5sVRHelB7TCNjdo8Vp9VJ3
         ZpA5ZcBPFlJHPQ2gznJqV0oxas5V8ybn0FhVUx4dHqLQ5NlIT3T0FOUBgnrvuLGgiSUw
         jpY6bUNlbtmg35teeJMioSwCk3CuFiO1MWqwJrZUeDdQ6CLfu4xZNcJmbS6zh6i3VZzD
         molLyHO0kUZvCsVmvUwPZ5aYmzrvQxHygvLlxTF57iv+p6pqujx124WRioi2eNrWKD9N
         GDDrgGP61iWH8OllA8bXBp3ELPhW3I2EMwl+65qGO2aCrJXNhdfXn34hEOW7mxl/iYyw
         33FA==
X-Gm-Message-State: AOJu0YwYNlmfC8kOQQtZydOjc7iVEtE/t2a70SE5kbIiDyLTx49BBovj
	JifPK52/PjBlLvv4+l9Wd+LIdilr0kg=
X-Google-Smtp-Source: AGHT+IEuj3To/ijIbbGj5izGWYAZ6HTQuBn6TS1s/Z/2sGyJUQ6zRguKjbDsYG9HTaTSz3ovuZpjvQ==
X-Received: by 2002:a05:6a21:998e:b0:18b:d207:d857 with SMTP id ve14-20020a056a21998e00b0018bd207d857mr5326970pzb.11.1701675148994;
        Sun, 03 Dec 2023 23:32:28 -0800 (PST)
Received: from [172.17.0.2] ([20.171.70.179])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00179000b006c0316485f9sm2723726pfg.64.2023.12.03.23.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 23:32:28 -0800 (PST)
Message-ID: <656d808c.050a0220.43db9.55a1@mx.google.com>
Date: Sun, 03 Dec 2023 23:32:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5466038382790321284=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, v4bel@theori.io
Subject: RE: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
In-Reply-To: <20231204070243.GA16386@ubuntu>
References: <20231204070243.GA16386@ubuntu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5466038382790321284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806468

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.01 seconds
CheckAllWarning               PASS      31.13 seconds
CheckSparse                   WARNING   36.27 seconds
CheckSmatch                   PASS      100.31 seconds
BuildKernel32                 PASS      27.37 seconds
TestRunnerSetup               PASS      423.62 seconds
TestRunner_l2cap-tester       PASS      23.57 seconds
TestRunner_iso-tester         PASS      46.96 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      164.14 seconds
TestRunner_rfcomm-tester      PASS      11.08 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      12.31 seconds
TestRunner_mesh-tester        PASS      9.04 seconds
TestRunner_smp-tester         PASS      10.05 seconds
TestRunner_userchan-tester    PASS      7.49 seconds
IncrementalBuild              PASS      26.74 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block


---
Regards,
Linux Bluetooth


--===============5466038382790321284==--
