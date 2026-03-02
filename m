Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A08329395
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439951; cv=none; b=T4Vf4tap2SSr8R4ofdGrezhV/XDvr0/q09EqomE08RSDSZozfl1W46VB0ZZgy+1dM3oqiajk8exGU6diqlwiKvu/nrjHEf5FEZErNBZZJMOhVHYlUnddJDkuTS1LV+n3LSmPQNfocjOsGoyffMwsqwTG5NNdTUb1i8Wm+tOCdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439951; c=relaxed/simple;
	bh=G4o5AhVRXu9q/KQtrP+cvkVRz+ki4ewCCkI9WkZZJoU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RU7IGUhq8+RVkBKfQpA4CHK2PVNVtGyHVU0Nw3+SIcPWV3GLRz75ywOCcMhcOOjKpD76LxCJwJNBmaTzwbK5o2khw2XDDqyaqOH1ay/+DaImsqzjb+Lk4tNyQhZ3wCMrdbDVUSu3+nGykprbmPq2C5zEm1gkJYvEMjyOOumBAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainphreak.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainphreak.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389e139ee5eso64593281fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 00:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772439948; x=1773044748;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trf/1mTBw3nxCTZfrwTxoSFWzFdd/2MCiJdClMbPshw=;
        b=rjwdSOnCKFVVqaPFZnZIOKz6+2YR2lEGulCiJNzrvVWDUqg3oSjGEEIwcqb2yig93D
         aQGYJdL1xp7pD0kN4n9naIo0BCplByG55R6Ixh1mc26WJ+Uftfn+eoZ4vv+LbO7jTEz6
         1zdIkJs/GxdOpyILBe6FAO6EtHeXM+1LRU01I9hCQFpdrZROZnVUKP1yqy1tiLWYSmQe
         gvHChCljvXtM4zbL/Fm4GgVFqiQtVMJrv2ddil8GjkMjtCDr06CAFOEqotkGldeIGBZX
         fnFKCG80Qi0ME5TBb6esWXtrvrX+YACvjhUeKQjkDt84M1pQ3mYkpV57AcPnoQOn0kL2
         Ddgw==
X-Gm-Message-State: AOJu0YwzyI4YE4uO2rqJBRfRx12fb7vMmN7DH8bCA82pCNfnKiDOGsgH
	5SkHLJUb9zOzjQVVqSzP4BGzzYu9gxBR23W5xdSSP7yrKX7P+6BcxBBPjzC+8A==
X-Gm-Gg: ATEYQzxIfnxXYCgkFsol7BK7sylO3PcgIKAOkpSsy2HktRbozOp4Nn32W9M2mJuscaR
	LHqOZkfMpUQxiWB7xPV4DdleYVPwmUDBIXFb9kQOkzsByRTZvT2KMflV2wYXDr3cVP9Ax+Jmcp6
	4NMYpQJXmv6QdULmpzD+CKgoLWw7LJxst0FWFnsQNoeQg3JwyDpFF3abuDQNgc0w3lVXh+tAb8q
	svlfkSmCS5CPMp8sA4T0Ne8AZTZmkb3Q2DFnT62Ch+3iNtEUiqAwJMAyZ1OTbpBrqOjgC6NbpSF
	B4EA8KP8yBDaH005BJMrXWYNyMlBicaHe9J8//45sMlXVljUCwfqyl2isfrJk4n7LUVUm0/IWm1
	QPKi3z4pkFPwnkkysUp82dSlFGmHUV5GjVhNwY3gmRrncmxvMU1xZnau1vaT+zy4KXnJKhXwNje
	kregSDmjDll1o96sqF3M6JnIeYMnqeH/pZED/c3A12kd/t+wtVsIbltO6Snp/5YfJf1I6S7RMvN
	g==
X-Received: by 2002:a2e:9784:0:b0:387:6b1:cf4 with SMTP id 38308e7fff4ca-389ff356b6emr69565281fa.27.1772439947460;
        Mon, 02 Mar 2026 00:25:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bd2c94sm1494168e87.6.2026.03.02.00.25.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:25:47 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38709888abeso60080191fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 00:25:47 -0800 (PST)
X-Received: by 2002:a2e:8887:0:b0:385:f547:1842 with SMTP id
 38308e7fff4ca-389ff356fd2mr67276261fa.30.1772439946767; Mon, 02 Mar 2026
 00:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Don White <brainphreak@brainphreak.net>
