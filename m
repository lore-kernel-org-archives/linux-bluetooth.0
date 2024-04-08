Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733EE2DF73
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581661; cv=none; b=rJh0WRpDivtw6Rv5hCUQjWkM/6R889Kirsgg2Jcm1ly/l1iQFVggCcj4vSJMzsJ8OS83a684NZtWqdFySplo2u2oRExZWnJb0eTvyx9U/xf/VL7RXmN1uqtXwbRu+6A01Yn8YfMftAA9d/G97kD7vfq9NGMAGonUAahMoKVwrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581661; c=relaxed/simple;
	bh=usQ6Qm/c8NgqUsSVSJHQBn1E6ngoAcpc+xn0aqC04j4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hLXV3lN+uHkWSw/vyRVrkXpXHW5+rsql7Ybs8l0OjztFNbeVe7alIG33EowDWu2b3y4Y/gRhQAxeVWmFOQMqabA8nRaty+fxFOaGcf+jI1eTA8UIBg8m7PRQyj8oIEq0VkSHdQ4I8wqc57+Ufn8lif+VffzFVaNSXyt/N8DfSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu9KVAJG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu9KVAJG"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-699312b101fso24660286d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712581659; x=1713186459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QVrju9p0ycw5kC2VQIx4ofvz+cZJttYzsAD8R+NKUy8=;
        b=cu9KVAJGyEYrGEUXyvorA5WrGFdvv+5iP71fFez8XRAWHvj33M+kP7FRKBQZ6TJT7P
         BspelVlvV/BgJltr2SptmquxmFufX+R00DVVTuzmsKORZdL1GNfRMu/DEmmib4Bm2Ix4
         l/R8Ux9c0I72Ls5gdiH26TpzwQZyuX2h84BtNAt+l5aIzAen775KzWlh7Hktu44GUeqC
         +iYd0hRIr4l7yiYyowHHJ17/2ltSGyI8jw2n5zJjpnnZXeTROPauESX0yUkyyibm0IYh
         aee+tZzXSvBizF1adiD5RfhPyJcUsUmNESYuaRjyf3+U0BiMbP71f+lzNNl4UgCPL/lV
         0E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712581659; x=1713186459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVrju9p0ycw5kC2VQIx4ofvz+cZJttYzsAD8R+NKUy8=;
        b=V+Vh8j/sdrM+xNyEVLCNlVAfSdoN09XBNxPfD1fCz5pPcYbwg50Hj5qpl1jo6z6ZMX
         lkCFqGnclqg1HwhWFCseAVjWqUhn/GJskfDqylQK62gyFOy5XxuzS9vczVAoswXe5ok4
         WmOOc9uYekd90peStQaFnLh/O92h1aoz6svHZlWeQ6RYIuxT2YscvfW+iRyRzgB2cs+F
         JyeIoyR93v6H89c+pOge4N2BKtAUVRlNd5WVT/+IIecWu0QyV+nVrm9Q0zihUeKMhzmx
         qsSEeDDQxKvZrZgg7l6CZP6q+5Ut8pPWYShhbK+yyyBRd5AWtgNRs1stuJ72dBGyb14/
         y2Ag==
X-Gm-Message-State: AOJu0YzS14kScF0FNiGdRAXSZChYLV+iu07RHjhPbKbaFy51QKb4/MR5
	Wfg756iWIyREdcuHJGmj2iQJvIHA7WQTGy3V2eniocYw9zRzgSOTMG3YREYJ
X-Google-Smtp-Source: AGHT+IEqVwYZbKEaN3L/hhtZHjESy2ug2ovm5z4E/m+ImFK8jGjOT+fKwAuOi+fXt0dlfOA2nN785A==
X-Received: by 2002:a05:6214:4017:b0:699:2dd2:eb0b with SMTP id kd23-20020a056214401700b006992dd2eb0bmr9977108qvb.10.1712581659053;
        Mon, 08 Apr 2024 06:07:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.25])
        by smtp.gmail.com with ESMTPSA id di4-20020ad458e4000000b0069b1ef5d425sm694669qvb.134.2024.04.08.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:07:38 -0700 (PDT)
Message-ID: <6613ec1a.d40a0220.2bce6.1b4b@mx.google.com>
Date: Mon, 08 Apr 2024 06:07:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1168249301106365040=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wse@tuxedocomputers.com
Subject: RE: [v2] Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20240408123459.66504-1-wse@tuxedocomputers.com>
References: <20240408123459.66504-1-wse@tuxedocomputers.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1168249301106365040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842438

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      32.60 seconds
CheckSparse                   PASS      38.16 seconds
CheckSmatch                   FAIL      34.65 seconds
BuildKernel32                 PASS      28.83 seconds
TestRunnerSetup               PASS      516.94 seconds
TestRunner_l2cap-tester       PASS      18.33 seconds
TestRunner_iso-tester         PASS      28.62 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        PASS      111.11 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.84 seconds
IncrementalBuild              PASS      28.23 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============1168249301106365040==--
