Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60130676C;
	Thu, 14 May 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726708; cv=none; b=KYpM7/QQeYh7XmU7jIKxBJqSr5H7x5qrt15QAM/2jp1Ey9qO93cP2FvAefEdpyUeNgyTv2dPFLV6vW8B4d9P/olgCWbHegsJLVffM0auC7WpDjQpckeEaq2sAIDui7QjPgMltiJnOZEmf4RloY1aeXP4338VpMcFosjns9T5MRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726708; c=relaxed/simple;
	bh=SILkXwUflzPdjEJbCQ/3qpbB5gDE+H5fM8C44fxIHlo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P7MgzfCgo4KZnxnRL28Uimog2r/GOOJJ50YWTJ2ede6R7lf1j2BDQnHq/f63zo7iPLYhWv2poR8vY7J2FTng/3nuHlpR46++11p4spfrjEzffb13B3vtAb7/KWAHsxkfF8TGmmcj69wjoBGxJtcj3/rcvghrus9jPvto4FFs+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IaIXncM5; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IaIXncM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778726689; x=1778985889;
	bh=jrXRkM9lAz7zYKdGDPSkmQy7ff+j3Gi77kdyFz+HJBI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IaIXncM55wwlGoecFHt40uq3SBu8GUTvVzuLeYGPwkTBAv8z3dlSN9KEKIIVoLnTL
	 Y+/+YAuY4udRDXpNuD/WkZW+mHFKayYRsrk5MTUQQE7qm7lzEJDpmVA2sDXstW9947
	 MUnAL8k7JfrB2RoYUOAWyRdLQ7GlJ1uST17XW6r+0Bm4DmSWKb6COiB+JvcGoFOgqQ
	 KcHmptc1Uvwym2FKYfxrz59P7StjrRuCL0R8t/1cYUzf83XWXmyaYiTxk0IXKQ57zx
	 gKsUUnd7a5RdrLaTTxNUTPX8dWT6vLYZWpQs96kAMd3SqTEuVGhGqIQoMb9eoxEfWO
	 BaZ5DhFEp/B5w==
Date: Thu, 14 May 2026 02:44:45 +0000
To: "shuai.zhang@oss.qualcomm.com" <shuai.zhang@oss.qualcomm.com>
From: makro-kernel <makro-kernel@proton.me>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when version matches
Message-ID: <GCBTvsv1x8qAB3ZmSCpTLo7M63lTTXM2c5n1TJLmQuus0g4gViSSJVRZzl6CzehnMdSHDqtZkQA33RYCVSxdAm7tGEeVYCflhV3QgbLIcfg=@proton.me>
Feedback-ID: 197359692:user:proton
X-Pm-Message-ID: ce91ed0a5e4d1cceb7211aa4f37f2f404aeebb17
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Shuai, Luiz,

I sent a patch earlier today touching the same function for a related
but distinct failure mode in the same family of chips, and only just
saw this thread.

  https://lore.kernel.org/linux-bluetooth/aD_Lix2EVXOHmbZ4L1CunlWiLqfiKlU_1=
_FcVh4CBuIgud4kmE_544xjW2zFKsmh4pNAo9yIQ7q8_GZ4YcmgAXPp8LgW9rfWKqnu06WSjgk=
=3D@proton.me/T/#u

In my case the *outer* check fails first: on Foxconn USB 0489:e10a
(Qualcomm WCN6855/WCN785x, ROM 0x00190200) the chip reports
QCA_CHECK_STATUS =3D 0xe0 (PATCH_UPDATED | SYSCFG_UPDATED) on every
probe, so btusb_setup_qca() never reaches load_rampatch() or
load_nvm(), returns 0, and the controller runs unpatched firmware.

AVDTP setup later fails on Acquire and A2DP audio cannot stream. The
PATCH_UPDATED bit appears to persist across cold boots somewhere on
chip -- originally set by Windows on dual-boot-then-Linux systems
we've seen, but the bit sticks even after a successful Linux firmware
upload, so subsequent boots also see 0xe0 and skip.

The rampatch itself also persists on this silicon at least across
suspend/hibernate resume cycles and driver reload (whether it
survives a true cold boot I haven't isolated). Either way, once an
upload has succeeded the chip reports patch_version equal to the
file's version on subsequent probes, which is exactly the condition
your patch addresses. With my outer bypass in place but without your
inner change, the second and subsequent probes hit the existing
`rver_patch <=3D ver_patch` check, return -EINVAL, and controller
setup aborts entirely:

  Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00190200.bin
  Bluetooth: hci0: QCA: patch rome 0x190200 build 0x8567, firmware rome 0x1=
90200 build 0x8567
  Bluetooth: hci0: rampatch file version did not match with firmware
  (btusb_setup_qca returns -EINVAL, hci0 never finishes registering)

So your fix is doing the right thing here, and on this hardware both
sides are needed together for the chip to come up cleanly across
reload / reboot cycles.

In my local tree I skip reuploading on equal versions rather than=20
re-uploading on every probe:

  if (rver_rom !=3D ver_rom) {
          bt_dev_err(hdev, "rampatch file ROM did not match controller");
          err =3D -EINVAL;
          goto done;
  }

  if (rver_patch <=3D ver_patch) {
          bt_dev_info(hdev, "QCA: rampatch already current, skipping downlo=
ad");
          err =3D 0;
          goto done;
  }

  err =3D btusb_setup_qca_download_fw(hdev, fw, info->rampatch_hdr);

Best,
Makro
