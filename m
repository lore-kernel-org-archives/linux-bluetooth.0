Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24F373C0B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664632; cv=pass; b=ha6fkX8TW7HABjPrCprat048GudGtACQrRkqflsuuXdhWgMALkaZsXX+WmAjgOcGoRQSLTmJVNLth1Pm28Nuc1s9OMKQG4RPuTk9/9A3+ql12YHbJJG7M+Er/+DFecu+6h7BfSoz02xH3sH8DzoLmgKaaxn5eL6S7JLM0kCo3o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664632; c=relaxed/simple;
	bh=v+jTkoOuM2NPCetAIJg46/eO2RR8iZVRxxEScOdpXlI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=teLNNvihyVr/omXsKWct8ddxkWAqHvZyPhlWnogYbwmDtxB+YgXmrAnaaJytFmRqT8uHKvQ08yAgecsegqau98meoHqkE0rbPIza2sXhyM4Om5B/D29IUbH5p48flt6ruuapfWemJfufQhrrDFcxgm7AzqlbdrOLNtlZ446GYpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRdndyP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRdndyP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso13660626a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 14:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772664629; cv=none;
        d=google.com; s=arc-20240605;
        b=HVf6/MdImjPHHFIEPxtzxdUtQGhbrCwx8e6RGhhK/dtnJbQN1ekHrnePO7xcRRfj7r
         qd1XYD+4YBDazS8iwRJ2Q5Rg62mDPZkCnC37mURC0bg12Z4qwj0qcl5KXi91U1sJ02rb
         JjG0ZFxjjlQApGZcOhdLlEQJ4lYPthiQdBrgEcochkr108KVtCzbQBAxxWXNKSzmQH7q
         JJIE0YKjGc6VzO1677/TT7eh9nKfO4JfzqCOF4PEyQoMUSD1OQZhEH22mpYVGocUeu2Y
         tB0lj3KZmzmeBP/MHevu/9odmORGv4jwrL1TC3/bL5NWmVIWabNn7OiVG6yaaSyLdL/I
         gGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        fh=LlAdKWylgYIQs8OagHrsmpfU6pGCyr+dpzBBfEn0TcA=;
        b=kBgg+NniacDQ6tMYrBMfIWpAnls2s0/t4wRLSqEXuG96s4lmzbJYtp2FmNsol9ns8q
         eh6fprW2Yf3N4i6MetdhFY9wDezWbrw3zEWP00JvvnovwwsHjLAUIKKKZfjk2tW3eNaZ
         EeNqe1eMIQCtFnTFzAShjjw/z8GPZyurzq2hgeWsXL40Is+/6qeKV9YgWOB5B/rLI6yX
         1r734Whi0q9emTQZoJKEz1bHNupLUzWmkohreh5mW2YuDZm+16zTp5pqXqJ1TwfQfUtz
         IFcO04t+P6IXHCA4KMQJ7COdBkup48/QginZSv0npOB+g7VbMqhs1VwZ8sHK/ZDyyGdI
         eDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772664629; x=1773269429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        b=UwRdndyPaH8oO/owV+pMvihOZYFdZPdxfZAFUf2ei+OT/8knhPLq9bMEvFcOHqAikj
         X8kYySlbrtUgDxse6D5XCOViPseFfYn1E8eGm/jiOYKI0/V4s9KGmsBKu5CZmjzeIj1q
         gqRCtcU5985xznjE95E4cHiOAMAWqO4NaISJ7DAKG/nrNr6gyHxaq3PIZHNXiqU8L8IL
         5AKxh/nHzppgqwjGSe3VZhoH89bCdhYrBtBBPSbH4Cdjbe3H3JWDZi6fqzsu08Ka3eXs
         tm+lEojdPklxRM9OmMq6paQhZ2ByLxRTDEV3eHl4whWzFZ7Z5aVl5iE3+Bap6QcAp2Sw
         sVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664629; x=1773269429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+ct/ar6co3pGOjuj6b/KCIbM7ZuozKMfkuIjZQ0p24=;
        b=qXI8ZcWo42gXKPGOMwXOHVV5eae0hQZ3SofhD3BTK8fy3FH8E28FefmDIZYUHLSC1C
         SWpZL8rJ6mFa3ku963OCDOb12AHGRPa4UwqMIitlqt8UzRMa+S23DukOigbxHV98przY
         gvlNYwGTF5JTfxvWEnC71wXFC2v2bQqkbes5lJfoJ66mZ/ArvpZjrKN9chqvphsiN1V5
         oWNg/q3IXPzqheLFAhbw/eUfIGAmKQr32pMmtfUD2L3QwtsucOYlViboiHTO2dJyTAZf
         pozC1JutO7Ru52CiYmib6iZGffXVxP9s6JL2TeAEZkmltXB5V4tySDXszvT66ywKaCSE
         b/FA==
