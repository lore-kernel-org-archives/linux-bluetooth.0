Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6A155C97
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256356; cv=none; b=GikhTuNpWFH6H4MB6v8gjgAIqun9aOCnpVC8CCj9w6/m7FOUZhHS3ttpZ3ZyY4jolvMhxAzgdCdIxTnpoNcldXA2y+GOt6cgCwznjfub+1PLS7BJHUJ1EGb95qSL3kfzAldx2W3E6+0TQUUXMHefdB+JRE61M3UpPlvPHFxnCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256356; c=relaxed/simple;
	bh=my1fOBtIBB/+W5Vn4NX9CE+gYa14BwJsRJk3Qe5zIT0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oA3Bl8yIxjTPsn+TO5ymVJStk+EAPDV/UTAju+xcnNWbxC5YYPAx1wHCW72veaD6oAbhUisF/jGhC1U4v2IjjUQY9HjQj29quE7xWw7xhTgGMzgKyE6V7vO3vYvDKZ/o1XdM0YkiQI5E1xttv59guwmYVVFODJAuADSTgbrTUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GKQ09Kiz; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GKQ09Kiz"
Received: from github.com (hubbernetes-node-b2708b6.ash1-iad.github.net [10.56.146.44])
	by smtp.github.com (Postfix) with ESMTPA id 001B26009E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752256354;
	bh=MctnlviMcnQH/RRjp2RYR5H3TlUTB5c38sWhOjwjD9k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GKQ09Kizc+ybmEYlHZKeu45vRHMu+M8k1cZizym2/top7ibTrOdaMNocfP2d+qEmo
	 sZObdEaY1afnv9N8uTBiFogXoob9clUjDp7c65te7v93YnIQgelETo1ixJe+VQv3BG
	 CePuUkoUvQNdgHhlF5PxPMwoZZPp5fezQC4IlB68=
Date: Fri, 11 Jul 2025 10:52:33 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981618/000000-321f4e@github.com>
Subject: [bluez/bluez] c5bfab: mesh: net-keys: more uses of BEACON_LEN_SNB and
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

  Branch: refs/heads/981618
  Home:   https://github.com/bluez/bluez
  Commit: c5bfab4b7eb984b00e0cdb9f71e34d7b87653748
      https://github.com/bluez/bluez/commit/c5bfab4b7eb984b00e0cdb9f71e34d7b87653748
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M mesh/net-keys.c

  Log Message:
  -----------
  mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB


  Commit: b72101f07a2f3880ffaacd4a85917c5d43ff1843
      https://github.com/bluez/bluez/commit/b72101f07a2f3880ffaacd4a85917c5d43ff1843
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


  Commit: fe5fa8ab995192bececf2a1676a64ad1a56af00b
      https://github.com/bluez/bluez/commit/fe5fa8ab995192bececf2a1676a64ad1a56af00b
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


  Commit: f361b19b7b70368692a87f6cd5158a4e77a971e0
      https://github.com/bluez/bluez/commit/f361b19b7b70368692a87f6cd5158a4e77a971e0
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


  Commit: f42719cfa381b3b85edb53435cbc0eaffafdc2fc
      https://github.com/bluez/bluez/commit/f42719cfa381b3b85edb53435cbc0eaffafdc2fc
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


  Commit: 2dfb29867deb918ccd50b13a1b6db6c72b2915f9
      https://github.com/bluez/bluez/commit/2dfb29867deb918ccd50b13a1b6db6c72b2915f9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: update comment

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")


  Commit: cc707bf44c2d9ab5873aa38ee739510f880a8610
      https://github.com/bluez/bluez/commit/cc707bf44c2d9ab5873aa38ee739510f880a8610
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


  Commit: f93027c98b22abe9a5bf804134990a94e5786a6a
      https://github.com/bluez/bluez/commit/f93027c98b22abe9a5bf804134990a94e5786a6a
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


  Commit: 321f4e0ae55f2101b03c71ca183401d60cdf5df8
      https://github.com/bluez/bluez/commit/321f4e0ae55f2101b03c71ca183401d60cdf5df8
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


Compare: https://github.com/bluez/bluez/compare/c5bfab4b7eb9%5E...321f4e0ae55f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
