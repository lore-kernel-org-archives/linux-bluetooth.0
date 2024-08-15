Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047097DA9B;
	Thu, 15 Aug 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722689; cv=none; b=RBLQiLiFYrGY9cKx9R89BSRRHXV5PTWn+SYPHhfMKo2qw7ItREGGHvQNg4ujTuf6cbNz+QOKXarncMcrIYv2+eVJuXW5Ay1M8B2ROaKLlsXiRF6/EmAP6Km3oTaHnOg9Pj1m8gCRs1ymB8AroUS3RRArlSLfI4C68WeRVs353c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722689; c=relaxed/simple;
	bh=kGuVMJqQ7fJH5gwvQiMwjdCOEknsUjuW3RN+kRtocuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuxrZUC0nTBFL00Zu/iNFn3A0Ypv7j+WUq0xGTCwbqNmvFzxW5+gNBoIUh0phL5U4LuEjj5JYB3ELNgmNwRlGE6E6foCfoLUJD/WUYSDeznY60u4stL0bHdm4XYfRbFi4VIQPCQ0wB8SkHPVAlKUctepFEah1kFCaNcrCofkTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RjpgfACH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUQLCVsw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RjpgfACH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUQLCVsw"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F0654138FFCF;
	Thu, 15 Aug 2024 07:51:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 07:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1723722686; x=1723809086; bh=PqqsNeWnq9+9Q5vizD6sw
	F9qbRHy40p4oTWpwRdJXlw=; b=RjpgfACHakte+aKMFcWvMs77pzX/HR16ynvY4
	kPVYOWyYSGw5cNKT+AjMEXnCufVqQ95Dz7Lzr/dfa5v9cROY0B4C4aqtXbattAZH
	SaNrV+OkVFE213EoZNi7GnXy1XY1hwdgRiAzEjklI88udercsfNZc5y6nHaenHD5
	CxqRMzKPKRzKqZH7kIqQRzS55idPpCWtQboCNwTwQzNla8AWJXu1pV8Y70dOHsBa
	rvRKzlZfeqdLuY/bpKZRBat2k99uDR5fcoDvwNPZDtx2d8cDweuZbA71Jr/HrN4E
	PBZdcZ9VURYLZ/RVRjL3MR9x++PJXsAe6tpk6maB0B5/pQsNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723722686; x=1723809086; bh=PqqsNeWnq9+9Q5vizD6swF9qbRHy
	40p4oTWpwRdJXlw=; b=XUQLCVsw8/1fxDAfGvYU4rdbLgGGJS/eW+1cwnnH90yA
	jHAeOLwE/69TPW1dspRxaNOq9CBzYtjR/a7Ud8LXV5/DPbhqBQSM5kvqs0fUjdUg
	vf/y9H/WpCKUgg/xVGefIbBMIEfWcherxdeyKGBgsPwRBoe7iQCFJD2tFNW3A7th
	dawp0WWq+4lDKIp32ajs56kLL5oQcIQKYh4K6GaiCujjvUThBIl5fYvScZxBcs5+
	RG4APU6AD0bEquMtOfgqoLLUEn8/lduTgD1WDITlZLKoXIDv3jgi2f9r8l/HaIm5
	TpvtYTjIAM+3v7sn759Y+yQ9fTp9HKXV+APMnhnzAw==
X-ME-Sender: <xms:vuu9ZtTTdYKidud_h-I3eflimt-ElnCZAr8AMezQuCerjnzsiR5kBw>
    <xme:vuu9ZmzF4c_ZNCZGcnYsBvG0CRYJcdySGaUGcNHT4fR8Xs6KTslwGv-EGRvEj-3uy
    VvfN8JfBmB2-ak>
X-ME-Received: <xmr:vuu9Zi1vcPmzM0AAe7QvuiAPmlFLPjdJ6K0WfTKQw_M_rJWZmFDo31ZbOI_X2LhWF5LHdbHgY8-AughU386zd0-My_KDgo1MoXLkE4E-82sKZKOT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepifhrihhffhhinhcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhhifhhfihhnse
    hkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekvdfhkefgtdeugfelueejffel
    ueeludegieejtedtveekteetieehkedvkeevleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhhifhhfihhnsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtg
    gvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtohepjhhohhgrnhdrhhgvuggsvghr
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrihhffhhinheskhhrohgrhhdrtghomhdp
    rhgtphhtthhopeiihhgrnhegieeftdesphhurhguuhgvrdgvughupdhrtghpthhtohepsh
    htrggslhgvsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vuu9ZlAwIQHQ6M6ROilKnHNgSxjatC0vDIkzzBD0sAMf3D_zoDQa7g>
    <xmx:vuu9Zmg2jXKlQx9UbRgG0sOwPhjxkCS-aWcsdC9tYtNeXykNKPtz1g>
    <xmx:vuu9Zpo2yH38Lj1vrMjRpYYyc01SZb9-MaHpgLp-S0-OrWyb-e_Yiw>
    <xmx:vuu9Zhgt48OOf-zFlKV3D7hlNrgrySTaBrk1Y2V62xhWWkS8jniJFw>
    <xmx:vuu9ZvV8fa7cOl7sEDGjktgX_p_K__cT1T1Ahq3E1ubS6Cofk7JFslMZ>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 07:51:25 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Yiwei Zhang <zhan4630@purdue.edu>,
	Stable <stable@kernel.org>
Subject: [PATCH] Bluetooth: MGMT: Add error handling to pair_device()
Date: Thu, 15 Aug 2024 13:51:00 +0200
Message-ID: <20240815115100.13100-1-griffin@kroah.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_params_add() never checks for a NULL value and could lead to a NULL
pointer dereference causing a crash.

Fixed by adding error handling in the function.

Reported-by: Yiwei Zhang <zhan4630@purdue.edu>
Cc: Stable <stable@kernel.org>
Fixes: 5157b8a503fa ("Bluetooth: Fix initializing conn_params in scan phase")
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40d4887c7f79..25979f4283a6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3456,6 +3456,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * will be kept and this function does nothing.
 		 */
 		p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+		if (!p) {
+			err = -EIO;
+			goto unlock;
+		}
 
 		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
 			p->auto_connect = HCI_AUTO_CONN_DISABLED;
-- 
2.46.0

