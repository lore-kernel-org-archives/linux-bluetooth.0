Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D32134CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987138; cv=none; b=P4RoYUnz2iP/p6v4zfMPuezQ5/UHEA6CDOI8xB6gHkpzxoobQk5ecxkfBF5Jm30Kh76qc/Il/jMLX6COqiUJAT5bSiFs+DLYxUoI55moQinJXGJ7LvO/dLd2w4beQ2zFKqE4LwbPMgpOp2eaww/t9SwBh/l2HgrTuiY5eCNEDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987138; c=relaxed/simple;
	bh=z7gJCV/d69l/nV8+T3a2zDK6cK+BttGfVeHDfyn0NIY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BcpT33yNneFQTV3K/6AlGs4YPOROPVGTG7/hpfPI6nW9X8RebFqpl04BnnxTzJYB5cgf0h2oEl2SpFBQKNnUtilcKD8XKRRdMipEfSzmL/RIbRu8jilH3s+5WJr98QmAEhPia7WrrsidgIqCD3m4KTwqwMRFsPzHiJfylke39Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3hJqb0l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3hJqb0l"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1247216a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 00:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707987134; x=1708591934; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLOQhUioTnxbgJQ2lCwH8Y9HynrlMw1e7POa9cYYhbE=;
        b=h3hJqb0ljgFRJqFAyJ5thpnhLZSfHFjRIcomkGqrRvBaPuMx8FaCdJo09XXq+xRtqM
         jpSgVqLubql/8z1dFjODaq3NAgSyVr0R1djT/8Ngnz8p7Unk9LBSxnleQMA9yFGLMNir
         rlJ+APM14wajW5v2IXwLr6U5QyrGuXf55FncoO+aL8Nw3dX9p615k806pJs/iNEoSAaX
         D7Ulf3kr9UFXqnHA3SaaJqGLTewCxOCwOkrPZWRgGB3oJ6dV53pA6RFXR3mDZoT+92+4
         gTN0bP6Qve4RwTd8U3YF+HK7zl241aqDfXhm5AuFdFtkE+MENz28zXV8kvl361ZQekKt
         A0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707987134; x=1708591934;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLOQhUioTnxbgJQ2lCwH8Y9HynrlMw1e7POa9cYYhbE=;
        b=m+iZBNqfxyWB3Pnm+Gvc3r9uyBbEC5mXVA/yMS+/veIYcUBjeUxwoTa2TLJrMfTaXY
         Dt6bdKqrdyCyNRlxnKTW5ydr02BGnUw+X1UGsGGhwpujY8BnUnUQDlC9u3ROPMf1Dc0t
         RjmRweUa1KbCCoR2+neIRoXVqJlRIMAQx2WydiL6fkJzwCGasyt0gAJgSw9UyWg/38HW
         1m3ewQJ9eQbyLmLqPwv9pXtg5vN9PxnxL4vmOsHpG4tQwUK/jQ269kuR2hj7QJQHjCKr
         AAZPiAh0S3LXYLSvcoj8la6tkB/V9rQ7KWGFNWsQsWCo8K8ziE3+D/kxcAEn+kfDM8YH
         UneQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+mgkRHZOn+4oJeJNk1ZAbJKdZT5UqCMWQbCOHm29UmdktgHI74YETgaL8kV3CWf+Qc6yFg+KY12ifs60Yl6uzZeq1GjBq9CPcv9HVR4tx
X-Gm-Message-State: AOJu0YzftbGP4Wu3OUCCIvMflVYfjD7Bhl3GgqMUQsbzV0eDK+4mfRkE
	Y3/2R8frOn8ME/8dxxLy0xYfzz765rUo3IK3ydVelC0NRAavjnluqxUSbNQ6E8DyV9hIDSWA8Zg
	QU+lQ1T881XIEM/C6EFxAtYJXE7hTrOYJuk4=
X-Google-Smtp-Source: AGHT+IGlxtjHdE09yaep9ANV96az0BVYe742hdGp+iterOK1eJ/q3v3GybyRT67rnZX+uyNqFdm1UWwdlysypWD1uug=
X-Received: by 2002:a05:6402:2405:b0:563:c2e5:5289 with SMTP id
 t5-20020a056402240500b00563c2e55289mr59880eda.13.1707987134301; Thu, 15 Feb
 2024 00:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: alaganraj <alagan.linux@gmail.com>
Date: Thu, 15 Feb 2024 00:52:03 -0800
Message-ID: <CAMrsnHppCipP9F8+NDfoJs6e9Gd+Q6ROgCry4VoLzCi4MjE3nQ@mail.gmail.com>
Subject: Out of Band (OOB) pairing using btmgmt tool
To: "luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
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
