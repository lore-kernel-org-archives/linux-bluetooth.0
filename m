Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795137222;
	b=oesaNS0JiI6fg39a+9j6/1lyUy+V9fc1JwDDKjyCosM1B6njpHmGVH7Lbrii/S2KGM+K
	 cHm6BVKSuUXxltVU8uIuAKFAW48uPYmIzBFnD7Fx3eAa4RUstTdYu4ExJNoFGO6zT1M7K
	 /mkBFG9T3SnwnRXKF51uq+osQM4DVuYKL4T3LD5Q/KW3JE2oyUjDS8dOKF3V4tq6qpJyQ
	 cdO+oakKvHDaBjG1CSGcvI+0Tdy1L+e6feBNqpqLAbUD1inYw9n07Lc51DKvGZWo8cnK3
	 jl6LoE9l0NlUNQNUdunZWam0F/CfT32A36YsUoGrn0O6ecDBnTqn5AnsYjIR9dXNi1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137222;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4+N34wH9vfHLS4WrXIYkFEqFjJc0yjIlWDzHKwe4kRk=;
	b=fIp1co0SS07215833+AspogEt0Nt8Ll7Hn1+xaTs2KL6uAlLAoRamE15rSroslGG5yGr
	 qgRpl/Eh6reNQwwprpbYWf9ZdGvL0YUi7FiSUYCZ01VX0gUdehlblclKLPzRHku04Uu2F
	 c6iE3kFJXdTb8xML0uOOrYOb+woPXlsIje7p3MeNsWzlMtLOoMI483PG2AUkbsU74pMg9
	 LUnjPYPq/L2NM5eX0K2rjEwDB3Fkhgem2EFmuWg6m/dgXfb5RVvVHaEdfy02xQeUO4NY0
	 rtqiO47Bn+DqQ9CWl6BS5EmSnhCXQtAMp634/r7XmllRqnwA6JsoNocqEg8dB+UsmLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLDKk15X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB08606A325;
	Fri, 20 Nov 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLDKk15X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795137222;
	b=UWGzaBACcDPWLWlD2IXUnaxATGtl0cFOd3IhYlY12KR6tZR3yz1LdThhHh0dkSUt9ZWS
	 4f0dXItI9v7BjbERiUXgi80R6AXSW3IpJShrGTlSD2EnFlo2XnP/yglls3J5W3WeyzdLb
	 7YXGSN3Gn5CsiRugJmlko8rjvf+vStyL1SangIGwuXGqnfj+ByB215qHpWHQKckGIj1r4
	 LfOrR6kbbBmgZh3AtHZgIu5Fp3IPb3MPor7KENqfGz9ueiKRkwpvcdPF61mJB6UnLR+H1
	 JrkyDvF6msoC0ddIuTtbb54s/TwVhlp/cuq+Y+wRlWOp7i1D34ZxGdx0q8MVcGGOMPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795137222;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4+N34wH9vfHLS4WrXIYkFEqFjJc0yjIlWDzHKwe4kRk=;
	b=2FDG52neYJVwI4xDylejMTJqEKKv06HsrP/HsPf384aBBhdXfEmMB9Xi4NI4Uiwzm/P+
	 mhrn69yi5KIYYIQ6bw3QzN4HTQMQmovIYvi6RqaMqb/k2f96tyRxgwApYMjuSOaBAFryu
	 zTWvyOwrmL0AnzhhwLbzhdfldCluBgYPxDlsmEDOcf94lLmwCI85LW/bP3gMuV9K0PYQ4
	 xORnFaimAUOk1O1VU6nh8ciskN/UQpDUUe3KjX/Jo3GcrgV9WwPKNACobmCDSDHYyQiAK
	 vtk5qfhCxhlro4Wlm2hfV01cVFTIZCYCNEuAczZo9C3/1RU/SIqDewQpTWhw/4Cdlxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 93AFF1F000C4;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795137222;
	bh=4+N34wH9vfHLS4WrXIYkFEqFjJc0yjIlWDzHKwe4kRk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=dLDKk15XdPjvj0oUsvnaayn4j+3UVGkkwPPPfyWxjFbXYl/7lj3wx0wn6IUGONGrT
	 OAnM2x4YagNBOmBkPvoQOQ29szfbYiVpuTYpUNi7W3tlGNTxyS9fmWYesKi7ooo9et
	 MDBAPHhuVmVmwWcobN6GM2zMNjLaiwjcyvRsyz+UFbwAn8MBdKYq1v8IzXqrFEx36f
	 2UN+9Q6tH5HKH9xDdHTzDVCnkMHtOk+Mq8PN3FChzIlK/3jk0RdZ2M2IfY96oBgxRV
	 SBFewulJGKOG7EcFFu6TbnMpQRrkQTW+7AadYIBhgDSuCjBHhN+W45GJf2v96+8sBK
	 A+T9z+YCWyCaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 255A64260F;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