X-Gm-Message-State: AOJu0YxEAQmM9fp93jVzlByBG4l32dxOYokCAblYaICY/f3QYWYZgDdz
	1nkq8ZcIFLDhW3wb/Z+RVSC4xaLMPFm45Gr2YUYhYgDh+fqfClZfM00xrowdqogo6jherwkK8/u
	M0pebfkMm0gPN8wvFyGsivKyTqIiiQfl7X99J6d8=
X-Gm-Gg: ATEYQzy6hXG1USBiPmbYROsLvbvwc/fJXGS1XaGqykjZRJGY1kBo+m5RiNRk/IsUUCl
	mmvfa1UWmTW6r63agxXDSYLVFId+0Ou3mJGA8DZ2zolsrujfE76y+gKtIGRMz9tveFuPH5cjTbB
	9PYt3FdgS2ZMCu4i2D7nfJIMDf2H+EnMvIOP+Y8+Bu3S+xXxjqkpBo3/MwpEjG0jBQr1Pk9u813
	QQyvzdrHPvlE2VM9lfLXXDxyZ69eU5yAHxl/n5wyqofpVMyPBw7Gz9MtRVd3hKzJLREn1POb5ec
	l+gQCKIfxA32bkJQ1AKjkYHkdtnuxz/8tupKtG/LA5jbJF8ruvp4llHmQ+vIsZ2vqwSrqtSKKQ=
	=
X-Received: by 2002:a05:6402:234c:b0:65f:81be:e78d with SMTP id
 4fb4d7f45d1cf-660efec42e0mr2442400a12.17.1772664628867; Wed, 04 Mar 2026
 14:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Thu, 5 Mar 2026 00:50:17 +0200
X-Gm-Features: AaiRm51dPWTiK7tvpsxWJaLOOYYndhqkdJC86YqBJtVs9MvlXc3KRn5Kf5R_r9Y
Message-ID: <CALynFi4pamOn3CrB+3b0PxhE2+Br_Ftep=VKceyeYSV65N7Y6g@mail.gmail.com>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org, marcel@holtmann.org
Content-Type: multipart/mixed; boundary="00000000000082ab54064c3aa529"

--00000000000082ab54064c3aa529
Content-Type: multipart/alternative; boundary="00000000000082ab52064c3aa527"

--00000000000082ab52064c3aa527
Content-Type: text/plain; charset="UTF-8"

