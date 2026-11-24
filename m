Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553428;
	b=MzpfoVijfFdxsgQhPXpzAkHKjmEbg/zY2MAao7QQW4yFtXjliOniXadvO+kc43/57Xi2
	 RTZgyxxO/WDOZo14bffgezhD2MMLqS47QV3izpv7PdOFkqXfdt3aC3K8bBlTKEHrGiAME
	 dfQiHuLE9UGuHZBT0z9VHGnT0zj+FE+//pOvORiTOCrsqN9tiJsmYFW2E4EcQtRT9nVb2
	 34GJrQt2lcgk2CGqql+ijLRfsgDNgKHdM5tw5naV5Eko2rOBk2PUtTJBFoo/tQF68RGdD
	 ogdpxcKD3vgLC0Q+ut5T/uY1djUerOS9B08yuUXpKi4+lG9Nfb3YsA4pl0xBT03tTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LYTvP/XUuIaBn2adocQqGXhzaiCWKheAUqkDV19urYI=;
	b=Zi0CPCdtbFTnrXVKP1/eE7zcySJ4eGXmuhjh/JYZOvawomXc+rfxArEAQwZvNPHQ9p/E
	 vB+/2S0rZbNWtfcqVDGcDadLy02ax7dDI4PXl16ly7Zzk4EzOxHR42+iDDauYL2M1a61A
	 G3MGIXDQ/LRGJYvG2w4olhOHmI9zPevw2u+oChw772fNlbmNpUcVgnkfelNhsv8ejwaj6
	 ZrmRRP+LV56uMapkxUrDFrtalMwK6nuz1zgy/FFTh19xQppo/txYGZEI+dJV8AnlBczOn
	 RbV/4WFPSblDKb1lbxxRDAxgVZSqrmPDymXIEpgWpdL4+8pQ7eZQ1IVme6p0LDHFlWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NuprlRfc;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FB606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NuprlRfc
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so2811123137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553427; x=1796158227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LYTvP/XUuIaBn2adocQqGXhzaiCWKheAUqkDV19urYI=;
        b=NuprlRfcKT+3E4nCHxwWx1q8aNLFyfHIuBSJUIhCpHRcwyro852wWAoE1x6ZVLmfa7
         NkTQsKyTW2W0I8xYaDXwaMftLnA8shX7wNuRMVw9IrykJIPt1VJr5BsZtAZUE52PvVKB
         SdZeC3Z6kCcq9A60XwgvljMNKWSH7t9YaDt1KPfE6R/C3B5sXxF/kth+OCBWGK0Lw/P9
         P366NDYar3f3yqjym8jJwJPFcwySCjYc31fpJ2Tee4b3SOTENGFD4UI8oOb+01L2oG0L
         LvPpFJsaSUoU61qjaAJsISooMKY5UsvSI6iifEkylY8mIyGoRax86CoGNR8Q4/nC/LcQ
         eMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553427; x=1796158227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LYTvP/XUuIaBn2adocQqGXhzaiCWKheAUqkDV19urYI=;
        b=bIQ5NH6Pk2wXiF4hIlusD+phOU5+ojq783U4Hd+firizq9+3Hcmk/bBQlbN7LBHHGE
         x4X7gbi4XdbZ/no3dD68+KChISw8qMjEKkPvugjIO9pJann7EJtyjedo6WIbHfohTWgG
         zck/tATosTrBR1bREXMiV7uCvC4nfm6vIDmAwJC6RmffMWwigzFIFAX6AX+FMRdMXtkl
         YepdFHQksyxBZmY2RDq9HupoICBpQQSdXf0bw5PDb3mRs6VygB2oagZgVc+/60WF8bTW
         hsn5FFkdAtUv1CaZgNR66Jq2xeKTLRyeCqBrG+V03DGgMHa9SEJ0AeDTg9oczpczvzZO
         gpoQ==
X-Gm-Message-State: APuU4Z8aSoN37fmtQsiYv7WNvZABOWcrpkDVB5ZImq5GbHo26Cf43hNX
	YRF7pzQLkZYkI3pdmwdkjslxZ8jWmAsr9ZUa6VqR6Z6uvc3uE+OBngO65UX25w==
