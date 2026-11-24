Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554160;
	b=wzEiVt4Q3viXfKWKMRLqBZlc8YGDp54iXM2SVo3h8sUO+0lRkbdp2HffRa2UZlzRbHFK
	 T9nJ129iqNt3FUGYxqvuK+Vv5dvoYCygtPMpAc4t3PJflZQAoCQECzSaql8DHKJ0of/Lr
	 BuKLlCfuvRcTr9eEvKHsaLFUDzVtJZB2XMHD6lQAUMIlLBQPmjdFARROERreTRMxSagpH
	 naPIKRiX7TpNnZ4Mj5wUa728QDYcAi7pWzGl2moMfS3J4eqUMH76WhQslsBT9GBSWv3Jv
	 zHEQzLx6oSbB/aUc1khLAHH8ORKmHrlaN7xdnVl/lrl93fZMz8dOWTUnktnA8yA3Mgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tOQ8deJlbue7zUWpKZuExHwAMW2w2G+6CLI1x62HiKw=;
	b=qf0eLG21ltT1SWDv7N9a03NaDpXyYeZvNCJ2MO60oqxBF+/B2kdpQQEkwAod9zqY4QUr
	 h2YEEQoExxO1QvEmwibwj6NgV+GuK3nZVX74rWRRD+V4dPrCbehEtifinC3YZ28HntDEF
	 yS/TMIe67t3QdKEeGqtUuZxkW9PkU/mY12rFBcP0HtgR7OiYgpQVB3LGtK8GeANmpXQq/
	 YKZeJxKB5vFTLnnD2aslHIKj4kcQaOjsCpOh4Awa0Cw4SbWSq0UCnVbFWnPZE21HqH4V0
	 zBJ8eTbSZkCQZovPYDf84EF2F8NbgnYqgD0+qrQW/SfB+x9D2XKSRhkayEDWgtp3ojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0fjZElg/";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E4606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fjZElg/
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3b4944a0eso3753891c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554160; x=1796158960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tOQ8deJlbue7zUWpKZuExHwAMW2w2G+6CLI1x62HiKw=;
        b=0fjZElg/h4LhASYMgzbdBqX36RIaZMrAsjAT00Y0UDzfiVyT1LtzkAYnG0JFGB5icg
         YFREqQ1jmWvmrLI9B5VBnP8yxuWM60b2yahFeAqdOxHR6TwQyIhf+ORHIZW1LmpGaTDL
         MkSkb/t40rDO/f6a5mVwkb0/g+3ER36W7jlRHgROMHpD1ZStym68wE0T8fX31/hK4QLd
         zekshOFgNYxY7p35EKoMgGUdl7w5DSdvDCjloos5Znf1/Fgz4IBuSLrkegE/jsgbTZ+6
         7yl4CSjqkqwEnS4r0rrOsQoe70re/uYzgplWZj2D2WYxIDr/dffHcEhOsHKRRVMhJpKe
         fUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554160; x=1796158960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tOQ8deJlbue7zUWpKZuExHwAMW2w2G+6CLI1x62HiKw=;
        b=I4ZtJBBQb3bsxW4AfETizjDajzT3/eSr3iNDPw9jerPaObPbPcTVqAdzaIFSYRyT9g
         SGZTI0mC2QTxmWObQJ9DlkVWcm1xKfbETttEOqlnw5zXeGBkKEqourEOhsclrJNe2pc1
         3hluCHh8foM8aRkM/4W9cAEAk7Wxr0BVzC66Bsni0OKrTpXs3h+NzdJle9YsXDjTV/dh
         k+a/UQVtppP2E3FVYmwzLcTp8w0BacwGuZW2uoiatRBd4F+OQqPH9o9zOlb/8c9dRMxv
         xtbbrgye+0E1L36q5AiuGJcx5GV6RP6UtLqjJOofxQwNryeF82ofXG4WeLwV1qML/a4x
         SCvQ==
X-Gm-Message-State: APuU4Z8ErlFrOfq4INSsr9h+odr64lNMsRF53CkVtbGsJE66GDGPbE9c
	31xBnbWV2ng/HTkFU8duv7m1LFvs2dZAPJjqrENYRdwCI8cLVACeRiVkJs9bFg==
X-Gm-Gg: AZFdTZccBforC8bNFF322sTI4+xk40wfrvMpeeXgd6vW+QrxljIsmdwii8KfVLqJGMV
	77AvMHR/ZlZZZi1bo2xS8Hs+S/x8sx8bqXtf7btP9M2iYiuyrtwuXofoupWGKRJ1uOCCsJLGMpU
	E9G4hBcvnpoIQdFzoO1nZ5fkZQynyXj+3MARSUGFrDD6FFL3SF5f7ti/lldUcYssxMUKKgel6d0
	WoPGKotkKK0wrDlY7RRHNLGLarpY/KC+mxkY6qLPw1m/PhuA2RIQsdT/gnxRjPmJSoevxQThAFO
	5jmDSv0whrRA/c7pr7+XxJi2YJsU9Vjw5Mxg4V8BdO7gL0B/JNVNnlgwX+Rqm81vWzSIMWVdAZ8
	ZJ/cr5Jb9IrJmjvNAJEVDBdhYobkI9lK1uVdXQHqiiXlxiC6GxCV/tbmYQa4kbvOo+N5sFWKleK
	TyjVT0NbCCD8f48gjEIywuTi3l5d7gVMDT0Aa5NXDG9PM1b6ETdB6zCanjfZ6yRgu6EdjbeZBoV
	9hyskQErdSqE64NNIcmWlCkA/0xfVfif72B5foLRLfnxMKlHfjh8Y8ezc5J3PM=
X-Received: by 2002:a05:701b:2804:b0:1b5:434d:b61b with SMTP id a92af1059eb24-1b5568cd633mr14704427c88.22.1795554159525;
        Tue, 24 Nov 2026 13:02:39 -0800 (PST)
Received: from [172.17.0.2] ([13.83.167.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm37104558c88.8.2026.11.24.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:02:38 -0800 (PST)
Message-ID: <6b05fb6e.45417901.4f93f.a144@mx.google.com>
Date: Tue, 24 Nov 2026 13:02:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6654062791793916486=="
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
Subject: RE: [BlueZ,1/4] doc/org.bluez.MediaTransport: Add Mute property
In-Reply-To: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
References: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6654062791793916486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220854/

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.87 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      318.79 seconds
MakeCheck                     PASS      14.72 seconds
MakeDistcheck                 PASS      148.94 seconds
CheckValgrind                 PASS      358.45 seconds
CheckSmatch                   PASS      319.44 seconds
bluezmakeextell               PASS      103.55 seconds
TestFunctional                PASS      1184.52 seconds
IncrementalBuild              PASS      346.05 seconds
ScanBuild                     PASS      1191.79 seconds



https://github.com/bluez/bluez/pull/2900

---
Regards,
Linux Bluetooth


--===============6654062791793916486==--
