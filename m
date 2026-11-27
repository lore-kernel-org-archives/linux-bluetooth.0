Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755519;
	b=zRe5+OOxbri8n7A+8BC8a8DZrZtUal/OtYwxXBE51w7MaOKFL5ezd4AH+tykmZ3yuvY3
	 VIiZv7rRaXazZ6VTffCqMAGS7VAY64ezLYPLATdshfXJJ3PRS/16o7pVvC+ocbbZwNGne
	 yUBCwdKRhiD9h8m2dw/SpuJKgpfIf0sJqGpM9QDQUqqoe8KxXKaS4A7dbs0GRCkdBWlrB
	 eexDxYCLSghRhIFUU69xPODwQyjox9ZTP45e3pzvX9qipvS2T7KloIfYn82bXvdUUvsBm
	 ZQQ9rOnW4KC2jlH7HQ8/n4A9clHNy8cVyvD1GNsFM0PyTRC32grRIo2iJjR78903pag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YVopo91WW7My4wF8VDkKKdHKX2dmHJ3Qbx+G0HOIfnE=;
	b=j5acUhwwffxl1RBA0UBspZnOQKuYvZ0PbgxFMPXUqcBhn4Oxv4q2b7zY1Zt00IAEK42n
	 44/Yppn4QeEhGSR6YInb2VpDmjUPyD9rk4R32T2TP5zJiooamkcmEtm/z2jykQ3r8pmS7
	 1mB8S2x44hley5mqJk/CN1rYVW318omPja/jwqGF825h97vSLiYeZeG5YEdg0fOS9j5l/
	 68oCxXbrSvSr2gtjUNQA2Zm8rkTIOJkSLkYU/GR6ahNB8Ou48l9Qyw/yVSXZjt0iV35cl
	 BbshTMVlGnjGubuj05+bUnMJVHtc2qLz1SwdZqistMk3W7LkNtyxypNeddHSb/31HSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLGIMRzp;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D5606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLGIMRzp
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04244c3d0so60612485ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 20:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755518; x=1796360318; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YVopo91WW7My4wF8VDkKKdHKX2dmHJ3Qbx+G0HOIfnE=;
        b=mLGIMRzpa+CdBH69u97RjJCmKjGUMCt3rbHVTB+HN300KR9A1W8VgHOL63RlJEAUQZ
         LeR/mfHWQe9X5cg5YMUSZ5nB93F1E2yH0KPIt0u22wOrJmyMgZ/np9cHV+/2mQR/p73t
         RZuCI2ARly2kWadh2mLXFDYdmuCCunX8myFznneduYl6Sb+WMciiSqc+UNxC7eFZbaZh
         C4ffXsOpWk2QlFGuEkBw9ULvU+AyLSjn9fvos9nuiNaSfBgC3ENNcfU0CZnnpQbFexB3
         oPi8OvahK2wnIy7bwRgILd6TtIpigBwrLIlHxShcsAopiw5B3S86YUIlbeo+U79zHQw9
         G/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755518; x=1796360318;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVopo91WW7My4wF8VDkKKdHKX2dmHJ3Qbx+G0HOIfnE=;
        b=nRoVeB2Qlw8NhipabMVTthF4/3+G04gqpkACKn24eTXHvTaek6+GPl844DoTfIn41f
         5QGPkhbPC3pu1ce1UK5oRRn+LYWQoAq4PXmb9FulPWBih2GoVl3an5+NQFXdX6oZU1kk
         ZKsH2rNObPGAd0+n1iBjZPxtWVVSxBbK7mxOsaOxl9+oFMLvJfvLm5ZPp+/VLp+WCFfn
         vNe9mQWmo5j7hc3vFaeRvqaodpTfsRKk5aNMlfB6Jz9KUvp1TBl7OJL1MEouYva6EZvc
         5kxw22R1B+ej9/dOUxbneZQTgDTXJCGxpYEHseLRK6zGMyns3ALBzsifPlUEUIIGC55s
         sJxw==
X-Gm-Message-State: APuU4Z/4VWGN+j6P2qr53sR7aesIUjthisDbWy1AITYnqBLu+ZK2o6aj
	Y/S7ukUEg/2gz66LVanINpUnxduakdsDFXziFrnTH0QTX8MzZko/Fm0RA4Ix3w==
X-Gm-Gg: AZFdTZfOPPDIMbYWrNf+8YGAVbqt3tDp+hRrHVz0M52bIJZAsK9vohQnW5MWE1bRnJ2
	X7O/zfHv7KN/qh9yg0khGWVd4J3/k2LWzo1DkSI+85Y6FzaPM4MIAPNFmlEcBlSE40EutZY0zjB
	Lj4pcN0En7tOmAJU5RFSBw8I3LL6B3S4cFYZAGMuqt2qi7FuUEKLREHv5T2rCnFRlOrTvIDNw00
	GHCYAQf3kcd3Cbbg2401iyARc9F2A4GZ8b20ET7ssye0biln7gpBXTZFcMLfSWPj6uTTafK2So9
	bOB6Ub5NQpzifAx4nHA9c2IfprbLLvvO31t3xHd2hj7s40y6c/0xe40+9hiMI4lowoJI+2z/Tn2
	r94dNXVMOa5RgifJrnQUzcsmO+g8riEdXpNNhLtrqoKxsOoir+34mjcmrt9eeHmTukIsToC8HI+
	xJEEAml7p4aIenHOat+NBCyTgVe2pVLw7ntwrgJNGmwlFA/MGIJFCrxJdPt++gJB75UIWeHkcD/
	SP70W87gb4R3O8x6PfOIo0iDUi8LH9bMWOXW41wbBvmRixIo4XQMwVBnRPjfN7ivyAhQU1lbsm7
	8R2ImPDp6DIdMcwMkcKErA/U22k+o/aCNbk7Vucp
X-Received: by 2002:a17:902:f787:b0:2ed:379:158d with SMTP id d9443c01a7336-2f03f0fcd73mr236815485ad.9.1795755517987;
        Thu, 26 Nov 2026 20:58:37 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-112.us-west-2.compute.amazonaws.com. [3.42.157.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm110642185ad.70.2026.11.26.20.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:58:37 -0800 (PST)
Message-ID: <6b090dfd.d0f6c027.19b01e.58f7@mx.google.com>
Date: Thu, 26 Nov 2026 20:58:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6112325831607395128=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261111200705.3802779-2-luiz.dentz@gmail.com>
References: <20261111200705.3802779-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6112325831607395128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add support for HDT and EKS
   Pull Request: https://github.com/bluez/bluez/pull/2801
   Created:      2026-11-12 00:37:06+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6112325831607395128==--
