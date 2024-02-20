Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E45942
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408130; cv=none; b=ZyOoiIbhKE+lqDRbMStX7Z1CVUapyBk57wSMgggpTssq8/vU39k3295Iw4XdzyFSuN9t2Y5X9YHYzjFRwEbz8d+O3d5jcXeF75hzv2dAu4aWFp7FY4JbLN5sD0Sr47EJhONdmoyd4okI0AwFCNmmQiwvqTf0tYZJ2PgxlTf4dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408130; c=relaxed/simple;
	bh=z7gJCV/d69l/nV8+T3a2zDK6cK+BttGfVeHDfyn0NIY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rlv3QhSiTaaPAJ4vztzu1E4brcvMBYNMNyPaE+t21vN7N63HF6efcqbQLBjwTGm89WaqPCFfyznHQUBr3BioB1zZlL0dl1MihvAUcqGZ0eW/U5iB7q/TU2MuvimXTs8+icfaZGjX7ZZhNXiW+AUQ1zdRCuPvw/B2LY1i1CfeQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqeMD32c; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqeMD32c"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2673691a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708408126; x=1709012926; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLOQhUioTnxbgJQ2lCwH8Y9HynrlMw1e7POa9cYYhbE=;
        b=GqeMD32c9AycEcNbNbsN7/X6M5V7YrdMcCAWS4Q+hl5YZOzGBGM0yG1i9TE2s3vRH6
         E5oRQd+S75G075uPNxnN7sN5xb0l40nXWfRs5t4/6EaasDjmghuxVIumK0HC/Ib0/DAC
         akQgIS1A3J+Rq7CTeAhalrdLUWh1VFkkSWcPktpPaL2I5cSlWJCrkelbyaqIpXS3O8Nv
         KBNfC3o35OJflQTxlKZa0rcQ9IW6/jvt1feHpRa10LHxLVnzx2/uwPmsF8wFCN8FwDSl
         E/VB1XZzyKYHsXjtttCZpwyY5NWKrreyHvlr+dDbSxI2KP7E9Cz/kGZvMewxhuDCL4ag
         q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708408126; x=1709012926;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLOQhUioTnxbgJQ2lCwH8Y9HynrlMw1e7POa9cYYhbE=;
        b=W20tR3K+cfnzZg+w5vwU++0aSWerG3Qc6BM7zioYzjjeTZPUPpIA2pWpIwq7H6VFmM
         7IjZImC5EjvDryH+J0Cu1z/4mu2dv1BcIJje1lf0jF5Gm2cmk/e5MIvL9SoxNPHZAJCo
         erBynbBLNcisEfiVF7+OALe+SqaeLwdEXFEI2u33dgKPVsf7mmgZt23DJCUlaSWd24GC
         oqUfJo8DEkn+TCJd2oEEP+4V+Ul5JcfVzh0wdEo6go2a8xaoVR4zbLd+sgbV0PoRPNol
         hCu7jPtYwVO4VCOB13M52JUDntvA9uFlj65jJRN7ODpgSLccfdPnfrr1+3m2T5ZqNf90
         cChQ==
X-Gm-Message-State: AOJu0YwlAbSjvMTgiSGBF3wXhZniyCbApJWzOHj/dBnnqKoKjToU7qJ1
	32kDRXnqh/f6/aRaO2J1rzHZ9//pKhg2yVY6pKM4J/jYQiuW03IoNQVNxbSEiHw6L3r3faw4G20
	tsKfCteCu7Bho+oBsi6sMsfRuWawKteDgbMY=
X-Google-Smtp-Source: AGHT+IEY08NHJjPR9zsKzz/saHwxeTbHsJn8WcR4uvTubdxUGMARqdVifsceKKQUieWdDjmx3y3yQUhgGNm1IoqDY+k=
X-Received: by 2002:a05:6402:5248:b0:564:a994:a057 with SMTP id
 t8-20020a056402524800b00564a994a057mr1894226edd.27.1708408126238; Mon, 19 Feb
 2024 21:48:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alaganraj Sandhanam <alagan.linux@gmail.com>
Date: Mon, 19 Feb 2024 21:48:34 -0800
Message-ID: <CAMrsnHr7_XoCBqaW_E45j61aLKOUr2HBUWykwBqU_37YNh9Hrw@mail.gmail.com>
Subject: Re: Out of Band (OOB) pairing using btmgmt tool
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Luiz /Community,

I'm trying to verify OOB pairing by manually sharing pairing
information using the btmgmt tool (Not using NFC)
between BLE central and peripheral devices.

This is similar to the question below, which is not answered.I tried
googling, but couldn't find the right info, so turned to the community
for help.
https://stackoverflow.com/questions/42344367/out-of-band-bluetooth-pairing-with-the-btmgmt-tool-on-linux