From kai.aizen.dev@gmail.com Mon Sep 17 00:00:00 2001
From: Kai Aizen <kai.aizen.dev@gmail.com>
Date: Wed, 4 Mar 2026 20:00:00 +0200
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and
 create_big_complete

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

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS
connections")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5daffdbf..e7fe9cc7a4a3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,10 +2119,15 @@
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
@@ -2196,6 +2201,9 @@
 {
        struct hci_conn *conn = data;

+       if (!hci_conn_valid(hdev, conn))
+               return;
+
        bt_dev_dbg(hdev, "conn %p", conn);

        if (err) {

--00000000000082ab52064c3aa527
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">From <a href=3D"mailto:kai.aizen.dev@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a> Mon Sep 17 00:00:00=
 2001<br>
From: Kai Aizen &lt;<a href=3D"mailto:kai.aizen.dev@gmail.com" target=3D"_b=
lank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a>&gt;<br>
Date: Wed, 4 Mar 2026 20:00:00 +0200<br>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix UAF in create_big_sync and<br>
=C2=A0create_big_complete<br>
<br>
create_big_sync() and create_big_complete() are queued via<br>
hci_cmd_sync_queue() with a raw hci_conn pointer as &#39;data&#39;, but unl=
ike<br>
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer<b=
r>
they lack an hci_conn_valid() guard.<br>
<br>
If the connection is torn down after the work is queued but before (or<br>
during) execution, the work dereferences a freed hci_conn object.<br>
<br>
Race path:<br>
=C2=A01. hci_connect_bis() queues create_big_sync(conn) on hdev-&gt;req_wor=
kqueue<br>
=C2=A02. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=3D=
0,<br>
=C2=A0 =C2=A0 disc_work fires immediately on hdev-&gt;workqueue<br>
=C2=A03. disc_work -&gt; hci_abort_conn -&gt; hci_conn_del() frees conn<br>
=C2=A04. create_big_sync() dequeued and runs on req_workqueue; conn is<br>
=C2=A0 =C2=A0 already freed -&gt; slab-use-after-free<br>
<br>
The two workqueues are distinct (req_workqueue vs workqueue). The only<br>
lock held by create_big_sync is hci_req_sync_lock; the deletion path<br>
in HCI event handlers holds only hci_dev_lock. No shared lock prevents<br>
concurrent execution.<br>
<br>
This is the same bug class fixed for hci_enhanced_setup_sync in commit<br>
98ccd44002d8 (&quot;Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync=
&quot;),<br>
and for hci_le_create_conn_sync, hci_le_pa_create_sync,<br>
hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and<br>
create_big_complete in hci_conn.c were not included in those sweeps.<br>
<br>
Fix: add hci_conn_valid() guard at the start of both functions. In<br>
create_big_sync the &#39;qos&#39; pointer assignment is moved past the guar=
d<br>
to avoid dereferencing conn before validation.<br>
<br>
Fixes: eca0ae4aea66 (&quot;Bluetooth: Add initial implementation of BIS con=
nections&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D"nore=
ferrer">stable@vger.kernel.org</a><br>
Signed-off-by: Kai Aizen &lt;<a href=3D"mailto:kai.aizen.dev@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">kai.aizen.dev@gmail.com</a>&gt;<br>
---<br>
=C2=A0net/bluetooth/hci_conn.c | 12 ++++++++++--<br>
=C2=A01 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c<br>
index a47f5daffdbf..e7fe9cc7a4a3 100644<br>
--- a/net/bluetooth/hci_conn.c<br>
+++ b/net/bluetooth/hci_conn.c<br>
@@ -2119,10 +2119,15 @@<br>
=C2=A0static int create_big_sync(struct hci_dev *hdev, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_conn *conn =3D data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bt_iso_qos *qos =3D &amp;conn-&gt;iso_qo=
s;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 interval, sync_interval =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 flags =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bt_iso_qos *qos;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hci_conn_valid(hdev, conn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ECANCELED;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0qos =3D &amp;conn-&gt;iso_qos;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qos-&gt;bcast.out.phys =3D=3D BIT(1))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D MGMT_ADV=
_FLAG_SEC_2M;<br>
@@ -2196,6 +2201,9 @@<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_conn *conn =3D data;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hci_conn_valid(hdev, conn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bt_dev_dbg(hdev, &quot;conn %p&quot;, conn);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {</div>

--00000000000082ab52064c3aa527--
--00000000000082ab54064c3aa529
Content-Type: text/x-diff; charset="ISO-8859-1"; 
	name="0001-v2-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync.patch"
Content-Disposition: attachment; 
	filename="0001-v2-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <19cbb0b668c18bc94a61>
X-Attachment-Id: 19cbb0b668c18bc94a61

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAA==
--00000000000082ab54064c3aa529--
