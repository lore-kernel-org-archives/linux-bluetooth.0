Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD7405C45
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575495; cv=none; b=R4fKgjFHfbxstJGewvNC0YgoatZ7Y8DKVBPRma7O//TjOy7JQ7fVEn/qqvLQ3oTFgWp4AC2C1OBxsOhhgv193mB+mxYmOXUGxreg2dpBr4WFugcstaiFTin/TqvA9ixxMuMFuwpEi4Zxw0lU6ytuP/8LQfEU4gT/wOCj617+oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575495; c=relaxed/simple;
	bh=xtJKUp4uNBkmn2vVGgJzIBl1vBJOQWZ5vGzH5GK4tiA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SOgRyfM64s0halaM6ghDFy9cPp/i9zKGTV4v2AG0mz9oKiXDVkt1mjEYbrUeXcUPKmkEvsCMIaCLl1stbNM+QY7qU7s257N9pMaBEOzJjTCztiN5GpdYShkY7Z5II2v5ovHfVMN/FbTCxAPsS5EKmGlBVcQuO1n1/LYWNIuka7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7sZS/gL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7sZS/gL"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccf18ef922so8694876d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780575493; x=1781180293; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+C6Coq3Jhc6cSbggxUdrT2oSa1awQDKeBOGK4CRxhE=;
        b=e7sZS/gLSequsnV7ptkkbLe8ZjbFd0qbRgk6lcnIy/6Ro0uyc4DYMwgKk1S7EnSwXc
         gJGJYjnKsqaSx257FVvTRfvEQCRgr8XHCbSDcXMw52NORPAUd/Z8WAdP2EtC5OrQ0oCI
         TwefmzuxrfWgRbRLoJ4jhfb+qFOd8mLtWmLDqxN6BCT0haPWV3o/4TjQlT+lYP0//lqk
         r+uhNuoIZQ2k0wfX4AdiLwG4iRccCb0ylp/4ZtBqMzgbeoL1ptSovi2JfMWJcW8cELaN
         M1efzEUDzj/6EzkqjBywWfw0tUFaJNxlSjsV0KgwOiti8TKFiozxIBLbeR8cR35kR8i0
         BPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575493; x=1781180293;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+C6Coq3Jhc6cSbggxUdrT2oSa1awQDKeBOGK4CRxhE=;
        b=Einr8n70+TnekZJengEgrAvRcAp28ynORdlY7azz5qNxF1uI3qX+HipUsAjI8N5pOX
         YxHouiiZj23zShwEFhRzw+9j3Y5CGZpra2Fx9Vn/m5cwEeIbQl5u+/g3Ga//oXv1o6Fa
         OSHqkrFlwUVndROipmAYB7gtSmfg8X5WHvzdUplkRDbw0gNMoodfk3rC7pPee33X1V3f
         I+HcDQJk0+Mo/0NYRbGdC/lQtbcXB8vTAgz+kQVpYVynUYwaHQbghrWpF2DHINcFJo3+
         BZ8P/XzZdZkDjL38f3rD3FeszTzfdHkmp5F5gLxNlXNCNiJFO6i8TYnDFRnum70sYZzI
         Gflw==
X-Gm-Message-State: AOJu0YyLOEn49zKSvvypBweNcZMNfMqlOK00kVE1syKXMf+tJ+iTk6w1
	Wntgu8AAyzfAl3YCubkFAozes0hecQB0nbh0iOehmS4MGdOfREUd/8pabKrv4g==
X-Gm-Gg: Acq92OEY77hvMzqT+a4EOrf6nw6CJ9Z++Z8qhHuwxO1B72itmE0iiW8LYn6fVE6+KJO
	FYsbnGyvaUTORLD5J5nnKISGi6OrpM5W+R6vGjodSnnXZ0oLccOSZkzHriQsu8I9imOQGiOKwkU
	aPqL9uQe3vcTjMUP3++wpgaDQ9FwphK3dHxEWMD13329GJNYvoAwLCZXxIMtr3+R3L/m6o/Agk4
	xf1t0+ss0utE0cv+B7ecbbRFaVCqw3ndbx+vS8P0ItrOigoYoe4BBBTz0KnBjHP9+ZSif/FYksR
	i69HAS9AV9Ft+iseT3wRyS8vgkVGN7jAQO1Q0EBiW9jwk8Otr19wGlBdx155XyMG2C34gH79Fdm
	2ypxlQxtrkpzg+rmP1Fw7v48yz3ALFnDmJxhwnPIL44P94aPbdLpn1YrItkhRVqn5k39SF/u9cr
	Kjb2OmPNJW0yKVTspPyFDvdT0X6fb3KooDvc4V3hlsug==
X-Received: by 2002:a05:6214:3d0e:b0:8b6:1c72:3597 with SMTP id 6a1803df08f44-8cece0306bamr116771296d6.36.1780575493125;
        Thu, 04 Jun 2026 05:18:13 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcb3c5sm52670896d6.21.2026.06.04.05.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:18:12 -0700 (PDT)
Message-ID: <6a216d04.b63906d5.71d9c.e081@mx.google.com>
Date: Thu, 04 Jun 2026 05:18:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8272721770703309563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] build: Support libical 4.0
In-Reply-To: <20260604080139.1264222-1-hadess@hadess.net>
References: <20260604080139.1264222-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8272721770703309563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105842

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      598.14 seconds
MakeCheck                     PASS      18.48 seconds
MakeDistcheck                 PASS      232.81 seconds
CheckValgrind                 PASS      271.14 seconds
CheckSmatch                   PASS      321.22 seconds
bluezmakeextell               PASS      164.77 seconds
IncrementalBuild              PASS      603.55 seconds
ScanBuild                     PASS      906.29 seconds



https://github.com/bluez/bluez/pull/2177

---
Regards,
Linux Bluetooth


--===============8272721770703309563==--
