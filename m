Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722065;
	b=EAzSrt4NmZKWBA2L54SStWQgyMR+y4LG6YftU/OTqCh+nlPWl7InWs/HbF2swvW6pb4k
	 hjAvwkKbMOuhS0OV4YFNoHgCH6Gf2O4+xZDNXPuIvDc4iiNiaVYjrj5RzGpTzHMW8/FjB
	 ctO2hPcSxJ7HS93G+7elgCBSoy5F403wfVS5ROcoPpL0dYyus/+aFl/vqZwruCDBVPKei
	 VCk6xh9mpkDouyu7ZUrEB7Z4nVzA6bbkDS+vWLFpu2UuxC+4XVXGR6O5gjoCrYdlpAy8e
	 v1cf6PYGs1Me7ik3H6bREyM9u6HGYGgmUT+Lwe4hM9RsHmzH9vQcZVofpQU1z6xHuUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722065;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WpRiRLDlsEhJ/mKw2G/KVu4k7QRGbXwwSK/KpDrRjxA=;
	b=UXaQK2BfoCqATuy7VcSJeQK1/HWYOwYmHLSZqLCnZYGsQdrNyuJ0AkUtZ7I3QU9+fsDR
	 pAGoVQztp9KAUf0zcnRJRizV23dWu8xx2Nf5lVS4e/1Yj+nVedH6l23PjmE4+nt694Prb
	 2Uu6Aqh2n3nZENr2PIFFpKsU/BLYG5SGbFKoSvPwnx3EP9It/D+PoB1cW4a74Yr/LdfmG
	 jyKBAJpKOOLeP+uPmJl1ABzmB/hela1c5lA0o/rbQYnPUYOZn11M77t85WkHEH23KIfQl
	 Nmb7PwVcdbDwZVGOfRBE9TXspYlB0uUMtwn3Obz40yhcAc/hOc5avPTzyFU+wmZiXkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=daanbouwman.nl;
	spf=pass smtp.mailfrom=daanbouwman.nl;
	dkim=pass header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=WvgTQtcW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p5amaD36;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7750606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 19:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7750606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=WvgTQtcW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p5amaD36
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ABE78EC1195
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 14:41:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 14:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daanbouwman.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1795722062; x=1795808462; bh=WpRiRLDlsE
	hJ/mKw2G/KVu4k7QRGbXwwSK/KpDrRjxA=; b=WvgTQtcWx7iXzUhE5GtbKoxC2u
	pzmAMMEIZy2qGrqBc8Os6Z9WIJprIR0EkUTa2zQhSii4gKBgZ2O1iXkPjk7Yz/1f
	CR6PhiYt2yTFfug1Qzo5AAZFC0rgXShbYq0Aqp9Q7cgJQxC5FrSMKIIpDWuji4WK
	eJYgu5ATW3Bic02mwqXoIB1+Qz2/l8iABFExwSGYNRQDn61DMtv8JxjD1il10Eyf
	MGCQT/8P+M5PRE2E4+hkc3nKEmjs6IsTLoHw9PPo1PTkt6a9J5gx76CNJOiHxlbn
	xsrbQmCHVE7Ezsj7bAx3w3FKBG25km1NcUhgSvpdE8hdfcjkLcOIt7Be1ZtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795722062; x=1795808462; bh=WpRiRLDlsEhJ/mKw2G/KVu4k7QRGbXwwSK/
	KpDrRjxA=; b=p5amaD36hvmgedjwZ0xg94s5+XBilBNGeeSjckrHogdVRXidjt9
	pCBNdemrKw2VWCnzdZgUJ4C1+nkbPBK2HVdjsFYVb7gMc869tEK1MxFBcc7L9N6m
	NPILWiZJVY3Wui20l4RlHIpOGyy78ScOqxibaYcfEC5i99Nk+tvyGlteRWykut/e
	BJKsQ+lC8Ld0f0/dbvymxI/h7cB0lN6CDWO8p/lzygz32yegNITv8fwg8Ruub9Xl
	/z1AhTFI5pc4cPA4aT/Xtpwdt856joQut2W2eHLk0s+XdJiuIhqFS6xrPGY3j/Qw
	n+DxKwDolVgmkZSBkpudWfVuGjcZ/uH8EHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=daanbouwman.nl a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795722062; d=daanbouwman.nl;
	mf=PGRhYW5AZGFhbmJvdXdtYW4ubmw+;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hwNike5aab4EsJxN0Ip8foCJs8deCfjiCzmjYQR0glp+sxc
	FhfOnJWVwTeCm9avqFrhPyGp0ocGx4nvgrVbHhmXcon//mGs187JQlOt9K5/CGQZ
	o3qtQ49onwSKcDFta2JdN540PSAkgUksHQ/fLrvqG2M6Kwnj7hZdtG/g+353Zsg7
	fZnLprFewKv3T4t7NH43CmUd6P9tLydxW/0pXm2ovSXgRwFI5Qput9wR0/7doshH
	RnNH8hGnQ2ndJ9IBvaBKYzsn0EylGXgi2VNVzvxoWanLkXkgirXmOFiCqJZkV8SI
	jSX8jT7rLWUWvGecsKtXfzKxqCmImtePBKHtpgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:R8kzPbfgjuoOK5jPv4j9Ml+rxssbyrSipHj58v8evZY=:eSlI5FW4uvOmNVy1NhkYO2FY9VrCksPhnDcCcsJ5OXs=;
