Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6BE55B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003136; cv=none; b=kxuofXXxSXp4MbAXuCOCEJk6etF49zgX1NwKXzcfnV5sMk9qF9ogbhjgL00fPOsyXe/aoolKg18oZVS3mDxtH+Vw6Q2T4Hp8Avu6SGueW1Mrb6TB7CXFyHE00a5nMWbbBz7VOazbH0XCrFBoH3dHMk0D5mDrG1TkiHy5D1TO9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003136; c=relaxed/simple;
	bh=En80ib9LkWxoof7VgSqxBW6EhzAxLT51RmhNrmxkNRE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Iz+0o/4FZ4OBqtFYDSzc7FY3yBEGBSrLEIXZgqbIkNwP3DWbZQHB77h7PPBdWMQn0MRdiuIQe+a6xQ1AojAZcajqZY25BQ9YJD2oY752OD29bMwBtW0LUn7eOc+8avqW1FwLp3tLZGrwcOp+U0srcsB6bKFmm03Neqmqfj8Fw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FqUEgiD1; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FqUEgiD1"
Received: from github.com (hubbernetes-node-9144770.ac4-iad.github.net [10.52.158.57])
	by smtp.github.com (Postfix) with ESMTPA id D01F52005E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752003130;
	bh=PI1SphylmajAF4smafHL/ayn7Ea7xQEZjyp4xkVBbW4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FqUEgiD1SKxhE0JMpmJtpYf07gR4pzLCoB20/Ew5ZbAFSjyNwbyEoCkCj2AZ+05Ln
	 7YIrDWOd5SYoLAHwLm2fWvKJqZPn+hgHmsvErMFnHqaGJsthRgupscKbm/Tf6X59jM
	 XhZQUF2km/CChpzdPyCAf7GeIxwjX5+P7FrMNrro=
Date: Tue, 08 Jul 2025 12:32:10 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9ed79e-a3824b@github.com>
Subject: [bluez/bluez] 441f05: mesh: crypto: remove dead function declaration
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
  Commit: 441f0539a1f8cd228746309d71386f51b7595bda
      https://github.com/bluez/bluez/commit/441f0539a1f8cd228746309d71386f51b7595bda
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.h

  Log Message:
  -----------
  mesh: crypto: remove dead function declaration

The implementation of mesh_aes_ecb_one() has been removed in commit
dfed4839463f ("mesh: Convert crypto to use ELL wrappers").


  Commit: e1b2647179c5c3475ca0e5645916bdf7b62b70c6
      https://github.com/bluez/bluez/commit/e1b2647179c5c3475ca0e5645916bdf7b62b70c6
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/crypto.h
    M mesh/net.c
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  mesh: crypto: remove unused function parameter

The 'relay' parameter isn't used by mesh_crypto_packet_build().


  Commit: 2d012a2f629cb0a5ffadd50af519233beaa9ee66
      https://github.com/bluez/bluez/commit/2d012a2f629cb0a5ffadd50af519233beaa9ee66
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/friend.h

  Log Message:
  -----------
  mesh: friend: remove dead function declarations

The implementations for these functions have been removed in commit
f246d31a7752 ("mesh: Friendship clean-up and rewrite").


  Commit: 797b330b9ff5150d9797678972584da3485d9df3
      https://github.com/bluez/bluez/commit/797b330b9ff5150d9797678972584da3485d9df3
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: mesh-config: remove dead function prototype

mesh_config_write_address() has been added in commit 78668a02d6c4
("mesh: Change mesh_db prefix to mesh_config"), but an implementation
has never existed.


  Commit: 806aa9de2b426870b1518d8f68179d538cfd6bfe
      https://github.com/bluez/bluez/commit/806aa9de2b426870b1518d8f68179d538cfd6bfe
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/mesh-io-mgmt.c

  Log Message:
  -----------
  mesh: mesh-io-mgmt: Fix NULL pointer dereference

Don't try to dereference 'pvt' if it's NULL.


  Commit: d40ed08f446e4d3cdd3d02a8b20d9a66d8a5abdf
      https://github.com/bluez/bluez/commit/d40ed08f446e4d3cdd3d02a8b20d9a66d8a5abdf
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/model.h

  Log Message:
  -----------
  mesh: model: remove dead function prototype

mesh_model_cfg_blk() has been added in commit 6fbc4c83e134 ("mesh:
Header files for mesh access layer and utilities"), but an
implementation has never existed.


  Commit: 2d9afa114507d8046e5b7be53471624c513a93ff
      https://github.com/bluez/bluez/commit/2d9afa114507d8046e5b7be53471624c513a93ff
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: remove obsolete struct net_key

'struct net_key' has been introduced in commmit 37ebf9eb0bf9 ("mesh:
Upper and Lower mesh transport") and became superseded in commit
994932b740c7 ("mesh: Refactor friend.c and net.c for central key DB").


  Commit: 0cb00fce1b3ef1ed49b33ca0e203c68c9feb85ff
      https://github.com/bluez/bluez/commit/0cb00fce1b3ef1ed49b33ca0e203c68c9feb85ff
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/net-keys.c
    M mesh/net-keys.h

  Log Message:
  -----------
  mesh: net-keys: introduce BEACON_LEN_SNB, BEACON_LEN_MPB, BEACON_LEN_MAX

Lets introduce symbolic names before spreading these magic numbers over
more locations.


  Commit: 41b4b531beb83d6906c26ff90f576e33f5ef2ba5
      https://github.com/bluez/bluez/commit/41b4b531beb83d6906c26ff90f576e33f5ef2ba5
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/net-keys.h

  Log Message:
  -----------
  mesh: net-keys: remove dead function prototype

net_key_snb_compose() has been made static (and renamed) in commit
5ba57cf85140 ("mesh: Add Tx/Rx support of Mesh Private Beacons").


  Commit: 6ef0f297235d897533dc29809f0f74367f574e85
      https://github.com/bluez/bluez/commit/6ef0f297235d897533dc29809f0f74367f574e85
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/node.h

  Log Message:
  -----------
  mesh: node: remove dead function prototype

node_init_from_storage() has been made static (and renamed) in commit
7cafe5fd7cc8 ("mesh: Manage node config directory in mesh-config").


  Commit: e29506315cc87429a05a25f16a6b3279a300e574
      https://github.com/bluez/bluez/commit/e29506315cc87429a05a25f16a6b3279a300e574
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/prov.h

  Log Message:
  -----------
  mesh: prov: cleanup header

Most stuff in this file isn't been used.


  Commit: 4e5a3a80a8425d144ba70b23b02a1bed0d89c352
      https://github.com/bluez/bluez/commit/4e5a3a80a8425d144ba70b23b02a1bed0d89c352
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/friend.c
    M mesh/mesh-io-mgmt.c
    M mesh/mesh-io-unit.c
    M mesh/net.c

  Log Message:
  -----------
  mesh: remove unneeded casts to bool

The result of these expression is already of type 'bool'.


  Commit: a3824b4aac0e894699ca2643af5887239a6c489a
      https://github.com/bluez/bluez/commit/a3824b4aac0e894699ca2643af5887239a6c489a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/net.c
    M mesh/net.h

  Log Message:
  -----------
  mesh: use '0x1' rathen than 'true' for bit operations

Although 'true' expands to 1, it feels more natural using '0x1' (or '1')
when performing masking or bit shifting operations.


Compare: https://github.com/bluez/bluez/compare/9ed79eedc075...a3824b4aac0e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
