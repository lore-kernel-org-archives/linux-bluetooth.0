Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70278189F45
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873267; cv=none; b=ltF31/Zar64nH6sEhFQVrUNJb3DFA5MdpN1r6TLXPuXIKicQ9GEb6FfE7aKWab+35jxmeUo4N1OOWFlgaFQyh/YEo/+9/jZ36sLJyi0rFTU58q7aJDv/ktmPGn3FiW+wMevyJVGE5HSvqAGHWDQKG87GqQ5/IJn7f5iHvwY3THQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873267; c=relaxed/simple;
	bh=YSc/2/Tn4rb5hDMLaoL0j8MX5DaoRjOltHxZk+JAAR8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q/QyYF9BJxzDSrJxm3JsNgPhcIGAdAGW9tLCOcuWVFqpXHZu9x3cGW+Wy0IQCqpusRlnBavND5QzFc1cEkC6bDKMAYOe5InQeqppDzNw0urj/AwD8ZymDHMfXnsY6W0xCAnd3sosFEIzgRFVgJ6Nwoy0jmMSCJhBi9nF+NOTiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LzYcKPXR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LzYcKPXR"
Received: from github.com (hubbernetes-node-afc22be.ash1-iad.github.net [10.56.168.38])
	by smtp.github.com (Postfix) with ESMTPA id 7A5076C04BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729873263;
	bh=FFkD/gfwRkcBFZPaU2PBST8Iq/PynVAvAtBfYJSTuI8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LzYcKPXRdw0LpMc0NxBoWgKJh6bP48QwdluurjStkt7g4GLEb/zbIJLMwXD779HEq
	 rVRlLwuvTyrjKh14jyESkxOxLbQzjnYdhUmS7VLoZo7PrIZTh1fQVCfyay1ZZR2Psu
	 /x4SzZIenUJ4mwWdqiSUNYx4F8Koc3krAeAtOkkc=
Date: Fri, 25 Oct 2024 09:21:03 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/806a55-06c94f@github.com>
Subject: [bluez/bluez] 7ff51d: shared/bap: Allow multiple links per stream
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7ff51d684956cf3e063ea341ea0a98c40452af5d
      https://github.com/bluez/bluez/commit/7ff51d684956cf3e063ea341ea0a98c40452af5d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Allow multiple links per stream

This commit adds support to link multiple streams together, creating
the foundation for implementing broadcast links: for Broadcast Sinks,
the user could select multiple streams to receive audio from. All
selected streams need to be linked together and considered when
creating BIG sync.


  Commit: 85bee521c7375d48be96dc2de88a8ec2a173fc57
      https://github.com/bluez/bluez/commit/85bee521c7375d48be96dc2de88a8ec2a173fc57
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support for handling broadcast links

This commit implements io handling functions as stream ops, since
broadcast links need to be handled differently than unicast:
Unicast links share the same IO, while broadcast links stand for
separate BISes with independent IOs. Unicast links have different
directions, while broadcast links share the same one.

This also adds a function for unlinking broadcast streams.


  Commit: 71d19c6c84162ea5f46c850d30561a4ec6b25fce
      https://github.com/bluez/bluez/commit/71d19c6c84162ea5f46c850d30561a4ec6b25fce
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix broadcast set state

When a stream changes state, the update is notified to other drivers
that registered a state changed callback. These callbacks might further
change the stream state, leading to the stream being freed. To avoid
use after free errors post notifications, this commit adds support to
ref/unref streams, to make sure that the stream is kept alive until all
processing is completed. This also updates the switch condition post
notifications, to handle the stream based on its current state.


  Commit: eaff473cd263b4780e5f73ea7638a35f49ea830a
      https://github.com/bluez/bluez/commit/eaff473cd263b4780e5f73ea7638a35f49ea830a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Use enabling state for bcast sink streams

This updates the stream state transition from CONFIG to ENABLING,
on enable for Broadcast Sink streams. This is done to differentiate
between streams discovered in the BASE after short-lived PA sync
and streams that have been selected and enabled by the user.


  Commit: 0b5cfc1badf061f7f8977212f819be23075ba5e1
      https://github.com/bluez/bluez/commit/0b5cfc1badf061f7f8977212f819be23075ba5e1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add support for syncing to multiple BISes

This adds support for a Broadcast Sink to synchronize to multiple BISes
from a Source.

