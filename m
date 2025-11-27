Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17752765DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250216; cv=none; b=nh3A/TunMm0hITG7GZDsVLI+TxumovUYhawlZA5qg50yT6ZNcsgP9NsVC4wapcOW2jeLLZNdZcr9qtEsM27X54oImc/J/heX7Ttf63lw+qGYVztohK2IbR0P7z8Yue960KT+tMzYbItbDLwYu3C4LorjMnvUlvGn04bhqxB7Auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250216; c=relaxed/simple;
	bh=2JG6fKhGdA5AKs1DHbcFnDOa5j5sne+foWz4E3Nc6qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r2pD8I4XaxZTTIrhb+l5tR8B4CZNmuwSN/Xk7BfwrB8ep++zIsNFa00YZkMvDj/2L4ZHfWb1udmTNGXj8XMglkTGtFRLoaTtR88HB/J+qtaJ8mPqxUDvlPQZFR5EjehaFvbQeEWHR14bKk6peVu48y2HdlF1hJNXeoyPcswykZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fccdT0YP; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fccdT0YP"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4330e912c51so4034855ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764250214; x=1764855014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jRLqdOw3fIJDBhdNiwIn3w8HfCHZCZWvI7vxLKjXWYo=;
        b=fccdT0YPKLZZd43aNiffzmzUWJ41ebGQgfrawRqqvGsAUSG2Y/16lQxOCXiEeNhYG7
         zNbvFRDud0i6IZZi9EqWk3NVgnKFsWs6hddSkYi2dsLvPKk5XpC+lgGUGBpKfgBC5YlL
         FA6n/1MPtDGgOK9V/7x69ZbF0p/PJ328Ycc+X1xA1dwXUgzCmToZqOGZtxzdtKs+UGFe
         uVatRNDsNE7n8LWWqImR0qYyJOd9UJBUzNJ64FzHl8IcbTeeQnqsKTyRX49z68Vi2w7l
         AcorE0R6wQoieO6uPYfo2p/HVBIWUQ100IHLKBJ3s5Q5nw2EEfgoToa3jS8kTw3PLxEK
         Vg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250214; x=1764855014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRLqdOw3fIJDBhdNiwIn3w8HfCHZCZWvI7vxLKjXWYo=;
        b=ZQZNKcI3GUfzfTPA4DnFDj9uVBjE3jR2MpMElMSPQzfoWinKEq5SOM4U52PEjgOBCa
         vPQhvKQ/h7ErQYU1dgMp7Fkv9ZsLg+50l6kc7uulrJPO/RJuunTx/d0LqSwaE8PpVKv7
         U4U7hYkDfhGiO1JSUuLElVPVBPn+zmAwQLu80gzYUhBqO9VFNL0AgoubbodfhtB5kDg5
         okACdCMkPqUFPqEHuiGINE04hig4tBKEFk5nCv9K/nGNgE9LKOMSgcAd/wm+JMobzmgN
         4NPiI7tL2xFaPl3s+y3l0IYBpS0wVSe/nVzNZxdDXdDJ0llPNKSNzQKAO65Cvg+4oPvQ
         hs4Q==
X-Gm-Message-State: AOJu0YxtPDJ1za6REY8K+zFZe/EEBl3LMtUuM8LRa1CmVhCYDmFeXrs7
	BAPo65PFpCWoJCLwAqTe3T08vcruL42FgTGfx4oNWUmtSc3mIaP23wquyYLqNg==
X-Gm-Gg: ASbGncv1rKLa3DsVwWfM6OBpn9G4/PH4uBPiNm38pyGToK0760Qu/nOLuPx21MN1x4h
	4seVfEYbF4NYblVfxw1uBeTEHtIzrBhDEQ4DkpAocb31TCwRQndg57xTCtpEazlnyeYfCcdH394
	oZmjbqNdi+3Mjjs0+pLBkdIlC/PlFyK+Z6qdyva1+PY49x8voKkNMxTROSQjTotOXtFNmqJlFcO
	K2ReIC/+I6KOjpibdcPqyol5ps/OmdsEq9+jLcB5XUwtWLS2Xj71yxqIBK7cgetFuHrYnr50dRd
	G8IxnOCnjl708oTHFmMj5gW+y4BsbvbNy9FzPdl7fI718Px5o5uxaRkEcPwMSI7o4xjlNhtIKXW
	4z79isiUSYbUIQ+eQBxMQjBqZMtery9cQFlBBQvrpPas3xuuZ8ejuMbMBuQTn7yewcZx4u9r3Dx
	nhg97knZ+MK8xFr9OX6Q==
X-Google-Smtp-Source: AGHT+IFwkwxX0/aE9XC/PFwcKg7cVBwUnoSGSpmJXoK2MM0V1rEeV9k1N7qfyFSXwcbzKh2XpQ34sQ==
X-Received: by 2002:a05:6e02:2684:b0:434:77cf:9df with SMTP id e9e14a558f8ab-435dd10a602mr110467645ab.32.1764250212197;
        Thu, 27 Nov 2025 05:30:12 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.233])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436a52e7706sm7368155ab.6.2025.11.27.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:30:11 -0800 (PST)
Message-ID: <69285263.920a0220.3cb650.0f14@mx.google.com>
Date: Thu, 27 Nov 2025 05:30:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4890814776289934117=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastian.david.forslund@gmail.com
Subject: RE: main: Validate the AdvMon scan parameters correctly
In-Reply-To: <20251127124244.410438-1-sebastian.david.forslund@gmail.com>
References: <20251127124244.410438-1-sebastian.david.forslund@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4890814776289934117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028268

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      19.98 seconds
BluezMake                     PASS      630.12 seconds
MakeCheck                     PASS      21.43 seconds
MakeDistcheck                 PASS      239.18 seconds
CheckValgrind                 PASS      295.08 seconds
CheckSmatch                   PASS      342.59 seconds
bluezmakeextell               PASS      180.29 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      966.80 seconds

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


--===============4890814776289934117==--
