Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C15B5A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190700; cv=none; b=PeWdbjlxL/HWqJ3CVYQktdOwA9OThQykHCuEYLyEerf5kWT8XTUmaud3oHRdRkSculHln6exu98c3gDwS5qDeU2lqOEaSLBcpd5fDqkY3mzX4rV1PFqvaboVaJKcUWpwmx8Xv/ttaHZWEtlfvhEGfFyWkz9CIFZUygFpCt0VjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190700; c=relaxed/simple;
	bh=i10PJqr3IMh8GiSfDOu3x/O7Kn4mqHDAzSQdb5zL7/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i5TssZB226Wz0V5Ti2KDRlhE21WcTA9bqKUlYcvIiaRToSjCaE087/H3Oci8qr2FpCJNlyWthNxS7hIE2rORNwmEpJ0/pdyiX8aJLIENYNtzjL66Z7Pb2NtEnUhJBMmx1sKONiUsKCH8qPD3RXMAvKY+T4cessj74TAsr/Ozu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oth8S2Rr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oth8S2Rr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eb033c192so4768435e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706190697; x=1706795497; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OeGOGZM1S0HVMw9wmZOdd3d9R2TvrQk/FDYATvj+b1s=;
        b=Oth8S2Rr4Wi4gJbVkQLDZc4efO31U5u8CF/o/qpPWS2Plavu+gFT1M82EBMfhNPtJF
         jYdJOGI+R17vLNgwazFYpbt3sIKE6UHwPbXiwJd1UdUedisRDaoNEdGH6aAWtK7RU5uJ
         dbyTImwFn2Stoo9XiUMFTm+GbsDFHnjInkARYGWCjFnCsTkpa0VVdU+dL+UmstH9zmMV
         KNfVw8dvGfeHGNnK2Y+uRa/8M+7HVl8pD1VMyj/NSKHmF+fEuvIoBX9Ji6xsbfo/+l8W
         2K11TQ5M/gFYsCwcSxWO4B5+AewjugjdgU36ewM/l3LcAUdVDIpkqieIXK2VdIJBpbuQ
         /cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190697; x=1706795497;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeGOGZM1S0HVMw9wmZOdd3d9R2TvrQk/FDYATvj+b1s=;
        b=Gejbtp04rr7W+XVxHJzzvynTF/X2/XDc+TI6gHqOLDCZFmYEDtUyHYKaMkn1nx5/bJ
         ZfdjdN4LeQkmUc0skSDgKe35r4c4SxoWFHDsMa+KDP1mwCGhdtR19g1p+DPSMgUKErIG
         V4zjAUC1uBSolgoU/obyTf4j1iJSRGDYsGc2rik9JF7kVKk8kAp55ns/5KvfGXhsVOzn
         keKBzecpCTJ1ZnFkY0DRqkDI3HKvXWEA0FJvUdwfKyZOgp5wVUtKTN3YTrJJYFFKNk0Y
         uDeED45YwWKIDVDKxgE8QYu8KIVFkY3lBuJl3WMBRdxqtBswI4TeHHq2tWPPYt2J9LfX
         pKnQ==
X-Gm-Message-State: AOJu0YyMui28apbGE2hGuiNl8lnUGDD2eLkS6FHqUedwbHSwaHbUA7YK
	pgYWQZSvBqPcDeEq72OpXBPGNVLpzunQYvIWHZ71K/+j403dmf1+HK592pN2XiYzdQydMIgDZoU
	yWhZJ9xc5X7fNbcZJBTcqVkxN9BiSnfm6g1U=
X-Google-Smtp-Source: AGHT+IHbLNXn1rIGv3B17qrb9FIURVbKFIiu80v/XXsG7qQqtncD21ZRiYxerdTE7DWvWADKnCp+ZcvX0JBvNAX47n0=
X-Received: by 2002:a05:600c:2e42:b0:40e:c31f:aa22 with SMTP id
 q2-20020a05600c2e4200b0040ec31faa22mr565744wmf.133.1706190696620; Thu, 25 Jan
 2024 05:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Thu, 25 Jan 2024 14:51:25 +0100
Message-ID: <CAO1O6sdTVEH-qHxWEPX3E2ia1yQ_HNTfZFEQck4144hO0iX5AA@mail.gmail.com>
Subject: Wrong order of ACL Data and HCI Event packets for HCI over USB
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. I have a quite annoying issue on my Ubuntu 22.04 computer with an
Intel Bluetooth controller (8087:0033, Intel Wi-Fi 6E (6GHz) AX211 2x2
Bluetooth 5.2 Wireless Card).
Very often BLE connections to a particular device behaves incorrectly
(ATT timeout by remote device) because the initial ATT Exchange MTU
Request arrives to the host (BlueZ) just before the LE Enhanced
Connection Complete event arrives, and is therefore dropped. I guess
this is due to separate endpoints and therefore separate flows are
used in the HCI USB protocol, but have no idea how/if this can be
fixed?

See btmon log:

< HCI Command: LE Set Extended Advertising En.. (0x08|0x0039) plen 6
#11 [hci0] 8.102056
       Extended advertising: Enabled (0x01)
       Number of sets: 1 (0x01)
       Entry 0
         Handle: 0x01
         Duration: 0 ms (0x00)
         Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4                           #12 [hci0] 8.104041
     LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
       Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4
{0x0001} [hci0] 8.104053
     Add Extended Advertising Data (0x0055) plen 1
       Status: Success (0x00)
       Instance: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7                         #13 [hci0] 21.049023
     ATT: Exchange MTU Request (0x02) len 2
       Client RX MTU: 247
> HCI Event: LE Meta Event (0x3e) plen 31                            #14 [hci0] 21.049304
     LE Enhanced Connection Complete (0x0a)
       Status: Success (0x00)
       Handle: 3585
       Role: Peripheral (0x01)
       Peer address type: Public (0x00)
       Peer address: (removed)
       Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
       Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
       Connection interval: 25.00 msec (0x0014)
       Connection latency: 0 (0x0000)
       Supervision timeout: 700 msec (0x0046)
       Central clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 13
{0x0001} [hci0] 21.049366
       LE Address: (removed)
       Flags: 0x00000000
       Data length: 0
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
#15 [hci0] 21.049405
       Handle: 3585
> HCI Event: LE Meta Event (0x3e) plen 4                             #16 [hci0] 21.050229
     LE Channel Selection Algorithm (0x14)
       Handle: 3585
       Algorithm: #2 (0x01)
> HCI Event: LE Meta Event (0x3e) plen 6                             #17 [hci0] 21.051290
     LE Advertising Set Terminated (0x12)
       Status: Success (0x00)
       Handle: 1
       Connection handle: 3585
       Number of completed extended advertising events: 0
> HCI Event: LE Meta Event (0x3e) plen 11                            #18 [hci0] 21.052293
     LE Data Length Change (0x07)
       Handle: 3585
       Max TX octets: 251
       Max TX time: 2120
       Max RX octets: 251
       Max RX time: 2120
> HCI Event: Command Status (0x0f) plen 4                            #19 [hci0] 21.053228
     LE Read Remote Used Features (0x08|0x0016) ncmd 1
       Status: Success (0x00)
