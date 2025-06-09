Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E37E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466273; cv=none; b=oOFGIZqmUd5voY3cmi/ZIn0SkbvpBIeBiaTlCL3JpTFfDJv8b+O57RdOlN2dqTc4D230d5vdOdaZb2invV60uHvH+X40cb9A18fvBWNWNxyD9VCB2JxrxJBbzG3tf7ctv/PtT9Im0W1xnPPPIEQAzm249tR2tNZk+ayC3dR4GU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466273; c=relaxed/simple;
	bh=LPA7xCYMv13s+EWfgcMRQxZQBRnRKV4eEPP40TTYxhs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gU3CVQoYopqAXQ4RovACu2341WkYZpsyhtL/Nb3s99mTcZlBrAH+rS5pt9HpaqhwGMY/RQEy5DUao58qQc6j6uF+ajBijAxf1TgUi0o7pfn5MAgY9NdGC3Zhvjpc9e5StyZKMhs5oIQRzLkBfMiWQyqtNjLOIcT+x7paPAm82n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XFm6VTIR; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XFm6VTIR"
Received: from github.com (hubbernetes-node-004ce96.ac4-iad.github.net [10.52.182.41])
	by smtp.github.com (Postfix) with ESMTPA id C97E4700388
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749466269;
	bh=34Cy2VFccN5fylCafolbsX0qaRaQKQVcvrOnboCyQDk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XFm6VTIRKix5jCxs8XS/eq8r2YoAWRio9ZZe/ZNuNlIQsKqBmgMzy2+y2vn/HptQI
	 ZZyY3w7Gr8oVbDfU1sJzXG4olkjwK9wxvugyRFCjbJHYkbbrz0OjmFLMWRvrE6kaM2
	 meKnwB6P9VpXEY1WNHBtAFiI+IDruKZD/8yyB7jo=
Date: Mon, 09 Jun 2025 03:51:09 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969781/000000-d69c12@github.com>
Subject: [bluez/bluez] d69c12: monitor: Add support for decoding Channel
 Sounding
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/969781
  Home:   https://github.com/bluez/bluez
  Commit: d69c129e9f0a18b3217f4625182a212ed55530ce
      https://github.com/bluez/bluez/commit/d69c129e9f0a18b3217f4625182a212ed55530ce
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for decoding Channel Sounding

Add initial support for decoding commands and events of Channel
Sounding, a new feature introduced in Bluetooth Core Specification
Version 6.0 | Vol 1, Part A, Section 9 "Channel Sounding Using
Bluetooth Low Energy".

Testing:

To test the feature you need a hardware that supports Channel Sounding.
Channel Sounding can be tested using Nordic Semiconductor's sample
applications for the Initiator and Reflector roles, which are available
as part of the nRF Connect SDK and require an nRF54L15 development kit.
See tutorials:
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_initiator/README.html
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_reflector/README.html

Example output from btmon:
> HCI Event: LE Meta Event (0x3e) plen 250                        #102 7.954000
      LE CS Subevent Result (0x31)
        Connection handle: 0
        Config ID: 0
        Start ACL Conn Event Counter: 53
        Procedure Counter: 0
        Frequency Compensation: 49152
        Reference Power Level: 237
        Procedure Done Status: Partial results with more to follow for the CS procedure (0x01)
        Subevent Done Status: Partial results with more to follow for the CS subevent (0x01)
        Abort reason: 0x00
          Procedure: Report with no abort (0x00)
          Subevent: Report with no abort (0x00)
        Num Antenna Paths: 1
        Num Steps Reported: 22
        Steps data: [234]: 00e801024709000702f4000aa2f420022e0900d05df900d0edf820021009007251e400e27f001201100600ffe8f8ff01022d0900c5fd0200c7fd0220023c090029b11d0015911e2002030900bc002200e8effe1201030600ffe7f6ff01022b0900646f220041bf2120022c0900a75f23000820fe1202210900d93ee1001d80001202230900e00ee10000dfdf2001230600ffe71c0001023d090029d2fa00e24f0012021f0900c04d0100c18d022002050900674023005780232001050600ffe80f0001020e090077b0dc005c60dc20022209001f3eec00fcff01120000000000000f0003000005082800
        Step 0
          Mode: 0
          Channel: 3
          Step data len: 3
          Raw step data: [3]: 00e801
          Packet Quality: 0x00
            CS Access Address check is successful, and all bits match the expected sequence
            Bit errors: 0
          Packet RSSI: -24
          Packet Antenna: 1
...
        Step 3
          Mode: 2
          Channel: 71
          Step data len: 9
          Raw step data: [9]: 000702f4000aa2f420
          Antenna Permutation Index: 0
          Path 0
            PCT: 0xf40207
              I: 0x207
              Q: 0xf40
            Tone quality indicator: 0x00
              Tone quality is high (0x00)
              Not tone extension slot (0x00)
          Path 1
            PCT: 0xf4a20a
              I: 0x20a
              Q: 0xf4a
            Tone quality indicator: 0x20
              Tone quality is high (0x00)
              Tone extension slot; tone expected to be present (0x02)
...
        Step 6
          Mode: 1
          Channel: 16
          Step data len: 6
          Raw step data: [6]: 00ffe8f8ff01
          Packet Quality: 0x00
            CS Access Address check is successful, and all bits match the expected sequence
            Bit errors: 0
          Packet NADM: Unknown NADM (0xff)
          Packet RSSI: -24
          ToA_ToD: 0xfffffff8
          Packet Antenna: 1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
