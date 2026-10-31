Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483808;
	b=i3cBXAZ4fHwOX8Vrrljr/DCBwKPAq7awWABNmWjGaOB2bP52r4a/N0n/FJv/PKnOWAEd
	 JldhzFWOKgHPIKIqnvJHoxMxggJ6X6gg92+bwVhIrF9ei8uD/pohhMVu7S/G53dxgu6Zc
	 FXq8yBNFsHtVmtMIZ5ZGPWT7DuNJnbR8+DD9GyxJKgNGnc8u9+JAC/cmS4KyAyeF1iGjb
	 v3ZaJyV55oYGyrObQxRVWrtMGI91uOb5Wrx6AAWBr0asZ+Vx/7xCKP5oZxttBi7jyo5Mt
	 5DFm+dSr/RILDy8enSKGJoIqXRJFjyMt2uq99oFNpE0OM295Nwqm1cdxH9QMr5jE1wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Subject:Content-Language:From:Content-Type:
	 Content-Transfer-Encoding;
	bh=/k/27a+eA6E4M8COfCv3EKw6ttTCXgcbMNRNrtjaddE=;
	b=JBbZe8iw25a367CMeeOTQNGH8/3EtfjZz9ZJ8HEcXK6A3Mw9UGTbO1mjsXdUe10s330s
	 3qbUdwZ0KXxqJQKZYYmIo3ff9MS9z9erIkqiQpzRNHvezfyziUCkhQjTCnvG7ucUrYo8k
	 yR1QiIFzVmoHaVB655W0az60vEJmuWWV/kM3XzeIlKCT4ZoLQOaQqIrPqLcsoV92AYVpI
	 r/NMFvUJEkQVIaIoxIiOW4XQekLNTJ0IErQwoNhM0/u95sG1SA+dj8zkaj6YJJW98Ru68
	 lWvszSCp5uSiwfTmTx9nHweXDGvNo3vESxIuOiPk4D/cQ4MKkej55YZexL3N9Ap0oVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uL5fl7xJ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44915606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 21:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44915606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uL5fl7xJ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso17907925e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483807; x=1794088607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/k/27a+eA6E4M8COfCv3EKw6ttTCXgcbMNRNrtjaddE=;
        b=uL5fl7xJLhU4eOSaqxhN2WMiOHYr4GlVQMia/s19y+C1kRGyjuwBYuS/LT8VvbV0MR
         IQwPyAulwRkaxm0faNmAva1ItiKSUD8BA4ao0sTrYpZHEEfo6rqPcBCGmdCWyiraf/dI
         egUitEcScFnGapNjnasrSIz3DP8GqPXnh5uAYiuVrVY8Zq/kamZ0yAkZzLzD1CpMP6iL
         zb/kllD7K/a0h8KRBR59FRhbHktS74iSMM+kcGTGbDi5Dlf7c4QJ2qdHMrHKdWP/XmLF
         UUttKaQXwxfeg28N+GZE1bivc8GALIHIApPm3qaePyzvB0GrZbOA23g1aupkl+4ViWpF
         uOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483807; x=1794088607;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/k/27a+eA6E4M8COfCv3EKw6ttTCXgcbMNRNrtjaddE=;
        b=qaN7bVi1aOSGPbX9FveBjCLqNSrpRSN/AnfxrkFPC4QYmRJreK9h8i+xXbetGzGWP9
         cKQ0ah5oZIPuBwJhIxc1WAdxsHVveX8TNSZLv4zGlzC1gnUxadb+XEYOG+h8a8eoUKyE
         /jufmmUQOOB+PYPXtMVr793BMKMgLthWGQfjWUoCnfsdym+YmOpr206P0nS38pM7nGDg
         jr9SvqGgODxtCF9VUUo6uQdsze8hvtXyeQAGggL/o6EXSE6YzYdWJtmH9qOBCAeycvmE
         QXqvoZs8sDZM4t+L2D85lisl5T+x7xtv4FxJ3DCjpHJq9yarRIy9oarO54iD/Umuv8o8
         BwUA==
X-Gm-Message-State: AFq9FYI6VxTFvydDcLekhMaxGiCtoFr5REbihNxaXPE8BNtup4I4Ebhe
	5L7JHR3ZGtXM534ubA5glPRfKR1gB+zfHseWLa3yT6uCvpTiHafCP9V2fMc9RF9G