From: Thomas de Gruijter via B4 Relay <devnull+thomasdegruijter.pm.me@kernel.org>
Subject: [PATCH 0/2] Bluetooth: MSFT: Only enable the advertisement filter
 with monitors
Date: Fri, 20 Nov 2026 02:13:34 +0100
Message-Id: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQBPyhVykuGp3oSE1kJpaCe
 HfTdvkt3jtASZgU7tUBQm9WTrHA3ioY5mecCHksBmdcY60zuGrIGPiVSXBNkXMSRVNT67vgG9v
 WUNJNKPDnt330f+vuFxry9wXneQEdqSFXeAAAAA==
X-Change-ID: 20261120-msft-filter-monitors-05e7b8fb6175
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Brian Gix <brian.gix@intel.com>, Yun-Hao Chung <howardchung@google.com>, 
 Miao-chen Chou <mcchou@chromium.org>, Archie Pusaka <apusaka@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas de Gruijter <thomasdegruijter@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795137220; l=2581;
 i=thomasdegruijter@pm.me; s=20261120; h=from:subject:message-id;
 bh=8/AuYm0ked8MCkDMwRkqznLi5F2SKWqBi78N6Aa7kMI=;
 b=AphLmhqzHZxMDtYf0VAg+/x/lgsXYSXgkcQBKjrS4dPXrmKocw1a04GmEI6I/mcRTS/3quUOP
 Jo9s4NXGOKmCxiILM75AwxlizDUzGHcgpgfsZh56HcVxTXsfugmB7bX
X-Developer-Key: i=thomasdegruijter@pm.me; a=ed25519;
 pk=YtEZHHXdsASGVJkddpdFLAnfVg0G/gza+FXgPGUJZlg=
X-Endpoint-Received: by B4 Relay for thomasdegruijter@pm.me/20261120 with
 auth_id=1578
X-Original-From: Thomas de Gruijter <thomasdegruijter@pm.me>
Reply-To: thomasdegruijter@pm.me

On MediaTek MT7922 (USB 0e8d:0616, BT firmware build 20260724) LE
discovery and passive scanning find nothing, because msft_do_open()
enables the MSFT advertisement filter on every power on even when no
advertisement monitor is registered, and this controller then drops
every advertisement.

Patch 2 only enables the filter while at least one monitor is offloaded.
It is the first user of msft->filter_enabled, which does not follow the
controller when it reports the filter as already being in the requested
state, so patch 1 fixes that first.

How the problem was found
-------------------------
- btmon showed LE Set Extended Scan Parameters/Enable completing with
  status 0x00, followed by zero LE Extended Advertising Report events
  while three BLE beacons and ~20 other devices were in range.
- With hci0 powered off in BlueZ, the controller was reset and driven
  directly through the HCI user channel. Legacy and extended scanning
  both delivered reports (~870-980 in 10 s from 23 devices). Adding the
  kernel's init steps one at a time showed that only LE Set
  Advertisement Filter Enable(0x01) stops all reports (0, versus
  ~520-540 with LE Set Address Resolution Enable or the CIS host
  feature bit added instead).
- Disabling the filter on the running hci0 through a raw HCI socket made
  BlueZ LE discovery see 22 devices instead of 0.

Testing
-------
- Patch 2 was tested on the MT7922 described
  above: LE discovery works right after boot (22 devices instead of 0)
  and BLE power control of Lighthouse base stations works again.

Not tested
----------
- Patch 1.
- Any setup with advertisement monitors registered (adding or removing
  monitors, suspend/resume with monitors), any controller other than
  the MT7922, and the Command Disallowed path of patch 1, which needs a
  controller that starts with the filter enabled.

Tool assistance
---------------
The investigation and the creation test scripts were done using Claude Code.
I have reviewed the changes and the analysis and can answer questions about them.

---
Thomas de Gruijter (2):
      Bluetooth: MSFT: Record the filter state on Command Disallowed
      Bluetooth: MSFT: Only enable the advertisement filter with monitors

 net/bluetooth/msft.c | 57 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 8 deletions(-)
---
base-commit: 1d79f61152c315e30e758116e525871732181a98
change-id: 20261120-msft-filter-monitors-05e7b8fb6175

Best regards,
--  
Thomas de Gruijter <thomasdegruijter@pm.me>


