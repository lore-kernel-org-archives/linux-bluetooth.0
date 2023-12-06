Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmX44CpV"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83DD5A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 14:29:34 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso331109276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701901774; x=1702506574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hGZuaSFXqxeco+wIs1bjt8zYIrryIM+DmGyUD/2PB5E=;
        b=jmX44CpVie7Jr5Rd2HBlkU8x/T/Q0cf/C6QoQOtqdNta+L8o8zj1h7KuGO3fyLVdNW
         XwofdAJu7luB/Q7K0FQRkPvuyLSrzxeVDzUzdTfKg7tm4+MD+5SGuvL42fCEhNX2IxCM
         GgalFaDWv6q783Jo3SKZeBzPH2N3rDf+/6ujaN+eBk9nhKDDX7BCnCqlCEmLofOCIqU8
         4rB4pc7MGB/iFZLjLH1aKgtZg/9j8NC5B4jiBtF8rYJnKjXeRYHMyorc7lRl34CIl7Cf
         HTtXj7RjuC68siSYfOnkhbtTScER0luYbprb3TT6VYw1YxHYACP2m8zTvwWChCtJ3zio
         6mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901774; x=1702506574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGZuaSFXqxeco+wIs1bjt8zYIrryIM+DmGyUD/2PB5E=;
        b=emOM77GxpfZzDzPLwrYCbLUwQRZ9pjrXjBWIVLJUiOunRorXz+Lmrujw8+mC2WghIl
         /uMnbi+rHb575VcQrRsSbQ0EU2iOIAcwIKUCtKojM7EHeZy95LylLnIKvh71pmcgUc/Y
         3aU0WpM65/s3Fhww4et56prgEJd8u7KEKsxWDnQY2RQH8gKrQwCH/xEGziyUZjW3rNi2
         x3DBrbtc5Zy1vsocNWxp+2yFMbSX7ryWZRdXHTIifLq9ey0h/c4v2NLO57D4sX6F5kDI
         2zpjvT3pSHI6CRZVTHoSFEVhQ3Hx5pXNK50Rb6FXBr0ejpkcbiESKT7Nmj0eUIjf1S/i
         SPOw==
X-Gm-Message-State: AOJu0YwM+M+F4O/Oq9VYmtpZegat0owJi9FWJgwiBtdvL6JYMqPDQyr0
	0fLdqhtA2T5ERg6j4QQ42ZuNO+PEuc6NpA==
X-Google-Smtp-Source: AGHT+IHqcf1kxq8/YXbEbcs14CgY6/rL+3nnfxZjHF2LNXPwdOeNkipyhqPa1euKGdVGFfX1KvKrjw==
X-Received: by 2002:a5b:c12:0:b0:db7:dad0:76b3 with SMTP id f18-20020a5b0c12000000b00db7dad076b3mr1429558ybq.79.1701901773926;
        Wed, 06 Dec 2023 14:29:33 -0800 (PST)
Received: from [172.17.0.2] ([172.183.50.148])
        by smtp.gmail.com with ESMTPSA id px10-20020a056214050a00b0067aa351b0a3sm317023qvb.65.2023.12.06.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:29:33 -0800 (PST)
Message-ID: <6570f5cd.050a0220.d455.2a0d@mx.google.com>
Date: Wed, 06 Dec 2023 14:29:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2833301060523053497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastian.david.forslund@gmail.com
Subject: RE: [BlueZ,v2] Pattern match on service- and manufacturer data
In-Reply-To: <20231206212457.275-1-sebastif@axis.com>
References: <20231206212457.275-1-sebastif@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2833301060523053497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807617

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      724.73 seconds
MakeCheck                     PASS      11.37 seconds
MakeDistcheck                 PASS      154.90 seconds
CheckValgrind                 PASS      216.52 seconds
CheckSmatch                   PASS      318.39 seconds
bluezmakeextell               PASS      100.97 seconds
IncrementalBuild              PASS      671.31 seconds
ScanBuild                     PASS      915.60 seconds



---
Regards,
Linux Bluetooth


--===============2833301060523053497==--
