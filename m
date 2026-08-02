Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542B356741
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662049; cv=none; b=KYuRXgAxygeSzE/lN7Ozvj4EXWYMe+tOJNTGiGG5GJ+99lwlMzoq/xKfXTt3CVSAHHB+qXnRreGfe5z2tuZDDivjZlBGjmusOnZ8laZjDsIWKYJ45k+637VLsASJR4UIJHhd2/f6TMmXJPWzSLnUYqWGTyBoOfsu1uzO2+jwo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662049; c=relaxed/simple;
	bh=fo36FqeLISAJC2inQBUoH5k2WIeiXQht4pXGKYLeXKg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BoIjzM2CT8zmm4izoi6HX5NnsCWgGOtF7nVp7m5WtULUP7JQDk8r9TOkY0XVwAJfaKh0s/IQQwB/JSy0woC14U/6TMsDrXpfOnktFl/RnlQVc3OtYjyvNNBASey4hpSPrY82KAarVlRPF1Dcmw87DybX8KofzF+q4vxyRate9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmSDI7o1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmSDI7o1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1311692a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785662048; x=1786266848; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DsfDh0NwIAdLMgojEC1gvo8ItBEyvqSnkEOFF7g67Bc=;
        b=TmSDI7o1etmIF36ZVVcMcxuIu16sOdyzvpfMBrOdCF2Dzs1URHliBNjgeVPz72kpA/
         WgmqBjodUirB7IIRu5ErMOtL8LW18vNcoQ9Ls/kTjhWUU6ETSooo1PKda+fC0w/8BL1+
         nKF98QpMH5YlTAgJq915/yY7xkEiKD6VUOmfnMk6DmmAkkMQIk4f9IH5bJRtEkbgaPl2
         YNkYirbeugLDTcxBjiDrfepgrcGoOuyaCfdHoHA8JgI0DEhW3O889ZD04gPb4JwRZg5B
         Qq4Xe1j83z1rV0KqWhUP30KlT9IBFIe3ApnHuT7NPxB+Lst2UKhz1HHbo1VRUzPmWeRg
         EbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662048; x=1786266848;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DsfDh0NwIAdLMgojEC1gvo8ItBEyvqSnkEOFF7g67Bc=;
        b=AlBwqGRhtfx9aZ/0TVzq1Pat7OX8PjYaTeQEj+xndiwNG7Lp/ol1ZoTLwiUKhNnAAY
         vJffUEJQXDlxeZuIPXk5LjCoCbfP/TH9GAxpzJ4B9xqgGp7fY3aNWHPs+qPDZ1TIy+AM
         aUpQFeA9rgacEzdKLOnjTaEogXruCzZB0D5x+m4B0qOaZLVizqfYD2/QVFHOcuieKhOc
         hZm60U6F+UpQyHZylR/UcV6u7MjbBz+2pTXLHWJGUp2GyAj7ZZJ6IrX2kNRRyp2iHH4q
         Xoo3vRHmiY45BWGyvsPOm9ka52uYoOQ54v6qXwVXqhFBTy4fnB6n5dQqvSbIHosfQtk9
         umsA==
X-Gm-Message-State: AOJu0YwMAcljPT0IzsXC7TflLAvQUWxFFB0u65dnAnHnbxM99LgWmh+Q
	yj6b2uFbgTnBpLDUr5OveE1hafBbaKn2tpeO4czooDEmVjcdsNFt+0HVNHc62g==
X-Gm-Gg: AR+sD10Qegq1ER20V4WrXIbilY4VoKIw84i2VUFAF7z0HGaF0832hvv4rW53K6Zt5HS
	Py6WN6IRB5BNyuLTL6YN6PeCrsIy5M6C+RFgrcOal1r/NYt6wh7/RKY5yllhysNqrQEas+vyBm/
	P4PaA4rYfh1dBNnpHwACEX9Vj0VSY1moYXC6ICfAtmZ4Rg0xIpC3J4rSvJQO7Rfa3gGVwC7dqGb
	I8kFjnxP+Vk74tXWrNPyKrMNZNdCeQj6OZTs35IX9HCVbV+YnBvBBNmQh434R6uKwtJphetiVSR
	THrFIvu0HuX1P0KSWjUyWuoM5zpezsr2Xko69vWIPryiO9W3ZpceRa8eQ0fqqxMtEixn8tk2h29
	2mch8X7sv8b5pdHKsJzap0mUVcuTHtiiTAKz64L1l1AWL8Ia+Jk5qn9QOhODiks9fDB+RttOLLG
	cBNJEyiZoQlDbaV7D7UJ2dLo6t0KXmp78pi3ih22Y9cxy0SLA5dQdRbHPintnZiWaoyYa01oLqI
	HKJ5UchOQ==
X-Received: by 2002:a05:6a21:468a:b0:3bf:a11c:176e with SMTP id adf61e73a8af0-3c92aa7a17bmr5734039637.57.1785662047886;
        Sun, 02 Aug 2026 02:14:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.242.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm31802366c88.9.2026.08.02.02.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:14:07 -0700 (PDT)
Message-ID: <6a6f0a5f.e5907290.26ab43.e35c@mx.google.com>
Date: Sun, 02 Aug 2026 02:14:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9155166708747199080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahbazovelman97@gmail.com
Subject: RE: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
In-Reply-To: <20260802080137.17604-1-shahbazovelman97@gmail.com>
References: <20260802080137.17604-1-shahbazovelman97@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9155166708747199080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138845

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      15.68 seconds
BluezMake                     PASS      396.13 seconds
MakeCheck                     PASS      4.22 seconds
MakeDistcheck                 PASS      124.49 seconds
CheckValgrind                 PASS      121.27 seconds
CheckSmatch                   PASS      211.57 seconds
bluezmakeextell               PASS      75.56 seconds
IncrementalBuild              PASS      393.03 seconds
ScanBuild                     PASS      659.48 seconds



https://github.com/bluez/bluez/pull/2368

---
Regards,
Linux Bluetooth


--===============9155166708747199080==--
