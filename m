Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BB21E0BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272034; cv=none; b=azgXwiJvsYB2RVa+Iezn2XZpQxuQJN+JuROExrADs4r+lMVtjYRFyhKKaCM74ZrAvyvMkRB6aFWNdux1j4xCG/U13ClUNPM5bfnIjqKLPWhdN7P5BUQJ4XHE35ja5+HfsKoOpgByJJ3CvKuobzVlJPeOYesQcz62YQj+ncJiXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272034; c=relaxed/simple;
	bh=GC4Zwng2mP9MUNNSIBmgBuA1YdYFYpdaymlKTTvobz0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SSVMnenl3J/75tnXhb5nR53V+Ij9QxSWOG43hIagzUskW17EF0tUHapLQHtrrVZhQzZaHiZnGnK1oQRFb/X5Ch5n2suoL/8FEbQpb/lZ4ANQtZsS4sg3Cd/uFG2OdjzVKKvUUjtvL5qNO7qOg2YFA8I4y+JCXwMGODlQg/zrtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TYPLOg7j; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TYPLOg7j"
Received: from github.com (hubbernetes-node-741e309.ac4-iad.github.net [10.52.132.30])
	by smtp.github.com (Postfix) with ESMTPA id B83DB7005C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752272031;
	bh=NXiC5kCA/ZSv5Jnu+NkragIo7gxjdtwt8C34Ks5Lc7s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TYPLOg7jMIGB9tYq6QNonU6CJseZi3tYKDZLFwstH/k5RwMQI97MK+tS1xlOPGgXz
	 4SLLrGeKCMuv+4X97/KKiYyCIDJbt/n8LWo00gw7PBlqNac+tuRHkWXTPRC5ve/OUa
	 dr6uFuhB/poC+4RJRE7CBoa438zi/Wg35NUKA+4o=
Date: Fri, 11 Jul 2025 15:13:51 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981661/000000-ae801e@github.com>
Subject: [bluez/bluez] 0fc19d: mesh: net-keys: more uses of BEACON_LEN_SNB and
 BE...
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

  Branch: refs/heads/981661
  Home:   https://github.com/bluez/bluez
  Commit: 0fc19d15ff10c019747c60307c167aea069bf77e
      https://github.com/bluez/bluez/commit/0fc19d15ff10c019747c60307c167aea069bf77e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M mesh/net-keys.c

  Log Message:
  -----------
  mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB


  Commit: 6cbf85ad849eb3e9de8db1301103e2f78f217599
      https://github.com/bluez/bluez/commit/6cbf85ad849eb3e9de8db1301103e2f78f217599
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


  Commit: e85b0f0dd73face9b8571f484b7eb68b50e94e07
      https://github.com/bluez/bluez/commit/e85b0f0dd73face9b8571f484b7eb68b50e94e07
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


  Commit: dae63a77d15a16030b91287824013c7f38236ea9
      https://github.com/bluez/bluez/commit/dae63a77d15a16030b91287824013c7f38236ea9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


  Commit: 511e193044e6c9f1d2b72d4a822c7d9b145d8ecb
      https://github.com/bluez/bluez/commit/511e193044e6c9f1d2b72d4a822c7d9b145d8ecb
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


  Commit: 4f1cac447a1649b2a1a978154b6bc66c50d9ea54
      https://github.com/bluez/bluez/commit/4f1cac447a1649b2a1a978154b6bc66c50d9ea54
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: update comment

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")


  Commit: 1cc4bc94dacfab1393b0b01d66b16ebf391ba1e4
      https://github.com/bluez/bluez/commit/1cc4bc94dacfab1393b0b01d66b16ebf391ba1e4
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


  Commit: 4b2a1be80c602149fc32a968a71cf262fd33e941
      https://github.com/bluez/bluez/commit/4b2a1be80c602149fc32a968a71cf262fd33e941
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M mesh/crypto.c

  Log Message:
  -----------
  mesh: crypto: simplify mesh_crypto_packet_parse()

- NULL pointer checks are not required (no caller passes NULL pointers)
- reuse result of mesh_crypto_network_header_parse() rather than
  determining value of 'CTL' again.


  Commit: ae801e7eb04c70c5e8552da0922fbdc6013d86ed
      https://github.com/bluez/bluez/commit/ae801e7eb04c70c5e8552da0922fbdc6013d86ed
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

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


Compare: https://github.com/bluez/bluez/compare/0fc19d15ff10%5E...ae801e7eb04c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
