Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A10130E52
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544831; cv=none; b=j61l5B/oa8UaJxtksGt7/uRMmusa77YxmcfYE7XGlfaXl3g5qJyP5UKf459H1z7/DmwVywDYg/sXZbnV/rF1YvzBHlBwZYSu+z2kz4zCikbd2eVQ6VMp8ChJmHe5vRrLOH7CjrarQhbOfI9MkU7/vJW5Z7gNznLr9a7FpGAn9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544831; c=relaxed/simple;
	bh=AaPJWJC6bowIzZS0NN1msORW1Pb5ZuzDlcvmTR2PMys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rF38HSq3DTckgjA5P+CwxN5vB7were4+vx0su0Y8gNwI3Sp/omSEhQeJccmqiNDIh7bQv2kV2lPKoE8vMcPv4xPnC59fOD/OpPO1mcMwHamFoCYGB4tyF9abBV9NvpCIkrMkwMETOyWlyFUG3JMGSxAXdEwfOvcjvFkHurVZdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7xckIq+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7xckIq+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b10ead8f5so11550436d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713544829; x=1714149629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GBQIsHhc9BVyGURrbDaBHc/YmcgYT1YDYEJaxZ6hOao=;
        b=e7xckIq+TBroZ8Qaq03bwtWC2qZ/dYkYGFqpQYlXzLMCLaxio0od19LacEBKviznha
         g7SN0TnglXAmcl/tu730leI1KIhBTIrFPT086TstP2IO8ssPkGmfrBCRfD/mWCQCYMfp
         i5H9GduogvbMKepM/rAdf1UAuEEy3JCjSm4Yoa43SVXnyXeh/yySjBEStse7o3JtMxyM
         zBIn+xkllCuBaAHPQQ8aLq9ZoodxKgTQnFNDd5W7DZFzcNc+HxxwE7PQF7RUKpLbnfxe
         LCD0mr23bIIVSv1R/xglLiatcTw4bjYrMmOI5Ogns4WWCCb1V+HGRpkRdb9oEfFR5cR+
         oumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544829; x=1714149629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBQIsHhc9BVyGURrbDaBHc/YmcgYT1YDYEJaxZ6hOao=;
        b=ZPahidxg3ZPgXIZWPiGUWhyEa0IKDN5lNwkUCg47LeUVA1DyOjra4/l/NujCgOSomX
         gbDBJGwlqx++GGDvEyjUXYmgYgmYZV40cXdTPWA0abj2yk2y+k/JKwQB4fN+b2lPny6H
         7FLm7cRhlvFx3eDomQDgoF4rZl/44RFO4z7vgAZYuJFg/9xxtd2R/Zhqbz/S4fMoA4iY
         eAMvATEu9i/9++iEQFeaZ5FrCekLhWxt8mUPRx3MCf6oTOs+UQbu81ffEioS9YODOQDu
         8EZzm6z/Rryh9S+d24HOVk5j9crCadK2uIv7XmwNSoHnpPr8GOSpgGGjnKUEOlUnqAgT
         DDbg==
X-Gm-Message-State: AOJu0Yyaj2zFNvtvA4u6Rl+lV9O129jJaRh/Inoc0enO6kyAsLDCDFnG
	hbqrHyx16cPDkGfET5htMqQM/bNjx6sIbtSfhT9PnOP8lEHcPzVMZzmfKA==
X-Google-Smtp-Source: AGHT+IHbvkNbsDA8a0RRV/3v1mt30mzBVFef4eEqIZcJBE1zAyHGPfgTPHcNYlXmw4TyPDWBiuJCYw==
X-Received: by 2002:a0c:c210:0:b0:6a0:605b:4d49 with SMTP id l16-20020a0cc210000000b006a0605b4d49mr2846641qvh.37.1713544829183;
        Fri, 19 Apr 2024 09:40:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.210])
        by smtp.gmail.com with ESMTPSA id y8-20020a0cf148000000b0069f50e7ff97sm1670732qvl.66.2024.04.19.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:40:29 -0700 (PDT)
Message-ID: <66229e7d.0c0a0220.31bc6.8617@mx.google.com>
Date: Fri, 19 Apr 2024 09:40:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1671874206315582865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Fix transport.send command's transfer of packets
In-Reply-To: <20240419145805.46263-2-vlad.pruteanu@nxp.com>
References: <20240419145805.46263-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1671874206315582865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846161

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      24.53 seconds
BluezMake                     PASS      1712.85 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      176.46 seconds
CheckValgrind                 PASS      250.02 seconds
CheckSmatch                   PASS      353.84 seconds
bluezmakeextell               PASS      118.77 seconds
IncrementalBuild              PASS      1478.60 seconds
ScanBuild                     WARNING   1002.10 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
client/player.c:4985:5: warning: Value stored to 'offset' is never read
                                offset = lseek(fd, -transport->mtu[1],
                                ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1671874206315582865==--
