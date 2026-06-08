Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63343AA51F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956958; cv=none; b=dt0oQTiy2xTTwVFHVdtfhxpTOu3YLQg8Y6CUsl0qdeIIcKEVhezi9pIfQucuDhEF0+hP2kucEWHuv2anTIN1s0jNMpP16tJru2eeUgX3G7SJYL3WA9TNJovSgbV2MEcvlBZjtaUwTK+PqYDjqH4Xc4EuZ0xL4hOsVXi0akuZQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956958; c=relaxed/simple;
	bh=PrFMZldHCPg+FAVMfy2MGixAyx8j63RWqtF8ANo7RvU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f+qSihm6pZAUNYDxWYmFX24Me5SyeunyhcKnOih7lTt2HB13h3/JMmVY+aLGEBeS1LXVX27EFKYll0a7JnUvhRJPiHwQ0JSiCPRtz8eZqYhJjZdFo+8m4QUyrev/bN3OM2IMCxMuQH09ExsM0VFOaSQe2zbizPUvswpr8agMilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJKIp3La; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJKIp3La"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9156ceb55ffso422341285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956957; x=1781561757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJCNAHOtPr+4Uy6wB7VVfUC361Sfu1fSrvNlkQrTE74=;
        b=tJKIp3Lazi0QeMnGuUs2tcXuv/qki6UwH5nX+Vhnlim4VUFwwa1nObwvcFKLmuTSBL
         1PxcgCnQIOisjHUMKhDBLiFrAUeM4X7k+h/YlsdAQ1qlhykKFfW2II08/v32ymXqw8jE
         6DLVcaoWx2TFNNIRv0heIa8DSXfc9OO3KY/GVVUHe/OTYBocyiRpPwedNtpeEO7v0ChE
         sLaXFWjwYQRLj5WGl0Ggauh54mHiAnq4pLpN/FQRX39lnEZnPtH/ACJcz1uphLM798nw
         yYKsDrp0uk11ER3JSEMUrbNj7TJCy7ptv0OPh59/1FjYfWd7Xxea4cc0ZdnvMztdGUMR
         cgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956957; x=1781561757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJCNAHOtPr+4Uy6wB7VVfUC361Sfu1fSrvNlkQrTE74=;
        b=YjvPzMWlWZwVfcJxI+FljPPYqSmfiSsLEL8pTz9+PMbAjcQ8ffmRlICK5dKmb86CCj
         2AtbdmAmHL0XE0wb2Dv9jvOzM+cYEHqkYvOkUdIsFtB1LDEa/D9tty57TqyQ+bZACOC6
         UgpEZIZioK2u+rG6X0Ux/t9BhC7g/Nwa6Tk7KfD4gIkobbZaDcGk4KTh+Twgh3fJSg2k
         CcTWMNKVQYT39u/Ii8gmAXRFyzqGPT46SLnSOD+UaqiS18ther4OKA60ojI1skRcynD4
         wWauisICqLET+ToBmadL7bNowbLSqTIaZ0FXOoJk0uhyDhQK7y6HwLgqHZ+qKSZcloC+
         fNkQ==
X-Gm-Message-State: AOJu0Yw2sKdonJFzbYqwRs3Q5eqcHsduPTBjtP4JSMke3eEk5ACYZEsK
	PenPvt5Oov31YkicgednuI639CsT1Bkq+X569ZfBNLJdBJUAjXZSPzVjrWTLRQ==
X-Gm-Gg: Acq92OHTlz1fjn7qmY+ye31nNNupJxdM9DBNT+et5yyO6ob44jy4E9fOCPd0TfOdNdM
	vsFqdMsaq0q1pvc8mgr3vwuMvJFI/LouGSc6EgIj7hLkB5/f0ya1ZINNV55e+op6NKfxCYCnfNA
	cX4/jguKz13mykJu0TRBqje7BK4pGCr0itpad6huND+L8ARys/MeB0Oj+KiKDPYj7AP8qDLYJyF
	mlfwcg4Y5k+BqOOd/sX8kG81Eaf5tW31p1SDpd+PmDHLBzV/cZJFGYy8KQmWzSNWAa8lgcIFNFY
	szLG8dd+NDYICrJ3XybbpM2uvsh6coMd4omLgRdf0W/eBimeZWMD6GOLrUvZHH+10O7S5zH4mkg
	dJQEkH/VADcVAuImDcmK9HSmsOEst+9xGkXdP8TVD6nCeAMDBYDBt1Sjmxmt+MC/sj1lce/gY8a
	tmh1B7DZuYDDAtWui3BfXz7En5DvPlDKwnE9qyOzk=
X-Received: by 2002:a05:620a:bcb:b0:915:9a18:bc1f with SMTP id af79cd13be357-915a9db8013mr2724357885a.41.1780956956589;
        Mon, 08 Jun 2026 15:15:56 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e35dbsm1886976785a.42.2026.06.08.15.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:15:55 -0700 (PDT)
Message-ID: <6a273f1b.d5c1a6d7.14e272.4328@mx.google.com>
Date: Mon, 08 Jun 2026 15:15:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4632538683045676389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/hci: Avoid redundant BPF filter updates on duplicate events
In-Reply-To: <20260608205009.97585-1-luiz.dentz@gmail.com>
References: <20260608205009.97585-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4632538683045676389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108111

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
GitLint                       FAIL      0.67 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      632.10 seconds
CheckSmatch                   PASS      331.99 seconds
bluezmakeextell               PASS      166.70 seconds
IncrementalBuild              PASS      640.51 seconds
ScanBuild                     PASS      948.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] shared/hci: Avoid redundant BPF filter updates on duplicate events

1: T1 Title exceeds max length (81>80): "[BlueZ,v1,1/2] shared/hci: Avoid redundant BPF filter updates on duplicate events"


https://github.com/bluez/bluez/pull/2197

---
Regards,
Linux Bluetooth


--===============4632538683045676389==--
