Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF02AE8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590463; cv=none; b=JaeK0ENroEiMv6NkXNjODLUAgwhNzP5jjy2NLCeS+ne4zLJV6SnPI3/ACRWrxIGYYgAdnX8cgg/+zTftFDl9IrtMeK34tkIRtsXdEF0+5bP3tiHtaEr94HzoIj1FIHH+xMoXRNJGUAqhibx7xR6GvnUCSNRevzZbWDSjG/OAz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590463; c=relaxed/simple;
	bh=Fc3V58y+DgsL84VmtGSzTSp+aQ0gBx/hKP3ni9riOH0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XTcsd1MLd9BPi4SKFwDyb0k4NGBN4htHKWcoJmuaTuqxxBJCzItr6KD2d313JYio4ySozduCghd83ss+lzD/ZpXUIHGARKa8ftpkfGKzKsIAcCPpYnSarfQvg4dw/1rL77ZIgPC3wYA0FY6ZyiU5NwB+i6tf2hoFoUf8FX2xZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NU0SZYlg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NU0SZYlg"
Received: from github.com (hubbernetes-node-6d3bd38.va3-iad.github.net [10.48.204.41])
	by smtp.github.com (Postfix) with ESMTPA id B83218C038C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752590460;
	bh=Or+diNU2Q4ohIXQPBH7agIEgk3BK9OW/a83suG1HTZs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NU0SZYlgCDsT/V0tONg5Xl41MgnYxTK/vlOyBhmNDBkxYmLr2c8cEoCEEMd2A3GR7
	 nyCYIExfgNLU51lf7VblCpV51FZIXpVM6dMKtfF1iF6yX9nDfGsF2OLV88gCpJY5dK
	 dgc6giDDYnj89bxEmqP16tjqZCc3aGjfU3mEJiOg=
Date: Tue, 15 Jul 2025 07:41:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b0a138-8c9977@github.com>
Subject: [bluez/bluez] ddec33: tester.config: Add missing drivers
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
  Commit: ddec3358fe5cd991c4da89b35dbfff0058b0434a
      https://github.com/bluez/bluez/commit/ddec3358fe5cd991c4da89b35dbfff0058b0434a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M doc/tester.config

  Log Message:
  -----------
  tester.config: Add missing drivers

This adds missing config options to enable all drivers which is required
in order to catch build problem with github CI workflow.


  Commit: 009cfb5188f8287819cb73ae4910dc55b659e41c
      https://github.com/bluez/bluez/commit/009cfb5188f8287819cb73ae4910dc55b659e41c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/net-keys.c

  Log Message:
  -----------
  mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB


  Commit: 646cbe922792f1c299703c111a41c0c959a9d045
      https://github.com/bluez/bluez/commit/646cbe922792f1c299703c111a41c0c959a9d045
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/mesh-defs.h
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh-io-unit.c
    M mesh/net-keys.c
    M mesh/net.c

  Log Message:
  -----------
  mesh: introduce MESH_AD_MAX_LEN and MESH_NET_MAX_PDU_LEN

Use symbolic names rather than magic numbers. Remove unneeded extra
pointer in send_seg().


  Commit: cd651d8e21d785399086e1e6136267e407c1e863
      https://github.com/bluez/bluez/commit/cd651d8e21d785399086e1e6136267e407c1e863
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/manager.c
    M mesh/mesh-defs.h
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh-io.c
    M mesh/mesh.c
    M mesh/net-keys.c
    M mesh/net.c
    M mesh/pb-adv.c
    M mesh/prov-acceptor.c
    M mesh/prov-initiator.c

  Log Message:
  -----------
  mesh: replace MESH internal defines by shared ones

Replace BT_AD_MESH_* by MESH_AD_TYPE_*.

Both sets of definition have been added almost at the time, so maybe
it was a 'race condition'.


  Commit: b692d72b15b3d732a482d342db1d5934fc84a8b8
      https://github.com/bluez/bluez/commit/b692d72b15b3d732a482d342db1d5934fc84a8b8
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: constify tx path