X-Gm-Gg: AYBFou1eKuEGg3ld0zxA6FrhL5Sg9R0uwDNCvInWjJBtUg/7o0OjKX7ut2H6lXWo2Cu
	OlPBicQZF7/DiyVIn1u7W+259gyXXtGJNSTVq7zXYix1AOwvgqFf1DK/LIJ4CZS5PsLKD8qBRCl
	jZWkx8qvMZlSdnv6pn0rj/qNKG+NRMwiYrN3k9yOqKrMi31EUpFFUliw1RZVCZ6x3IbqJQ6vaHp
	3dnOtLxpwxSkTBRu3T2vls+JSmfvQnxFtzhbA1nh1WDtHKTD8fujqqwQ+7rys3GPaivV7K2AzHu
	9UqXBdEtkp8GnpI3TMvwmzDY/rVfzjx3MC2/D8SkOd7ZfI6cHQ9NOth7RVnmCiPa2rA35FTerab
	njby5WVSu/TipFSVylWdQcSBCqQvd4MXACrThwM1WS3hsW3DhooNJ3IVa3qyTanV/wwxmCx3yk/
	1oBZSKj7fxtXRIBHi0wooqn/PBHZkUUiiY2nsTF869LCUBnZf374BmlV/Pb6bZ3S3cIACowB9HQ
	uSrGri8IOjyHKZlvailL/SuQODWp2VTNHetPKaHJmllzrLTpqYDt1zC8Ux1UeVYL31hykxI9JgT
	wfQEDSkH6iBfAEMaCEoqvPsfR/NQV1I6NgqXfQig3Jp404w+eCEqOdyvUdz4nCWizipNijWjnC2
	OD0AALQGWZj9O/dOB8PO2tIow2xODvYbAKfIDIH7hS3YKKiLkRi2LP/Sg2A==
X-Received: by 2002:a05:6000:178c:b0:487:b50:101c with SMTP id ffacd0b85a97d-48e6e2bc04cmr14420591f8f.5.1793483806659;
        Sat, 31 Oct 2026 14:56:46 -0700 (PDT)
Received: from [192.168.178.190] (vodsl-10406.vo.lu. [85.93.207.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm11312022f8f.52.2026.10.31.14.56.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 14:56:45 -0700 (PDT)
Message-ID: <6a48a5bd-7a0d-414e-8cde-048b60e46f13@gmail.com>
Date: Sat, 31 Oct 2026 22:56:43 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_MT7925_=280e8d=3A0717=29=3A_HFP_microphone_unusable?=
 =?UTF-8?Q?_=E2=80=94_firmware_delivers_zero-filled_=28e=29SCO_frames_on_sen?=
 =?UTF-8?Q?tinel_handle_0x0E00?=
Content-Language: en-US
From: Mo <dabiggmoe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Independent reproduction of this report on different hardware, a different
headset and newer firmware.

Hardware:  Framework Desktop (AMD Ryzen AI Max 300), BIOS 03.06
            MediaTek MT7925 (RZ717), BT on USB 0e8d:0717
Firmware:  BT_RAM_CODE_MT7925_1_1_hdr.bin build 20260813113236
            (linux-firmware 20261019, newer than the builds tested above)
Kernel:    7.3.0-5-cachyos
Userspace: BlueZ 5.87, PipeWire 1.6.11, WirePlumber 0.5.19
Headset:   Sony WH-1000XM4 (HFP, native backend)

Symptoms match: A2DP is fine; in HFP the microphone stops delivering audio
while the SCO link stays up. The kernel logs the same signatures:

   Bluetooth: hci0: corrupted SCO packet
   Bluetooth: hci0: SCO packet for unknown connection handle 3584

(32 "corrupted SCO packet" and 18 "handle 3584" lines in the current boot.)

Observations that may help:

- Codec-independent here. It fails with mSBC (Transparent) and also after
   pinning CVSD (headset-head-unit-cvsd): the CVSD session failed about two
   minutes after a fresh reconnect, with "corrupted SCO packet" x3 
followed by
   "handle 3584" at the moment the capture went silent. So removing 
mSBC, the
   workaround that helps MT7921 users in bluez#2545, does not avoid it 
on this
   MT7925.

- Two failure shapes seen at capture level (pw-record on the BT source):
   1. Pure zeros (max amplitude 0.000000) for roughly 8-22 s after a
      "corrupted SCO packet", then audio recovered without any reconnect.
   2. A persistent state where speech arrives about 35 dB too low (peaks
      around -45 dBFS vs about -18 dBFS when healthy). No userspace errors
      are logged; a profile switch (mSBC -> CVSD) does not clear it, only a
      full ACL disconnect/connect does.

- Not the headset or userspace: a USB headset on the same machine and the
   same PipeWire/Steam setup works, and the WH-1000XM4 mic is fine on other
   hosts.

I can run a btmon capture of a failing session, test patches against
bluetooth-next or mainline, or try other firmware builds if that helps.

Is anyone from MediaTek looking at the 0x0E00 SCO frames?

Thanks,
Mo
