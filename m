Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650712;
	b=c7dXf+3cvJu7gnPgvWU4HPHfaEIXoTOO28BfPDinI/Df5AWF899oyapFGkRPZV3trxVy
	 WArRyVIif6gC1eF7GWmbLMBhdpxRG4h+4KHpXt76tfsYygrualaVDynSgb3ue3bYpGfd1
	 C9TfUh8qJku8mBQzimXzj4N9OebI9JmmRGFh49pb6kR+gAsOfcf+dYUOuqrijwuEcZkgI
	 eAMR/i881aRMLVAfUR+GKbmbkXMcjH5B6LF1R2WlTYJupRBF1IBu+ZFPnx335vXES9GeJ
	 t/V+gKPpZT/sM6+GlTIcUhyakc8RkNta5q9UccKdzhCu2ttmN7fPt8baUjmUVgNdjLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=LbsKFki112iVwaoYuIHeGrZMlG07IZSpjbfAzEP2ZpM=;
	b=FoxKYVY0tjCznKeXWFGrqHYREkok3ooR0XQ6Ag17Qm21iMdSjRqB5HXvYJx+DCuvnq9o
	 71W/fe8yR3Eg6o5X24zwA0phH4wIv4Bomv3P1e00m11uG6n9v0ICnGPToLmeNLVU7DYW1
	 QkRBiFUFp/muoW8/Hpsawu3Ella0chcO0u267udVsn4N3k/g4A4uX2KYC+man6ng+b2QG
	 r/1vs8lwwyUpOH6KYSN5Kawo5J8jx/7NlQVCnSBGKbyCG+gQsUfBCrJt44x1Enkff+HYB
	 bf1xyF2Jepb7ctFNmKliN5b9AzRbPkMIdFt2z2oVCLz7lK+6QG7s2RTYyyn9UFIJUXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNZRUyeY;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FB606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNZRUyeY
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3acec6677so9669188c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650711; x=1796255511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LbsKFki112iVwaoYuIHeGrZMlG07IZSpjbfAzEP2ZpM=;
        b=UNZRUyeY9ftgpOOvs95/FBCEZJTdvZQrENrMXID5oZyQx7O3AMZfsU1UvAQrSU62sH
         Pi7SiE9y4UgjNgUN00ZCVLs2EHWd55CA8hFvugdmjekboRqROOKsSpcY2mL14gKBeweS
         zdpgjbiwOrPEla6/Yk+XVa1VmdG2uyR5A/zL5QBszwNQBCYYkhsOYdnnQ+9haFiCEwez
         B2p+ehb7umM1/YPQqNCwH/ukv8g2GbS4YjL+jUxua8xlLprS4U95/odKIBUc4qrOHjmW
         jyXLEB6zz8Tl/IG7RwkI6ZxeULmUR94c93BwECHnNG90IWa7UBkqXRjePRtQF2bbtiX0
         AJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650711; x=1796255511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LbsKFki112iVwaoYuIHeGrZMlG07IZSpjbfAzEP2ZpM=;
        b=QxuGSFdZS/IGOCwevoUkW/8aKD0yaTJ2labH1ofgHD9PBuYPGK7M04b2z2j6JL8JVY
         NOEWU9Oxo11TdAaX95xArkYV6U8HPrIKuz959QNFkpOrMUT/IUvedmySYT/JRfYAFCWK
         wLB7MzNiojo1K0CWUVmUOLl4nN0olehzxrBpO29/nCJsJA27BwweyTylAeP2dU56YByw
         1aMuHJskZn0W8fED3mNMXKpvYeAtTPE6ZFJKg4eRgoNsWyi4v7lacbYgUvyxB9/yQjwW
         6pKnXXvFipmfMSwkv3Ztc4A2Df9+TEMENPEgG8TRRG+EIm0SGVPVtQ+F55uEA3lK6h7t
         UoPA==
X-Gm-Message-State: APuU4Z8OmcFqOtzmFTEneXaDgd1OJtDLWqoVnxEQEwcYmI5YAzlK+kd1
	L+DZwNqsFDNr+JHpsVKdzn2DsKogF6IhM3eqlWpcOeE8f9OdLryR6L63Ze0Rpw==
X-Gm-Gg: AZFdTZe7uis286dId2q0TK1PYpPpd0Th+2lhOM+/cbZvPzvLGlvPfRuJ9vbwufNfml/
	YO+zfpBzzNgJiiYQFTu+AeFxC3p9x2oT/9tS/vxGrhyd2u001gtKImbpPe3dQo/ZiEzLg0wwu+q
	hhSZ7TbHFQCQ2liHw8juocwth9I0nKadZ6xnhgfkybqTpeun4ienE789OOzIxln24e4dKAggy4F
	HtmBlTZx+RZszNm9D/NGE13pXhwJJwYHLyYbq61VEThtPLWV3xXdvd1VIeVpQuCyfPmRmQ9dTeQ
	FdrokcS/hJsWBf42lD4Yw+o/L50Qr//GGdeI9Cs4IDW4WAdp97StAIrqV5/1Q0fdcve+jMwEw43
	7kCDOpANAIpTITuEcZar8MyuMdTZUsMdrhGbs9TVKBr1xWcbRzFpaXXHEicaKd7O6ZbHOmfrXH7
	APCorp/i4DA18el1j2Ttt0bKJd3NXtq2Co1kFLu6urmN5tkdbnBp+yrcjFn7rLYiZ7L1xR3Taoz
	rFPmz1I406m33wqr3xfx8yPIvwJaMVldEa7wNEmG+//1Wtn2aMbVFSLysEh/p2UUw==
X-Received: by 2002:a05:701b:4553:10b0:1b2:6a1d:bf58 with SMTP id a92af1059eb24-1b55694435amr19221602c88.38.1795650710519;
        Wed, 25 Nov 2026 15:51:50 -0800 (PST)
Received: from [172.17.0.2] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm72549564c88.9.2026.11.25.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:51:50 -0800 (PST)
Message-ID: <6b077496.ccc6ed06.212c36.6d9b@mx.google.com>
Date: Wed, 25 Nov 2026 15:51:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7044664638742122720=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2] a2dp: Don't suspend a sink stream on our own
In-Reply-To: <20261125170224.1648830-1-simon.mikuda@streamunlimited.com>
References: <20261125170224.1648830-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7044664638742122720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222367/

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      308.29 seconds
MakeCheck                     PASS      3.42 seconds
MakeDistcheck                 PASS      145.82 seconds
CheckValgrind                 PASS      158.37 seconds
CheckSmatch                   PASS      315.36 seconds
bluezmakeextell               PASS      99.44 seconds
TestFunctional                PASS      1215.37 seconds
IncrementalBuild              PASS      311.86 seconds
ScanBuild                     PASS      1186.14 seconds



https://github.com/bluez/bluez/pull/2925

---
Regards,
Linux Bluetooth


--===============7044664638742122720==--