Here are the steps I followed.

1. secure connection is enabled in both devices.

Central:
# btmgmt info
Index list with 1 item
hci0: Primary controller
addr 00:1F:7B:4A:0E:CB version 12 manufacturer 72 class 0x000000
supported settings: powered connectable fast-connectable discoverable
bondable link-security ssp br/edr le advertising secure-conn
debug-keys privacy static-addr phy-configuration
current settings: powered connectable discoverable bondable le secure-conn
name Panda

Peripheral:
# btmgmt info
Index list with 1 item
hci0: Primary controller
addr 00:1F:7B:4A:0E:81 version 9 manufacturer 72 class 0x000000
supported settings: powered connectable fast-connectable discoverable
bondable link-security ssp br/edr le advertising secure-conn
debug-keys privacy static-addr phy-configuration
current settings: powered connectable discoverable bondable le
advertising secure-conn
name imx8mmpanda
short name


2. Unable to read local-oob
[mgmt]# local-oob
Too small (32 bytes) read_local_oob rsp

3. So random and hash values generated using "le-oob"

Central:
[mgmt]# le-oob
LE Device Address: 00:1F:7B:4A:0E:CB (public)
LE Role: 0x01
LE SC Confirmation Value: 1e8cb994e8d913adf0fc55196b3e3f0e
LE SC Random Value: f1813b0ddd3ca126ac847dc8cbe492a0
Flags: 0x02

Peripheral:
[mgmt]# le-oob
LE Device Address: 00:1F:7B:4A:0E:81 (public)
LE Role: 0x02
LE SC Confirmation Value: 759058bc5620bf728f3e18ce88728d67
LE SC Random Value: 1329bb1dbc7f13f846c12360f596ada0
Flags: 0x06

3. paring info updated using "remote-oob" but seeing 0 for R,H in btmon log

Central:
[mgmt]# remote-oob 00:1F:7B:4A:0E:81 -t 1 -r
f1813b0ddd3ca126ac847dc8cbe492a0 -h 1e8cb994e8d913adf0fc55196b3e3f0e
-R 1329bb1dbc7f13f846c12360f596ada0 -H
759058bc5620bf728f3e18ce88728d67

Peripheral:
[mgmt]# remote-oob 00:1F:7B:4A:0E:CB -t 1 -r
1329bb1dbc7f13f846c12360f596ada0 -h 759058bc5620bf728f3e18ce88728d67
-R f1813b0ddd3ca126ac847dc8cbe492a0 -H
1e8cb994e8d913adf0fc55196b3e3f0e

btmon log:
@ MGMT Command: Add Remote Out Of Band Data (0x0021) plen 71
                            {0x0002} [hci0] 30.534680
        BR/EDR Address: 00:1F:7B:4A:0E:CB (TechNexion Ltd.)
        Hash C from P-192: 00000000000000000000000000000000
        Randomizer R with P-192: 00000000000000000000000000000000
        Hash C from P-256: 00000000000000000000000000000000
        Randomizer R with P-256: 00000000000000000000000000000000
@ MGMT Event: Command Complete (0x0001) plen 10
                                       {0x0002} [hci0] 30.534706
      Add Remote Out Of Band Data (0x0021) plen 7
        Status: Success (0x00)
        BR/EDR Address: 00:1F:7B:4A:0E:CB (TechNexion Ltd.)

Also seeing BR/EDR address instead of LE address.

5. paring initiated w/ address type 1 (LE Public)
pair -t 1 00:1F:7B:4A:0E:81

6.  OOB data flag is not set in both pairing request and response
So fall back to IO capability and prompting to confirm the numerical comparison.

btmon log:
< ACL Data TX: Handle 128 flags 0x00 dlen 11
                                              #534 [hci0] 121.916889
      SMP: Pairing Request (0x01) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 128 flags 0x00 dlen 7
                                              #535 [hci0] 121.917990
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517

> HCI Event: Number of Completed Packets (0x13) plen 5                                                               #536 [hci0] 121.961103
        Num handles: 1
        Handle: 128 Address: 00:1F:7B:4A:0E:81 (TechNexion Ltd.)
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                                                               #537 [hci0] 121.961727
        Num handles: 1
        Handle: 128 Address: 00:1F:7B:4A:0E:81 (TechNexion Ltd.)
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 11                                                                         #538 [hci0] 122.005568
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey Sign (0x05)
> ACL Data RX: Handle 128 flags 0x02 dlen 7

7. Tried to set OOB data flag using below command but it doesn't help
set-flags 00:1F:7B:4A:0E:CB -f 0x0004

I don't know how to set the OOB data flag using the btmgmt tool.
I would appreciate any input regarding this.

Thank you
Raj
