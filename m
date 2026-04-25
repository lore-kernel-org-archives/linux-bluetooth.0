Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756F31327A
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143440; cv=none; b=UP8hcwx3WxjkwJoL08Sstcyw8H70qnrItQ8scIy3G7/KehyFYJ14+cgaal9yVRPUuvNHtaCi/OQnHur0UcAR66S82GgQ1D28v/kpoElOD9fTFjNO/FN9I79774hn2VbGmfvK94iTdkmyGNQKIJrPQWROn/F0z/zfa7ya7dIIfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143440; c=relaxed/simple;
	bh=98+GRhpisUGHKvfDig6I3GmB9/8Dn8Ia7FYYqbqNUyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H41qYsHQCCd3Di5PVJ9p8RUCL75JOCRlQcD5U5XTsIVgjj6Lrftb06RZtPgVpFn5xfkWu8VFSN0m+LvWjXxGYPPivWsvuaiLgYfxpGqYIFgUmApuqdfYxq4QrcHpc/wwHLEwayjq3z4dkgLV4un10sFX7XknRdpNf3CDOt9sa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b=wqz7/c+Q; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b="wqz7/c+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777143431; x=1777748231; i=nils.helmig@web.de;
	bh=lMS9aYdNFuc/ku/Swa9U3CLrnsfbnBmEXXkQ7RHYheg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wqz7/c+QKEXj2FsQbtFgQpYqBecr21VrDfulFLIyhTX9J4LUmPioHITmhPKlqx+Q
	 RTWkbUmMOF4tCLb1eHXoV5OdQDGuroe+dx/eueKzDGhr0pyAngFELJpQysD83fQnw
	 6Q6KxisqMzBwg3qUEHKRPqTSyCzl70LTg9ed9DsRmKNobcbsNWrc6AUKLYaF9u+S7
	 81kqYnbaoceAZ9jFCnMiJ5hLpMyIQiHByFHJ17mED0ppKImyEtPTaOHiBf1UYOVGk
	 Sw1JoLZvLNKgK9+4TEMqW9tn/eJJaCpNY37kfAWnP/pNLXzSDgtJ1D7C690oomOAg
	 m7xcHIFeOWDk+jZ6Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxeE-1vWg4U3Ml6-00f7tf; Sat, 25
 Apr 2026 20:57:10 +0200
