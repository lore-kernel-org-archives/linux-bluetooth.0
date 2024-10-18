Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72112D7BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260961; cv=none; b=NO135P+EF3nGc327sfpmBpX39CFFb3QSypUSGE3hLAiZVDLKHtEehCDYlqyCRKUB87NhXI7F1iVSJ0bL49tIXVotnQGz8KUU90lBg2iF3huBL3vN9Lo23E8VAH8RTY3EU+DWI+i0mpfSBP5xpHLYBMplqeUDjyAysle6AanR7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260961; c=relaxed/simple;
	bh=CDbuE8DmEV2slVsPDr+qopkduSM84I4SyV0WIhSyNAU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=etk1YXYyEOKZcpmhaYOZWSafEHPUdS7kyJfoq3JWdQBxRZlqTqwwT5fFzPNVe/ejVq+JLQ6o8pl7e8DfApOASNBc7hfBR01JiOR/Y7VLuflrY5Fdyv+2uAe/OE59onHbgETVzfHmSl3oDRONYpNXgujqp95LvsjAHNjN39pPZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XvlWMD4z; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XvlWMD4z"
Received: from github.com (hubbernetes-node-ef6d4bc.ac4-iad.github.net [10.52.148.38])
	by smtp.github.com (Postfix) with ESMTPA id B4FFC641061
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729260958;
	bh=s2aEyB5GJQtKGFLPJuB4WYFpqNbr3NUTV+lKAS1/nNs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XvlWMD4z0aHSQWORRoIJ7TZ7Ewv1RJpM1lA6+Y2eLCtXuZVeAzzbUkpEqKslh5+DQ
	 xcR3h5cHPwmThDDFrE7RdxDOWXoD9lRCOgiIslK7D8z2y6f7dFXY4YWI4FdH88wBhm
	 QRDRBJf5k3cXoAoQtZE4g0uzPs4p1cVxJzSAHH+4=
Date: Fri, 18 Oct 2024 07:15:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3d9900-b5b510@github.com>
Subject: [bluez/bluez] c1d01a: avdtp: Fix triggering disconnect_timeout while
 dis...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c1d01a378f23549e57c6d439cfa740c8b32ecc17
      https://github.com/bluez/bluez/commit/c1d01a378f23549e57c6d439cfa74=
0c8b32ecc17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix triggering disconnect_timeout while discovering capabilities=


If there are many endpoint registered it may delay the discovering of
the capabilities long enough to trigger diconnect_timeout which may
cause unexpected collisions/disconnections.

Fixes: https://github.com/bluez/bluez/issues/981


  Commit: ee6f3a837e325184ea1009b94dee20411480844e
      https://github.com/bluez/bluez/commit/ee6f3a837e325184ea1009b94dee2=
0411480844e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-17 (Thu, 17 Oct 2024)

  Changed paths:
    M client/main.c
    M client/mgmt.c
    M src/shared/shell.c
    M src/shared/shell.h
    M tools/bluetooth-player.c
    M tools/btpclientctl.c
    M tools/mesh-cfgclient.c
    M tools/mesh-gatt/util.c
    M tools/mesh/util.c
    M tools/meshctl.c
    M tools/obexctl.c

  Log Message:
  -----------
  shared/shell: Fix not handling prompt with color properly

Colors use escape sequence that needs to be enveloped with
RL_PROMPT_START_IGNORE (\001) and RL_PROMPT_END_IGNORE (\002) in order
for readline to properly calculate the prompt length.

Fixes: https://github.com/bluez/bluez/issues/965


  Commit: b30b1eddb4b3d69968f18c943139f4aa0018d1b3
      https://github.com/bluez/bluez/commit/b30b1eddb4b3d69968f18c943139f=
4aa0018d1b3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-10-17 (Thu, 17 Oct 2024)

  Changed paths:
    M tools/obexctl.c

  Log Message:
  -----------
  tools/obexctl: Add support to connect using PSM port

Since commit 5d7d3ac25bd5 ("obexd: Add PSM support to session create")
obexd supports to connect the session using a L2CAP PSM.


  Commit: b5b51017ea1818712137bc03d0eba49204e5bc4e
      https://github.com/bluez/bluez/commit/b5b51017ea1818712137bc03d0eba=
49204e5bc4e
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-10-17 (Thu, 17 Oct 2024)

  Changed paths:
    M obexd/plugins/ftp.c
    M obexd/plugins/opp.c
    M obexd/src/obex.c

  Log Message:
  -----------
  obex: Move size emit signal to plugins instead of obex.c

Instead of emitting the property "Size" from obex_put_stream_start(),
Call the function manager_emit_transfer_property() from plugins/*.c
wherever plugin has transfer object present.
Remove the code from obex.c which is generic for all profiles.

This change resolves the type mismatch issue when calling the
manager_emit_transfer_property from obex.c. We are passing
'os->service_data' of plugin session type but the
manager_emit_transfer_property() expects the 'obex_transfer'
type, therefore size is not set properly and might cause
crash/disconnection.


Compare: https://github.com/bluez/bluez/compare/3d9900eb754d...b5b51017ea=
18

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
