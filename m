Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076155;
	b=BRhQI/XIgaNXnfj3ynQMYJ3bAq2Dk0L8V1ey16yoOg/EJzUO26hvDnKf6MJXKC/OYYN3
	 mX15GvTwWEg4MLR6ePYZ4WtbDz4+CFO7fz0u9NgQK3MWMakZMhVlSJIOewcD/1Bl/PHl/
	 wss1JIrLaq6dr0KhDHAZ2X9F6k7aYJX+UCpbj0VYlXBZ5MWNv5ZQybqrb+w+49XLQHANq
	 gCmJ5XaYFBRnpyHcxZVKcwCfld+0Iscu3GDBYcYN1FwHITDc52NKlmTrVjzeWhop2/4Je
	 TNm99QeOnWUEKUHuCER7+9ktEyW4RWzVYisqy0RsJ8CEMWkMwakP+hG9AeS6yujZdwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pEskpVtuD6flaPibKt5b97rkJQjGUOB/KUI8AgmZqu8=;
	b=Cl+UbipKBYHdtDk/Th5+W+Bp6w55gvYy5I5Ifiq+zz4zP9Ao9bN+XxP5lll/2bjytwf9
	 dHPMV3OH47guN/fV4cXg/hwjbXhuFdtYxS/8SpBLGOqXe3nElQlScuIZCj5RXZe4yan+F
	 pGhlSVv4fPqMbif4jMnUZjJvwL0/BhiwbRzK5lu0xUWTOEFjU7+4q/QmZgApjoegMQ82v
	 Id+7eLBrk3u3RP4ZyHwx9d9sNOfjYPqEXds5qCZuFEaKHq5vosq8qeu6MFIBOCVGjMZBP
	 6rHObnXCRQvmQdyfwMvViMsdIS+/Nle28gmXdpdtRcBsPAqTfh8tptV2UCaYgQQ1cmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCdtkTKw;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB62606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB62606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCdtkTKw
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9495d543c42so192464885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076154; x=1795680954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pEskpVtuD6flaPibKt5b97rkJQjGUOB/KUI8AgmZqu8=;
        b=LCdtkTKwcBXQyghhDJ3wZzSmIDzDonCF7DqYKrq8izmvkG1nYEE+K8D+Zj+MI75J2H
         QOIxxOkKS6pMrXtb3VfBW6Fg4ORFneD0D6Sat14WnADn7JXmx8KUd1Z+0hzHWioXdshS
         vj1q9JIUet3a1/gW9NymtLfVp88AFUQTx3zr95NAxS9Tr6wh0ivKn3lw1L/ABAB5Avo/
         18QMT/uzqVpidvCCk1PS0mjJbiTPCe4w2NnT9MMkvrkrEMys5K2IUxdJg7feqniU3eXs
         V8A1ErkwtB2E+TCg6dJ99BF2SNrS3vFdm1hPtv5ufeb/DMvq7p6D1ywNWIbDrRbAP1Jo
         h8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076154; x=1795680954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pEskpVtuD6flaPibKt5b97rkJQjGUOB/KUI8AgmZqu8=;
        b=It6+1ekLyKUEOWwTVx21wCy+2JFLIh4gmF5ywCY1vntO3Wpci639Cnkidy/RJSt+bI
         oAqkGfdCqKTQTo38Jgx3Eov+W9kjDm48BwIY2qI9EaWK9xxIKyoeHOR8TXDsH5mRGnPR
         x4l2N5I5+xJET24DVr4z/wMYltbFzB5Ly+2xVKuZstMtRxEaQCjXC+nmz3+w+Jse/gMD
         Tt+TJGewY8fHSmSzPwB1qnHWiFgfrrBUhB1LY9alHOhK5ObhESLO1RmQ32HhaxsG1l7e
         Bpac6aPejB+s0FvAXdU53qHm5w67+cS8OnLYgUmprwpha1w6Bl+vYEJioh6nVyo8RuXo
         dH7w==
X-Gm-Message-State: APuU4Z+l2lyY+w1yAp8agShKukZwC3EQ3ILXPoRKAMybvQ4IZ99b19XA
	K1SNchio7M4MjZP9KiOq609YRoIae0N/ddLz/uZxuVya4D60pfQqYRoWquDRpQ==
X-Gm-Gg: AYBFou1HcX5+W+EUR0bULY0kmNToWqOPbzdZu2EwuqxMdG6ASZ6S/XpY45nBiC3lKsZ
	6hfAVzGx/EWcgRMyGwgWF0AUvmpM9KeSTLRvdQqqZ6tYBABS5kxifJ83aMWKxsedJ4fJcRIz31o
	tWu4RoYpCYLKGXjhCrxaLb9xewGpW2UDLKCie72dpabC1HFCUWkWINnBEUrrRx19smoDq5QUeuW
	gktmFRq5oTeg5ky7W5FbmzcoHX8lQA6agkKg3uA8I4zxnEcjGgrKaqcYwjomlhpdvtVY3xiLtz1
	9psxAkOYm+eCy3k5rqX/E2KOCxLqke5KRk0LiY2WA2vuLbYN0v2QoW2oHXdWp8kBVOxhocs5iep
	RBKbyAiNros3g175e8VpgUubg79Qm4m9jdvj3PHkEKypI55VFRyqcBjQmlDMNEHkFRJ6QXvdNiO
	SyuFj/wziJ2EXMhF2onmTxhZ3U6kapL+nz//Sy5x0T9wro5++eGu33e3aTSN33+f2K6E/RLQ9N2
	8U+552a8Ss3+eCw7hIKMj+mdzc6MPCkKC4OxfyfvNUdW9kaDTq0L9ZLuJNrAPwGCvuhzVSgga9m
	kuDFpyOlQwU=
X-Received: by 2002:a05:620a:648c:b0:93f:1936:b20a with SMTP id af79cd13be357-949997dd0e4mr870037585a.76.1795076154217;
        Thu, 19 Nov 2026 00:15:54 -0800 (PST)
Received: from [172.17.0.2] ([135.237.158.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b72186csm387820385a.14.2026.11.19.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:15:53 -0800 (PST)
Message-ID: <6afeb039.58979103.1582a1.f801@mx.google.com>
Date: Thu, 19 Nov 2026 00:15:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0153329370866802821=="
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
To: linux-bluetooth@vger.kernel.org, tzungbi@kernel.org
Subject: RE: Bluetooth: btrtl: Fix NULL return on errors in btrtl_initialize()
In-Reply-To: <20261119032415.4010732-2-tzungbi@kernel.org>
References: <20261119032415.4010732-2-tzungbi@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0153329370866802821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215632/

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.70 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      28.84 seconds
CheckAllWarning               PASS      32.89 seconds
CheckSparse                   PASS      35.28 seconds
BuildKernel32                 PASS      28.53 seconds
CheckKernelLLVM               PASS      28.85 seconds
TestRunnerSetup               PASS      668.01 seconds
IncrementalBuild              PASS      28.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails

5: B1 Line exceeds max length (94>80): "  [ 2592.730992] Bluetooth: btrtl_vendor_read_reg16() hci0: RTL: RTL: Read reg16 failed (-110)"
6: B1 Line exceeds max length (99>80): "  [ 2592.731005] Bluetooth: btusb_rtl_alloc_devcoredump() hci0: RTL: Failed to generate devcoredump"


https://github.com/bluez/bluetooth-next/pull/1157

---
Regards,
Linux Bluetooth


--===============0153329370866802821==--
