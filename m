Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A54198833
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123213; cv=none; b=bT+RP4LHC+l0x1whHS1KaWl9d/C+nkqihX4G38cAObFEr2/nt86BZQAEDQ6uCpFnWKOkZLIHN1cxttZ/GZOUeVUQmyhx+WIeazUJ2a4LFo8LJypj7QLEp9ytzPC/Drp47EDGv8OtHC9wrYAZj9EMvsRLoXYorFzZ3ZhBFW9WkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123213; c=relaxed/simple;
	bh=wi7kR4hMg/dhzFgX+8eV7Zq+r4cbxO+AD1u4D/Wrhqg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QA5UIxWYdGqrntGUIezjkjT97lbaGAmnD9rB5Rqe+swGPuzg6QHdTExMEbA978q0HwWocAT/hxIsQNbOHGsA1v1+FKG9OJxhE2h+MZd74mjnJLs8aWMX3XDDjqksCcr4XQOhQlplIZDl1qMWIlnguIBnsNCMW/W3OjUb4jkxC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlJ7YGp4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlJ7YGp4"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f16c85da0so351825985a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721123210; x=1721728010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=14Yy9SEQlZdoe81h+1skZa06X2Md22PcfiaN4QlcUqQ=;
        b=VlJ7YGp4Nk9bkhyAwWoR4TUfCATsVZeoWeCY3AYew3KrPQTiBG33JjjeLKNoTMnt0r
         RgXoPil+EsOhnLrFZLh7z2jsD6fOo413LNxYMIZMmyafA1F9QVeKTNP2awfwXzBUOc8L
         TTrWZCm1uPxQKoO4Fhm/PCR2jRRc2NwFbA8lBMW2hkP686lqz+qp70DraKBHIPmKWxs5
         lYAruKMNfa5pPcQalPM/OjwmXScTRzVz4OrO64K7wjj+Alu7OwXVuMCtbU6cBaUVnie2
         vh8kWr0XfHG0Xb0wiUj6EEIN0m13iE0JBHfWjyXaKOzb19bVvGRXH44+Fvr2WkDTpX+J
         TRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123210; x=1721728010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14Yy9SEQlZdoe81h+1skZa06X2Md22PcfiaN4QlcUqQ=;
        b=MIf58mfl6yeGnzufEpz2GLT7G7UcMa3TVWlz2AdxV+hZd9IWfY7Vm8wNheSlpj8cNS
         7O8n7OSHBQ4Zt0/oHVb6c4rWDQKlgNRTAi/Uvd5oQ7LFXW6GrgWcctUoFaqJVEEeGQlx
         GPpytudwB8bbODvzsiyYxW0+GlKZlByY15ehHMXAOTPzvJz5sBMxYYUp4VndKb7D5zS1
         XzMq0R8kaJcYuhjgJss1wZu9mYAHuQcxeLlzK9gbVTO+xAe1k/7IuayiLZho+StrqAT+
         NfLk5kDPYnpjQt7GVfrvsL3CE/2jCtx0SuAvZ+C1ebAayZ/DzpUDpkU93/Y2f8dtIalR
         4D3Q==
X-Gm-Message-State: AOJu0YxfnWd7CqXC0tbVFf9+DbQ4pSNPOZv5A2v5Ck/m1Lzuz2+guMhW
	y8lOEl5bi+Vs0gMBNm9PC003PZTAaZJb443yATKLiFq+pz43IzgHoro+wg==
X-Google-Smtp-Source: AGHT+IEFj5Dzc4fF3/InnzRLi2rala8n7M9v4ITEe9J6xz04iS/HyVOoO0DMVttJq/YpvEgmW7YU5w==
X-Received: by 2002:a05:620a:8812:b0:79e:f80a:2ab8 with SMTP id af79cd13be357-7a17b6c5a19mr207379685a.25.1721123210292;
        Tue, 16 Jul 2024 02:46:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.50.157])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160be34c9sm276976785a.71.2024.07.16.02.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:46:50 -0700 (PDT)
Message-ID: <6696418a.050a0220.f1fa3.a1b3@mx.google.com>
Date: Tue, 16 Jul 2024 02:46:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2568262399599302089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bap: Fix crash in bap_bcast_remove
In-Reply-To: <20240716081131.14893-2-iulia.tanasescu@nxp.com>
References: <20240716081131.14893-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2568262399599302089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871594

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.97 seconds
BluezMake                     PASS      1753.70 seconds
MakeCheck                     PASS      13.13 seconds
MakeDistcheck                 PASS      178.55 seconds
CheckValgrind                 PASS      252.50 seconds
CheckSmatch                   PASS      358.86 seconds
bluezmakeextell               PASS      121.95 seconds
IncrementalBuild              PASS      1489.90 seconds
ScanBuild                     PASS      1025.78 seconds



---
Regards,
Linux Bluetooth


--===============2568262399599302089==--
