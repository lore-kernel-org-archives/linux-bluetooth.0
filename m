Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DB79F0
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614870; cv=none; b=q9+ekTemRHno3E3KetjbUqJTVoyJaUp5qfl41jxLzmmZlOmTa+Q2SbuiPnBoCjb5afGKqpB18WXdEOAcEw79Qrd4Sy9Whugwy+Qq844uxmcagyW4Gt0Znx+9zS5vmlrrDkcGEpk3Y+F15++AfOxmNXUcPakYXT+CLGjEukANZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614870; c=relaxed/simple;
	bh=35/CpLKU6EQJxiBqcfxv1zrphXexaLt+in8ttRPNX90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YgcnlmT52SaJz82yyrCPE1rsUTT6xcdnwmHtrp19/eQXTPcrP0hEhb2OcqnaQ+BDzaU0YHx4eg1U6TLcz9NkdtOyPJW7tRJ5Jhc+tTur9S5vQtNhb1TxLhCENkClmbL7ITmhYPx2yuKt3/oDKgI8fQxGPElDq3n0asoJVYZmunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2nd8o9e; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2nd8o9e"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6f031549bso36821125ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718614868; x=1719219668; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTYl2/ZQ/xc8gkjCt01pOD+CKrNvdaoiTl2/FOOyVvc=;
        b=V2nd8o9elpWnzYexHW+CKAu7eLiY1H054dSlgBik1x5U/JYpVNaaIuDn4a4BlGa9VS
         jtU+Y9CVYDLfbFEtgyVfbmwLENgXaZ67WRMYEOzB6AKlJG8tffmVTvbiUSWuW13167yt
         EgGsCl4iHw1XuhzN5cuf2YllGvHG+9AEwMoyIhEktHK0uwuU9WwDNNWyK1/YB9km3chv
         5KLjjpV6rUOkG4IXcHQFN/08iRP5wUJ2KDsyzYUbo4HEudSYdeI92l4G7JV5Z4eEgM8q
         JKtYry64q6afYAXiKwHFnLEE8Ipoe6bQ9T0OVEFYmNAqKuQypzSTf8ncFgX/g2GVPNkO
         eHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718614868; x=1719219668;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTYl2/ZQ/xc8gkjCt01pOD+CKrNvdaoiTl2/FOOyVvc=;
        b=J8s1ovTevDSNjQICM3VHm/0jTplV2UOuV1VRcUrxDgGMg5F2BArrhr7soun/pfSc58
         5R+vS7sf/gw/9tBs6hK2dpbhc1MQR1XfDdUiwv50rxhKBjpL+/4DsTgV6rN8qB5CnDo0
         bJQSR8P5ldbp05B/JgYTd521EGccicGzGerl1Tpj7+2MC7AbDfkVxHs8OdqcJIstD3Hv
         bhFUCy8sl0sRlb5ejVQWaX1MB8wmz9uHfKN3JrOc7PLBYvlj75kFM30qdunRcWIMlw5p
         I67TlM2PT9LYKxbqghYyp3KyKUCMSHBDCsKC/4Ln1O6ZPvJJ4FTAE2KEXZnblQRSS510
         ucdw==
X-Gm-Message-State: AOJu0YwujXkRJK2mL1HqtMw9YPAxzcWevl7v03muv/kBQHSpX9zfcNOX
	KTPQ69UvlPB0muGwZVnRi74nMETlmAlsvkKuFj9Ut3W/Lg1rDsiXA+bjRg==
X-Google-Smtp-Source: AGHT+IEAbrPfHqxSp67i8ardhFXbJo0KVLfgSiPXhIW1BcQp/dKV23CxTodWnxhFaoqq/9hH0W7NUw==
X-Received: by 2002:a17:903:2341:b0:1f7:42ba:5b1e with SMTP id d9443c01a7336-1f8625da084mr101582705ad.17.1718614867938;
        Mon, 17 Jun 2024 02:01:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.76.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c3bsm75332685ad.57.2024.06.17.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:01:07 -0700 (PDT)
Message-ID: <666ffb53.170a0220.972b1.41c6@mx.google.com>
Date: Mon, 17 Jun 2024 02:01:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0508875945292572898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables
In-Reply-To: <20240617082101.3237350-1-hildawu@realtek.com>
References: <20240617082101.3237350-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0508875945292572898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862506

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.60 seconds
CheckAllWarning               PASS      32.79 seconds
CheckSparse                   PASS      37.60 seconds
CheckSmatch                   PASS      103.14 seconds
BuildKernel32                 PASS      29.08 seconds
TestRunnerSetup               PASS      523.46 seconds
TestRunner_l2cap-tester       PASS      18.57 seconds
TestRunner_iso-tester         PASS      39.05 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        PASS      109.87 seconds
TestRunner_rfcomm-tester      PASS      7.89 seconds
TestRunner_sco-tester         PASS      15.15 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      27.63 seconds



---
Regards,
Linux Bluetooth


--===============0508875945292572898==--
