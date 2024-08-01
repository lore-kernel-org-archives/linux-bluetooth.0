Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68794170A29
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504725; cv=none; b=JYvFsGqea4uFW0MRobXwv6H9CTU0D7H4yEWFM0j08OE9uL0CEsqKG5fdLfO+4Uy69bYe79nbbSV11g7dMWPDUfXqzRDnkJ2V0Qae8Hb+9/RtpGYjiWHlSlLm3707b7AVwFFIu3b60tsZAn85r/gDYNfhgq1Cb6inTQv9R0pm7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504725; c=relaxed/simple;
	bh=I4YZiAvV95bfui+Tf3fzlfwWc9yAipwR9TiziRupok8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MjKUHeR0/+U1CFECPmn93MkVMW/VtEyL4/CFuyEZXI7MDjEqwj0xuLy3YrAoPhDEHwR2c2JlLosxpl4BwrwSVP/zy02BX8F4agxv1X/rcNy0JUNhEUk0Lh29TknWF6+5c6FwWe8dv+9PzSlsd93M0TciAoIXez9alr9N0K4fOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=amwzNHGh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="amwzNHGh"
Received: from github.com (hubbernetes-node-1b3c1fc.ac4-iad.github.net [10.52.153.31])
	by smtp.github.com (Postfix) with ESMTPA id 82936641165
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1722504722;
	bh=Sy5JTc4XiQLOnRjgIIn13ndu+hIDKzrk/Ok2vyHvvJM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=amwzNHGhJgPgDZQmoku0p3p3G+cQiTtu/pfkXcWcL3BVMBACrb7pYyGryNSKroCsU
	 FmufDSBnxjAl2YQ80frrjZL7Vp3CY4CNQGTkItCJjFYeGj+iD4hdFhhM7CQ+XmLgQ6
	 Qs+OV/ViDjKgHsBsHe+jnyHShCHErVSl9yi8ZcNE=
Date: Thu, 01 Aug 2024 02:32:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/549d38-998104@github.com>
Subject: [bluez/bluez] d7b7f3: doc/media: Add 'broadcasting' state and
 'Select' m...
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
  Commit: d7b7f3a39562ca6341254a711ce079b6b8185cd1
      https://github.com/bluez/bluez/commit/d7b7f3a39562ca6341254a711ce079b6b8185cd1
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Add 'broadcasting' state and 'Select' method

This adds a new state for transports created by the Broadcast
Sink. Such transports will remain  in the 'idle' state until the
user calls 'Select' on them, at which point they will be moved to
'broadcasting'. This allows the user to select the desired BIS as
the audio server automatically acquires transports that are in this
state.


  Commit: 9357edb87bb98c74677f4c5548a4fe2d589230f8
      https://github.com/bluez/bluez/commit/9357edb87bb98c74677f4c5548a4fe2d589230f8
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add 'broadcasting' state

This adds a new state for transports created by the Broadcast
Sink device as a result of scanning a Broadcast Source. Such
transports will remain  in the 'idle' state until the user
selects them using 'transport.select', at which point they will
be moved to 'broadcasting'.


  Commit: 083d1a7b66b5c495d2545670d5d255aef340dbf9
      https://github.com/bluez/bluez/commit/083d1a7b66b5c495d2545670d5d255aef340dbf9
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add 'Select' method

This adds the 'Select' method for Broadcast transports. It's role
is to change the transport's state from idle to broadcasting. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.


  Commit: 61e16e3b831754368599fc619ddac31f0db48571
      https://github.com/bluez/bluez/commit/61e16e3b831754368599fc619ddac31f0db48571
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Expose transport 'Select' method to the user

This exposes the 'Select' method for Broadcast transports. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.


  Commit: 53a4078cb350f630b19f7fe6ea32dd4e1c01b7bb
      https://github.com/bluez/bluez/commit/53a4078cb350f630b19f7fe6ea32dd4e1c01b7bb
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Broadcast sink: wait for user to select transport

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.


  Commit: c7e79fa8bfffff1c7b76cd32ff925ab4613ceb45
      https://github.com/bluez/bluez/commit/c7e79fa8bfffff1c7b76cd32ff925ab4613ceb45
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Add 'Unselect' method

This adds the documentation for a new method, exclusive to transports
created by the Broadcast Sink. It would allow the user to terminate the
sync to a BIS, via a 2 step process. The first step is the call to this
method, which changes the transport's state to idle, with the second step
being done by the audio server which detects this change and releases
the transport.


  Commit: 6ee75c3ec383c664cd7e7be02e951999758a6c4f
      https://github.com/bluez/bluez/commit/6ee75c3ec383c664cd7e7be02e951999758a6c4f
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add 'Unselect' method

This adds a new method, exclusive to transports created by the Broadcast
Sink. It allows the user to terminate the sync to a BIS, via a 2 step
process. The first step is the call to this method, which changes the
transport's state to idle, with the second step being done by the audio
server which detects this change and releases the transport.


  Commit: 827416638289d901fe5b2bc747fc33cff8b7db99
      https://github.com/bluez/bluez/commit/827416638289d901fe5b2bc747fc33cff8b7db99
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Expose transport 'Unselect' method to the user

This exposes the 'Unselect' method for Broadcast transports. This
allows the user to terminate the sync to a specific BIS, via a 2
step process. The first step is the call to this method, which
changes the transport's state to idle, with the second step being
done by the audio server which detects this change and releases
the transport.


  Commit: 720e8ec9760b8d8bfb565e535bd311bbc8273a76
      https://github.com/bluez/bluez/commit/720e8ec9760b8d8bfb565e535bd311bbc8273a76
  Author: Alexander Ganslandt <alexander.ganslandt@axis.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Set handle before calling print functions

The print functions (print_service, print_chrc and print_desc) all print
the handle, but the handle is never set in the struct object. This
results in the handle always printing as 0x0000. Set the handle before
calling the print function.


  Commit: 8a708aa5f04613768e903d243a7261efd202ea88
      https://github.com/bluez/bluez/commit/8a708aa5f04613768e903d243a7261efd202ea88
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix crash parsing notification

This fixes the following crash caused by notify callback being NULL:

Jump to the invalid address stated on the next line
   at 0x0: ???
   by 0x1E8375: print_notify (att.c:5420)
   by 0x1E9464: att_multiple_vl_rsp (att.c:5463)
   by 0x20D39E: att_packet (att.c:5637)
   by 0x1B2054: l2cap_frame (l2cap.c:2567)
   by 0x1B4A4D: l2cap_packet (l2cap.c:2708)
   by 0x19AD43: packet_hci_acldata (packet.c:12522)
   by 0x19CF07: packet_monitor (packet.c:4249)
   by 0x152405: data_callback (control.c:973)
   by 0x2204F6: mainloop_run (mainloop.c:106)
   by 0x221017: mainloop_run_with_signal (mainloop-notify.c:189)
   by 0x14F387: main (main.c:298)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd


  Commit: fe703a0058d8271a259885d3da4e886400cf4245
      https://github.com/bluez/bluez/commit/fe703a0058d8271a259885d3da4e886400cf4245
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not setting metadata

bt_bap_stream_metatada shall not send Update Metadata if the states
don't allow it, instead it shall store it so it can be send later when
enabling the stream.


  Commit: 998104507ba103ae0c83641d381794bf11dd46e0
      https://github.com/bluez/bluez/commit/998104507ba103ae0c83641d381794bf11dd46e0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not setting metatada

Fix not using bt_bap_stream_metadata when configuring a new stream as
the endpoint/client may have set it.


Compare: https://github.com/bluez/bluez/compare/549d38852f66...998104507ba1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
