Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006425;
	b=4xqLQAdiwy2JETabNhZXuCHUJjE7fuonqwq8aDFM8c5Kl5zrv7Pv+rKlXazxOoA9Udpe
	 8TOg83eDgCFJ6r+yUcXATQXOzCQlB8ZqCaDgmnjK6wo5KH7jS2YoQvTrLbqj2uVUlcE18
	 4B+yoYhOXhkHDe1+ExPsL13yCE7qs0GiZ7doeznlBAhM0sa6nuhrD8X6kElNhIhVZw80Z
	 lNdyhVP4LUgm0IisxjRHpuynIAz74UOEngJxD9qSqPAPAk+kHJz9Yk3Ca/wCfB2/0L6WK
	 PU+295JrTtn5ra8C68SShoGQVE12xlNgPtcSHYXXCJwHy0IuH+h3v41Pj0unxwhBBhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=IAkZDjIXSa6bwuyKdJvybvKmhfm5cuS4U1gJIM+6Qjs=;
	b=1p9zDPCsrHG6mKC30aOPY3cFInOlagVZ3myBXkK+4iUyes7Aew2d710WOJZ80hGWPfUt
	 v+Iz872EtcBLZyfVCfevl+O3n2y2cm1ciJEWaLdsmLcCAX/uRFzZzKLFiHKXDumPGacTc
	 iF5WJvsEVq7YdHzyJ81A/1Pbh9UTag656QcvcXD4RNWaYSzLqaggdUnVfbp2QkNlFoY98
	 SxJylAJ0g4D+LMnnWIFSaXOkIc4pwy2aYLc6NDxL0IonZIysIYkw4qkOOTm6yUGvd8ff0
	 mjtDsrcxRW4me2fgShNVPkwsE3Z7UD+fRdjc0EHz975Lp+f9F9uFp2deZWIVcy5vMJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe9Co8wP;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59789606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 23:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59789606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe9Co8wP
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-48ed0b68895so746117fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794006424; x=1794611224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IAkZDjIXSa6bwuyKdJvybvKmhfm5cuS4U1gJIM+6Qjs=;
        b=Xe9Co8wP3szBjMv+l+M7D5dokAfUjk7wUDSO6Rg1LnYpgHWqBaFWOAIhbmjm0rY81I
         iIyGdjoo3eaakiAzGAq310sdtFfI/Cea2t9QTOdQt4pfWXIii+OEu4HHSpnC/LSufMD6
         sjm02E95z1QTc6r5J9X003axxg+6iDHZ3Evq/aKmlg4ezEZ4wp7H2p/xRnOxpc0ghYHM
         kg/gq1peCD3ChSJAq5oViD0OP9ipHjzzwG9sWwV4y9l6IzbURnuoXBySHe2OA8oh8g5S
         zMXPKoKBxSyv9xChAsTr7gmhc3/2US1vMa/MiOHopI4v81jko5pMYgY/Ni7gLUUIomTI
         Tlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794006424; x=1794611224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IAkZDjIXSa6bwuyKdJvybvKmhfm5cuS4U1gJIM+6Qjs=;
        b=KosVjG4+CYlI+AidM4yUsap8XZfZxED+hQ5jnjGLPlA6TPpTMhIR5NPfj5gs77Y0i2
         5esxwW+BAe92A7JNccRwJyToSByGKOGeVkq8NNaRg1EN3LKjHsqMJ4QmF5e0zLf1Sr8I
         m3zx5fpNP8Cnv3IXu3FwTmbvjOh41+lKhViVaEUzrK37kqWAAQ23IQppFTw5GFKts/pT
         cEouSq9K/vSxvb45HXqyKl5VB981ERN1Wa9aXcTrt77TM/gJjb1kIXHqYEZn68lcXpj8
         ASNadZGtziuikZkOF396OjCBhfpQC+ynjRB5EhRn3RhRQNhXY4ODgYe+X7O4YjZRy6Wg
         wvTg==
X-Gm-Message-State: APuU4Z8SWjYmWxrlb0hZ9gUSyDVTXTKirdI1yRt3GbrNFZTG2YTYXIa4
	HW8yP2N+6oKrDrfwKs7k6gITKVwcMXgY78tpkrfdCEYoQCd7lIoTPAnoeNSEuQ==
X-Gm-Gg: AYBFou371+NFrLzEzBrRePoONQx0jK3DDD7BFn33k4S0I+l3uWi0nOo2pI95TEYuHhf
	7aSOCkaGqOJydLyUcxHq5VXSTInKM6qgMo2k/0EQesodAmay2Ov4VSSorUVTQlM3LhXjvHFakcn
	1jH9PJuZFtZxzfPEzoEwdB47T8ztOhv+bUtakZhzzMx6euBD7p4bqrOfkk5S/oxaLuvt+Nd04fy
	dLce+5K2FCPd6M8q/R/o3rZsQ7s+W+UM/ndqKL1mbV5akoDDGWdJSanSfjqAEJJWzGqwfrl26WM
	xcr4RNAj8wQN72F25a/0gHAFSnWSXoKkVfOOSxZLeY2ZW1YI2qnfFsXGWk3TR7rEQkN1blefjHI
	ShgjEs91r1+M9zN+5IRQ+tQzISMs09Z6voO2CYZHUWpdvIFe+4mbXWvFhZM/GO9igLiXMEWnXfN
	RfH6KMCdb1a9gywBmHNYJ0tRVb2BbJ+JehY5KfDfvfrS4TO7U0cSIxmixcwon1BZXEE/0XTDnSz
	PAcnbckTnvz5N6IdSmcEuopHaSDPCh7I2//YoQP2g3utwkG2Nn4fdfc/7jt62hf
X-Received: by 2002:a05:6870:218c:b0:4a7:4a8e:237 with SMTP id 586e51a60fabf-4ad98ae42cbmr2514536fac.19.1794006423102;
        Fri, 06 Nov 2026 15:07:03 -0800 (PST)
Received: from [172.17.0.2] ([172.171.14.208])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad97ca8e99sm3506218fac.16.2026.11.06.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:07:02 -0800 (PST)
Message-ID: <6aee5d96.99d0dbd8.15a7ea.f909@mx.google.com>
Date: Fri, 06 Nov 2026 15:07:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2717751546331888676=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261106181809.3134862-2-luiz.dentz@gmail.com>
References: <20261106181809.3134862-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2717751546331888676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204430/

---Test result---

Test Summary:
CheckPatch                    FAIL      8.41 seconds
GitLint                       PASS      2.94 seconds
BuildEll                      PASS      16.10 seconds
BluezMake                     PASS      229.17 seconds
MakeCheck                     PASS      14.91 seconds
MakeDistcheck                 PASS      117.29 seconds
CheckValgrind                 PASS      278.69 seconds
CheckSmatch                   WARNING   231.88 seconds
bluezmakeextell               PASS      74.95 seconds
TestFunctional                FAIL      1010.24 seconds
IncrementalBuild              PASS      615.64 seconds
ScanBuild                     PASS      844.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,01/11] monitor: Use __packed in bt.h and its users
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#230: FILE: monitor/bt.h:16:
+#define __packed __attribute__((packed))

/home/runner/work/bluez/bluez/src/patch/14958698.patch total: 0 errors, 1 warnings, 4719 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14958698.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v5,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

/home/runner/work/bluez/bluez/src/patch/14958707.patch total: 0 errors, 3 warnings, 2945 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14958707.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2771

---
Regards,
Linux Bluetooth


--===============2717751546331888676==--
