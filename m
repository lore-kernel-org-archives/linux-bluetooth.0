Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CB32C64
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Nov 2023 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mul6H2l0"
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11F98
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Nov 2023 09:28:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2f2b9a176so4427996b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Nov 2023 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464492; x=1700069292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+ITWUlymgTq++TmmY0+SuYLekO6sODq83wtuq/RQ3pM=;
        b=Mul6H2l00LFOO2mF0c3/WfsNeFn/jAVs4+3DJvNb8yUkPTJOAK/LiRgXK0CZtLQjcf
         WiNiHF1BGAmeyvLfRluq9rNEhmsfzqTtG4OVpbH8Yz5fL/wMU/4JY8TltDBf5gCk68mZ
         RClfaG2ckoCnzOsrhPU6U21wRnI5o3ob1CKquHi/cx16gLmsy30RCjlcMYnMeJAa4WrB
         uxv1J5KFVTzCXfpQ3A4174dksTMeAR+3u4jTz4bZ+Cl/jv3mPVH7KqW0/ubKKYRB2CeQ
         Xn0YbElZ0fpJhNgno9h3pcLQqJdQ88HZ8U3eDUHjESJTHzyADynO8QePqYzEKewyrGbK
         XLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464492; x=1700069292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ITWUlymgTq++TmmY0+SuYLekO6sODq83wtuq/RQ3pM=;
        b=NwV0wlyeUCfRFoheMTRJb1DoVbc7bQiNPk7pqAfOS9lguS7XC6GdaayOfdz5pXVk9r
         h9TyDS+T84RKfRHfRW29AZFDm0e1MBmlqvPKxICU5yxQMlXIp6O7hLsyHzX2KLPM07sW
         5dy8ePioK0KenvzWcSYXRbieSy0smvj3bdnP0nk/JtXy8zkTcdSIcpC9vnd+BDBOaS3D
         G36r1LXDSWMTWBWpJUemzv2LveCtBoVQxKWetdkmtXGFgFzm4hB62TjeHLBEyMhHJGfT
         7Fr4030z6I1MaDa0yvsdpE/ObdtWuLUh1e5oPXUeQJ3D1V9ti8Cem7Q+V3PtvnY2m46R
         jmSg==
X-Gm-Message-State: AOJu0YxtJYP7NBPFnudMVJeNdh/CKyNYBVv0bKja+QGctW38CP2V6yne
	aXKDySeMjE+xBpab43Hul4Rw59FqpNaRmA==
X-Google-Smtp-Source: AGHT+IEEfPuoY0D2dEob7HFHQSH7L83EhKO37IxCp9wXyTXH7pzVTjfIVESoE0i1Kxe77+lcmQCEbw==
X-Received: by 2002:a05:6808:5d0:b0:3a8:5133:482d with SMTP id d16-20020a05680805d000b003a85133482dmr2460702oij.35.1699464492366;
        Wed, 08 Nov 2023 09:28:12 -0800 (PST)
Received: from [172.17.0.2] ([74.249.5.225])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b0077a029b7bf1sm1264911qko.28.2023.11.08.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:28:11 -0800 (PST)
Message-ID: <654bc52b.050a0220.09fe.6e7d@mx.google.com>
Date: Wed, 08 Nov 2023 09:28:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3859184312196834536=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: [BlueZ] client: Invalidate scan filter on "scan" command
In-Reply-To: <20231108161949.11276-1-verdre@v0yd.nl>
References: <20231108161949.11276-1-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3859184312196834536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=799718

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.31 seconds
BluezMake                     PASS      562.65 seconds
MakeCheck                     PASS      10.60 seconds
MakeDistcheck                 PASS      149.28 seconds
CheckValgrind                 PASS      208.63 seconds
CheckSmatch                   PASS      312.79 seconds
bluezmakeextell               PASS      95.60 seconds
IncrementalBuild              PASS      509.70 seconds
ScanBuild                     PASS      922.37 seconds



---
Regards,
Linux Bluetooth


--===============3859184312196834536==--