X-ME-Sender: <xms:TosIa7eukU9tcfyQC0Ix4_LGGY3feZdra8TyMXxzut--gg96FY1dZg>
    <xme:TosIa8Ls4xVAXG5Sx1XVYQsyAFnoorlqBGbGNkLQ0Jeds-p8dGSosDWQaEhoOwJxJ
    EAQvvur-o4YcfrcNibfhtDcNtIIwahW529cd55oHoLLbaZ55Kt2S0va>
X-ME-Received: <xmr:TosIaziRoqWj-PI7C0AAvC1GHRKuhD4tktKwFUFqHSFoxwhYka-M04raCb8Ke7aaKx1vgl4BFQdRrazPR54>
X-ME-Proxy-Cause: dmFkZTGONWxFrGZw7VqbtTjR8yfHhTWMSA/rsfyBvayoHSb34KaJ9oF0YLBMoCjgCttwOz
    TVYMupIgi5tvQK8hwYbqfl19bqI+aASltLMeCJ5D2v6DPlMRdprBH+TSqLclMQsoMUaiv0
    B5vkPX6MkV7niVHBJMslhLohIN8i3bimyJbTCrcQC9wbgb8HcQUA8944tdfz09/tX8LIlE
    3t3UPuwTDwHzridGJ0X/TD5p9WPCdtkZfJJg1m1QI8lQyv55Y9G/lhoE2gumiJ2Vrd50UQ
    AgmRPKEUq3Xv6f17P17mT7WDkpD9702QnPJOd/qbfHndqiP4hNsIuHfuEVkFUee7cAj1sS
    rNsiOpSpvCm8MhdN6DnGBvPNTadDEL27dWY7rWp3W+/kH0tlTLAjLrHY/EV/jDm4+IzoWf
    tj2ERZUqQDVUbvRhIqB9yUcUQGeoE6XoCY9j0n+qi6egrfPgR78z8AzU+3dIPTsQM0YZcw
    anx/NtcSqbVdaLpCyorap6S86AfnNKO0uos9mIbh6F9bQ/siWNYn9HTv+jU9bfkrpLMDLd
    GObywz6UXZd0P4mfoFgwh1RrVo2PBYak7IAJ33d12RzX5VWIB2FpE5h7TonMPmGK0f802e
    A4SXuMCvgNv3rAT4vzcYPDPWgL94UELlgdqp+r4PtDCCtLLZ/IhDdA25PJ7w
X-ME-Proxy: <xmx:TosIayQpHgO8RND-SHV5PDSml9GBaXOEugMnxYsjBMc-_GmCBaPdVg>
    <xmx:TosIa1W4QX0fuJBF-VCyqUi3tKxOy1HK-dmUXWrEOTYUOuk_1ARSig>
    <xmx:TosIa2RIo5P3H9qUEVdCHO2al-L2i89_V9IS_WbHNbdcq0-bOxec8w>
    <xmx:TosIa_l-dEsxttdayWLuK77j45dUp36Gaw4_bRQXg9uYjEykuyCDMA>
    <xmx:TosIa7mQPawTYGrP4GkPKYS9BM8R8NYrxYUKnomTIhWWkMKWH9egJgJK>
Feedback-ID: i83ce4876:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 14:41:01 -0500 (EST)
From: Daan Bouwman <daan@daanbouwman.nl>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Daan Bouwman <daan@daanbouwman.nl>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
Date: Thu, 26 Nov 2026 20:40:49 +0100
Message-ID: <20261126194049.123171-1-daan@daanbouwman.nl>
X-Mailer: git-send-email 2.56.1
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

The Microsoft Surface Laptop 3 (AMD edition) uses a Qualcomm Atheros
QCA6174 Bluetooth USB controller with USB ID 0cf3:e303. Without the
BTUSB_QCA_ROME quirk, btusb binds to it as a generic controller and
never loads the QCA rampatch and NVM firmware, leaving the controller in
unpatched ROM mode where BLE connections fail with "unexpected event for
opcode 0x2005" errors.

With the quirk applied, the controller is set up correctly:

  hci0: using rampatch file: qca/rampatch_usb_00000302.bin
  hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
  hci0: using NVM file: qca/nvm_usb_00000302.bin

Add 0cf3:e303 with BTUSB_QCA_ROME | BTUSB_WIDEBAND_SPEECH.

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e303 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Cc: stable@vger.kernel.org
Signed-off-by: Daan Bouwman <daan@daanbouwman.nl>
---

Notes:
    Changes in v2:
    - Drop the "Bluetooth: " prefix from the quoted log lines to fix the
      checkpatch/gitlint line-length warnings. No code change.
    - Rebased onto current bluetooth-next.
    v1: https://lore.kernel.org/r/20261112152426.10335-1-daan@daanbouwman.nl
    The commit message was drafted with Claude (claude-opus-5-5); I reviewed
    the change and tested it on my Surface Laptop 3 (AMD).
    Tested on v7.2.15 with this same ID entry applied to btusb, after a cold
    boot with my out-of-tree workaround disabled:
    - stock btusb: no rampatch/NVM loaded, HCI version 7, BLE mouse fails
      with "unexpected event for opcode 0x2005"
    - patched btusb: rampatch and NVM 0x302 loaded, HCI version 8, BLE mouse
      connects and reconnects, no 0x2005 errors

 drivers/bluetooth/btusb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca..f44b44382 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -288,6 +288,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe303), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe500), .driver_info = BTUSB_QCA_ROME |
-- 
2.56.1

