Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565949;
	b=uL7XUYnDEz0WEPMNEB1VZQ91koLWKoZbhQ5II67duQXhfWNxNsyh+4vCbHh/PjuqeprS
	 sZyzOJa3zdiz7a0cc36CdPp4HnCncWfc0AfTBndsz81Xo1TC7ANSpgyyTwWZJdDHp5jIS
	 kWfM6BAnBI6Khcp0bUBBz4m+XAY4XSe8Z3d1Odc3LcGvv/N8dz5ovF7zRYFr6MkqZtMHV
	 voa7CogVlvSTQvU9JMeNI4GwwhJF/ibk2lXErmEtD3ij0R4W3l9I+q8reVxUXFEEge1VK
	 Dwhsr28rJorInXqK/wJO+E7vk9nkF7DxO4+dPStZeU3UVlDygBHE/YG77YvuZKYr5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SLexcCgDK2SIVIMYs8/iOOF5BBjM2PxK0AQdb+qmIk0=;
	b=c9YP5mxeLOUVajdoE9r5nwRyA0eNEYJ73uND5tzNZsyWtpQG91/vZ/C0rbFxhTNy32ap
	 1mNA8x4maRkmThXGwQHSxLsiUtx8I+Sl+m5MZVaRGYf7mdIazu2tZVbcd8B+jt/+FQS7w
	 zSgWpNP/mJ+W4/Iwk9RNIN4+OizHn/tRVf7wbV15QtIg8z3Vlzb/lwJ59LqvymDHgKbVq
	 icjQ/cjdT3XNr/26miviZ79aGBSUO4OTerD0ku3G892UcFRVCu9ZgqmZdI/zncUChTkHf
	 LNNWl89TGRDMFz1yXMZZcHnrR3y0+1B7Y0pbSiiYfE0DvYn1wfzkSY6NvExR3CNJpCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tooangel.de;
	spf=pass smtp.mailfrom=tooangel.de;
	dkim=pass header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=m90sYhhv;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02546606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 06:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02546606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tooangel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tooangel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=m90sYhhv
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c434376dbebso73931066b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tooangel.de; s=google; t=1792565947; x=1793170747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SLexcCgDK2SIVIMYs8/iOOF5BBjM2PxK0AQdb+qmIk0=;
        b=m90sYhhvzoPRuC4q2/O8LG3/PGBvy/AuAbSPQJ76i8q41A+oXDvG1F7diDOAyI70C1
         wGS4ArVQcworN4xlnmSlEODt+YKzhEU+we9cAvqsfTJeN0EuvHUDQgdIRgrBZEEXQGoM
         kWpSk/MyXY0Ff9wueuUe8msUTddTTl5RGVz5f9U8OXOenpiv3IF+MYAlsDea40r6y3Af
         r2ByA2jDAU+lUnhOVsNJIjcLPanME2tmwNTg06bbZ8ZUua0blsPuns9g/kRp/BjFoUK4
         /IW3QI3MxFsX81BaNdd1ypuF83apuXpwiXFpO0meT5Jpq2U3mgOHf+gz97LoU9VpOv3A
         v0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565947; x=1793170747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SLexcCgDK2SIVIMYs8/iOOF5BBjM2PxK0AQdb+qmIk0=;
        b=ezb8vF+xR83XrZWUEkociboy6gNu1s2jGF2Un23GO+b8/cWdsp38tZz7GEN1tUTLfb
         Crrq9cS6z9MkAEOxyvLJvz857c1YfmEhp5vTY2R5S4QiQoi0RrU0WJJJRR9i44N+QU2Z
         xtJzMMi+qfXJW+UIyWMRvM3hcymapOq8tf8LBhxOjfTyManALzazqHvUrnjrPUpOIpOT
         7N/OHvdYwjRK1Vc6amrSScwgqm+Y4gqu6A3H3Wm2im6IbEsGEw6YNGM9Xes8TcDIZCWN
         qV+kYaUGTlvBoywKJ8h7VyFA4pbdXSXL2LT39fvaIUulNdW2ce6dDCIyCyNYXZHwDVRo
         PUsA==
X-Gm-Message-State: AFq9FYJ/trV1e/qIBLUeBPHMjQ1y/8UUZHTLorCeTc2h4x2biyZUWfJd
	rcpmpoTFpbCxYWS2qfTcMPmWV3iC2IOgiZNPDYltU5BpZVOBv3cT4LdGDUCWxZDAg5Z+TSucyPZ
	5aD5wAq3Zzg==