BISes selected by the user need to be linked together and then enabled one
by one. The first enabled stream will enqueue all its links in a request
for PA and BIG sync. After BIG sync is established, the confirm callback
will be called for each BIS io created in the kernel. Each fd will be set
inside the corresponding link, even the links that have not yet been
enabled. The enabled links will be started as soon as the fds are ready.


  Commit: b92b857f2fb022f89dce3e1d495c226187668567
      https://github.com/bluez/bluez/commit/b92b857f2fb022f89dce3e1d495c226187668567
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Handle multiple bcast sink streams

This adds shared/bap support for enabling and starting multiple Broadcast
Sink streams. Stream enabling should fail if any other Broadcast Sink
streams are in the process of enabling or have been enabled for the same
source. Also, a stream that has been enabled and already has the fd set
should be started on the spot.


  Commit: 47da1efdc5843294cfaf9522624b3876e8ab2972
      https://github.com/bluez/bluez/commit/47da1efdc5843294cfaf9522624b3876e8ab2972
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Unset transport owner before owner free

This sets the transport owner back to NULL, before the owner object
is freed.


  Commit: e0e3c922f715aec65a1edcc7f78fe914203cee82
      https://github.com/bluez/bluez/commit/e0e3c922f715aec65a1edcc7f78fe914203cee82
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add Links property for broadcast transports

This adds the "Links" property for broadcast transports, which allows
upper layer applications to write and link transports together.


  Commit: 5b1dfd2721e25ee190b46dfc7a81240ab7652a5c
      https://github.com/bluez/bluez/commit/5b1dfd2721e25ee190b46dfc7a81240ab7652a5c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Document Links property for broadcast

This adds the "Links" property for broadcast.


  Commit: 3bafab44663605bc64d7022fbad2881392016162
      https://github.com/bluez/bluez/commit/3bafab44663605bc64d7022fbad2881392016162
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Set bap_update_links as transport op

This implements bap_update_links as transport op, since broadcast links
need to be handled differently for unicast, which only allows one link.
For broadcast, the property changed signal should be emitted everytime
a new link is added or removed.


  Commit: 2ec04e02601fbd6233501fdb74d9976a24995e52
      https://github.com/bluez/bluez/commit/2ec04e02601fbd6233501fdb74d9976a24995e52
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Make transport_bap_set_state part of BAP_OPS

This splits the transport set_state operation for unicast and broadcast,
by implementing it as a transport op. Unlike unicast, broadcast transports
need to be acquired/released separately, so changes in a transport state
should not affect its links.


  Commit: 7b63fe6bd4d01de09a51641bf9e87e1efb653b1f
      https://github.com/bluez/bluez/commit/7b63fe6bd4d01de09a51641bf9e87e1efb653b1f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Handle acquiring broadcast links

This adds support for acquiring linked broadacast transports: Each link
should be acquired separately, unlike unicast.


  Commit: 3075a9c17d161e45d1006bd091f0b5af9d09726b
      https://github.com/bluez/bluez/commit/3075a9c17d161e45d1006bd091f0b5af9d09726b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to select multiple transports

This updates transport select to link transports together before calling
the "Select" method for each of them.

The bluetoothctl log below shows a Broadcast Sink detecting
2 streams from a source and selecting both of them. After the
first transport is acquired, the link is created and the first
transport goes active.

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
Capabilities:
  03 01 ff 00 02 02 03 05 04 1a 00 f0 00 02 03 01
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 17:7A:80:64:A7:93 17-7A-80-64-A7-93
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# transport.select
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: broadcasting
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: broadcasting
[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 8 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: active

The btmon log shows that sync has been established with both BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 0 us (0x000000)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 6
        Connection Handle #1: 7
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 6
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 6
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 7
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 7

The second transport can then be acquired and it will go straight
to active, since the fd has already been set:

[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 9 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: active

The transports can them be released one by one:

[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: idle
[17-7A-80-64-A7-93]# Release successful
[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: idle
[17-7A-80-64-A7-93]# Release successful


  Commit: 06c94f0ac0558bd937f10486536da5c256643432
      https://github.com/bluez/bluez/commit/06c94f0ac0558bd937f10486536da5c256643432
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Unlink broadcast transport at release

This updates broadcast transport release to unlink stream from all its
links.


Compare: https://github.com/bluez/bluez/compare/806a552d53c7...06c94f0ac055

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
