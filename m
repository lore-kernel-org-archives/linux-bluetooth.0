Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794969246;
	b=bOGFWviDKBjW4YF+XZGDVEad0CvOLFSclfyEtQmjZPC2iz3VgLGICRA+q4RODs4G8pFW
	 WHkhMq1mCtyVwaT12vbsIo0Io/+N38sliFCDvTFVrxXB2JW8PFbYQ+h+R+2vLWwf4srxc
	 uMCgN7MmmxLx5Fy+6tq/So7oMYxJI/HSZNtKL8Xar6R32Hg89Bv/A56rkNlkhUfJe8WBI
	 Cvla2Q8TGzW2o8PGhgrqalFSSrDHF/yMocHez+it2QI3sdaBE8Ys8kP0sI+mI2QschHn0
	 xm73J5axVoAGvn8LPB/Qgb54arTppSseq5Cy0kQnkRGGCArecjHyLc433L6H9anSjLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vfERvSbLKQVx2/pRS1U49cTa/EfH2SnyGAp5xqkhniI=;
	b=JRtGzyawH3GSAnBxVmMFP/bd361XLYwddsRYI58SITId4doEUYHf9yzzQiH891JWClUH
	 qEz22aRj8KOL6xExoW5NqcvHuLXKOc04RJYHD706zNvYkZz3Q72MedkmA1P13/fXZutYW
	 tfCEFoUsI3GU7RBoQ2DpvwCLeaQASp5//hQiWDzcy6pm15gmXllcMRVBJ5q2FVbfXP89s
	 977PdVmoLbm7Wwha9F0zD4X5u8dDy3Xa555112bjyjF99lJgkahGvIjJY6Sxkvxeh8gAk
	 wGTiMcFS02a4BAGxxgIteax9J1zxiWVS3doXql19VCUlfyvCBidOHsK9h5JVNO9FHow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gac3E7di;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00862606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00862606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gac3E7di
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3818b9f0083so270636eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:34:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794969245; cv=none;
        d=google.com; s=arc-20260327;
        b=PkhDAOWnRLgTU4mlmm+RlWXLspzNRcH+YJOaHVPs+OAhoZJgsMUMoXGisKwncBGxuD
         QjvMpMpeMrx672hDn8tJ+NTCaaz77whuk+902EqT+nkiTGiQzHRgNbZFRbopBSDkF3cB
         Ci3c6Auk8Vd+ePKj1DDm8E4tDQP9J05esN8lMe9XJ8lgtgfR2OWkAGsH5OK2XbuW3zT2
         a9WKJf1km2bLcLwUVPzFO1moxyb8/w2BgU20wn787xKslJ94Znreg4klkT7JVMc//zb2
         E/m5pWT0ikDbEqO/K0Jiov4X1/Czhj9gmr6Z5PHMqJYDKGGXOlbXJB3FJCdeNsK11DZQ
         Mmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vfERvSbLKQVx2/pRS1U49cTa/EfH2SnyGAp5xqkhniI=;
        fh=+kT/Xrv19FyZSJDN+clPnX0NaPUgFHxaD+n+mwaMUws=;
        b=oxMelldXwOngbpZ6GQSa0fOnmD1bLj5flckAr/wwrWaMkalQyvnGjjrxrqzDlLkMIy
         FnlirXnY2tHmmEFbpL4Ka6t5L4IQyVQf1D0jrSN/wZEaizmst5t7JdzCMoBFmVJwfDVA
         zqVTRRKPSLl4DZ2lhxYMxoAttLHZiJ3bWBCA/kAcF36gRzuEqLbfcrhmKGkjE573UbDi
         4JofsQVydPpUXnmS0zePKUWsfIqtJDAXjP594FAfiCb+pcgKMxznT1IpotBsTTxkW3t8
         AkaiTzzEFsvUOLk/s08xR4QI0IfbHNTTGFJn+RLJh6R1QS0RyULAKr6iQeZy8ukfh3DV
         F/pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794969245; x=1795574045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfERvSbLKQVx2/pRS1U49cTa/EfH2SnyGAp5xqkhniI=;
        b=gac3E7diDhI77CxrnWcaVxp7A7V8hA9gpeDzoYEZ0mJicCqSfy434UiqYwr6OYe9aa
         6B1Ku+sBIR94H9U1Rd5+OOIdCBBXMvSOkvMQa7AmsPX6gdIvOW/gv/+4ea3A1ImuMetf
         FYBuFTwMW4SP1vGUp3xBt7r9zmZN71XQ4UxaJccPomuWW3+6Bj6YiH+v4Pl6q3wZG28G
         ZCzRX3r8xLVfBJ9Fz4GEuv7Il08oCIhLAtd4zjoI1C+xsWafy7VL0422ov0h2mZtUnzV
         h8UAwojKNui9gVJCCbQCSnJazMYyVgloTMHbs6PZ2J1m5vIy2yvZ78a/UqiM1ylaSU8b
         1Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794969245; x=1795574045;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vfERvSbLKQVx2/pRS1U49cTa/EfH2SnyGAp5xqkhniI=;
        b=n+Wzi46csFrAnw868AFuxptsc9fU9RLjPSwV4YjMgASX37pd6Xg+j2FT5oszAPcqrh
         bOH5wjJEi/Y1xPknBL4JTZ3liD66TldS41a49VYogICGjTZLqsnH7uAWGlexoQTvj21m
         Q4CwtbyeVVaLIBLkTeTkWbvNekafm7sYxK9AomJMwnHwbIhtbYSmzfhvf5La6ck17MEf
         rC/SY8ietfuLFIUGMKjMePn2hdFFAcBFyQKEwVLVtZhFVph+P7Zx6rZk9AHiqZDvuyot
         pp7xEzOTj0ucLQQiUOEEKKERk+ZOsoXzZ5qvAwVvDr2F1WHr2FBi5d1ipMmfF+RTAmTj
         F/Jg==
