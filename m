Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC33BB47
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418804; cv=none; b=Ehw78s19HptL5BdWxmRvJ3s8LPSJzx6QS+/eFCKPAzlXx2XpnyksF8r9vLdspY3Wsu/2IiMY1cIKZnC5FtgThG6+kXBJRO7h/0PrzG4T0BhxKvo/owg0owkQryVso2HfBL394hV1kNu1HjtzhNxvVp7KNf8ltuwumdtj1ijPV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418804; c=relaxed/simple;
	bh=AaX52A5fTCr0+Eq7tFAfIg1m+WqRTaglWEvIzlKTuDE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pscnCSlTG+yZ7mzKaXH0ExiaE+5O30Kwn1eHGOoIcWeQ/TZmXC79OsaOSou5Mt3ccGASfgBuLJh5lqPXSmzIrLdT66lifM2alAIcqSRTnsL08P7CaswFRfhpwddE6fFY1Xz+yUMUdHZGR0tQyVAsKyb7MZl2Mcp9n4HTQmd6hYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfZ4r5ff; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfZ4r5ff"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b5ece41dfso2936806d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713418801; x=1714023601; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPAr0lgmTsHRN0MBvGSucZZmPtwtp4d/ZJDuFTBEfjI=;
        b=EfZ4r5ff7m/dur6bPg4loRelkKEbzPTLkdFOnamFvBCRCwtskunsumz8jFZRgcn13c
         MJudrSr5IL6UXUXhJAUhsdiB3OGBY7K7r7IvLrgr/bsh3pWQ7S26qjmBjNYsp3D4CV73
         m8CsiX644JayujzBRk5W/gqLThe7r72LERCl11IKJMGNkADLV/gr6Z8Lz0TC5cTfk4CV
         IA2zULAA5ToTpIxGMWbEvusoFsmC4cdYI6EB7aOYCvW76ppAxGf13TNp1yMQLNRIP3IC
         ho8MA57VWjQO0Q8t8EbNf1uYc9WulJAp4r3A2u3bIFAFhgDYziUQ1hTNrWF/i1eW3Urf
         mUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713418801; x=1714023601;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPAr0lgmTsHRN0MBvGSucZZmPtwtp4d/ZJDuFTBEfjI=;
        b=KVwg+ngd8F+Y9zw63sN2Y3svIUi8+EbQygCV0oVpf02TnQJbEeFKHvDLcUk/MFSU27
         KeHqy6bdNe7CnP3XlOeTNXh1OByhtLq1WTH+ydltg7H/3n8bASnjwRqkl2IxC58VLxrG
         j3wRRuXzhOh1fg9kn57Vy2dd6CaqmuiST7aAdQgT/rBXA5RPkH1wVGCMoU1sqN8AHx6u
         77z4CeHUlaMPQ4xRNO1Yz9XEEXLvl9sAVMy6vlia+IErc5JlaY2HlJiAw2FxHL0y3u+c
         PVtw8L2Ul/cOM5vKNxmKYNq1i46JbxBoXMwlmTgvQuu5q/bclOHxyI2NIpO8nEpYCQ/M
         Vwmg==
X-Gm-Message-State: AOJu0Yy3WaQklfMdrPxesd5HyniEgw02dx+luOPeslc426Qo40CFEWXo
	vaO3nr0RcjeMHTtQyNr/aWLRL6pY/BSljE8rurFYwiz1ty7evQv6hvBlfo5y
X-Google-Smtp-Source: AGHT+IGtp+UTf8k+KeL72sREsU4jQqscqXPlv9ouvKd9FRdUhN8HIRl/wsi08zN1uDKHygDTMJGIcw==
X-Received: by 2002:a05:6214:178c:b0:69f:9d5a:1edd with SMTP id ct12-20020a056214178c00b0069f9d5a1eddmr1887395qvb.62.1713418801548;
        Wed, 17 Apr 2024 22:40:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.130.194])
        by smtp.gmail.com with ESMTPSA id g2-20020a0cf082000000b0069c5d4b95d8sm339761qvk.73.2024.04.17.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:40:01 -0700 (PDT)
Message-ID: <6620b231.0c0a0220.3e3f5.1428@mx.google.com>
Date: Wed, 17 Apr 2024 22:40:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3013367647998394274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [BlueZ,v2] tools/btattach: Add support for more QCA soc types
In-Reply-To: <1713411538-28578-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713411538-28578-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3013367647998394274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845653

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.35 seconds
BluezMake                     PASS      1651.99 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      176.71 seconds
CheckValgrind                 PASS      246.94 seconds
CheckSmatch                   PASS      348.94 seconds
bluezmakeextell               PASS      119.09 seconds
IncrementalBuild              PASS      1406.00 seconds
ScanBuild                     PASS      1020.09 seconds



---
Regards,
Linux Bluetooth


--===============3013367647998394274==--
