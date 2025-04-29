Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E12AE96
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949971; cv=none; b=CBr5FWhzobuUwk0Mv19j251PTLq+dSiMSc+sQC2R23Iu5/hZIwvNlA87BXEexz1ZoBRnI3pX9rLB0+K8lssZGse8XTGI4rGFyLxKL0uaFL741YetGtHeTrNuC//U1XN4nVaP5zOTxXY24lbRURkUFyoAIe91zRzxCQblFAbsjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949971; c=relaxed/simple;
	bh=0x72V3ssHPNrzND0bwg6Sm8CvpnnItphk0gbMZViyyI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CjYMR56IwikE3wj6pA9KOJVWPRxAO5Y3wn0yFIjrQKmRAbRhC2Y+MKrPIiwV1dJ4ehGZgEOk5Mwu935FUJSYn3rgerlcKzwWSZCpwcq8+RkIyTstyGDc0jlMKMcvZh028EZTLg47oqqXNZ0OB2W/vWmKnSh4fKejzTrvWsaM3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WClscDBI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WClscDBI"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07cd527e4so685470485a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949969; x=1746554769; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VeWsmltJ8Mdqqj1Ui10TKK37RSAGQKA7SVrXU+FK/EY=;
        b=WClscDBIm9TUX2NkdGnpQkCryUy2s4bjpYSSNwOc98JhdsNXqrLXzlyi9LLxEmt0Ey
         dwi7Dd/3wpo0W5D7v680cZ/HhBaRRLEbVf8xil9w2xWdHZEUPCl23SzXakOXVGxwFP3+
         2f2J/NHYvoT9yzcwXECh2imPFcrqbBmy6Niam36eRnS+DrZs+FGxS71yZnPQw8bacPx5
         XT8tLJNEpD73aXqnPyC+dL227sR4X7/jLbMBBpOHKIpRllWboCbWPiiyWNX4+Fh3pOjw
         IX1LL1tvXPrxcJHEu/iTF3mbplIwy0juvzh3pjWHoVlOSMWvqOvcwHTJPyWyLL5YC7JQ
         3tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949969; x=1746554769;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeWsmltJ8Mdqqj1Ui10TKK37RSAGQKA7SVrXU+FK/EY=;
        b=aYiVv/7nUAN61BX0KGhlIJ6fkaOi2ZhKgaHG7cyUUzVKqcDs48KgizXhuTGaizn2M5
         VoQncBhBhP4bPdvaAEPyNUHsEnFukG42BEpD528FSNR0l6sP/DivmmAQyjiPchkAJMKh
         H0od3eZdMiRJjy7qDkoBZewCU2im4RUXoj75TOmd9083VDufWL3w+TGTes4WSWxnS2st
         Ur3JTz8qzG9GqX1c+RLWLFq+/d6IcqF9x5QQ+G8ZFfYscc/g9wHnZlfICV6C9auNiWFs
         PAgHl26RCaDpcJ0yzOm55e/F1M0D1WtlyrFyUFlzrwYqiYPWVe7/YwAMAQyIRGjAvX/w
         I+6g==
X-Gm-Message-State: AOJu0YzowLaG+8Fw6J8IC6+4yw1Et3w1dX7SDBY3h/lF9ngrq3N9kP4P
	89XB3SZlgxQK0qrnAuw1ENGeopudTIbfPh5KEvIHr9XhkOnShIBpFWlkxg==
X-Gm-Gg: ASbGnct210pinZjFAQ/todvA94VMx5L8veJeewq5xQhYMtH/GgmnInZfex0OWTW2PkH
	33k3aWLBLP07FcU5TOeiZYtZIcNkN68Kcs5YS6WG7eOWsn4o8TEKNbkP08ljvV8VPH5VjHB8U32
	XaH2Mb+K9J/U5Mblh8wDJHnRG+yeqwZH27WFoifq9WuWHRAwoDmJfybuuSjnoyyeCTj9GFNxPE3
	XRAayxGongmk65uQphFd2+iy4EzJOkjFDEUKGJAAUTcKZM9OsebU7lU90IQVJfJ0J9OpTaapKMm
	QbK1WcazEaCG6nkYr2W9OkU3RzQNWbyAhtom3hRmE/PA6W3H6w==
X-Google-Smtp-Source: AGHT+IFml3YrMERvdQlZzsCeTVyz+4OQHctD+22+RgE+trzAAcrTuCUP5W8HG6gbzVXB2Q7ecUzVkg==
X-Received: by 2002:a05:6214:4002:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6f4fcfb219fmr5291936d6.42.1745949968595;
        Tue, 29 Apr 2025 11:06:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.135.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aae668sm74418296d6.113.2025.04.29.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:06:08 -0700 (PDT)
Message-ID: <68111510.0c0a0220.16c5b6.165e@mx.google.com>
Date: Tue, 29 Apr 2025 11:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8811221570579671155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP when required
In-Reply-To: <20250429163615.2188056-1-luiz.dentz@gmail.com>
References: <20250429163615.2188056-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8811221570579671155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958207

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      2624.79 seconds
MakeCheck                     PASS      20.41 seconds
MakeDistcheck                 PASS      199.32 seconds
CheckValgrind                 PASS      275.36 seconds
CheckSmatch                   PASS      305.42 seconds
bluezmakeextell               PASS      129.34 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      919.31 seconds

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


--===============8811221570579671155==--