X-Gm-Gg: AYBFou31iiVXEqNYyhEfXFimDdLpYSTiLyDPCrCMhfPCL+2DXAAx/msFPv7UtTRVrbw
	j1kyU2AsQf7whqq53+fwkfeTcLaEtACG71A7jbnpRhkWW3poMYrOGTKgOl/klHbyO8DwvOdCGFM
	a/7LdTDxe8bs4w34dyrvgpfAH5hq3RoTGuhPjmDjjHAIU02kObzRDFcG0L9y9Vq2zFag/ezBwe1
	J9rXp8zgumiNcmVDqkS/FbPX5AcvcP7j+JIhbZRYvcUeHGeTREz1E/nW9XW008ukYZQGsMgTN+V
	brlajhY7c943JUtAsfNpH4ePhHQ0mcC0GNtGWYTwa8FG3TKrURt5P7J0nU89iJBHheFVCWKfUa3
	9LkuVhgrBPf/Qay6IK4Lmhv60/pFd28WJPGsY+sUbl0muH2LnsyYC9tm47Z0vMeUQSixLHFrHuk
	B7VaNT25c/pCaB6eZIXcn6gog3K9iJvvNKa2Ea8iksEKge/IH/GQYeIHwjjSd5N9AtYaJqeeXQs
	fVx8f8vSdQ63mMkJj6VAfKF7tbwiEAT9AVnc6tdnIDYclvG2BvpdyQpJbgN8yuo3diA4CGDJbcI
	+1Ui+U8jPvX/8sJi2IeDcCr02J4dXompbyGrQOtzXgfGC18fwg1hD0qvpxiFYPYODCkqqqQw4Kk
	9oFmtzYWtKBA0+MobPnyt62RiUvlOyY9NNTk4P94Y8/gkyfZ8FPsvzJL557kGNQ==
X-Received: by 2002:a17:907:b045:10b0:c46:7fa4:9212 with SMTP id a640c23a62f3a-c467fa4a4f2mr33166466b.23.1792565947131;
        Tue, 20 Oct 2026 23:59:07 -0700 (PDT)
Received: from toogaming.fritz.box (2a02-8206-7df6-9800-2fb8-381c-b7e8-86f2.dynamic.ewe-ip-backbone.de. [2a02:8206:7df6:9800:2fb8:381c:b7e8:86f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679006ffdsm45166366b.77.2026.10.20.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:59:05 -0700 (PDT)
From: Tobias Wilken <tooangel@tooangel.de>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller
Date: Wed, 21 Oct 2026 08:58:33 +0200
Message-ID: <20261021065833.120347-1-tooangel@tooangel.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since MGMT_OP_SET_POWERED runs through hci_cmd_sync, powering on a
controller that is blocked by rfkill fails with -ERFKILL from
hci_dev_open_sync(), and mgmt_set_powered_complete() reports it with
mgmt_status(err). mgmt_errno_status() has no case for -ERFKILL, so
userspace gets MGMT_STATUS_FAILED instead of MGMT_STATUS_RFKILLED.

Before that conversion, power on went through hci_power_on(), whose
error path mgmt_set_powered_failed() still maps -ERFKILL to
MGMT_STATUS_RFKILLED. bluetoothd relies on that status: for
RFKILLED it sets the adapter PowerState to "off-blocked" and returns
org.bluez.Error.Blocked for the Powered property, for any other status
it returns org.bluez.Error.Failed.

With the controller soft blocked, "bluetoothctl power on" printed
"Failed to set power on: org.bluez.Error.Failed" and btmon showed
"Set Powered (0x0005) Status: Failed (0x03)". With this change it
prints org.bluez.Error.Blocked and btmon shows "Status: RFKilled
(0x12)".

Map -ERFKILL to MGMT_STATUS_RFKILLED in mgmt_errno_status().

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Assisted-by: LLM
Signed-off-by: Tobias Wilken <tooangel@tooangel.de>
---

Notes:
    Tested on Debian's 7.2.9 kernel with a soft blocked MediaTek MT7922
    (btusb) and on bluetooth-next in test-runner. mgmt-tester passes
    515/515 with this patch; the new test "Set powered on - Blocked by
    rfkill" fails without it (Failed (0x03) instead of RFKilled (0x12)).
    The test is sent to BlueZ separately as "mgmt-tester: Add Set Powered
    test for rfkill block".
    
    Not tested with a hard (hardware) rfkill block.
    
    This is my first kernel patch, so I'm happy about any feedback, also
    on whether it fits the conventions here.

 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b9c82bd2f0..0f93e9e2728 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -304,6 +304,8 @@ static u8 mgmt_errno_status(int err)
 		return MGMT_STATUS_DISCONNECTED;
 	case -ECANCELED:
 		return MGMT_STATUS_CANCELLED;
+	case -ERFKILL:
+		return MGMT_STATUS_RFKILLED;
 	}
 
 	return MGMT_STATUS_FAILED;
-- 
2.47.3

