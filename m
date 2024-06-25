Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021353370
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312930; cv=none; b=TX0udldDqAkSqxYbpbcMM0J5NiD2QUHk0HkLxH5tgEIh/xfGcBjNApciAENLXK1zMjFN72TCgdtdEKDuiM5jzQpj98Kf9aM+0OsmyKdy2/t8DsBN0gXkzzN7A7UeUrmKF+OHsPDR5TAGOh+7/AugGV/ndPeb5U/kzOuIddMmG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312930; c=relaxed/simple;
	bh=/45zuP30P4maE0YtlOxcJIVP14kUAlxU57rmLe3xlzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lZxe1dL1mCU65Z6vedSAINUcCiYNn+fw56+TJ3RQFU5FENtnfH8dN2j1yVOUHAfNX5+xklstaC5LGCZlO3MLSZaAxES5+dULRGPEMoPuemEHqlH7FSRWT4NXvQsrY3GmYwXZqtf4NcBA5LDsYZM29yM3mt3mm6w6EdxE6RXdL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6lUcM01; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6lUcM01"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44051a92f37so40911601cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719312928; x=1719917728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LIM6RkmYFZeVD/yTGymJvBoLuz3qMcBXxFUyoFBaewQ=;
        b=P6lUcM01c+afCKPILttjjcmqkJDdsQrlf+QNVtht10TbRhCaQgsoLXNxNZ35dAlILI
         XdAXMEOd4agxBTcfrKMfzAyVHZ656Pbp0MnGRTrjBsRnQ0QCY8j8r01vpqZ3nHce//R9
         47eT3LZzO9sCuZ6RlFRg7cTFg6bJ3HwkQwb4fKdquGmIkcsG9kVj6huZVn42t3hXV4Rw
         r0BREX1d1j5SHRV2hkMiak2FB8FCnN/N8Zer6yLosh4J0YHQFDBEdkrXY9iPiD3b/mqd
         U9sFLH7g5ZkB+SqpbvRIh7thUFA22sLtiE618KTdU///nh+ppeGrSlMIo1qYTe/JPXpT
         1nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719312928; x=1719917728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIM6RkmYFZeVD/yTGymJvBoLuz3qMcBXxFUyoFBaewQ=;
        b=AaEn2NZgAGLLfaA7OmTKtF+gzewEg/xHEGChcl/AJOa5c2+1AQRr5V/dNF3+2B28Om
         WdqNPo83kuRLvi+StYxDvOtg72CQo4R2DXacLO9GXMyZ4dtm0I86l8tke2yJ1A0zeokX
         zzxT5Qql+yUws1rOsaoWkWRgAje+0BENdFSDbrPW1clkoyVdpsbMqKZD/3jVBc6TKhZT
         lOM+3gdC/EPv9uDHMxBMMBAXCCbf/switGTVdlyYP1ywfqP21dnyhsYNQujwacnfGDBO
         j1UtfEBWrtC9DFGycF0ldlcPEy9ABR3MftJ+l/sQLjW2/fgL2EC2Uf54mbQsaNJVqhnc
         D/sA==
X-Gm-Message-State: AOJu0YxUUHtkywD2gVwvlce7UB//YH6AiVmDig2l+lnwI/C9spe8SI56
	x8zfa4P6AxXJ1Ls/w084gMqG6XXcbeWeYm1KVESeijqW0QyvczqjN9toeA==
X-Google-Smtp-Source: AGHT+IFubn8Dc1JrwzHc0OcWnQqkPDUm2MbaFN5UZgxc1HkU4rapMGABUpa/LpUy87NivwO6LLqSzA==
X-Received: by 2002:ac8:5a83:0:b0:440:5f3e:5a33 with SMTP id d75a77b69052e-444eec9de3emr52123311cf.7.1719312927704;
        Tue, 25 Jun 2024 03:55:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.50.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b4351esm53749361cf.17.2024.06.25.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:55:27 -0700 (PDT)
Message-ID: <667aa21f.050a0220.ff16b.0c84@mx.google.com>
Date: Tue, 25 Jun 2024 03:55:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7932118140228121581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Source STR MBIS tests
In-Reply-To: <20240625072711.7011-2-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7932118140228121581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=865195

---Test result---

Test Summary:
CheckPatch                    PASS      2.35 seconds
GitLint                       PASS      1.44 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      1767.92 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      181.14 seconds
CheckValgrind                 PASS      259.12 seconds
CheckSmatch                   PASS      359.95 seconds
bluezmakeextell               PASS      121.59 seconds
IncrementalBuild              PASS      8109.81 seconds
ScanBuild                     PASS      1024.99 seconds



---
Regards,
Linux Bluetooth


--===============7932118140228121581==--
