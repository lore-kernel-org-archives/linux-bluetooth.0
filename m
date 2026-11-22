Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373700;
	b=DO9geyk60uF4be79qyElUcHV3mcmCzQ8SMRSqsk7vTyreG1JZVEgWZAydTApMhV3GO8w
	 +aze5ObkN4CfZGDTp0ZHRC59ZjRSjr3ljV66Z/t3P+j6vQ/RntiV1SAFvHHzG+KE9aTkk
	 ajyRMe2bNgqKakS3EvJN6uWFDQoMauPRiS2meImSeiRt1fH++EYnCO04xhDVcsSiIpcW9
	 i0m19crIjMPA3oRkfre4alZiB3UFBOVKvE3uBBNj2T9vCwV8pkKvpUpfTqDWiz6hFTntk
	 LQNOJ6qanfIPm/X63r59xRMTw8mPlwHwTJVWI5dUvMTi6x18iOddn/jNnc9bxhtupsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Sxx+I9ZNKzqmnKhw+CIcYNdw3wbTfhMk0LPaOQn5OtU=;
	b=zAp6DGq4FzVPQ6BTfedqM/Raqqb/x+CEdz3DYOYutywqDzg7dWeGYWdDNbkwjEp4mQMh
	 g+Fmrc60xJ7zXNgkjn/cF/cwoQDOO7pkRwubas0lrYFBd2cKshtupbBeL3BPvgamK1ZJO
	 Q6VYSvlRBFmxjc2WBXBcGdj6QwHLqKBE4GzkqWLlIep3OM3aX+9LiArstdjI+9355+0xA
	 md4FFaxIRnkYc9mn5UDCKGv1+f0T88hSfIySXTjqJPynWLgIG0TQQoyNatFCmbf8i4sOK
	 qtsGsufYICxyvoAF9+Mwq26GDrFh8g7fcpcfWhrPzvge/Gbhvx9imqGXGWKnH4qVLDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UDucvQ/x";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A727606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A727606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDucvQ/x
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386ab9ab619so859735eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373699; x=1795978499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sxx+I9ZNKzqmnKhw+CIcYNdw3wbTfhMk0LPaOQn5OtU=;
        b=UDucvQ/xXHiuYUxeVLzdUM9G0FgNZmF4Cz1zYAeZFAztwvUA2gHzShcZFleZImCGEh
         w9jJIqG4YAJA69Vhs9qojTjU/Fd+2Dil07sIYTSUbMepZ6lcnyPoulGcRZgt5tkQJFaO
         0yzoY2XchJNJD3rr714Lmg5aQ2EMGk6WESmex/ttClpJ4/sUO8sZlvnggSncRk7tWvB5
         WcPWt4jU+9yQYy/accR6r2Gu//affe766ksuaW01kmD96pCRc8qXOnKBUVs6n6DIPayv
         NXnv4Li88hTgDZqO1+eBFQ5OFScpKxm14uBuRDSpomhIdMZdnGtsD9Ez6fGolDxKwmba
         6U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373699; x=1795978499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sxx+I9ZNKzqmnKhw+CIcYNdw3wbTfhMk0LPaOQn5OtU=;
        b=rKl+iQbywuMAE4wZskc3J1WDb+pWrcKv8eMsqWzT1WJQoBAIREJhoIbUU6QZ/duWUL
         1mUjEH6cNBZl8LFsJb+KtQvveBbUtgYc9F5XgQSoEleqf2l5L01mZz8uiWxTF1vzsRbN
         o99hmQLZylj7Xg/66jjcawD8HrLEKqj3atht0GppiatToyOOYVTXyFM2L7NhM3rFak94
         5T9PGmYujNnPRacURkbnkJChM74Aq93xzWgLUU+h4KkE7wfyO3zd2wH8c0Bzr1UNvGcU
         I4TL77v/Jv/YyKrcov8DFlsuhYJKJHgGK8A/PGgptaDexHbHmvZM6DTjsAN5HxT4iApw
         dY2A==
X-Gm-Message-State: APuU4Z+do2fijuOVk8DCjHe0chYaFEXTn/mPul2ngqCEFfVNed+b13C/
	83UpPDiKe+CJqfVwNppO+0CUvarzrj//oM4SVOqTH9pHVaJcumEcgVoXit9/jsXz
X-Gm-Gg: AZFdTZcUsEcBdi0mAPj3wgkOhQwLHdaDJxGNWn+GkR0/Vc0bKmwX1PXAtWh38GijUYr
	GLj5XaI754Np+QHkkxS5bIDW7R6hjlq7Q3XeENlhPowUYt6+jA7v1pGViZPXTS5HN7eCoGRQZHu
	KnYrxHeQyhvT85RQ/N8PVKRsTa4bTVOLzFZgFeKgt821zGD+zfdrm0sN1RMXqqYTkCDLb4rUKCV
	Fo27uSK8Y+ds1EXxiNG9xMGQZWkDsWZTvDdjskknBymtw9kLu/ESwUnfM8YEjHreLV6uYi1xZMI
	P4KRxKhwm/mKzlBS8p9Ne6o2zLrh1pStG3vPt58eV1of/SUFZpqdgNiqs3aChrS3G77G3QsX08c
	lesjbYXIDWwwTQxSZW+N1k1yaNmg8pmQ/EpS3Z7vXjocyaUW/nN6myZpAOD6HE5qjddXmOxxN4y
	Inm950HjuI1Mk6zePfgmZuYljp/fA1xQUZk5gBsdzjCJYQ2723ZMe+GtB6Xo7XsCCYUtyuhJwEb
	X2JN0kCR2ayOuFRrbcLFVNSmg1NRmrhFAqL/MevvS8QH+SowZ/9T5wrufeWLw==
X-Received: by 2002:a05:7301:4b10:b0:386:ab5a:d3f6 with SMTP id 5a478bee46e88-386ab5ad528mr1845790eec.19.1795373699447;
        Sun, 22 Nov 2026 10:54:59 -0800 (PST)
Received: from [172.17.0.2] ([52.157.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm24719244eec.20.2026.11.22.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:54:59 -0800 (PST)
Message-ID: <6b033a83.a3ee3146.1c5663.bd05@mx.google.com>
Date: Sun, 22 Nov 2026 10:54:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4582897862472624034=="
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
Subject: RE: [BlueZ,1/2] adapter: Notify adapter drivers of settings changes
In-Reply-To: <20261122105026.753191-1-simon.mikuda@streamunlimited.com>
References: <20261122105026.753191-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4582897862472624034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218576/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.74 seconds
GitLint                       PASS      0.47 seconds
BuildEll                      PASS      21.09 seconds
BluezMake                     PASS      320.55 seconds
MakeCheck                     PASS      3.66 seconds
MakeDistcheck                 PASS      152.04 seconds
CheckValgrind                 PASS      162.57 seconds
CheckSmatch                   PASS      328.49 seconds
bluezmakeextell               PASS      101.93 seconds
TestFunctional                PASS      1238.32 seconds
IncrementalBuild              PASS      323.26 seconds
ScanBuild                     PASS      1218.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] media: Signal SupportedUUIDs when the adapter's ISO settings change
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#160: FILE: profiles/audio/media.c:3871:
+	if (!(changed & (MGMT_SETTING_CIS_CENTRAL | MGMT_SETTING_CIS_PERIPHERAL |

/home/runner/work/bluez/bluez/src/patch/15010056.patch total: 0 errors, 1 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15010056.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2870

---
Regards,
Linux Bluetooth


--===============4582897862472624034==--
