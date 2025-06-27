Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1123C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012181; cv=none; b=djIbM0n3GgmaEWbHNSSyt20XP0WjjyMkkvO72T4Pw8P0zXcF0/CqauQ+RO92dNlPcpIIDWIBB/NN2VtGO0e+iiStVadjFQ8pNP26a3v0ko2qNEouvNP6WnKClXqDXcnapk3Ve4Vcyx0Umm4sYZ/M59exyEi5kg+xiqR9/9BELys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012181; c=relaxed/simple;
	bh=YTFEQ20Hh8rimIXuz50oWg0WggQ6h7N5n7CEAdc10tU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k/+udAP0He2k6d0b5F5Z5zrBCV8n8EJFuDP6epLdg0Du8dg8xjntbtJMHYbV2mVBn5W4q8nOkfN8K1D79IurX4anDSrCH/QDHhAYrdoq4Ajk2VoopG4OuG87nUDccyZl9cpdOTUTDM+BPOxLBEXhcZvnj6ZdPAnhnAMa1R2HH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UiqTmKaT; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UiqTmKaT"
Received: from github.com (hubbernetes-node-028f8bd.va3-iad.github.net [10.48.141.43])
	by smtp.github.com (Postfix) with ESMTPA id D86AF8C031B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751012178;
	bh=6NISdNud+3uF1g6KwO0LuyQwB/Ov+cnwBTbZ+4HP8lQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UiqTmKaTLwPh4EWbr3TdrSb+yTWAzzOMUJRnjBckP644qM3L1iJS/GsK7n5xXN0Ot
	 g4mg76CIDIMfZih16ZiN9dVf5Ln4+1+Xmq/7m49nJpYpKP18JdudG8BdTGSefD3ubx
	 Nz5nxn7ovCgJDXfKAJI1FgngTwQSmWppdV4Vni1w=
Date: Fri, 27 Jun 2025 01:16:18 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976514/000000-e51dfb@github.com>
Subject: [bluez/bluez] d8ecfd: doc: mesh-api: minor copy&paste fix
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

  Branch: refs/heads/976514
  Home:   https://github.com/bluez/bluez
  Commit: d8ecfd8287f457007125fceb0a639d47a89d8651
      https://github.com/bluez/bluez/commit/d8ecfd8287f457007125fceb0a639d47a89d8651
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc: mesh-api: minor copy&paste fix


  Commit: c19ef9b4866f033313f22b846b1acae764b9df2b
      https://github.com/bluez/bluez/commit/c19ef9b4866f033313f22b846b1acae764b9df2b
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/keyring.c
    M mesh/keyring.h

  Log Message:
  -----------
  mesh: keyring: constify


  Commit: bc49e71bba2fe2cdd3b971f1062a68508f76a4c6
      https://github.com/bluez/bluez/commit/bc49e71bba2fe2cdd3b971f1062a68508f76a4c6
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/mesh-config-json.c
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: mesh-config: constify

removing 2 prototypes where an implementation never existed


  Commit: 5b5eddad59bc547bf39e4c0e997542f459c2721c
      https://github.com/bluez/bluez/commit/5b5eddad59bc547bf39e4c0e997542f459c2721c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/util.c
    M mesh/util.h

  Log Message:
  -----------
  mesh: util: constify


  Commit: 5c6b993dacfcfb8182875fdd6d9a69dc93be7e94
      https://github.com/bluez/bluez/commit/5c6b993dacfcfb8182875fdd6d9a69dc93be7e94
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: mesh_net_transport_send: simplify

No need for internal copy of 'seq'.


  Commit: a68ecd526824676fbc33af9cef90aa9970174700
      https://github.com/bluez/bluez/commit/a68ecd526824676fbc33af9cef90aa9970174700
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


  Commit: 79ddf781f1bc3242996009ef66aeafe2c77b51cf
      https://github.com/bluez/bluez/commit/79ddf781f1bc3242996009ef66aeafe2c77b51cf
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


  Commit: dbd29ca4631df6d6fe97b405aa3fcd38ca5b9fdc
      https://github.com/bluez/bluez/commit/dbd29ca4631df6d6fe97b405aa3fcd38ca5b9fdc
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


  Commit: e51dfb5db16624db672b131924975abdfe637157
      https://github.com/bluez/bluez/commit/e51dfb5db16624db672b131924975abdfe637157
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M tools/parser/parser.h

  Log Message:
  -----------
  tools: parser: fix printf format errors

struct timeval members can be 32 or 64 bits which results in "long long
int" on some platforms. As there are no printf conversion specifiers for
time types, cast them to the longest possible types.


Compare: https://github.com/bluez/bluez/compare/d8ecfd8287f4%5E...e51dfb5db166

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
