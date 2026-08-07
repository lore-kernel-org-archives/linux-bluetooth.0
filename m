Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B712B94
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071600; cv=pass; b=PWew1ddMIhMhyWZeki1Z30wjws0d92VJ3Ll2mNKej6PaN+T9owrK4DBcWT7mEtbXRQ1ezv4J+2GWT28ItI2VeZcGpf9B1LwxJR0aYSYKnYKus0NeKvwjp0uNx3wcXpAsKpVpmqWfdEPtBvgZoUINdaxHh/oeGbA5ewZ8MbsOviE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071600; c=relaxed/simple;
	bh=J6lEaPQmLNxH0xoHH46Kpoyn5FE/S8Xi2mlS3KiyS0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUQjdJcQR2OGLlMNW1WSiS8XvP+DcyWxh6LnB2HnmUVx/uhnu+tR2Y/WWWQ+U4DZcTUbFOe0onoiVrpE+l06KJfDr41LNoBszE6Yh/fNAziwu2QxJW0HhIUpZtWK94XzP/r8pfG1czwbgbX2vRnik5IjEYX1RPTyOI/AMnAsXHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=DW3RYZgY; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="DW3RYZgY"
ARC-Seal: i=1; a=rsa-sha256; t=1786071594; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=a5+PHJZfNPxDfWP73vJgdUqhYfVGf1iLg9CCIRvVFRAcg5oBBQUCcXfSgLcQJ8+kEIKptNoeVm/34yTfErZEGH5KnzUXcE9tjfuKrZnJpb7zmW3c2Kd9vbprNwcFBQz0lbne0guJRWCn6I/udUTAM2b++EiKhfmC7PedEXrszAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786071594; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7gC39IxLInlIOuh1EiWL0pp7xaxTgHLUzjJ3nfHstaI=; 
	b=C3wGnDb05kLd+DJnCbgBbanytIGs/OsGjMvRp7bCbZzby9sveRuk7fGoJj/M4aqq6SDElcaaEojLLV5afImMPlbzWdz2xPKDGHB6H7Q4ml0Y1gBUWzf70pDHH6rWwHzwCA9ZRc3Gx7A5gIZfzKYIRMmZA0FwAacxeO7n/3pJIIs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786071594;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7gC39IxLInlIOuh1EiWL0pp7xaxTgHLUzjJ3nfHstaI=;
	b=DW3RYZgYJ4MOTxcnLRC4L2A4+qpt0h9DJ0XUgtT9VCAC6p7t/9KvdOQc95dfYie1
	B2epg90uwiFL5J/rvr7fEdB9Gy1s2G6bRb8ujorunt9fLAzGmhPTPAYuiaqfbL1R1+N
	dksgZ9WBFrV9oe2z9D/0viD4+lfr8NnCfyc65JHs=
Received: by mx.zoho.eu with SMTPS id 178607159240470.43768942515999;
	Fri, 7 Aug 2026 04:59:52 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] Bluetooth: MGMT: dequeue queued mesh send before freeing canceled tx
Date: Fri,  7 Aug 2026 02:59:25 +0000
Message-ID: <20260807025941.121018-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703060024.570535-1-zzzccc427@gmail.com>
References: <20260703060024.570535-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Cen,

On Fri, Jul 3, 2026 at 14:00, Cen Zhang wrote:
> Dequeue any queued mesh_send_sync() for the target tx from send_cancel().

The analysis looks right to me, but the fix is scoped to send_cancel()
and there is a second path that frees a mgmt_mesh_tx while a queued
mesh_send_sync() still carries the pointer.

mgmt_cleanup(), called from hci_sock_release(), walks every controller
and completes the mesh entries belonging to the closing socket:

	list_for_each_entry(hdev, &hci_dev_list, list) {
		do {
			mesh_tx = mgmt_mesh_next(hdev, sk);

			if (mesh_tx)
				mesh_send_complete(hdev, mesh_tx, true);
		} while (mesh_tx);
	}

mesh_send_complete() reaches mgmt_mesh_remove(), which does the same
list_del() + sock_put() + kfree() your commit message describes, with no
hci_cmd_sync_dequeue() first. So closing the control socket right after
MGMT_OP_MESH_SEND, or while mesh_next() has queued the send for the next
tx, frees the object the queued mesh_send_sync() will dereference. That
is the same use-after-free, reached without MGMT_OP_MESH_SEND_CANCEL.

Separately, mgmt_cleanup() holds only hci_dev_list_lock, never
hdev->lock, while it traverses hdev->mesh_pending and removes entries
from it. mesh_send() inserts into that list under hci_dev_lock(hdev), so
the list itself is walked unsynchronised against insertion. Note this
one cannot be fixed by simply adding hci_dev_lock() there, since
hci_dev_list_lock is an rwlock and hci_dev_lock() is a mutex; it needs
the usual hci_dev_hold() and drop-the-list-lock dance.

Given both, an explicit owner reference on mgmt_mesh_tx may end up
simpler than dequeuing at each free site: the pending list holds one
reference, the queued cmd_sync entry holds another via a destroy
callback, and only the last put does sock_put() and kfree(). That would
cover send_cancel() and mgmt_cleanup() together, and would not need
every future caller to remember the dequeue.

To be clear about what I did and did not do: this is from reading the
code, I have not reproduced the socket-close variant, and I have not
tested your patch.

Regards,
Ali Ahmet Memis
