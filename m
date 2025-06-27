Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955AEEDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043486; cv=none; b=tHWMLgW9YjvKjEcwbCuIQEO9QVU+FYCqv6LdOthCpnTvfSf/dM87P0UqwvQ4BbgkQTK0F6GE/G0fwl9ewB9JhhYspnByZJIHIyHy3wcq62/E/i92rkYk+M4TNF4VYa5scKBsdQiIzU5Cnpoe0J77KonvPal90TkXbLXWyGLijtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043486; c=relaxed/simple;
	bh=mdTj+LjqGJ9kpTRIu429XzclAR068FSgig2azdXbB9s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=di/uf9c4O5K8QQXcG9WtgUSjMJR2EQvH0cTYPVTPe78U4CfIvEjvjG/oDGEcQrawtuaWn7b/CdaUp0+2P7E7CItZ1G5cWbeiYCuezmpgLYv7+v12s7PTiih1fPdL/n9Gj/SyzlEYEvvZ+o9Qoo2o4+383pAX4VTdW0meU0aowa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KRMGPVIQ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KRMGPVIQ"
Received: from github.com (hubbernetes-node-86730cb.va3-iad.github.net [10.48.155.33])
	by smtp.github.com (Postfix) with ESMTPA id 36551E126D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751043484;
	bh=+8QNnvXHINnnT6tnZlH5vJAQdAadc/Iyzp3fxutJqXM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KRMGPVIQtW6KqrINhXUKGJZALHGFYzZpcfW+7HLY6I5SsxamGi+I5PacZxkhKgRVC
	 xagDqtj7kKpxW7fp5E91L4LIbpIv+YSKhciNnco4Z1NPeC9AuVFx2ilGuI07e/mFLJ
	 jdKNk/YYpDnzO+9SuZiefS3reuNYyp3qaawaByAs=
Date: Fri, 27 Jun 2025 09:58:04 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dc7ca0-8e2425@github.com>
Subject: [bluez/bluez] 6983c9: doc: mesh-api: minor copy&paste fix
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
  Commit: 6983c985e08a8126bf75fde701a884450728be98
      https://github.com/bluez/bluez/commit/6983c985e08a8126bf75fde701a884450728be98
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc: mesh-api: minor copy&paste fix


  Commit: 5651fc8bf55cc687c13bd08309c1d9fd26968503
      https://github.com/bluez/bluez/commit/5651fc8bf55cc687c13bd08309c1d9fd26968503
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/keyring.c
    M mesh/keyring.h

  Log Message:
  -----------
  mesh: keyring: constify


  Commit: eb8ffa0f972144163576402aee59de6035f7701f
      https://github.com/bluez/bluez/commit/eb8ffa0f972144163576402aee59de6035f7701f
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/mesh-config-json.c
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: mesh-config: constify

removing 2 prototypes where an implementation never existed


  Commit: b913bd1b92a4ce1fe710972b4b453aa2d5feb509
      https://github.com/bluez/bluez/commit/b913bd1b92a4ce1fe710972b4b453aa2d5feb509
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/util.c
    M mesh/util.h

  Log Message:
  -----------
  mesh: util: constify


  Commit: 725a72ea654c2966f6d220ee39bbfca0369f1171
      https://github.com/bluez/bluez/commit/725a72ea654c2966f6d220ee39bbfca0369f1171
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: mesh_net_transport_send: simplify

No need for internal copy of 'seq'.


  Commit: 2874aeb4d05679b1d96009d84a13882ca34c3eac
      https://github.com/bluez/bluez/commit/2874aeb4d05679b1d96009d84a13882ca34c3eac
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/manager.c
    M mesh/mesh.c
    M mesh/node.c
    M mesh/node.h
    M mesh/provision.h
    M mesh/remprv-server.c

  Log Message:
  -----------
  mesh: node_add_pending_local: use concrete type

No need for using a void pointer here. Add const qualifier to passed
mesh_prov_node_info.


  Commit: 2a40b2f8e07a8b9bf564fd59a5d1847d9a46fb57
      https://github.com/bluez/bluez/commit/2a40b2f8e07a8b9bf564fd59a5d1847d9a46fb57
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/mesh-io.h

  Log Message:
  -----------
  mesh: remove unused function typedef

mesh_io_recv_ext_func_t has been introduced in
6a6fe856a900 ("mesh: rework incoming advertisement filtering").
According to 'git log -p <rev> master' it has never been used.


  Commit: 2251e6d796209258b15f95ccbfdf63ebd96b5752
      https://github.com/bluez/bluez/commit/2251e6d796209258b15f95ccbfdf63ebd96b5752
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  net: packet_received: avoid unnecessary copying

Since cca48f305b60 ("mesh: Fix Relaying for multiple nodes"), the packet
for relaying is assembled within send_relay_pkt(). So we do not need to
assemble a full packet within packet_received().

Additionally remove misleading initialization of 'msg' variable, the
value is assigned in all possible branches of
mesh_crypto_packet_parse().


  Commit: 8e2425dc2b2553803157d4bee52261e2f4d1ae73
      https://github.com/bluez/bluez/commit/8e2425dc2b2553803157d4bee52261e2f4d1ae73
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M tools/parser/parser.h

  Log Message:
  -----------
  tools: parser: fix printf format errors

struct timeval members can be 32 or 64 bits which results in "long long"
on some platforms. As there are no printf conversion specifiers for
time types, cast them to the longest possible types.


Compare: https://github.com/bluez/bluez/compare/dc7ca0e3b415...8e2425dc2b25

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
