Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD42505D6
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454712; cv=none; b=Q2PBrJOWm4UIuraTP9G1i4UxKHtxn4nhyfGM4mXBXO329ybHNRtbQ2gcrWYZhXlvD2U7w18FO3YPQLqDz4M9K902+oUUeKpk9yaZIjHhmqNoJVFRSSYQDrPBhPVh6/Obg5gj60vXg/IzeSdonlls5fCZVze5CJhdpolgFDc7qa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454712; c=relaxed/simple;
	bh=CzX7gptWVyAKwYR/wtCmA+RbqWfd/+BpFiRIZZh7FZM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NEYvlTRKXRHUqqebI5ysBiNVFlFG9TZMlaHveftH9ne9FeBfvLSz6BRdD8ZbTXMPtBHK/2Ak2oG3+GdSXnsRjR3MGv2No2lWBs8V/4IIqsH3N9WqschmZq4XhzXjUlq6sm0dQNHDysrH+PsQYvmT718qii0hI4DjnE9xDEf2OVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2QuefH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY2QuefH"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso53186096d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746454709; x=1747059509; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6b5FXrcI25tI/nskm1Q16q91FXE3Wu3EXIfd8q4Vo+s=;
        b=BY2QuefHLfhFxpXe/dQPJiKstS9vGmVbkXSiuIX2bodnFa/1e8a+r63YkJjp0l5XMi
         xRtZwHId6211GdqDlowe5IO5OYzgMc/o7eXSxvLQaDDLCnMBEyONiyuSuDAopX5hAc9d
         1wVF3n3f1/8EBnJXvm4SAHDlRYtzvZyfDAvqzoJADMJRXPqhM6tkGwWmZgpA5xC8+GHu
         7JuKJ4cIf404aSuqBizwRHs/u1+pC0FXne2jCjDG9xFdMclvH+EeF3fgtYCmM/GxPNdM
         Xl2v7qeSCibeofT50eicv4LlTFuEiTR8Lab+7ZidtFE8/Z0Wdm+lxp+B1yxVtgoKFqLU
         D9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454709; x=1747059509;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b5FXrcI25tI/nskm1Q16q91FXE3Wu3EXIfd8q4Vo+s=;
        b=tbEFEjT75DxjSmokyCdV/uJ7xxsRBnE5zflHXpn/gv5jz3TxwoKsnyO+b2zhmxD+VP
         YwpLxe0GfKOSefvsd9Q15ZkW5kdzsTL8LLdpJO1oJJgO35evQ5zm7WrqhODu9MuhJ/iA
         yMzm0Qn9BMWyvQ31ciLQGa90G0kYV+ZvHz5YEO3GK3MqEWXu6xhawYwNIHXVaNHIqDtW
         LuqP3vniwv+aQfYGwunX2QIEVTBx6tru/t8Vx73GZ1kPlWbv96SgH5qa3x+pPKPfM7EA
         eycnDUC2HR2QW/nXnyRafRNfofb+OPSgkkw5C5zdSilof6JROoh7YrKG7DC/9p0X6BLP
         tpfw==
X-Gm-Message-State: AOJu0Yw5XfxISJPK3H4sdT/svs2hovPDbrx/AS8tL6Py5HIcdgtrITgi
	5RsgaESHQB6NlBeN9WoIlUZzm5BXu3XAHGEqYwp6nV2EtuC8bNf5GEZICQ==
X-Gm-Gg: ASbGnctn9zC8ciBrkeN1BxCVBO0sYiGqTDHGh/b+oowA4Kt6jpbC2/Lt0MugRPvDVbN
	JfJHnXHGkc8ddybqS2lXFlD+O67QMD8Z6crLAjj10M9W8iJE/4jEG9cicwNDs3MJUFpu5ZNKb/v
	JmC4+W2ZaR97IAMf1gEp8kEqLyP8AEktwokQbYndY/x+3fx1PqLamr1tphfwSkiuXXYgVlJtTWv
	GfY1RaQfg2EcO/OBkW9iLvlPIckb7K7REtUoGte8/K9hXzG6OMoDYjg2tspXhP2+X878aAgf841
	NzxlHEt++n744DnpJwy2eHX48GXfrlgu9tO5lOUWVPozuw==
X-Google-Smtp-Source: AGHT+IHG0U8zpXPKosak5ncm6S32AlDUyPYLZySP5oJLdH3q3pUgs5+iFNQ06ZWBm69oRXO6nYA65Q==
X-Received: by 2002:a05:6214:2a47:b0:6e8:9e9c:d20f with SMTP id 6a1803df08f44-6f528c7fd8cmr102589926d6.21.1746454709083;
        Mon, 05 May 2025 07:18:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.62.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f480ed4sm55957676d6.103.2025.05.05.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:18:28 -0700 (PDT)
Message-ID: <6818c8b4.050a0220.110936.c693@mx.google.com>
Date: Mon, 05 May 2025 07:18:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2837873746655850629=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ] mesh: agent: add hash calculation of URI
In-Reply-To: <20250505124346.6621-2-ceggers@arri.de>
References: <20250505124346.6621-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2837873746655850629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959620

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      2769.51 seconds
MakeCheck                     PASS      20.88 seconds
MakeDistcheck                 PASS      202.47 seconds
CheckValgrind                 PASS      281.34 seconds
CheckSmatch                   PASS      305.13 seconds
bluezmakeextell               PASS      130.20 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      918.63 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2837873746655850629==--
