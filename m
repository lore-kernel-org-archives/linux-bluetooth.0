Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9522313
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq3kyn11"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9218D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 09:04:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77a277eb084so311393985a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 09:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699895047; x=1700499847; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PV5+RlZzquXYCrUTkFUZiABfEItMTviKjvKEsDX37+s=;
        b=nq3kyn11fMos1QdSY0LE3a7BISUwnEDiKO+t6wvNB/eIYRDwb7sRHmvIuOtkZw2KYR
         IWDnN9GpbW9N7Nj8Z1hg7SsBAslzMjcWD6AO7+k84lnuBQDWNU7qzfktFP6BDA8OF+7e
         qpUJJJ+PfNAdRtjWEIoYr15dO+O42UHQiB53PIp/l6OqhCyNAJUgYiOJmnhZT31hVufl
         Z+LTyeHcNvkx+wkOtE0qI0S2g5ktbKf+HoNe5j5PaejiLLOM37pl9uVKYggLLtThYkxi
         Fk7mdJ1IDxlhvMFHJEutRAEUt4i5itMJlHHZFCsnrM90WxTaxecdpOWYSFK6Bs2yfYlw
         E7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699895047; x=1700499847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PV5+RlZzquXYCrUTkFUZiABfEItMTviKjvKEsDX37+s=;
        b=AVYmQLLmrZaOM+bd4NcyilsCrHcAQphv8UrpnXUc7KfVb+tHhj+MnNGDQTFddPWhzs
         M+exGm3hWCj7xpUznstpDuB2VhQq9WKJTMH9xjL4wSc3B20HZ222GbCgKqJ7LfjSwjoV
         LZ6zwySn/jYduB/rnufxb19BxWYWIrkLp/+yNrayW3zaQtK9ogXMuShLHdhZbmHq2LV1
         nIPIQepAvwF3ZGrCILtVNInUuQ0RsUEOQj3lk8Bp9fYWmpzgxZulYtjZlrFxGFokEFs7
         Q5dKYdrn9vDcFzEAgFNzAK9WRIl2H8a59112nTv2xHOguW+OCUZZDQGgLX+kIR1qrImy
         k5VA==
X-Gm-Message-State: AOJu0YyXokcOEMz59oAQ+IYpqmodHB9qUnpu0+JEpYDZ2PVF22hbQOo8
	EaC9PpfSxdlRLrRGqIsFEqgtnlaE73SSkw==
X-Google-Smtp-Source: AGHT+IEnxpHnYddjL0xPfj9WtqZGbPHINyIA7My/wP/+XdNGG7x299B3etXC22dOQNiBeWu1dQfAjg==
X-Received: by 2002:a05:6214:110e:b0:657:a0cc:635c with SMTP id e14-20020a056214110e00b00657a0cc635cmr6657360qvs.22.1699895046816;
        Mon, 13 Nov 2023 09:04:06 -0800 (PST)
Received: from [172.17.0.2] ([172.183.107.240])
        by smtp.gmail.com with ESMTPSA id tp15-20020a05620a3c8f00b007743446efd1sm2027650qkn.35.2023.11.13.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:04:06 -0800 (PST)
Message-ID: <65525706.050a0220.12ea1.5cdd@mx.google.com>
Date: Mon, 13 Nov 2023 09:04:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3962136982237133062=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast AC 13 reconnect
In-Reply-To: <20231113153942.3875-2-iulia.tanasescu@nxp.com>
References: <20231113153942.3875-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3962136982237133062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800701

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      23.98 seconds
BluezMake                     PASS      560.84 seconds
MakeCheck                     PASS      10.55 seconds
MakeDistcheck                 PASS      149.57 seconds
CheckValgrind                 PASS      210.28 seconds
CheckSmatch                   PASS      314.14 seconds
bluezmakeextell               PASS      95.84 seconds
IncrementalBuild              PASS      507.65 seconds
ScanBuild                     PASS      898.84 seconds



---
Regards,
Linux Bluetooth


--===============3962136982237133062==--
