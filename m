Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0E154A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxmGqSsF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7833bd8be24so79955885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704972729; x=1705577529; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rE3oniQfSTutdTzMKM/npQIJpGvkbx5KXc5vjOOboGQ=;
        b=VxmGqSsFzkYRYfRqt3VH2PBQG1GjUwv/ER72B4ex3icKaa6g97S0mPqh5ifDLoFHSC
         72sy5hkIbCZcGMx3L9VpD+bo8/8mTriac+ikQCwpP1VmR4kJNu4wULwuGeJt0xARP/+H
         Muq7t81SwWW3pfIehvWtjvxJsrsWftYLYdcGwOjwLSkYysfZU/ZaA8U90X4tNlC95QWC
         NR9s+3vevnNdhXv2liVp9nbd6+ekLgH6Xfp8fVV+Mms9ZYZ7TUv2IyQ5OjePK1PPBLGu
         BW3Oq8xD3GwYAdc62HbnSbmWlAv3KIxb9hVu6l350E1idC5sNuXONzBW+cNRTsfIwF0Y
         cVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972729; x=1705577529;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3oniQfSTutdTzMKM/npQIJpGvkbx5KXc5vjOOboGQ=;
        b=N9aGyXEgjSiMnkrSPnKbcHk605pH2a+5q4/0OQRHQOARyLNyABTUTbcj9Qn8SymLeL
         SVnXTJvEWRkxqx7bEeBoLG3zcxjhfpGSR8++JCaZsT89vhy16EogaJ+GS55ZBcFc1P3t
         LyW1q1rIVu7bqmot8A5t326/3aLmLXXkYD5c2SvSZeqtPlJzRR0NnWN3Bk/nmvCgyrb1
         DNK/ULfmmry1rFGuJ6pIZwIimlSAh50S583H9mexQ7pcyMa1bA07zaU4xpBpbs/NJh6L
         vqUnjR7ykL4pF3HttXf4MmWTuJHVqfya0unyB1zY/WZ2kvub464jHrmcL08EAcUHD25F
         QlOw==
X-Gm-Message-State: AOJu0Yw+EzoMtJ+7lCLk15B9so4tPhaPkrQtBH9bYM2x/i+9/SqQJnht
	dIoWabt+xQ04sKSjkCyXE9AuOdzs7dYTtg==
X-Google-Smtp-Source: AGHT+IHR+5SV0wzkahUk6Cj64NSHC7+pq+4oZO0zo8D327pznTYjPuPVpEwnVtoU5HkyjJupcS4SDQ==
X-Received: by 2002:ae9:f305:0:b0:781:94d7:9575 with SMTP id p5-20020ae9f305000000b0078194d79575mr585582qkg.47.1704972729163;
        Thu, 11 Jan 2024 03:32:09 -0800 (PST)
Received: from [172.17.0.2] ([172.183.39.68])
        by smtp.gmail.com with ESMTPSA id ge9-20020a05622a5c8900b00427b3271ab4sm357863qtb.41.2024.01.11.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:32:09 -0800 (PST)
Message-ID: <659fd1b9.050a0220.607f0.0d5d@mx.google.com>
Date: Thu, 11 Jan 2024 03:32:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7214932429189002423=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: qca: Fix crash when btattach BT controller QCA_ROME
In-Reply-To: <1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7214932429189002423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816109

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.32 seconds
CheckAllWarning               PASS      31.56 seconds
CheckSparse                   PASS      37.70 seconds
CheckSmatch                   PASS      101.51 seconds
BuildKernel32                 PASS      27.64 seconds
TestRunnerSetup               PASS      443.35 seconds
TestRunner_l2cap-tester       PASS      23.28 seconds
TestRunner_iso-tester         PASS      43.29 seconds
TestRunner_bnep-tester        PASS      7.00 seconds
TestRunner_mgmt-tester        PASS      170.47 seconds
TestRunner_rfcomm-tester      PASS      11.76 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      12.39 seconds
TestRunner_mesh-tester        PASS      9.02 seconds
TestRunner_smp-tester         PASS      9.86 seconds
TestRunner_userchan-tester    PASS      7.31 seconds
IncrementalBuild              PASS      26.99 seconds



---
Regards,
Linux Bluetooth


--===============7214932429189002423==--
