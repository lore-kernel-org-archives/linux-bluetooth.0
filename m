Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6A1F81BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513478; cv=none; b=NUjnh9DPj3Ag06PQ7/dARiJUaQOtXcTKqmPQSjp5IVZbYqFNoJI+6/V8nE1oxeID7bQVDu7LuEoYW7Tj3qW8CtbX2Pmlxl7F0qqCDbwaInYrfae5BRntyyclPhwu/86lPuKHO7k90LBKype8RDHQsgpsMMnfvIdlWQG2WnjRXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513478; c=relaxed/simple;
	bh=kg3dVERtjY80usC3GdKZbJivOwwlsUO9wbZ9wnFFPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuUsnjw2cOPr0Du9T8ELzISu5VBjqIOtEbjdZF3NoJp7e3kCyBosSsH4DylMDxPOf2Lh7H6w1hMKcgTW8cZnEs+ssSB7wsi4CKbBGnNIcaImkdHkAqkIRK1aBXxBuLBJH1rTPyttwRS8WE9zh0LVqXAC/egioAZx6q6kO3v6jIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1VXRt2x; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1VXRt2x"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so5232818e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513474; x=1730118274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7+4B3Cw1mJDA8JFQ5EIWPe9FoSBC1Z+PxOTCPnJ2nw=;
        b=g1VXRt2xIAmvR6REJqwcwV++Qrsj31sqmQz+Aa4H+8ciFjzOrYgDeviE9gRuRUDj2u
         S4zUjSn5ypW7FF97uYS8+cZ/IL+W3wtA7dv9R2jjXBFFcS3n6hCY8D93oqbKONrBK4uR
         sOLi2912kH+VCW6eB2iGk0OMs7xov945sXU4KgH9eMkqGHbf4126ce7vVDF2ik8R9R3q
         AleDC10ymT+6zNZ4tctrX9uDCXvyzZOdpamqpi+ryLUqSeNOJPbkwCsXo+cPQXfjTCkc
         /VwZYw0ww7XAIr0XQU0HJiEKw87i0qj2HOe+0D6Sj7XXO/UTmxE6uDrJVT1dDqtrZS3p
         wsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513474; x=1730118274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7+4B3Cw1mJDA8JFQ5EIWPe9FoSBC1Z+PxOTCPnJ2nw=;
        b=NANaq5Lqjf8WMXhEIb0ywvGK5hQ9IlrNTo3fnjj3bGRLHDoRENHwVimsfqju0kyLzN
         U1heL6QI1BqAKHG6ArOGp/MjeSIwq2j4kmKnm0Sz9WvjqCwnJootywKMX5RUw2n7Siu6
         ObgzNT9M5q2VJ6MPesf748jnD53V4Dmd+ZHWqVpn+0icP/hUi6m8CEwFyRF1PdGchBNF
         tNB9bHsSML6zSI4z48fkBhUMEqzQI2ME8bcfk74bvkriYB4H5z1uxl30snr58v/eQszR
         jz/W5zkbdv7BDlF41vU8gYIGRWdpuefBWEkzRFnzrhxvquHaUNs4fdyFkYk7GbADg188
         +rXg==
X-Gm-Message-State: AOJu0YwUhR1Y/evZQu+ElVO0jC9xBlsrT43EDLRk1QPDsIzc+Xu/P9HW
	Ct7u+Z8ZfrT5zuhlE1YkGRR237uCnRfTD8SWPp53HDym5sFLqGbai1mrR5nBjFY=
X-Google-Smtp-Source: AGHT+IEv25qYm2/mHN1fpdaH2x96E3ru8ATEYjqYRRNIhGjzBNowudR43TXgcd3msgaXmrv+647iGw==
X-Received: by 2002:a05:6512:31c1:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-53a154b0defmr5642987e87.30.1729513474123;
        Mon, 21 Oct 2024 05:24:34 -0700 (PDT)
Received: from ha.lan ([185.52.141.89])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f02c1sm464015e87.111.2024.10.21.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:24:32 -0700 (PDT)
From: Danil Pylaev <danstiv404@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: uhrmar@gmail.com,
	raul.cheleguini@gmail.com,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Danil Pylaev <danstiv404@gmail.com>
Subject: [PATCH 0/3] Bluetooth: btusb: Add quirks for ATS2851
Date: Mon, 21 Oct 2024 12:22:43 +0000
Message-ID: <20241021122246.1569235-1-danstiv404@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller based on ATS2851 advertises support for the "LE
Extended Create Connection" command, but it does not actually
implement it. This issue is blocking the pairing process from
beginning.

To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
This will avoid the unsupported command and instead send a regular "LE
Create Connection" command.

< HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: DD:5E:B9:FE:49:3D (Static)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Unknown HCI Command (0x01)

This is a resubmission of a patch based on current bluetooth-next/master.

Also I noticed the following problem:
1. The connection with the LE device is stable for 10-20 hours,
the device is periodically turned off and on,
the connection is restored after the device is turned on.

2. At some point after the connection is broken,it is no longer restored,
the adapter sends an mtu request, does not receive a response,
and connection is closed.

@ MGMT Event: Device Connected (0x000b) plen 40     {0x0001} [hci0] 3949.336820
        LE Address: E8:42:26:5C:0F:07 (Static)
        Flags: 0x00000008
          Connection Locally Initiated
        Data length: 27
        Name (complete): RFS-KKL002
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Transenergooil AG (450)
          Data: 4000070f5c2642e8
btmon[11980]: @ RAW Open: btmon (privileged) version 2.22  {0x0002} 3949.336952
btmon[11980]: @ RAW Close: btmon                           {0x0002} 3949.336962
> HCI Event: LE Meta Event (0x3e) plen 4              #61140 [hci0] 3949.339079
      LE Channel Selection Algorithm (0x14)
        Handle: 1536 Address: E8:42:26:5C:0F:07 (Static)
        Algorithm: #1 (0x00)
< HCI Command: LE Read Remote.. (0x08|0x0016) plen 2  #61141 [hci0] 3949.346390
        Handle: 1536 Address: E8:42:26:5C:0F:07 (Static)
> HCI Event: Command Status (0x0f) plen 4             #61142 [hci0] 3949.348227
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12             #61143 [hci0] 3949.414952
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 1536 Address: E8:42:26:5C:0F:07 (Static)
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
bluetoothd[422]: < ACL Data TX:... flags 0x00 dlen 7  #61144 [hci0] 3949.415720
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
bluetoothd[422]: @ MGMT Command:.. (0x0014) plen 7  {0x0001} [hci0] 3948.495765
        LE Address: E8:42:26:5C:0F:07 (Static)
< HCI Command: Disconnect (0x01|0x0006) plen 3        #61115 [hci0] 3948.495995
        Handle: 1536 Address: E8:42:26:5C:0F:07 (Static)
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4             #61116 [hci0] 3948.497701
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)

The important thing is that the response to mtu request stops coming from other devices (tested with two le devices).
Therefore this is not a problem with end devices.

Doing power off / power on from bluetoothctl temporarily solves this problem for a few hours.

Danil Pylaev (3):
  Bluetooth: Add new quirks for ATS2851
  Bluetooth: Support new quirks for ATS2851
  Bluetooth: Set quirks for ATS2851

 drivers/bluetooth/btusb.c        |  2 ++
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h | 10 ++++++----
 net/bluetooth/hci_event.c        |  7 +++++++
 net/bluetooth/hci_sync.c         |  9 ++++++++-
 5 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.43.0