From: Nils Helmig <nils.helmig@web.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nils Helmig <nils.helmig@web.de>
Subject: [PATCH v2] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
Date: Sat, 25 Apr 2026 20:56:59 +0200
Message-ID: <20260425185659.13133-1-nils.helmig@web.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ofWaK3qciNC2AuzrtKKpc7uGg0nny7mbsQxZe/62ODYXJt3IlJI
 I0/4bVzEVk2T8oTWiNN8Os6QU2kU7dGcUZNZPkZbnRMfpte7e/nxIOJaSuWJBV4eL/FsCDr
 C5+ldy8EKx37aAPYaaKpUz15Z9grVe9fedMoOhC6pVwlYDScJI45F6tYkFDfR+8w1UZ/PPr
 sb3kkxi2qZD680ckxgkkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eGW+6WfJtTw=;B16kAcL+UCnAe7Gqf5ITm4dhpQZ
 PigcbBHxwlkRFUvuP2khJaKyb/r0iDYbvmiQ5z9fA4IbBWSzz5VVvBext7i4SNbu4y2OzIoly
 LI7jpY565GC8RrvpnD0T7KpLSHSWLrm9C837Rq+vA2mB13pzbdqOHvxJxbUDfBLtWX2DqhzSp
 lCplY3TZkoAZm92Vpp4NtV+uhOZ+hoR41c6707gmTiO7+PkL9OBuWFJ2NfcwV9zCwtk/AJDCo
 Gn+NychNfUR6pocE/JdEhmfxFiDfdKBT/Nv8GAD1VuZF4AT+osKqx0v4L4nKEW/Hc0tlWSXrZ
 1wn9w6Zg0KNOTK/HzQF+ND7V61h4gnpRTUISsNK6a/NG4g0Es50R2HKytf9HJTPqTkwuZyP/A
 wmxpbpL5e51KqOyiBXADDNNko0nYbNXNsvKKACHIZAQwFuMyyQbfvZNshzsJIb08+R2HcDBUT
 KamK09STJPojobdHVZj/TiuI4dfO7xkFyMA4Of7gWmoNPUs6kinyes6VKRwzdjlRkeQpzZjPA
 WqCk3y5gHEiw+1oDSLmRS48T4GbZCzPktxL7ngTkY+/fEeOyHEwoWH0q+ZbxT4Hlefnd2mlQo
 CbjzPBRlw+X296gvNZbWsvg5pl8b5m8HHNSazSOzRGBD/o7KjT5WQypDd5XVq7a1z6kYVPnuk
 3QDdJWfDrrB+8O+3Z/c/nWlDm1RecJC+ZdvlcsTx3W9bOOxBKOlqfHzMTi3CUice8HIJAjR70
 YOSGQCQ2rGgDlI4NZJO3i4N/3A8FpUsI8fcLAwDyvJLAUFSno2jLSGBJDGWBd2VWW90vP+epf
 L5XOi2T/ytTyQlZAgEFmV5YVX6emu7ZcNBvUxDNGZ1pIYzHFxNb0xfZZl5i91G8IzSqZScSeJ
 RKfV4v7HRkeKXCgRqkoMRFWdaBOZapVE9wPnWnDV+jyUBpa5X7/q0mJtxZjK/wbXBNZmd0Cvp
 MP3aqF9YP5NfniarsA/XbQlvg3mvzhwjMNBk1tLFMRYItZob4k3z4u4F9UDXzxln3Fy0Rf658
 P1AZl07fo2LdHHTwFxnBgP1GF9pN4vIB6sGSD+xHFiUFmFhzPTRKcnKcvWXr2q8vjLojXMJfK
 iCVi8dAKbvtkhst/nbqm+WIhEvjO6HFK1KwC+XSSowJZkeO4Sz1iPhMnn7lRLFEUa73B3Rqvu
 5rP2aXhBvK/0ZHTFnD5sK3do1ppyV874ashM5NWOJmnm2CDPEvtaHmMoL0z4q/aT/jqM5nWwC
 rwnhuEXbMTJKZhUt9vpHfDod8xDQdM7E9SeCyhFwlkR2vm/SBiZMcuIygMtxOdT/Y2yq1XDcP
 YwaohtS+pGyZ29qhFlGrKVIMjSnnbyQkNTryZbdCoIm8w8qQR3oS97Z2Yhoy8R2Hupk26MKRC
 i6FeCkTXU6+YpYXPINtYT1tR4kKY8ibFCCtvAe1kkBqWfxYuaHg0FPhgwM7mohZ6C3ULMP82E
 +6jcFzFWg1vUeE1V09l8jwwI2DUFDLYQZGBSd9hpAggPR4qDGGraztno7gP/0e0+PRHa+o+bY
 wXSsNGYDUBxcN0lfCzJmbBqAexl/rKBrrSiMvlzDRDzp//2Tec2nczT5zroVNN08/Me4fWVHo
 n8gHlidjt/UcNkgGf5dygbICG7p+gxwZikxUz3QRPHjQTCAUGP5CfspCzyDFCPcmyDX8PB/T+
 JTo9krm+mGMt7zw145kS2j08TyuwTWuc0Lvrs2fS1fLT1wGWNucnVvhsYfiOTvhC2r2/x7nQm
 84FcVT3fBKTTT6OKrAjczN9wW0sPdCLF68VGNF7rk+jU/2CSnGvNlh9kNlP31t4RXTqtDD3Rw
 Dq0fTOycdXmZ0s945g8z+or8ncymM62MzVhVKSwcWBiDpeJxTGuPbT0Hox+6rp5Gj5w8WQfH+
 M7O297HhX6EuxEGojHiaaYSo9zJ5y9wNw8zuSZLjDU5K+m91kmDGY+V62tqsRoUVZtZq4Gby/
 JIsR2iUk+oEL6ShociET3+/yo6ur4E0N6KUhPZoh1W9aicFwfvPeF0J0xYT9yuWVBIqi05TE3
 QhxTqzxj5SfH68HLFD+9D5qVRsAOvgbDiAaDq4zNRlwc/ildFO6N2v/aYhb3sJ03k+MFbc5Qa
 ooDQrOhej7H73vv0eqOMVMZ30jPyn6HrW8q1lqXw4d6+GDFrPwJOnjmoz8DEdspoLG5LaYGcH
 GtPWpKb8cyhAThnNMFR2Ejof4vnCUlKL5Wa/qeB9i0zr/C1+gDowsX6pRXpSNS36R3T/UaVXU
 9HgX7saYcQ8Ne/lpvCC7B741pfGpnfd6/Inu0IAeeU800ywOkt9G1KcL5NdfFaFCb4Qltqi1z
 d52P576YmXZoVdqt/OvHXIJprvlAM4lQGSuhSV8QNmUETfk8SCiJqHRwBhKHj2ONyshPdNgEi
 ibr0NYv1YoIr3rWn9Y+8mykfFrrwFUBzYw+wj0zRxcbzw/oypdraC7jNRBFQSILIcxt6mttJl
 8CAW8LFvE40QjCJdTxFORvSrvaOXxGJAzU/9uX67YNtqSwtTHAxaTM2dLZAsiZNhQBv2fly/2
 NMfwx3IsV67oiKDAeoSHGRCb5dwqD52zbV4k3NlyZZpvanj7ZTQG9XXEUgCEiFv7JRsRzgpqV
 IMbLCIrr/84+7AZKQFqNZUfa7yx4L9x/fxZCjWoVanphhmsbQsf/8rFqhK0ord3hVxMOnMDCy
 CJzsUuq4rH5vnLd039IcO0V3tdAsfYJXQ8bIYS5OKUzGH9nOFg5/nZVnI0LPOra1KiK8cZLwD
 6G1gJzYZ31d/rzHc3PYpNovFVTTX+/TwJCfjkonEcn81e3VJ/RN3x6Eh5CHfmgpoKivZKSq44
 XzGcggryyj9vxwccUgzes4o+Cikj9F67whf9gTgzZS+nBeqMr3jX9PayAqqaqq3wAlKlteCzn
 IifJsxTiOoC3ktD5bHJdWJriwHbH0/2mIBjpBKp3WeUxqxZco4w4Nnoq9mqEtgILfXXI8wUcM
 SdPDyhBRfzn8XF+wNAZ+fpaFkzZ6Um9TvSNqVuRAoNtWTeXQrl3p4d9ZFaoy+CTZu3FBn72sf
 NH15yot28FthWufpeQC92+TnAO8rOB8R4efyA4auXFSp5iPzGzK+oxJ6nhLDLlJMhpzRFOgbs
 E0OriP4RJ6upQoh08lg43L7lNCc43PtCmN0fNNmw0DFZQ5Gy8/7GqitHqAzAmV5gUshgSjJC3
 4SH/z3b1T6RAO5ifJvGbF9gMNPEgLFNgciKY+RxmdOe4viS0hh6/1BcTIepSPGloKPxT7iTUH
 PgvaOcr70tXBJyf333rjM4Lyw372Lb43lmrXgzTOXZ+Nm0FUh2KmLcuTaUfs2GrXmv8o3vury
 WB8QeWjQSDvbDqAUyLSvQONe2+j1ydHPDn0633oXJkUOl/SoAF4fhwVqUnHJqCUf/VX2Gv3O1
 Xrwr7PaWaXbaTyCLDuqvHqma65T80SbJGxCvEzWGEpmoKw4taujl4UqeeFWOl5wdv7rT31ahi
 N/EFel/p3Ema3qioauISEIlEq8b0vK0cpbuuC+meQfgH4hcibt1yx2C2CSIwnDjmAx7e1eZr6
 eDk7hytM5/b9YZHaowEjPgHxpM7tn8TFNFDbrFHus8b/+mqUfjdp2Drnli7p+vqm4Y5sqP1VC
 aSgmA/fDrRELhYdewr1q2b8n8cUOPs0tg7rpiB+vKSMA7LsNLpuGE0QncSIgtZKlnIn68TwAC
 L+FDhJeCM9rNyR6isQ1Cv/ucG8ksmGGQzw/ZwL0ygUvCy0WFrKgx0aQ9Jv/ss0Nsy+xpXqeLo
 MOnCokqoRH/aPtGxpgcWYIApxoS/hvh75pkPwdr1/n53tEwfAy+m1ntwL8nJfsz/Fpbya9bP7
 md+4qsFlPSAvaXB/dS9F/Ov2kPaCwipBW3DwI3XMIYS1a2T0BhKTOP7Nx+2/1VNGHs6KwAzau
 initEaN8NdmvvoftNrjmGETz8q2o6XZjWX7+L8+s0h6Kj7RhJrZ6ToiARzJkaMxggkGfb8RIv
 mTd9gGwslLNpHzsIzXxkQK72LwOkQuUsJhHztodGIw0rXZ6PGWqZFqFY/1Z5WdigHPvb0HfaI
 UEHfvPZU+r0TvLfnj0E3Jy1Ey2KErAjyl7OCHtAKddIe/tHsxB65cu7hhw7xgxoqyArUL3rzK
 +XfIZVs8vjTHMPeoswv1BoW1R0JkhiWgi6VBHFSYFj3r93sTpA2Gp5EppFbbwZpbicInxeVt8
 PXIT0s77FSEVfr4hDBriwfdEQ32ZBIW5VgkuhRLEX0rkoCYnkGgPGx8BOe1sSznxV81qQpL92
 inwJtj1v77P44W3VJgyVgHSPUd6yFXY5aWan39ce3ij6ELheUdJuyWVV6Jpk0Jn9k8DQMFQdS
 MeI10ViUxNEjeo/wYzmwiR3HD5kcb/GGBGM1R6o8lP8X6UTa+ZKePB4PzaxU+Cbo6eGtj0pK2
 AUExYxXGUcCSL/tz8HfvH2mf5PTXMTQ62ZEHKrR0bviWRCmgtuafE/K6QzuuWa0VNucfTK1P1
 c9Ir+YvFpjt9mahoxlqqx1L5pw+5jzpv3O/K25iSz2b+mFqJMjWSsI04eNhQY9jQvDKHSb6N6
 /nAxpzKykTF1nRt27tzA3pM6o+L5yhB3Ao5XI1+Gn+9BN8j989TTtOWwka2Z7L6PEyjlZyTEt
 oGzd7niEJUvMKN4Rqmt1VmzDUXSs54XEBDW1ftAtu/cbFHxIbnFTvRBbyaJ37bI6ytCthvay6
 NPxnKaqqSpCLYVdS8g2tP2R358ukMWNc623j01cxjVN7WQpQJwjhDxvoLbgA10pDYPwh9IrKN
 M3BwjgDke18rmEK2XFqyJSkM0+GKuRN55mbSGm0mN9PmmFbsnOb4GY27vvh7pdHYvaEFmfe4y
 Ws1WnVXYY6IIoM0PT805ctR3WcpTDToW1ZK4G/WZX0osdEufpdGMZNs7FyPOkmx6xKJqIPzdD
 oNiQ8kXFVSOA+J4V2HNw4K6NxJ6boLW2YK1OqYYzeDbNmvtF+poEgxioFUYziuy6mLxE3zecZ
 lvHsoESr7uHSI2naRQiUqp/NLQqTgs0jr83VGTGLMC4LXXCcOYLUHBVwkHcSJLBtR8TO7g6gE
 dVBVe6GMwltfb5WVR+QzFcO22GgP56T+QCVnJs+qczH43f6dDYWtUhERtcxWor6pnnqAMJwaO
 o1qjZvgBwW/x3Vpm8mznYFwn/5x6Foj/i8O7HPRctSj+VKGXQchffyrsB9sTTARGqHBYTd8Fn
 nlJpr+uJNuNv18nYhJjhaB4/5bOlSi3ggQvZuoystR7OpCbIlyMWnyG0DdceoBaPALI6KOMBy
 inZOFsFhHCGS6LO4sFdVvUUm4f1+xGVq6vR6mFm86Lg9GSZ/ZaKNuVdM9XLsQVl/FWG/+Didu
 6qlAcN8WfTilEiZTd9ZqkOisgQ1ETRapB9llEFBWT9rExXpDdOSFQ3GH7WneNe1wRlx20PoZH
 r8GGYBDteOuktYJlvzYYicc0NEjbU2NMa55LllxonbqQRdC/ijFnHZBTMYLqOyFqXAxfJBvBG
 FP3hk9IDxPvNnKg==

Add the vendor/product ID (0x37ad, 0x0600) to usb_device_id table
for Realtek 8761BUV.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  4 Spd=3D12   M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D37ad ProdID=3D0600 Rev=3D 2.00
S:  Manufacturer=3D
S:  Product=3DTP-Link Bluetooth USB Adapter
S:  SerialNumber=3DACA7F14FD2A5
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

Signed-off-by: Nils Helmig <nils.helmig@web.de>
=2D--
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572091e601f9..2570ebc6ad9c 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -840,6 +840,8 @@ static const struct usb_device_id quirks_table[] =3D {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2b89, 0x6275), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
=20
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.54.0