Although the first byte of network packets has the same value for all 4
'send' functions, it feels much more natural to assign this byte at the
location(s) where the packet is assembled, rather than where it is sent.
This improves the readability because send_msg_pkt() isn't called with a
partially uninitialized buffer anymore.


  Commit: 0e586df2d0aecd181714191b2c62c83657d380fd
      https://github.com/bluez/bluez/commit/0e586df2d0aecd181714191b2c62c83657d380fd
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/net.c
    M mesh/net.h

  Log Message:
  -----------
  mesh: net: remove unused stuff

'struct mesh_key_set' and 'struct net_decode' arent't used anymore since
commit 994932b740c7 ("mesh: Refactor friend.c and net.c for central key
DB").

'mesh_status_func_t' isn't used anymore since commit c4bf0626fb62
("mesh: Replace storage_save_config with mesh_config_save_config").


  Commit: cb4b20c71fd3c426902b853cb70e8ffdfea7e85f
      https://github.com/bluez/bluez/commit/cb4b20c71fd3c426902b853cb70e8ffdfea7e85f
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: update comment

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")


  Commit: 9a32ff5aa7ed1d744f0d70403fe7851d8e0ad7c0
      https://github.com/bluez/bluez/commit/9a32ff5aa7ed1d744f0d70403fe7851d8e0ad7c0
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/crypto.h
    M mesh/net-keys.c
    M mesh/prov-initiator.c
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  mesh: crypto: mesh_crypto_aes_ccm_encrypt(): remove unused parameter

The 'out_mic' pointer isn't written by this function and all callers
pass a NULL pointer for this. It's obviously not required (and would not
work), so lets remove it.


  Commit: 159101c7bc38da3b2ca2f791ccca4cedb8da8a0c
      https://github.com/bluez/bluez/commit/159101c7bc38da3b2ca2f791ccca4cedb8da8a0c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/crypto.c

  Log Message:
  -----------
  mesh: crypto: simplify mesh_crypto_packet_parse()

- NULL pointer checks are not required (no caller passes NULL pointers)
- reuse result of mesh_crypto_network_header_parse() rather than
  determining value of 'CTL' again.


  Commit: 2b0a6fa0840715bbffe5b7a2195795575ce14600
      https://github.com/bluez/bluez/commit/2b0a6fa0840715bbffe5b7a2195795575ce14600
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/net-keys.c

  Log Message:
  -----------
  mesh: fix corrupted relay packets

Currently, all relayed packets are broken!

At the point when net_key_encrypt() is called from net_rx() for
encrypting a relay packet, the packet size must include the NetMIC
field. But the length of this field has already been removed during
decryption of the incoming packet (by decrypt_net_pkt()), although
mesh_crypto_packet_decrypt() has correctly reset the NetMIC field to
zeroes.

Move stripping of the NetMIC field length from decrypt_net_pkt() to
mesh_crypto_packet_parse(), so that the field length is only stripped
from the payload message (but keeping the field length for the network
PDU). Additionally add extra length checks during parsing.


  Commit: 8c9977b02169621f4643106c18de4de9824485a9
      https://github.com/bluez/bluez/commit/8c9977b02169621f4643106c18de4de9824485a9
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix RemoveDevice timeout when device already disconnected

When attempting to use RemoveDevice to delete a BIS source device that
was synchronized by the BIS sink scan delegator, the kernel marks the
device as disconnected due to PA(period adv) sync termination. However, BlueZ is not
notified of this disconnection and still proceeds to send MGMT Disconnect
command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
does not currently handle as a successful case. As a result, the RemoveDevice
call never completes and no D-Bus reply is returned.

Fixes: https://github.com/bluez/bluez/issues/1421


Compare: https://github.com/bluez/bluez/compare/b0a1386f98c2...8c9977b02169

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