Date: Mon, 2 Mar 2026 00:25:35 -0800
X-Gmail-Original-Message-ID: <CADZ-OS_xi1nfqzMCnNRa7qB3hDx4kMGduB-svYnnbWyB1--cPg@mail.gmail.com>
X-Gm-Features: AaiRm52CkldVFIYTi2xyUHxN9zugpOmuHu3VuJoJbqNPPbhxIm7wOlpD9mhCel0
Message-ID: <CADZ-OS_xi1nfqzMCnNRa7qB3hDx4kMGduB-svYnnbWyB1--cPg@mail.gmail.com>
Subject: =?UTF-8?Q?MT7921U=3A_ACL_data_misrouted_as_HCI_commands_=E2=80=94_firm?=
	=?UTF-8?Q?ware_never_processes_bulk=2DOUT_ACL?=
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been debugging a Bluetooth ACL data transfer failure on a
MediaTek MT7921U (USB ID 0e8d:7961) and have narrowed it down to what
appears to be a firmware-level issue. HCI commands work perfectly, but
ACL data sent from the host via USB bulk-OUT is misclassified by the
firmware as HCI commands.

Hardware:
  - MediaTek MT7921U (0e8d:7961) on USB 2.0 (EHCI, 480Mbps)
  - MT7628AN SoC (MIPS 24KEc), OpenWrt 24.10, kernel 6.6.86
  - Firmware: BT_RAM_CODE_MT7961_1_2_hdr.bin, build 20240219111427
  - Reference adapter: CSR8510 USB dongle on the same host (works perfectly=
)

Symptoms:
  - HCI commands, inquiry, and connection establishment all work
  - ACL data sent from host never reaches the remote device
  - Zero Number_of_Completed_Packets events returned by the controller
  - ACL RX works (remote device can send ACL data TO the MT7921U)

Definitive test =E2=80=94 HCI Local Loopback Mode:

I enabled Write_Loopback_Mode (0x1802, param=3D0x01) and sent 3 ACL data
packets to the loopback handle. The CSR8510 passes this test
perfectly:

  CSR8510 (hci0):
    ACL packets sent:     3
    ACL packets received: 3  (echoed back as ACL Data)
    NCP events:           3
    RESULT: PASS

  MT7921U (hci1):
    ACL packets sent:     3
    ACL packets received: 0
    NCP events:           0
    RESULT: FAIL

On the first run, the MT7921U returned the ACL data content inside a
Loopback Command event (0x19) instead of as ACL Data:

Event: 04 19 13 32 20 10 00 4c 4f 4f 50 54 45 53 54 30 00 00 00 00

Decoding: the firmware received the ACL header (32 20 =3D handle 50,
PB=3D0x02;10 00 =3D dlen 16) plus payload ("LOOPTEST0"), parsed it as HCI
command opcode=3D0x2032 plen=3D16, and wrapped it in a Loopback Command
event.

This means the firmware treats data arriving on the bulk-OUT endpoint
(EP 0x01) as HCI commands rather than ACL data.

Additional observations:
  - btmon trace during l2ping confirms: ACL TX from host is queued (TX coun=
ter
    increases), but remote device receives nothing and no NCP is generated
  - EP_RST_OPT (0x74011890) was written as 0x00010001 by btusb_mtk_setup();
    clearing it to 0 does not fix the ACL issue
  - Newer firmware (20251223091725) causes HCI_Reset to fail with -145
  - UDMA registers (TX_QSEL, WLCFG_0) all appear normal
  - The issue reproduces on every boot, every hci down/up cycle

Questions:
  1. Is there a known initialization step or vendor HCI command needed
to configure the MT7921U firmware's bulk-OUT endpoint for ACL data
processing?
  2. Has anyone confirmed MT7921 classic Bluetooth ACL data transfer
working on Linux? (I could not find confirmed reports)
  3. Could this be related to the btmtk_usb_subsys_reset() changes,
which were added for MT7922/MT7925 but explicitly removed for MT7921?

I have a simple test tool (hci_loopback) that reproduces this in ~5
seconds if anyone with an MT7921 on a different platform (x86, xHCI)
wants to verify.

Thanks,
- Don