X-Gm-Gg: AZFdTZfipxdo/usEtBxh1TOwtqLrL4n7wmKFt1eHy2SRgHtgFXRBHkQQdxd+drRasDe
	RB7ZXXoPvd4u3W1n9BvymFfCm4xxXziqyzHz+15zGiq2RJ3H8irgdf0OZ6RkWGPV4wAV0UO2Kwq
	sNBto5sDRuApdf68yU2UFE+FkF14J0Ie07KxxhCjrilkt/dAMw0b+yBRM6jEyHfQc0Jl9d/IbHu
	kc6400KfRTsk4KEjmBgzoohAzWY1xXeE1bf6nOFh40bpvH84/IK/jfXE2sDGMYYDUGD/A2tfMV8
	JAWOgsUsVXLWTy08nwO+zDUnBE+5L4OTq6ILw5Km0At3T0Zcx7tt9M3Awaongp+RfCrMYV1iJh5
	fyJlZAoJrSnwhAeIdFDHgFYF8rP+2QT1Aqu9xo990a+BgoPZ3PvJCxBPSc5OzvHy4CJ7hTa0Xnv
	fcusscaJ9kZseEDl0YqRZZVLjFfyjF5Byc5VNNFMTgl898drb/khDxpx8lbgFpqB+1daRLIEIsR
	8py54Xg3Bzka5uzWyDyEqVdBj7UhhB4gcp+vFZ749Kr8enc7Q8KDCnPFcCd3bp1JyeUI0uvdW5u
	LxQ+QaBNKFJN5+6nYQLONi2ve5Dw5NRRWz5eo/Gqq7DoHRU6bB6VD4+xJ61lLH8kjn1hzHEA5jh
	RW89mtXVgu/4mOCv4QohJBs5e3rHxOP8sugCb6mDedAdrKsAa9YxkSwwxYk28cV5cdmIk/Claxo
	CznCM=
X-Received: by 2002:a05:6102:441a:b0:7a1:f951:664f with SMTP id ada2fe7eead31-7d7395b06e1mr8553506137.22.1795553426891;
        Tue, 24 Nov 2026 12:50:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e80cb440sm16308884137.7.2026.11.24.12.50.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:50:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/2] L2CAP: Fix channels being established with insufficient security
Date: Tue, 24 Nov 2026 15:50:23 -0500
Message-ID: <20261124205025.736808-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_security_cfm() lowers the security level of a channel to the one
of the link when encryption completes, and accepts channels waiting for
the security to be met as long as the status is success, so a channel
can end up established, or be offered to a listener using
BT_DEFER_SETUP, over a link that doesn't meet the security level it
requires, e.g. if the peer disables encryption while the channel waits
for userspace to authorize it.

The first patch makes l2cap_security_cfm() compare the security level
of the link with the one required by the channel: encryption completing
below it is a downgrade, so the channel is no longer lowered to match
it but disconnected, or refused if it was still pending, and the link is
disconnected if the channel is a fixed one since it can't be
disconnected at L2CAP. Channels waiting to be accepted or started only
proceed if the link meets their security level.

The second patch makes a BR/EDR channel visible to the listener only
once it is offered to it, after the security is met, instead of as soon
as the connection request is responded as pending, so a listener that
accepts without waiting to be notified can't authorize a connection
while authentication is still pending.

Tests for both are sent to the BlueZ mailing list as "[PATCH BlueZ v3
0/5] Add tests for security of deferred setup".

A channel requiring a security level that pairing can't provide, e.g.
BT_SECURITY_HIGH when the IO capability is NoInputNoOutput, is now
refused instead of being connected with the security level the link
ended up with.

v4:
 - Disconnect the link instead of the channel if a fixed channel is
   downgraded, since it can't be disconnected at L2CAP.
 - Call chan->ops->close() when a channel was deleted by the downgrade,
   so its socket is not leaked, and also refuse deferred LE Credit
   Based channels in BT_CONNECT2.
 - Only start channels in BT_CONNECT if the link meets their security
   level.
v3:
 - Don't use l2cap_chan_check_security(), which may start
   authentication or encryption, compare the security levels instead.
 - Treat encryption completing below the security level of a channel as
   a downgrade and disconnect it instead of lowering its security
   level.
 - Only let accept() return children in BT_CONNECT2, as
   bt_accept_poll() does.
v2:
 - Drop BT_SK_ACCEPTED and the changes to l2cap_sock_defer().
 - Add the second patch for listeners accepting while the security is
   still pending.

Luiz Augusto von Dentz (1):
  Bluetooth: L2CAP: Don't offer deferred channels before security is met

Mohammed Alquraini (1):
  Bluetooth: L2CAP: Fix accepting channels with insufficient security

 net/bluetooth/af_bluetooth.c |  6 +++-
 net/bluetooth/l2cap_core.c   | 58 ++++++++++++++++++++++++++++++++----
 net/bluetooth/l2cap_sock.c   | 10 ++++++-
 3 files changed, 66 insertions(+), 8 deletions(-)

-- 
2.56.0

