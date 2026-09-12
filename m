Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C337F730
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789253466; cv=pass; b=U7jn2BneJHBadRYH7aafT9Xhp4qDpzcRoTgzdKzFouk25wyPjna8V+1+KQBkIs/zq9B/XPe0plbKUj5bxJ2xdAwAZUyqbLqhmqjH2c76R1Z7dpuThWC5vEkgEMpus+iZdaaydTmbtYv3fRwwluIdR84hguCIqyi1FTf23kaay1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789253466; c=relaxed/simple;
	bh=/CxV+x4ulpk1H1CWbvlCXU5mYoBmsyKociFQWLIBwNI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BubmMqzo0bZuIA5ayInTHX6n9W2bUBicCwinXyIPqqob+zhZs0CtfRmWT7N79Dc9bzFPKq49XZj+FLqBSp/mfwQncyLOmvxBWv0Mml6ihUGC/hN9d248dkEz/ApYz79x017lrYXOSpFi3aZw4MMCNLy7u8sHjAHXRQk3PJUYL/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1ItHe1q; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1ItHe1q"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2946dc8dbfso297634066b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 15:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789253462; cv=none;
        d=google.com; s=arc-20260327;
        b=sEEE9GSt+3j9fU3gfst6U5lh11tbxniFzhQSPWmlbilN2cZrkVAFlBa01N/JU8W862
         sMaUq2IAIGc6vfz/TF7/hXRsKIz/yZMm6oYXY/p7LFQX4dS05TTfxGyXhzeKod+zSSpy
         jw+YVC7p7D4HHA4OH5wDvT4zIUPKqp9JrzJrIZUjRON7VQCAqNxTWq75HXqwb42VHRWs
         enqLs+zwWhzxzsez9nRIKR1uIWj1SfFRkzy1pOrCCZE4iLnigMg2qa7GclM4i1xbcitR
         qbJILEh+4s4iwwMf9riUGapDl+ODXZwphrCs4rfzlSC0lpZj7URzRIiO4wCi8BSa6HLN
         nDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9GGMQLtF5QtOTx8VSTHl11V0ZNnZHtqpbzthTlu2ZSU=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=FWlG5mza3e7w7XFcFp6Kg9GL13npVvI59kyc24W3H/MUEtilRVzzB5/GYbiaAR+Ox/
         g7xxZWBonEFdu/1YMidjthwR5MX1KzPY0iNaCSYAXBZpEnZ24UExFXmNjs+ZAbEnWBIT
         hcxKUf3V53SRC69ez46zhLRQnTd0FNCh/0hG9U24IKdWmbjysvjeY4gyOaIbaodtdXb7
         6nbDRuzCYxJAgqCc3OQJMCKeessDfxJ0c4H3qosOHoVZlaY/0/8C8h52YFRqRM61q09f
         JbKVnXuMoxscabmxvSuwUS/FCLmnCJb93+cA7N7OL2V5EHG4DBYHWOSg73AEhZ5WuL17
         10tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789253462; x=1789858262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GGMQLtF5QtOTx8VSTHl11V0ZNnZHtqpbzthTlu2ZSU=;
        b=E1ItHe1q/fbLwQCbDOUav6qnH5U3NSH2fsgiLwHkFTl9hVWJr2R49QGBA/7oiFE25X
         gemM+YZKSo9m/4g2vrP1Wqwvd4P0D81unc3tXpnX9/Z9Anu8Bp1E7UjYQSneDaKr0vqf
         wniV/RgyfC2LpPWrTPYqTT+uyZ7xnlDJNlw87+NLPVpXSfNiQiUkJyyTznSDWELK8VkO
         RnV+m++kGK/GADdKtBU395H3CCeLhoQ86n6sM3jw0mAOR4ce0a5/xesQDSd/VAPFx6l1
         OrTb92zw28EqOwshNvFKfnMHEp5SfWqVtyrNHqnQ0TPvYUreOAY6OZkR+gjoHSuGE8e+
         XARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789253462; x=1789858262;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9GGMQLtF5QtOTx8VSTHl11V0ZNnZHtqpbzthTlu2ZSU=;
        b=AoNKqGgnMEz5oTDP6PhnFzJCk/rN74GJMu8fpMIKwSQM3dSnuqJDrpldhdo0gZDtyW
         N8/5ec0R0wfZfV3kqX+fRm+sIsfgLrjBYzfAT7K1pXgoVIMhvP7nWLKLLrDNqtxBCtQK
         PNMnG05MsH0WThsXhieWVdPc5sqdQD2zLVm5lW+aArXVpQH9J4WW0ksr//AFsPOVbUHY
         hc4a4QtKG2giKfKbino3a0YOYPiJqE7dxozu5moTqxNdpvCArhrtPIPVOQjzjXD9PqXY
         UVUDCSh/yDuW3Qn7FPAANQm6qE/IVKmDWMGQwqQOY+O6D+aKzfltooXUn1Y1OudOECbe
         qX4w==
