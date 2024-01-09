Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E739851
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4aTx0WL"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68009cb4669so21676656d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808934; x=1705413734; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2bwWiHB0wkGd2uzkGdfBCf2MGN3lmsEDAtObjguaRk=;
        b=W4aTx0WLuaLR0nRHgoYSjCj4MsMvNZUKqcZTDvIm1AHxPcq6bqxsxixjW47brFNORf
         RoljhEj7/xA7M+rHnIrw3sLXVVMNQ7/7oT18s9zdXXg2qbUOXlEILGXm5iz4iF4/WS0o
         n3R7Lzy/UeoWIc8vwDkLG3TIx/DfodCDUWmI+lpXYfsFooZdfmJqtXDE0vF5YM8BowCm
         YdSo2nfLsi+ps3dZkD9d3Ga+uC2pknj4kXFpJZVMeGcVAv/jwzAC8jivwgvWkzI2lVnV
         MbFsQYkdx88lzqBOpIID5q84y9LKZe3AZCdnjFulTbANBoa7KR6tRKFuq86e1oTpshG5
         aE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808934; x=1705413734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2bwWiHB0wkGd2uzkGdfBCf2MGN3lmsEDAtObjguaRk=;
        b=VnXRLFCcUCpCi5xbr/AT5uOh/vNNSOr+/4E07GbFKJAeQ8imcRsDwAHOTiy4TRjAL0
         m0oBaFScDEyYnuMAGS5eDLmpNwGq3SeQKfY40yPgTReeBTALzWHHc1xyS9j9hGnHXpLD
         s4C0A/QxvkPnHHxJUQ6+y8Y0lp1HlcBk+Cm2ATE8QCU53c50vDCemeVIZdO2rK0PXDp9
         ux6+H6COP/Mba4I5G216aVywMEKfZktmYqlwjQmQfcrYoh9d+aXqNLvkzQOeYaSgDHq/
         JyWTezMBm7HK++o7QOLImzk+MHI1PDDW9KCvzX9PWoHeX8yijgtGAKH8W0X5iNx9lHFM
         XXfA==
X-Gm-Message-State: AOJu0YxJx4pjUt11m1C16vbPs1VldPDwACBs2E+9eMfYOcUBwrL3sR9C
	6QKIvJVaolQxcpcDXsxn3jJRGCtpBl8=
X-Google-Smtp-Source: AGHT+IGhQ6EcO+DNWz9OYEyMHcFXuEpFiP85lfUhW8rJM9/8IpWTAZMBZpa4c39HIrbTaD3QkKyTUw==
X-Received: by 2002:a05:6214:2683:b0:681:212:f9a9 with SMTP id gm3-20020a056214268300b006810212f9a9mr5024491qvb.34.1704808932557;
        Tue, 09 Jan 2024 06:02:12 -0800 (PST)
Received: from [172.17.0.2] ([40.76.238.208])
        by smtp.gmail.com with ESMTPSA id mh13-20020a056214564d00b0068110f61fd6sm886752qvb.124.2024.01.09.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:02:12 -0800 (PST)
Message-ID: <659d51e4.050a0220.774e.4656@mx.google.com>
Date: Tue, 09 Jan 2024 06:02:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8868680416210254375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: Remove 3 repeated macro definitions
In-Reply-To: <1704805724-8050-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704805724-8050-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8868680416210254375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815398

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.51 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      35.92 seconds
CheckSmatch                   PASS      98.60 seconds
BuildKernel32                 PASS      26.85 seconds
TestRunnerSetup               PASS      432.81 seconds
TestRunner_l2cap-tester       PASS      22.86 seconds
TestRunner_iso-tester         PASS      49.00 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      161.93 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      11.95 seconds
TestRunner_mesh-tester        PASS      8.67 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.20 seconds
IncrementalBuild              PASS      26.02 seconds



---
Regards,
Linux Bluetooth


--===============8868680416210254375==--
