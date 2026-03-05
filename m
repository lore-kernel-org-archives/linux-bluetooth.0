Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A09225791
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673590; cv=pass; b=LnbLT8xQrbM4BLKaKTE2hJJhJ+cWrsW04XUIQVQwGX7bSW5GmRjVnSm6lAy7jC89y1ztgVF9hNesIh4FMyYHHOobHNkZxckL0OdReI+eZDDSX9xaZdy0Mal4uPItCDSU2vamGxBx6RnpKafRVelsdKUztEQV3/G3wTgRTJvTZe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673590; c=relaxed/simple;
	bh=2aT1PTMN9e98irX0/im0YZHkqcaEFpN5vTzEtdJm+ZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=myXfQXhcLuMon1wPjrx9VBLwRJx7DKuGQ2HGNrAAp0H0OvpwiOW8cqdeJ+8bOSA/ttcy7Iq8QpQT695r71Dw6gY56udklkEt850dN8XESx5Ld6MalcsTHXgT3HqElV6dY4bISGHefN4fPHIp6BECTzQ2Ajs2H+VT6iptzIUwnWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN+CeqbN; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN+CeqbN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso2235429a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 17:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772673587; cv=none;
        d=google.com; s=arc-20240605;
        b=aFiLPHREsVIxFy0hyeWYj+1MLQgbFeW1/FXQ/yW1OLPE4k4E15YI362PpXFmMRT2S7
         oXp11Vzkb2yYCOvxA9Jb2Uv0QEZi2IQKhO4kmCplCjxoTvF4CNMd1rGMNmkr+cZ0aZJ5
         7VEpmEHmyQ20iM8vlZd+hU0LHeKaXjpdAdGa0QZEGcTJOHFvpEgeJ6TPJXGZRqKPIFFT
         34o/1KyiFAPLobhGzhCs7XDylAiRtDc/AB7P0qMSIHHQhEXj8Lbmmr2w0Qs8ZYY61mgp
         g24cqDyN3DUyJCJE9YTG+NhOe1H7FCldRYcZ3KKbRlfHSOE8dz9NB+y6La8PXupAWqRC
         uxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        fh=LlAdKWylgYIQs8OagHrsmpfU6pGCyr+dpzBBfEn0TcA=;
        b=Al3RRsbNrRJ2jEKMpj0tXpAo6kpEGSKHcTnoFnKOuQL5fS0LBWYWgoIX/f3OHVaXLJ
         MZq2mGHCREBxPU9aCeQ2aw+a2O+Sts5QOWfW36JRFEoeKRVyWzfaT4FXBIC98jH0iHvT
         rkctY96MkVFRuf/kTgjX+ytyaGeawBP5krQwmH+SDD9pkqD4Kwfttn/GzlBtFq74qrl1
         diZbtGpH/pW9ByVzxDhurdHKaY/ZJKZ9UfNKQGfpprfz8tMk/Lw73gibl0gg/mMrv0IA
         wXcMjvY2qVceASqtf1NnwDAPTwf/1c4aZWa1xJxWOJ6zTnAMjIu+JXQ0JayfFUWHaWJr
         teDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673587; x=1773278387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        b=IN+CeqbNGXY3xT8juy88vEqx52LhDZoa33GWDXidv6sDE8p4gJbrOvyrDpQISXCOMv
         /tOH0N7uocXWD8qGQPBs16qkNg/DAjll3r1S88aI8s0edTP91ugBFfj/L2snEFKJHW0c
         i+jmN5sB2l9K7QvSjJrK2RPSj99LRgdm0NPxZUtptB5EZ7Hl1ezX/ay7k032VK/Cufgv
         VJH4oKpwpoCBMbDKRbCfUVLtHLZfdo2Qhyun1Eg1ojpIgcG05LWrnA4Bjgpp2Q0jg9UT
         P9gv9FrN+h2t2xYceAmY/KoF18OIMCx8WGY01wncGtVHCPAr03ckbhMMhxEu1FgAWtn+
         tp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673587; x=1773278387;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        b=ZEzU+aJKAo3X5RPO7D6iHH4p6GEPpx8hWn6Uzv5bMs70nWHBoczEYtcURE+bKQ3R1G
         97A5IgihoI8FgSKhXQVi6gAmcxPy9kpjveMu+uAVl/KSW52VUDfmyaqM9QkGCgRw0EUl
         YzXwVDn8U/OsA+zwJWfukLXiA3kwD06wrUMTuzkOA37RNQot7RSfn88CoRcpT23Y9MWq
         1JgSqufO+U7kK4c2cbNTM1lrvF5NYr0Xf7F/Ho8icIJReEvp3hHaQ+IUGOSFMJo7/rOZ
         44kSgJklUFdjawY+hZHh8IuEapGAcGz7dSXEagT61ZhPvrVRuErgVadGhFQD4WXJZxVC
         zmCw==
