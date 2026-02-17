Received: from a4i680.smtp2go.com (a4i680.smtp2go.com [158.120.82.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D73296BD0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.82.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351774; cv=none; b=bqkOVgFM4J8wE17MjDHpOrVnKf3VwkTDRfctaEYJDTL5A/q0403IBXZaKpzmy2MHxZx842iO2jWG6y4IZK9vdXxslZjelU4VBKV9llNBKdNmLEDt4ffo75uEjjB5bEaJsnluunFIOy+0d/K0OcnngozagpVUsDnHmnLOEI+iJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351774; c=relaxed/simple;
	bh=6t8H+384IDLlkN0wdl5nK7NVnDqSQHE5pJne2/V6NZg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bUmONFmh1eE5+EKtm1cOlafy3NACh8TV6qlqSrIuzJkbjao6MkDUgb5h9qqR54mOYiA0tW/PbaFuAXsZwACAunjBoOo7bA4fvU0pzOXMxdlooUnn7ixrVkw4jaQuog9nNxqCHvFDz3P7qQ1g1uHQ2meArJ0RhzSgRJ5hD2OSm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=celes.in; spf=pass smtp.mailfrom=em1059891.celes.in; dkim=pass (2048-bit key) header.d=celes.in header.i=@celes.in header.b=bBns+4nX; arc=none smtp.client-ip=158.120.82.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=celes.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1059891.celes.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=celes.in header.i=@celes.in header.b="bBns+4nX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celes.in;
 i=@celes.in; q=dns/txt; s=s1059891; t=1771351772; h=from : subject :
 to : message-id : date;
 bh=XyyAuD3bxt9VZzXVxdeWC65dj9gU11l8wx0bNKtL8A0=;
 b=bBns+4nXt0dXtDBKjA7As0vKD0kb496vpYnenzBpt6ZDExni9+8rMzSMMlS09vyJqu7k6
 ZfGnL7f7B4km6cyQM6BO5ryxtOSZF+nmwd3nu3tC4HE3MOc69OIvvh/lcmqz/6xX4TWdX0f
 /yy65pQktuVH3vEyZkJb6oOoFKWAoleSue5wqPk4AAmkB+6s+lpbpIc+vrexnqxEkLIBeJ8
 uR+I/VfqWQMfzIGVFzvQ3Qvb2BAYjqE5jmnimubHdi26m2slKZgqxFTLOkm5v3RAKBdARBt
 3OoPSIbF2pWn+PB8ic6NAW4eBuyxmFOfS51cWR/0xKnkBFb92p9nTFzDCCeg==
Received: from [10.143.247.69] (helo=mail-qv1-f49.google.com)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.99.1-S2G)
	(envelope-from <me@celes.in>)
	id 1vsPVq-FnQW0hPvaYn-fnGK
	for linux-bluetooth@vger.kernel.org;
	Tue, 17 Feb 2026 18:09:30 +0000
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f5af3d8aso66308156d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 10:09:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxYfANuSz64OK7vgak/ltT1aW6qatHBJ213jZJq1DIIf0IjzEJx
	i3RpDjgaqI9Kn/6RAm4ozc+xmQ29DxahETTaClO06ybRlZq8CBtxl2PBp04sL2Vzhh+d0QJf/Ux
	E5zYhMNFKvEfnku58Zldr++iayjUnSCk=
X-Received: by 2002:a05:6214:1c86:b0:895:4741:9f0c with SMTP id
 6a1803df08f44-897360f1b35mr188002386d6.3.1771351770129; Tue, 17 Feb 2026
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Matsumoto <me@celes.in>
Date: Tue, 17 Feb 2026 15:09:19 -0300
X-Gmail-Original-Message-ID: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
X-Gm-Features: AaiRm53pqYNtQCklPDpvkElqfxn3-ztbj70v7QngPGRnU5O_PdF0KNFME70v1Cc
Message-ID: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1059891m:1059891aeXj9Ek:1059891s3kKDNjq08
X-smtpcorp-track: 1U24taEOOvV5.aeJRDKrYKkIt.NC3uuQDFao4

Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
mgmt_mesh_add"):

I reviewed the call path for this patch and the overflow condition
appears to be unreachable in the current tree.
The only caller of mgmt_mesh_add() is mesh_send() in
net/bluetooth/mgmt_util.c. The length parameter is explicitly
sanitized before the call:

if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
   len <= MGMT_MESH_SEND_SIZE ||
   len > (MGMT_MESH_SEND_SIZE + 31))
return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
      MGMT_STATUS_REJECTED);

Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
the param buffer sized for this maximum length, the bounds check
introduced in the commit is redundant.
While defensive programming is valid, tagging this as a fix for a heap
overflow is misleading for backporters and security scanners, as the
overflow cannot be triggered.

Please consider dropping this from the stable queue to avoid
unnecessary code churn.