X-Gm-Message-State: AFuF++l0tA3gROWUpnklAtJHCdJlBb+I+JwNgxDes+zM4HLemWg8B1zS
	/SkZebsD+wBynKUTjEP9Lr5ETkDIZH2tLp0Yvukgd9BFwRf92O8g+1GZZkn0sbkWMM0QhUy9X0Q
	F+2ltjS10blPZoi4McL59UWPjw3oam1umVfNMg/XC9Q==
X-Gm-Gg: AYBFou0wiZDMIybBST2TXEKsmg/3gfsojLCtgGL6IsQhNrGd5+qGL03YmzKWB6z80yN
	O4OTZYorXzETryi0zkqlcibWeIbh6hB9t7Km0W+wv0zKBqUx9K4GWHPhlcYpWMdxGhz8k1ERSF/
	n+6+rbnlcR7kNDjXMsfkD7Io7APHo6q4zxwiSh/zQR/V1Yg+vFFiL1/HhpXloDJKf0pXo08JcRy
	fvDyO8RnmJQN9ovSpeK6kyXDpQQ+bxPvjid0QiM81cJLcI9TiIf15Ndj2X84NPJ877rmsX2bQ28
	U+1MAFKO//14iu4p6WTPUMxgGYMR/kqrSCwwccGGtgUc4raNx7Ld5fY=
X-Received: by 2002:a17:907:c28:b0:c26:19de:9ae1 with SMTP id
 a640c23a62f3a-c29666c0054mr598255966b.32.1789253462393; Sat, 12 Sep 2026
 15:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JLQvtGA0L7QvdC+0LI=?= <alex0plays007@gmail.com>
Date: Sun, 13 Sep 2026 01:50:50 +0300
X-Gm-Features: AcwNN1Wr8iuIjgEvz_W6G-D1INOF2snoJZLK1KERtgt4giIu5c62bI9zQCmQ43s
Message-ID: <CADv=UDfoE-YNrqmtCNee49eh0_yE7NQtNNCEYWx5MW7W_ziGrA@mail.gmail.com>
Subject: Bluetooth: SCO packet for unknown connection handle on repeated HFP
 voice joins (Realtek 8761BU, mSBC eSCO)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Reporting an SCO connection-lifetime race on repeated hands-free voice
sessions. First voice join after a clean state works; every subsequent
join fails the same way, which matches the pattern of a pending SCO
object being deleted before the controller completes setup.

Hardware/software (all verified, stock, no local kernel mods):
- OS: CachyOS Linux, kernel 7.2.4-3-cachyos (SMP PREEMPT_DYNAMIC)
- bluez 5.87, pipewire 1.6.8, wireplumber 0.5.17
- Adapter: Realtek 0bda:8771 USB (btusb/btrtl)
- Headset: soundcore Space One (A3035), fw 06.94, single connection
  (no multipoint), HFP codec mSBC
- bluetooth kernel module stock (on-disk srcversion =3D=3D running),
  disable_esco=3DN
- USB autosuspend disabled (verified) =E2=80=94 issue persists without it

Pattern:
- 1st join: single teardown burst in logs, then silence + working
  two-way audio.
- 2nd+ joins: transport Acquire/Start failures in a loop every
  ~5-20s, mic present but silent, card profile ends at "off",
  then auto-reverts to A2DP.
- Manually pre-setting the headset profile before joining works 100%
  (no mid-join switch =E2=86=92 no race). Full BT reconnect also restores
  normal behavior temporarily.

Kernel log (journalctl -k):
  Bluetooth: hci0: SCO packet for unknown connection handle 2 (x2)
  Bluetooth: hci0: SCO packet for unknown connection handle 3
  Bluetooth: hci0: SCO packet for unknown connection handle 6
  Bluetooth: hci0: SCO packet for unknown connection handle 9
  Bluetooth: hci0: SCO packet for unknown connection handle 10

PipeWire loop during a failed join:
  spa.bluez5: Failure in Bluetooth audio transport .../sep3/fd0
  spa.bluez5: Failure in Bluetooth audio transport .../fd51
  pw.node: (bluez_input....) suspended -> error (Start error: I/O)
  (node incarnations climb continuously)

HCI capture (btmon, 35s window of one failed join):
- +CIEV: 2,1 =E2=86=92 Setup Synchronous Connection =E2=86=92 Command Statu=
s:
  Success =E2=86=92 Synchronous Connect Complete =E2=80=94 eSCO comes up cl=
eanly
- ~3300 bidirectional eSCO packets flow, application hears silence
- at ~26.9s the host tears it down (HCI Disconnect, Complete:
  Terminated By Local Host) and A2DP bulk traffic resumes

Full diagnose.sh output (redacted):
https://gist.github.com/ShredRum/f59bdd2296c44916930967e0e4633e0f
Full 2 MB .snoop available on request (too large for the list).

This was also documented with full timelines at:
https://github.com/Mr-V1be/linux-bluetooth-headset-mic-fix/issues/2

Two questions:
1. Are abd93c85c866 ("give the socket its own sco_conn reference")
   and 8a5b0135d4a5 ("fix races in sco_sock_connect()") expected to
   cover this path in 7.2.x? The race reproduces on 7.2.4.
2. Is there anything specific (btmon filters, debug flags, test
   patches) you would like captured next? Happy to test.

Thanks,
Aleksey