X-Gm-Message-State: AOJu0Yyvzdnj59tli73qZJEz+3gCu+Q+HekgjUsvop7BDlC40jhWFves
	tstyyq6tb4FbK6jKsfSm3FG4LwLHElWZFRmDm5aYVs3vX23K1VMzIIWjmpNwJllKRTchSVYft1f
	d8Mts+3cuURaIDE6O/ukbCrp+frUVqVGCexeazD8=
X-Gm-Gg: ATEYQzxRSdgBiJLL62DhvuVx4pzAzhTssLmgASLO9qtd00vQl/l99IdV4IcJ/1rjMVi
	4LNYn1Ss3D6i9TjNSKhGFs/cyQNLP1lf6I8gMD0qdg+atZQslJUr7fpNG+9dWw76SHMexZZ7L+D
	CduTdCfzR3XAs66Ffl6kV8EEIOvyQYJTf1F133sWJPGLfYY11zKG5hHNv6FVtKt5sDYlZVz0Fcb
	YvQMSb+wwa2IOiWAzFpVF7Hng5JF4qi67C+Mz3jTdRpemF2dps5EbFoGrDAyYwogyXg/7FbkyFG
	h2XQetKu+12uLRr18MSSmVfXJlaUgHKaBGwAH4Q9eBkchUDXWU45CszrZnWfrf0gRd930o7nBT+
	MS1B1Ebo=
X-Received: by 2002:a05:6402:35c2:b0:65f:8e80:4108 with SMTP id
 4fb4d7f45d1cf-660ef897451mr2663635a12.11.1772673587054; Wed, 04 Mar 2026
 17:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Thu, 5 Mar 2026 03:19:19 +0200
X-Gm-Features: AaiRm50JGIdOkGQ3NRTab-_nEMQNQRYwipDm_Jfj3Hk3CQYx7gz64Retw-rTZ4A
Message-ID: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
Subject: [PATCH v3] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"

create_big_sync() and create_big_complete() are queued via
hci_cmd_sync_queue() with a raw hci_conn pointer as 'data', but unlike
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer
they lack an hci_conn_valid() guard.

If the connection is torn down after the work is queued but before (or
during) execution, the work dereferences a freed hci_conn object.

Race path:
 1. hci_connect_bis() queues create_big_sync(conn) on hdev->req_workqueue
 2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=0,
    disc_work fires immediately on hdev->workqueue
 3. disc_work -> hci_abort_conn -> hci_conn_del() frees conn
 4. create_big_sync() dequeued and runs on req_workqueue; conn is
    already freed -> slab-use-after-free

The two workqueues are distinct (req_workqueue vs workqueue). The only
lock held by create_big_sync is hci_req_sync_lock; the deletion path
in HCI event handlers holds only hci_dev_lock. No shared lock prevents
concurrent execution.

This is the same bug class fixed for hci_enhanced_setup_sync in commit
98ccd44002d8 ("Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync"),
and for hci_le_create_conn_sync, hci_le_pa_create_sync,
hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and
create_big_complete in hci_conn.c were not included in those sweeps.

Fix: add hci_conn_valid() guard at the start of both functions. In
create_big_sync the 'qos' pointer assignment is moved past the guard
to avoid dereferencing conn before validation.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v3: Rebase on bluetooth-next HEAD 50003ce2; no logic changes
v2: Regenerate with git format-patch to fix malformed patch fragment header
v1: Initial submission

 net/bluetooth/hci_conn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5da..e7fe9cc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,10 +2119,15 @@ static void hci_iso_qos_setup(struct hci_dev
*hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
        struct hci_conn *conn = data;
-       struct bt_iso_qos *qos = &conn->iso_qos;
        u16 interval, sync_interval = 0;
        u32 flags = 0;
        int err;
+       struct bt_iso_qos *qos;
+
+       if (!hci_conn_valid(hdev, conn))
+               return -ECANCELED;
+
+       qos = &conn->iso_qos;

        if (qos->bcast.out.phys == BIT(1))
                flags |= MGMT_ADV_FLAG_SEC_2M;
@@ -2196,6 +2201,9 @@ static void create_big_complete(struct hci_dev
*hdev, void *data, int err)
 {
        struct hci_conn *conn = data;

+       if (!hci_conn_valid(hdev, conn))
+               return;
+
        bt_dev_dbg(hdev, "conn %p", conn);

        if (err) {
--
2.43.0
