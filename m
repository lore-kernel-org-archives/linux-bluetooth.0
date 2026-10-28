Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204355;
	b=Ta9I56IN6z1Pk9gF8rpifmRuGwkVSoQ0hCD85Pp9WT4kaQuE35im1aFGgD9gQkbvmyQY
	 NO3YEH9IyJfBtRNYmjTr9Y82A4l6UL566uwodnfqx072OE7A1c1CbNDB+D7SnV5mqU5yX
	 Mg8IU3R3t0Rd98TisxzFTNkleiLQ31IG5BvmXK/11AEbh+A2lFF8uDP01fyLaWgXbwhp0
	 sl9Sv3+BbRqpzz5XHNwd2yTmDrF3XONbPwTCa9DVxC7gfsgad7ZFuMkGumJ3YWAgGKVPc
	 tiG/Fsd60zkvtfPs54pa/4uJBmljFXWKMJ+jCS+QVJC5fBxks5IkmhCDCK55Nct+9YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8Aa3Yp7kUxw8GdjVb9j93driV3lQNzHy3OOAQOWrkw4=;
	b=xPWqE2fnrcD3vh/bCr/UPj/C8P14ra7rmPdvECso7itthylLFQgOnRt8Z/kHAvgh4YnB
	 IbjuSHMTZyISistBcmUC9mNt3vpIDVEcZ9m815X+CIkEBjvBp4AWu7DSm9MSgElokFbrf
	 CQg9iTK2iHY1G+hwL31OxiQ8yOvNWtFDafeLsCKZuJlrp8sW6Bhzq+aqhWstBzIJxm9vu
	 +ofM5HCqETwZpsHGENr59nxzvF96T58kRBYODtfiRH18BGN8QX+IFiYuOqF7jT95m6ot2
	 lZF+SzTCxjeDDJw7ldrkSC5ryYP72QFkXDJz3GKaHLSqmRYhV0ASUJhdMFLJzNvpscw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P35A4+op;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E6606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P35A4+op
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-47b47de8b4cso704400fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204354; x=1793809154; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Aa3Yp7kUxw8GdjVb9j93driV3lQNzHy3OOAQOWrkw4=;
        b=P35A4+opzgUZN9d5rCbQq/plhIkHIqbpxh9G+utAM4GI8/NxU1M0L4iQZ9Xyti9EyK
         OwMijoIcVjVfjKzvD8ekXzrVbCoP5/xegwUt3v0zqHAMozJVCjc53bZyjMiHjE/hM/xs
         p5RT0+voFa4wz4wbOzXiUBhcHquyq2ONy4zn8moOHDSRclHZu7Qla3B+LNZ68S9XvOzX
         HM4LzSnE5A/ofeMJQwxxLPVBBvOgViTdhR6Vf1Flgcy6UpWbMF+ol41k6V2XpQKNItMG
         lelVyU7C43l13KxGueIpavoxjJUsMKMAeEmoBn0lduvQJvoFpLaiTeL+yRTUc4fFKnth
         Z45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204354; x=1793809154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Aa3Yp7kUxw8GdjVb9j93driV3lQNzHy3OOAQOWrkw4=;
        b=M1Ua2/mIUKCR2gRIlRzxy/pxd6uHhWv3767bkIe3gX/x3BXMTDan8VCEJxWHWxZBfC
         6aJ6G/tmAMbRCEN/8WUR16zOSN9tAOr6jYP8deUWFuyXPkTA5cSBQsvU+DmCreNA8uQV
         IVinSpH8mqBpyk56sY6Gmt4PjrrV4eCNvXlbxuNNb+eDbOzEvuPSAdK1tKXZO9idL1TY
         tAPkhWsDaY3dSqhebJgatrre+T4LuYmWVtrUAurwN4pEnALrLVdDkHXrlKM3s/Wmw+JL
         iX97w2X7tdtLan6F+tqcT89cv8W0D6CY2y2pa5mnCw6vTh3l6KKXT+x2LqXj7dz7Wc/v
         zYBg==
X-Gm-Message-State: AFq9FYIbe9tay8Ts4YOyMUvCGu/QlSi8AUH4o0K308zMdKXwobhCjsjF
	nZR5xKKSLSGdBDtOww09k1dCkhUDvWBK8eOJWQCYqb4oh6sFLAEZTBIOVAHm9Q==
X-Gm-Gg: AYBFou1NyXdexzjPPApyjZt29sKK3RF5ThplCUx5SKPqcmzDYVPbeJL0BCwW+o4+NFk
	W9tjVldSMT+4U3rNlzQQ9VQBhW/gakJIJc5PtX2jicFJ34eXzWGGDUGiA+nxYq8l/TsRys50/qt
	paX0xY6b4lp0+yBV/NeroMuJN96nzJv26Kx8LpY4BlVF5VzCuwITaPF2zKWCL0exlRHqAnut1as
	6H7RTMuoZHUPZUq8/TMqFla/hdlS2VM+jWahneEWn0TtKpO4MCS7WsZAo6pncGRtRuJKM8XM1PZ
	A5/5wNRyTKDhcS7QOYdvBDpqseFE/TUfYcTVkmRk5uGGgn83XSm8VmzVj8+YXUA8ilDiP/QavA7
	n1gVICIL5l8VEgy6aMixh4mHgy4BnqmQeaOr72ALA2EnsN6a+grVWVg4YjmK8FjjDY4PxwAMd4j
	P8UGrztw7wCQ97FGYRhcA3qVejpn4Nd432b/KHCa6SFmCph4vOy9hFW7fr7KyJjdHu3AvA2XE4h
	GQDZiCd+CS2VOBEe0z34gbLDxIeAvxapXspeSmQmD8A9rnS/51j7wAdAiecZ8FUgo7Iw4bbZ9cJ
	niBwz2ZE5g==
X-Received: by 2002:a05:6870:3113:b0:49d:c3f6:4195 with SMTP id 586e51a60fabf-4a8bb5ac8d2mr2196230fac.47.1793204353540;
        Wed, 28 Oct 2026 09:19:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.65])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b7901920sm2585381fac.13.2026.10.28.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:19:12 -0700 (PDT)
Message-ID: <6ae22080.318e7587.26e0ca.5b87@mx.google.com>
Date: Wed, 28 Oct 2026 09:19:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0119292061858747582=="
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
Subject: RE: [BlueZ,v1,1/3] shared/bap: Fix line over 80 columns in set_base_subgroup
In-Reply-To: <20261028135517.2395290-1-luiz.dentz@gmail.com>
References: <20261028135517.2395290-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0119292061858747582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195473/

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.14 seconds
BuildEll                      PASS      18.33 seconds
BluezMake                     PASS      273.41 seconds
MakeCheck                     PASS      12.64 seconds
MakeDistcheck                 PASS      136.81 seconds
CheckValgrind                 PASS      199.99 seconds
CheckSmatch                   WARNING   231.43 seconds
bluezmakeextell               PASS      88.60 seconds
TestFunctional                PASS      1060.41 seconds
IncrementalBuild              PASS      319.17 seconds
ScanBuild                     PASS      932.22 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2731

---
Regards,
Linux Bluetooth


--===============0119292061858747582==--
