Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503780;
	b=mUf/0R8cnd6Rsn/EDQUBiNWbJE0UoYJSdTr6K0oo/qwV72leIlO45ln66r6Qx1Q/9zzD
	 NzW4eyqffydDAcbOumj+41DSaCU4/qBrX8kBX5m1JjtenFmVzTzQWEFhbnvJj7Qp6/6zg
	 qmYfHJOCaZnA2GharbKLhcyis4476oZ4s1I6JcQbf5fs6vMsf8B7G78ZGpJECVKGJQWr0
	 UAnkiDAJD7nbyWwXy3/TH9GxU6pdkQlDfTTOqv+/pI/TnsCNbZBKouROZradVkaY4F/Qi
	 /rKlcSab+BZL7RnIzFnnsCQBoWSqoZBSDgPDbsR6hpo6l/oViDY+G74SnZKIjnf/EzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rJEZVm0MeI/BZALyAsd4GkxupHm6Nmerf42u77RXHCU=;
	b=Pif7VBB+lJ074SME4ENu+5QyX28gYZjctxcZfvjtxyNA8DhEaM98GD3oTufQjJS/Y0W0
	 S7LeP03T+ZMifs5fYc8RZyTBMpcoEiKgVEw3Pdps7Eousbhza37rY7yNlvdP0Aq+yX1u4
	 LuVCTjNLHxnX7CcV2yvWFaybr79zOl9or4he2hhWuBjGyElF8DtEUSAY7zqNRgfjPNZdL
	 cDbN+CkQFmVmCEbeYrYT4td9iNZq4rm6qYqSaasLu/N69jmJGhuFfExiNTnOllcLcZVI3
	 FKMsI1kwpP6r6DpAkn5m3HnxDykLp0xamkhl/1Ky+3d7e/9aCwCCZErFaFNANKUS4+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awHmgryl;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77692606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77692606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awHmgryl
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-703be215729so1793459eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503779; x=1796108579; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rJEZVm0MeI/BZALyAsd4GkxupHm6Nmerf42u77RXHCU=;
        b=awHmgrylbj0TtDydsE30vHymAuxZewGgRtFNOaAYis82qhcly490k3CNZu2T5BtJc4
         doD/TEewfmDFi6ZX45BbQaVdU4E08XvMzvhwbQEkR3d8U/e6KBKoidVgEwW7p+C2oACK
         IFeWW6tB39PjjdYiYKnfVMnf4OnzoeTmikJthiZXCd5FrY4U10LlXY184IkTcQGP7U+M
         ykjZ8iNX5Dkz49GSECREMIhC4BGdzV22JFrhW69TuxqotH1HjRLWqY8eXpw1efELfu3w
         mfPo0hVOZPeaTKF7UATnlu4R1P2X1YK4oxFwDY/mqOapcegvSPNmFAbYS0/hTisCwkWd
         RxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503779; x=1796108579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rJEZVm0MeI/BZALyAsd4GkxupHm6Nmerf42u77RXHCU=;
        b=plWeDK/U2EV9I0/W658RQrV365Tpi2V+95Wn4SaZcvYSI/TAo0P/nFiNQm+c9NruEU
         OqBp9pySy3VUVsftFWpwBbwAV9MPUqGP8axzZCfYqvI0d9caAr4p0k/GRzBAkeDo+ju6
         WZtaFkREUrQnkuSHRgKmigx7/PGToS4rWxU/DqObFDyc/38gpzEDoI8+1wNODkP1htnr
         GJNCGjizuc98HtbfZxaQW5pr6OL6St794bKjJg3fIrWqpp+i1M8JtcHQKZXvUBk5HHzv
         bixrzepbnemREhJgeBvPnxyIx8y7D53zze9rtl4yoyDjZReY5KaL2enu1VIi2CZv45Eu
         oYTw==
X-Gm-Message-State: APuU4Z/CsLzofmJ1x/uevfaZYP+Xovc8OVJkgVG2woRKQmfW0e2iBXui
	lscxvoVC7OSizLgmOXccrcQMR7Fim8yBCLaTh9GsRs/W6jiOZiBir7A6M+dDTw==
X-Gm-Gg: AZFdTZdX/x1RlLR5wA7JtzWeQ1EEpQ4kY6dW5XOiwAabgxIKsNMjTVv1FDzuSt8gFgg
	jL3DnChhNYpX2lrFBCzqS6hoZBRAbSPhJmbKRzlKlAkScxkU+pVmNd7FdlxE2Sv+3wSXsmVR4Cn
	qPzct9Dx2HIkXF9zxmjPLhTipTfYhJ3F34/p30AZI+kjHcUtLqL0N2SFRj4A+NCEBAMHNqnqIQD
	wV81lRYdg5Zm1hUFny5O/IaM2jgZzRiAu5B5aa1CR58nAQcDOPH4rsMnU0G4Oo/5aLhtjde5xG0
	gysJmWobJUwiGblW4m0PVAg+HPhnl0tvh+Hk+beXNUWFkGtH/5lFrNkKGbPmbUQcxFTvA1doMCC
	IBA1SxsY6F2Op3NOh/lnC5Hq3ZpQRYLZwy8w+1rvq7RRVYhg8p6e1+d2uNlNIkGJ+utNQvlxZ3i
	Ngz7Tyxxkzitol9t04nllSldlFgBCW+mCb5x/CZY5SfBJQlIM2AuF10/2vwZ+Z28mDA1kZdAqYy
	aEPfaayp8IgY0qUlnw2DRxOCvRnxXPRDZnpyjFbrsGZHEQp2cc7x30GNCO9MAY=
X-Received: by 2002:a05:6820:f016:b0:70e:1dd8:6713 with SMTP id 006d021491bc7-71b39568e7cmr11331191eaf.71.1795503779357;
        Mon, 23 Nov 2026 23:02:59 -0800 (PST)
Received: from [172.17.0.2] ([52.176.32.167])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380c6815sm8705669eaf.12.2026.11.23.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:02:58 -0800 (PST)
Message-ID: <6b0536a2.73c0e6fc.d91ae.34d5@mx.google.com>
Date: Mon, 23 Nov 2026 23:02:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7743867772643270232=="
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
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: Do not set BROKEN_ENHANCED_SETUP_SYNC_CONN for newer MediaTek chips
In-Reply-To: <20261124022318.663787-2-chris.lu@mediatek.com>
References: <20261124022318.663787-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7743867772643270232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220275/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.15 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      28.76 seconds
BuildKernel32                 PASS      23.56 seconds
CheckKernelLLVM               PASS      23.76 seconds
TestRunnerSetup               PASS      560.25 seconds
IncrementalBuild              PASS      22.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Do not set BROKEN_ENHANCED_SETUP_SYNC_CONN for newer MediaTek chips

1: T1 Title exceeds max length (85>80): "Bluetooth: btusb: Do not set BROKEN_ENHANCED_SETUP_SYNC_CONN for newer MediaTek chips"


https://github.com/bluez/bluetooth-next/pull/1209

---
Regards,
Linux Bluetooth


--===============7743867772643270232==--