X-Gm-Message-State: APuU4Z/SXTIBmQenrvb72xP3w7POHPca2tbyqeGV2Fug5N8C/cOOF7Yt
	MLDoQpR0xUIfE/IoW1QVAYYrnwOZ7QvFl2BItEIxyCaPzGRwl7BofvW8sh+sP3U5nlP1hRtvlKZ
	rZ5KRebw3e5YlSbBZJCPAkNANHN1gWyMIZ6R10Qzgo9hKEcxFOw==
X-Gm-Gg: AYBFou2ljqQZpnrDSbToTBPCv8Gg1xatrYzsys7u96NbPYFuUE7HzZNnnKVy9qLGpWE
	0I/IXvs0Xdcp69ZXY0UfJIY6S/hCq8sFCwFc/NeqX6Rz3DjIJNSLjhaVA7T01jc8Ailh7QyWG/y
	jNy1vNKexQN4qQtVXJuDlvStY5/6dd9ghtnB/cXWbKUjKYioaFFjJ/3TIllOZb4RvpJ+U0e9EUa
	JVY+m6Oxim++WScQTMf31NAoEqRrmnP/bM5YC/bN5zHMBgvWNsndaYGv8nCTHKjsRTXS2FQDQtW
	ADUa+X5JgMIJxOS6Z7bvfeqNBTaLdTuALSO4QQ0FLdQ/kQmtfv5bzrKlEk//s0hUNsq7jemUljd
	ZCxt+rZzgJ1SHTW2XGms3yunpEgQuvi9zwQYiC09OskY7OyZ1GSkXfYCJmyFeEkFbbKYe+RaFPl
	74Fbx8ioT10g==
X-Received: by 2002:a05:7022:ea44:b0:1b2:3e9b:3dcd with SMTP id
 a92af1059eb24-1b543be9924mr1290293c88.10.1794969244871; Tue, 17 Nov 2026
 18:34:04 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Kelvin You <weyou.dev@gmail.com>
Date: Wed, 18 Nov 2026 10:33:53 +0800
X-Gm-Features: AclHuK8FXhROSfHW6A7v44ubXBT7WqwXtcReM8OlPtWd9atny8fMmkX3zCEXpBc
Message-ID: <CABqFBbCA+S_pcKmxqbQtjZOELudcBHK+=wTEngk5Kz5c08BPzQ@mail.gmail.com>
Subject: [BUG] Bluetooth: ISO: BIG creation with 1M PHY fails on 0x203e and
 leaks active ext adv handle
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I ran into two related issues when creating a broadcast ISO stream
(BTPROTO_ISO) with 1M PHY (BT_ISO_PHY_1M) on Linux 7.0.0-34-generic,
and checked that the same logic is still present in current upstream
net/bluetooth/hci_conn.c and net/bluetooth/hci_sync.c.

