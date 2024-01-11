Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F2156EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfI8xjXZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4298b23abffso22920141cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 00:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704963550; x=1705568350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HWEWFFjadeELLaTseogAODWnQi3uP+mvS2fNSc44z+4=;
        b=bfI8xjXZ7qtCQE5ZaKzrD/QYcXkDhyhzHOu2ArynmovVky/sZdJHkSJCIKDgWIr67w
         J78CbshE06iMIivZUEwar4PxJzaXbo5jCnwY5jrHwS6O9dVEQ1Krpa3KQuQB3yPJRQEx
         XSzgCOXqIiG25Tii9pkr4wADclOb2vYfgxPy6rEU4/FbB+AUgORDo7kT+ff3N6PAkwgE
         95ifR+7EtTqDrfBIIbtfSjQtJQh8j0JgyxKKAmIFOPwG0j5XtNtSxENQUeqWAhL8Y5ny
         JVTKOznoq3j0OKmk66Gz7NTEzVXHU7Agu60HKGbdQPut60tMLBm2blCsKn8cqo5LdRY7
         6how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963550; x=1705568350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWEWFFjadeELLaTseogAODWnQi3uP+mvS2fNSc44z+4=;
        b=t+kqelenXCcpy+JzMMDQMxsgipZCqarf5kDkl1a0YIYZyzfapN5yoNFPRwT7egFKA2
         G1ITWOitN46V9l1gSVMOMS28SLmUR0ByBFDEthf2ciohMIO6xgu7kEIcwjBoI/kXn6Ej
         3wjj6tcIEzK+TRaYmVJ3mUrFzKQ2SFWj7JcW+6rCIQV+sFKL+j+Bnuojx+UmtoXog3lk
         tQCjwleDrrT7zNrfarnS9DEv/TsFgtUkT5v3otOfRIiBXw8A2szhfaEoVB6kZXvb3JqT
         8H8hep4kzIymeSStNCo9WbRRa7tN1XifVb3q9j+NO8CSnQa14g0M0mfnxoqk/o+fCJFr
         V9gA==
X-Gm-Message-State: AOJu0Yx+tAqfLtbbjjCxvjily4+8z2iaUZqoz3L4M4611Ur+uSW/yLSY
	inrAFoL9tfpcim1T8VCBYqaCAPYxCAM=
X-Google-Smtp-Source: AGHT+IHS+t0uDRy5UDezOAChoKD+KOEmPFELiVabeJNpIrx+4MH5I3qskiPZuN0AwlM/Gdk/ky+rlA==
X-Received: by 2002:a05:622a:c8:b0:429:b5da:10f9 with SMTP id p8-20020a05622a00c800b00429b5da10f9mr311514qtw.51.1704963549864;
        Thu, 11 Jan 2024 00:59:09 -0800 (PST)
Received: from [172.17.0.2] ([172.183.162.32])
        by smtp.gmail.com with ESMTPSA id t5-20020ac865c5000000b00427fabefe3bsm270002qto.52.2024.01.11.00.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:59:09 -0800 (PST)
Message-ID: <659faddd.c80a0220.0978.0924@mx.google.com>
Date: Thu, 11 Jan 2024 00:59:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9153976987038882038=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: qca: Fix crash when btattach controller ROME
In-Reply-To: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9153976987038882038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815958

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.60 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   PASS      36.51 seconds
CheckSmatch                   PASS      101.21 seconds
BuildKernel32                 PASS      27.98 seconds
TestRunnerSetup               PASS      437.67 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      44.91 seconds
TestRunner_bnep-tester        PASS      7.51 seconds
TestRunner_mgmt-tester        PASS      165.10 seconds
TestRunner_rfcomm-tester      PASS      11.03 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      12.23 seconds
TestRunner_mesh-tester        PASS      8.85 seconds
TestRunner_smp-tester         PASS      9.85 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PASS      26.42 seconds



---
Regards,
Linux Bluetooth


--===============9153976987038882038==--
