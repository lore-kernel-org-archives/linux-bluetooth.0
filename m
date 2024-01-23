Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7756741
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996635; cv=none; b=u+j+UWZiQgth870OO4SomQEm6yXIRPxIBmq1wAgjls0GQSLdexnxwjGhesNrUmyuGtxyQ5bEnvQPSSyKDrrSgUh2OMYzevRspS0QyVsibKtMmonBvsC6TxynjhgTsBgDJTa5PpJ4qwFIp0XZlj51zxXs5QnYuepgEyO+ESRCsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996635; c=relaxed/simple;
	bh=nrj6JNcaKplPqXxNMFRuazyc06LdJV2xyFaDU5BfOOk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=alskd4/WisiFzsXERznURWnx2RC2omo/Sgliqqskx9Oz6s9bOW/GJ2fzGXZeHc2p9yTBwp/1yzLBMWivBd/plCCWFqml/QAZ8Jj96ihMFtEk+Use9T/lWPQYDDtyOervQQRO790RfNFTrxKgb+kgKWaMDdiq8WjTR1TvZ0w5IWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA3yESdc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA3yESdc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783182d4a0aso321609185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 23:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705996633; x=1706601433; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EvX3vbn+mqtFQHFPju7kfIQWXC5HJXPyV5mOzwSEj8Y=;
        b=HA3yESdcTBCX2bWIg3Jd2goeS98Zqrz76WoatoAMA+3P4QIOMqSXZrIfubX8Ufc4il
         HNjoAuvhjELBh++ch32JqJQPv80HNSGHeJNUFYR7xqKnUdDCiL0vqA/A90iOUiXVDo/M
         9Pm6ZkxqJNQOLowVgGsL1CB+FoHMQZEIChk7BY7P+F466nadiaa91wXouOejyHnaTWn9
         IJq8pYXvxYuPV02dAfRptaMuq2y/pYlz+EEICfvnF06TY2XcdPgNiWwkDst6sII1Vfmr
         ji8/L5I3Tvx023EnCtsg/8H/6Cb5JAtGB2cmH3eEBqlTJWHsHzppvnij6LRUwiU3Tjz9
         zcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705996633; x=1706601433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvX3vbn+mqtFQHFPju7kfIQWXC5HJXPyV5mOzwSEj8Y=;
        b=ou10VoPSkEnu2ro4SgNp/6BiRKYN6z2Z1Lj4P9wFc4RrVFd7ntFQo7o5NJf7GQJNIZ
         L2lR2Kq0p7bN8d1KtALhch/FKP1XU52wRj6daut1nAR2tOp30UgVGA6SM4F8yYcjkpM/
         Bi/tfZ+MbEqMNb9UOM4JqFJRfUe/3z9U8/APt1JIFK3Fsbz4CiUkvZ911wGXgMPtVXPn
         b1n2zUMHFNJsoCFWRyKxgeAbhIvREEuwh39PcqafHg1J3z3DwVdXYLRztV04bnXZhfVa
         9J4mMbcFi05l/Qw8+c8z7gf3uEjZ9eoNlP8MHBEAUPiNy1oKMp14P5/KfFezziWZBjI4
         fJEg==
X-Gm-Message-State: AOJu0Yz93feSHvTg75TqL1buWHVHhbNksfs9BibXUgj8F1BQ2nQByiHT
	cdcw8EFqRtlOe9ftjSoRRURnC321VCbeJeoUotsTrYDkNWEMiYOJGhU72+Vk
X-Google-Smtp-Source: AGHT+IFOqy+8iUCzjrX22+Rw2ilMadxhe/rjQqpYa8iZMXNG1kIIxErpVQPFcuIc4fwz/+SZ0bVqVA==
X-Received: by 2002:a05:6214:230e:b0:685:7125:67e6 with SMTP id gc14-20020a056214230e00b00685712567e6mr692691qvb.1.1705996632856;
        Mon, 22 Jan 2024 23:57:12 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.180])
        by smtp.gmail.com with ESMTPSA id f15-20020a0cc30f000000b006817089c8f5sm3200654qvi.10.2024.01.22.23.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:57:12 -0800 (PST)
Message-ID: <65af7158.0c0a0220.818bb.ba95@mx.google.com>
Date: Mon, 22 Jan 2024 23:57:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0449467732140671832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
In-Reply-To: <20240123071523.23480-1-quic_janathot@quicinc.com>
References: <20240123071523.23480-1-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0449467732140671832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818971

---Test result---

Test Summary:
CheckPatch                    PASS      5.45 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.58 seconds
CheckAllWarning               PASS      31.20 seconds
CheckSparse                   PASS      36.95 seconds
CheckSmatch                   PASS      100.82 seconds
BuildKernel32                 PASS      27.48 seconds
TestRunnerSetup               PASS      439.03 seconds
TestRunner_l2cap-tester       PASS      23.45 seconds
TestRunner_iso-tester         PASS      46.07 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      155.01 seconds
TestRunner_rfcomm-tester      PASS      12.97 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      11.99 seconds
TestRunner_mesh-tester        PASS      8.71 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PASS      26.67 seconds



---
Regards,
Linux Bluetooth


--===============0449467732140671832==--