1. create_big_sync() triggers legacy advertising PDUs for 1M PHY

When setting up a BIG via BTPROTO_ISO with out.phys = BT_ISO_PHY_1M
(0x01), create_big_sync() in net/bluetooth/hci_conn.c only sets
MGMT_ADV_FLAG_SEC_2M when out.phys == BIT(1), leaving flags = 0 for 1M:

    if (qos->bcast.out.phys == BIT(1))
        flags |= MGMT_ADV_FLAG_SEC_2M;

That flags = 0 is passed into hci_start_per_adv_sync() ->
hci_start_ext_adv_sync() -> hci_setup_ext_adv_instance_sync().
Because (flags & MGMT_ADV_FLAG_SEC_MASK) is 0 and the advertising set
is non-connectable and non-scannable, hci_setup_ext_adv_instance_sync()
sets cp.evt_properties to LE_LEGACY_NONCONN_IND (0x0010).

The controller accepts LE Set Extended Advertising Parameters (0x2036)
with Properties=0x0010 and enables Handle 0x01 via LE Set Extended
Advertising Enable (0x2039), then rejects the immediately following
LE Set Periodic Advertising Parameters (0x203e) with Invalid HCI Command
Parameters (0x12), since periodic advertising is not allowed with
legacy advertising PDUs:

  < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
      Handle: 0x01
      Properties: 0x0010 (Use Legacy PDUs)
      Primary PHY: LE 1M (0x01)
      Secondary PHY: LE 1M (0x01)
      SID: 0x00
  > HCI Event: Command Complete (0x0e) - 0x2036: Success (0x00)
  < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039)
      Enable: 0x01, Handle: 0x01
  > HCI Event: Command Complete (0x0e) - 0x2039: Success (0x00)
  < HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e)
      Handle: 0x01, Min/Max interval: 10 msec (0x0008), Properties: 0x0000
  > HCI Event: Command Complete (0x0e) - 0x203e: Invalid HCI Command
Parameters (0x12)

dmesg logs:
  Bluetooth: hci0: Opcode 0x203e failed: -22
  Bluetooth: hci0: Unable to create BIG: -22

Using BT_ISO_PHY_2M on the same host and controller works as expected
because MGMT_ADV_FLAG_SEC_2M sets MGMT_ADV_FLAG_SEC_MASK and produces
Properties=0x0000 (extended non-connectable non-scannable).

2. hci_start_per_adv_sync() error path leaves ext adv handle enabled

After 0x203e fails above, hci_start_per_adv_sync() jumps to:

  fail:
      if (added)
          hci_remove_adv_instance(hdev, instance);

Since hci_start_ext_adv_sync() already ran hci_enable_ext_advertising_sync(),
removing the in-kernel adv_info without disabling the advertising set in
the controller leaves Handle 0x01 active. Any subsequent attempt to create
a BIG (including with BT_ISO_PHY_2M) then fails on 0x2036 with Command
Disallowed (0x0c):

  Bluetooth: hci0: Opcode 0x2036 failed: -16
  Bluetooth: hci0: Unable to create BIG: -16

until an HCI reset.

Reproducer summary:
- Open an AF_BLUETOOTH / BTPROTO_ISO SOCK_SEQPACKET socket.
- setsockopt(SOL_BLUETOOTH, BT_ISO_QOS) with bcast.out.phys = 0x01
  (BT_ISO_PHY_1M), interval = 10000, sdu = 600, rtn = 2, latency = 256.
- bind() to local BD_ADDR with bc_sid = 0, bc_num_bis = 1, bc_bis[0] = 1,
  then connect() to BDADDR_ANY.

Expected behavior:
- create_big_sync() should set MGMT_ADV_FLAG_SEC_1M when 1M PHY is
  requested (or when neither 2M nor Coded is selected) so
  hci_setup_ext_adv_instance_sync() uses extended non-connectable PDUs
  instead of LE_LEGACY_NONCONN_IND.
- hci_start_per_adv_sync() fail path should disable the extended
  advertising instance before removing adv_info.

Regards,
Kelvin You
