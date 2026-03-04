Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E5382391
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657961; cv=pass; b=RrxwrbQnYXcWy+kvJAIynx4xOAZqaPBvhMbyAz02MhshvucltNGOW2HoD5+rxpSJco/n9n8x/ZXpZ+s/VAwFTWca4JpAYWSABddUMgppPehs3oVLVSk517xwpzjL9CGQYQSw9Itc1cr6jzUOKxZfMOrcLyNwoBsMHcFmHLoUQk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657961; c=relaxed/simple;
	bh=kOn7gg9eFYsiiw7vuj5pcIKBTAGwDggxDiRAMPLxWoo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dwdbKQzV/kUgGGgul3RMekp82x8bPLki0AgS9WDdqSUodS3lZEiHe1xdrBau3b1yaP7wkhLlDNoe/JArKpdB5/DRZvgoGb62tDLALMoselwLZWTU+AC2K5940dSlNSXfTpsruA67U8U+4pJG8kHXiWOToe8zwRp+iwEzhoHJl5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYkkrKJh; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYkkrKJh"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so892079166b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 12:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772657957; cv=none;
        d=google.com; s=arc-20240605;
        b=ja6PyR5BALad6WM/YNpAP1tGXfJGKGolxpLMoyDGO+dorREcqIs0SNW2TPu716rkRB
         U3O25roq1HNw3IUcgvfsis1y35SFv3zmJpz1SbO2iFxFUh/iK1u8KZEuV7rgsBV/89Ym
         K6/uVePmX7B5SUa/hwjKR3Ud/7xACsL1oonxsH3CBaFCWVUnEzDMPwd2BR3L6caEC5qK
         Zpxmek6J4PvU0inkLHAsyLd0syodwZwCM0kxOOh+oyLffX3w46Xh6zDoxykXmYBdEUrg
         CM93IeXkUh26EcYqSEoOnlv6S/yvAhag3NQ84eUrUsatfaRFzu4iNg++Lj8WBwaRVdXb
         kfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+4y9b032w4xvF3lNa57Z9BiimU99PsG1j5zVbAH1EyI=;
        fh=LlAdKWylgYIQs8OagHrsmpfU6pGCyr+dpzBBfEn0TcA=;
        b=CRhmgjJ4Nj7MH1azKZUU7cuqxlt/a4gC9+uahaF+09GCsBLSrFeuPJKIQr4e2koARf
         J6q6yrY9uAWOxl2MNcROeuy2Gq0uQHxmEpos+kuifhK1X/XqlYRLyhcLSrGaNoO5iJ9M
         TQrHcRr4XHz9B5Wfwy2MoEfYjmhp6+N9XGOiPw9XhJCWLzRf3fMYjRUgpAzgU/WDgK0G
         AE7jdBR0xahPtHx1Wv0k0+zR3iwz9n1juNzmjw/5yMd2/tgF6VCgPRzDcI2GnQVCZABq
         OUPbYUApwBroBVrMuhPyu4GKGP5vkFLWtuyrkLw+ybDwXXsfdlqREv970oF/2mdO+XMn
         wkzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772657957; x=1773262757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4y9b032w4xvF3lNa57Z9BiimU99PsG1j5zVbAH1EyI=;
        b=VYkkrKJhemtY4zRtMfoFZeK1eEPaO2uxSS4mLv+o9Z124ONvaitHZHlsB+f0Ldv/mI
         8ej/CFqGltBEhi7lkvvhSchU1l4FvgAfBcvfcvUsnf+TB0WEE2E2kFm5AmIvif1GJJJF
         Pmzf3vQgPy6hSVgbewq5XuHhDtLxyiH1AvEclCghGM0fxAC4sq7AC/SQJq6uC214JI+m
         ufF8gzChyMxM+frwsvvSN5okUmtlO2EaqXZ8/ShiNqFKEj7X4F1dg2lyvz94OC2mxzrq
         u9iQRDJfoi+qnLzgm9xQ9+cecUz79/5S/zBW2BBQ2sAHZTalBS1pxJ1zH0aU9cGOX3pj
         +rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657957; x=1773262757;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4y9b032w4xvF3lNa57Z9BiimU99PsG1j5zVbAH1EyI=;
        b=MUMGAoZILkKZp/ApCroNrIH6A4dwCWOhd+AFRIQjK5KAhWptmjHIT3fmV16F2H8ceT
         jbUVDlhM2hmd09iVvFeqxpYKQo+ixu38jWBalKA8qsjQThIDROL1y8hQ/JXjZZfiIjXQ
         4HUOhao/2RuMIA7zPclqrKzlDzaEI08XE05w0UTjNaKyR/LTVeqSpz5dHFpBZGB2O8ZA
         3eMA4whbQYk5Grkv2WRS8vIDNf+JdXtsjgHiayLFai3vFkhKlDw6d3hzuv+63xi7IWX2
         p0btaLMyK5Y0u6Y6OhkUEB7uWlXIlbYqF4Q26EbOUegWEGy8y6qW2zatYA2q8qC9SW0Q
         3/7w==
X-Gm-Message-State: AOJu0Yy4q7HXIb0UJYcpExfeFIVzoGmumVMJt6euQq6cwtpCfTvalMLB
	85TBvTVdL6ohuwxNMzaboUDiC37hdbJfSUILQFqo7DXzNmvb48jt4eo5uq9c1J/sj5IE74hyIDg
	8fyJ7VHGlvE74ScpbcsZctoPEv4sZVR+gRAoF
X-Gm-Gg: ATEYQzyirGOvIjzmk6dxDf6exLOg323bJ2LK96m7pXp4uh0a3o8XmoDamojWqMA5k1U
	g8Cgvj2llRDwYrU5oll2UwT526f6tZ1pAgl3hOlFPvcdfL6tE595YjDeBzuFrYF2B/UrJzVoJbX
	UfDDiGGmxQGp6LpAeZ3Er8TY/QBijHpDoVK+UdEZu9+t+tMyPfEHPPf9C6FImiUSj9HQfu9ynEU
	jGArDqQWzUaFO6M6BvBveEegTU3qmQFO4fhUkirXVgwxUK++TyYTHyx1urF1XQM+wzetZcDyeOr
	W+xFa+5DqrJHBNV9O0cjPYNC1iqF12PYr1ms7cwdvCuYIlxUyKVtniSV4K7yOIefyjRx8yNnIQ=
	=
X-Received: by 2002:a17:907:6e87:b0:b87:1d30:7e6 with SMTP id
 a640c23a62f3a-b93f1171ad5mr184796866b.11.1772657957184; Wed, 04 Mar 2026
 12:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Wed, 4 Mar 2026 22:59:04 +0200
X-Gm-Features: AaiRm52OMpnc23y7yqeoa4sxL_NptXyXT0xuw5oAA7evj1P9G3EGDgeJvPfhJmw
Message-ID: <CALynFi7uvORERZA+9WUaLvbmc6ooPse4ETCn=ix3WLN62wON-w@mail.gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org, marcel@holtmann.org
Content-Type: multipart/mixed; boundary="000000000000d90779064c3917d9"

--000000000000d90779064c3917d9
Content-Type: multipart/alternative; boundary="000000000000d90777064c3917d7"

--000000000000d90777064c3917d7
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,

While auditing the hci_cmd_sync_queue() callback sweep that introduced
hci_conn_valid() guards (following the hci_enhanced_setup_sync UAF in
commit 98ccd44002d8), I found that create_big_sync() and
create_big_complete() in net/bluetooth/hci_conn.c were missed.

Both functions receive a raw hci_conn pointer as 'data' but dereference
it without the validity check present in every sibling callback. The
race and fix are described in the commit message below.

The patch is against bluetooth-next/master (2026-03-04).

Thanks,
Kai

---

create_big_sync() and create_big_complete() are queued via
hci_cmd_sync_queue() with a raw hci_conn pointer as 'data', but unlike
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer
they lack an hci_conn_valid() guard.

If the connection is torn down after the work is queued but before (or
during) execution, the work dereferences a freed hci_conn object.

Race path:
  1. hci_connect_bis() queues create_big_sync(conn) on hdev->req_workqueue
  2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=0,
     so disc_work fires immediately on hdev->workqueue
  3. disc_work -> hci_abort_conn -> hci_conn_del() frees conn
  4. create_big_sync() dequeued and runs on req_workqueue; conn is
     already freed -> slab-use-after-free

The two workqueues are distinct (req_workqueue vs workqueue). The only
lock held by create_big_sync is hci_req_sync_lock (hdev->req_lock); the
deletion path in HCI event handlers holds only hci_dev_lock (hdev->lock).
There is no shared lock preventing concurrent execution.

This is the same bug class that was fixed for hci_enhanced_setup_sync
in commit 98ccd44002d8 ("Bluetooth: hci_conn: Fix UAF in
hci_enhanced_setup_sync"), and for hci_le_create_conn_sync,
hci_le_pa_create_sync, hci_le_big_create_sync, hci_acl_create_conn_sync
in subsequent sweeps. create_big_sync and create_big_complete in
hci_conn.c were not included in those sweeps.

Expected KASAN report (analogous to hci_enhanced_setup_sync):

  BUG: KASAN: slab-use-after-free in create_big_sync+0x.../...
  Read of size N at addr ... by task kworker/.../...
  Workqueue: hci0 hci_cmd_sync_work
  ...
  Freed by:
    hci_conn_del+...
    hci_abort_conn_sync+...
    hci_cmd_sync_work+...

Fix: add hci_conn_valid() guard at the start of both functions, matching
the pattern established for all sibling callbacks. Note that
create_big_sync must not dereference conn->iso_qos before the validity
check, so the 'qos' pointer assignment is moved past the check.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS
connections")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4719dac07190..2821bf786a6b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,9 +2119,14 @@ static int create_big_sync(struct hci_dev *hdev,
void *data)
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
@@ -2198,6 +2203,9 @@ static void create_big_complete(struct hci_dev *hdev,
void *data, int err)
 {
        struct hci_conn *conn = data;

+       if (!hci_conn_valid(hdev, conn))
+               return;
+
        bt_dev_dbg(hdev, "conn %p", conn);

        if (err) {

--000000000000d90777064c3917d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello maintainers,<br>
<br>
While auditing the hci_cmd_sync_queue() callback sweep that introduced<br>
hci_conn_valid() guards (following the hci_enhanced_setup_sync UAF in<br>
commit 98ccd44002d8), I found that create_big_sync() and<br>
create_big_complete() in net/bluetooth/hci_conn.c were missed.<br>
<br>
Both functions receive a raw hci_conn pointer as &#39;data&#39; but derefer=
ence<br>
it without the validity check present in every sibling callback. The<br>
race and fix are described in the commit message below.<br>
<br>
The patch is against bluetooth-next/master (2026-03-04).<br>
<br>
Thanks,<br>
Kai<br>
<br>
---<br>
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
=C2=A0 1. hci_connect_bis() queues create_big_sync(conn) on hdev-&gt;req_wo=
rkqueue<br>
=C2=A0 2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=
=3D0,<br>
=C2=A0 =C2=A0 =C2=A0so disc_work fires immediately on hdev-&gt;workqueue<br=
>
=C2=A0 3. disc_work -&gt; hci_abort_conn -&gt; hci_conn_del() frees conn<br=
>
=C2=A0 4. create_big_sync() dequeued and runs on req_workqueue; conn is<br>
=C2=A0 =C2=A0 =C2=A0already freed -&gt; slab-use-after-free<br>
<br>
The two workqueues are distinct (req_workqueue vs workqueue). The only<br>
lock held by create_big_sync is hci_req_sync_lock (hdev-&gt;req_lock); the<=
br>
deletion path in HCI event handlers holds only hci_dev_lock (hdev-&gt;lock)=
.<br>
There is no shared lock preventing concurrent execution.<br>
<br>
This is the same bug class that was fixed for hci_enhanced_setup_sync<br>
in commit 98ccd44002d8 (&quot;Bluetooth: hci_conn: Fix UAF in<br>
hci_enhanced_setup_sync&quot;), and for hci_le_create_conn_sync,<br>
hci_le_pa_create_sync, hci_le_big_create_sync, hci_acl_create_conn_sync<br>
in subsequent sweeps. create_big_sync and create_big_complete in<br>
hci_conn.c were not included in those sweeps.<br>
<br>
Expected KASAN report (analogous to hci_enhanced_setup_sync):<br>
<br>
=C2=A0 BUG: KASAN: slab-use-after-free in create_big_sync+0x.../...<br>
=C2=A0 Read of size N at addr ... by task kworker/.../...<br>
=C2=A0 Workqueue: hci0 hci_cmd_sync_work<br>
=C2=A0 ...<br>
=C2=A0 Freed by:<br>
=C2=A0 =C2=A0 hci_conn_del+...<br>
=C2=A0 =C2=A0 hci_abort_conn_sync+...<br>
=C2=A0 =C2=A0 hci_cmd_sync_work+...<br>
<br>
Fix: add hci_conn_valid() guard at the start of both functions, matching<br=
>
the pattern established for all sibling callbacks. Note that<br>
create_big_sync must not dereference conn-&gt;iso_qos before the validity<b=
r>
check, so the &#39;qos&#39; pointer assignment is moved past the check.<br>
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
index 4719dac07190..2821bf786a6b 100644<br>
--- a/net/bluetooth/hci_conn.c<br>
+++ b/net/bluetooth/hci_conn.c<br>
@@ -2119,9 +2119,14 @@ static int create_big_sync(struct hci_dev *hdev, voi=
d *data)<br>
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
@@ -2198,6 +2203,9 @@ static void create_big_complete(struct hci_dev *hdev,=
 void *data, int err)<br>
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

--000000000000d90777064c3917d7--
--000000000000d90779064c3917d9
Content-Type: text/x-diff; charset="UTF-8"; 
	name="0001-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync-and-cr.patch"
Content-Disposition: attachment; 
	filename="0001-Bluetooth-hci_conn-Fix-UAF-in-create_big_sync-and-cr.patch"
Content-Transfer-Encoding: base64
Content-ID: <19cbaa58f167c57d0c71>
X-Attachment-Id: 19cbaa58f167c57d0c71

RnJvbSBTbmFpbFNwbG9pdCA8a2FpQHNuYWlsc3Bsb2l0LmNvbT4gTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCkZyb206IEthaSBBaXplbiA8a2FpQHNuYWlsc3Bsb2l0LmNvbT4KRGF0ZTogV2VkLCA0
IE1hciAyMDI2IDIwOjAwOjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRvb3RoOiBoY2lf
Y29ubjogRml4IFVBRiBpbiBjcmVhdGVfYmlnX3N5bmMgYW5kCiBjcmVhdGVfYmlnX2NvbXBsZXRl
CgpjcmVhdGVfYmlnX3N5bmMoKSBhbmQgY3JlYXRlX2JpZ19jb21wbGV0ZSgpIGFyZSBxdWV1ZWQg
dmlhCmhjaV9jbWRfc3luY19xdWV1ZSgpIHdpdGggYSByYXcgaGNpX2Nvbm4gcG9pbnRlciBhcyAn
ZGF0YScsIGJ1dCB1bmxpa2UKYWxsIG90aGVyIGhjaV9jbWRfc3luY19xdWV1ZSgpIGNhbGxiYWNr
cyB0aGF0IHJlY2VpdmUgYW4gaGNpX2Nvbm4gcG9pbnRlcgp0aGV5IGxhY2sgYW4gaGNpX2Nvbm5f
dmFsaWQoKSBndWFyZC4KCklmIHRoZSBjb25uZWN0aW9uIGlzIHRvcm4gZG93biBhZnRlciB0aGUg
d29yayBpcyBxdWV1ZWQgYnV0IGJlZm9yZSAob3IKZHVyaW5nKSBleGVjdXRpb24sIHRoZSB3b3Jr
IGRlcmVmZXJlbmNlcyBhIGZyZWVkIGhjaV9jb25uIG9iamVjdC4KClJhY2UgcGF0aDoKICAxLiBo
Y2lfY29ubmVjdF9iaXMoKSBxdWV1ZXMgY3JlYXRlX2JpZ19zeW5jKGNvbm4pIG9uIGhkZXYtPnJl
cV93b3JrcXVldWUKICAyLiBJU08gc29ja2V0IGNsb3NlKCkgdHJpZ2dlcnMgaGNpX2Nvbm5fZHJv
cCgpOyBmb3IgQklTX0xJTksgdGltZW89MCwKICAgICBzbyBkaXNjX3dvcmsgZmlyZXMgaW1tZWRp
YXRlbHkgb24gaGRldi0+d29ya3F1ZXVlCiAgMy4gZGlzY193b3JrIOKGkiBoY2lfYWJvcnRfY29u
biDihpIgaGNpX2Nvbm5fZGVsKCkgZnJlZXMgY29ubgogIDQuIGNyZWF0ZV9iaWdfc3luYygpIGRl
cXVldWVkIGFuZCBydW5zIG9uIHJlcV93b3JrcXVldWU7IGNvbm4gaXMKICAgICBhbHJlYWR5IGZy
ZWVkIOKGkiBzbGFiLXVzZS1hZnRlci1mcmVlCgpUaGUgdHdvIHdvcmtxdWV1ZXMgYXJlIGRpc3Rp
bmN0IChyZXFfd29ya3F1ZXVlIHZzIHdvcmtxdWV1ZSkuIFRoZSBvbmx5CmxvY2sgaGVsZCBieSBj
cmVhdGVfYmlnX3N5bmMgaXMgaGNpX3JlcV9zeW5jX2xvY2sgKGhkZXYtPnJlcV9sb2NrKTsgdGhl
CmRlbGV0aW9uIHBhdGggaW4gSENJIGV2ZW50IGhhbmRsZXJzIGhvbGRzIG9ubHkgaGNpX2Rldl9s
b2NrIChoZGV2LT5sb2NrKS4KVGhlcmUgaXMgbm8gc2hhcmVkIGxvY2sgcHJldmVudGluZyBjb25j
dXJyZW50IGV4ZWN1dGlvbi4KClRoaXMgaXMgdGhlIHNhbWUgYnVnIGNsYXNzIHRoYXQgd2FzIGZp
eGVkIGZvciBoY2lfZW5oYW5jZWRfc2V0dXBfc3luYwppbiBjb21taXQgOThjY2Q0NDAwMmQ4ICgi
Qmx1ZXRvb3RoOiBoY2lfY29ubjogRml4IFVBRiBpbgpoY2lfZW5oYW5jZWRfc2V0dXBfc3luYyIp
LCBhbmQgZm9yIGhjaV9sZV9jcmVhdGVfY29ubl9zeW5jLApoY2lfbGVfcGFfY3JlYXRlX3N5bmMs
IGhjaV9sZV9iaWdfY3JlYXRlX3N5bmMsIGhjaV9hY2xfY3JlYXRlX2Nvbm5fc3luYwppbiBzdWJz
ZXF1ZW50IHN3ZWVwcy4gY3JlYXRlX2JpZ19zeW5jIGFuZCBjcmVhdGVfYmlnX2NvbXBsZXRlIGlu
CmhjaV9jb25uLmMgd2VyZSBub3QgaW5jbHVkZWQgaW4gdGhvc2Ugc3dlZXBzLgoKRXhwZWN0ZWQg
S0FTQU4gcmVwb3J0IChhbmFsb2dvdXMgdG8gaGNpX2VuaGFuY2VkX3NldHVwX3N5bmMpOgoKICBC
VUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGNyZWF0ZV9iaWdfc3luYysweC4uLi8u
Li4KICBSZWFkIG9mIHNpemUgTiBhdCBhZGRyIC4uLiBieSB0YXNrIGt3b3JrZXIvLi4uLy4uLgog
IFdvcmtxdWV1ZTogaGNpMCBoY2lfY21kX3N5bmNfd29yawogIC4uLgogIEZyZWVkIGJ5OgogICAg
aGNpX2Nvbm5fZGVsKy4uLgogICAgaGNpX2Fib3J0X2Nvbm5fc3luYysuLi4KICAgIGhjaV9jbWRf
c3luY193b3JrKy4uLgoKRml4OiBhZGQgaGNpX2Nvbm5fdmFsaWQoKSBndWFyZCBhdCB0aGUgc3Rh
cnQgb2YgYm90aCBmdW5jdGlvbnMsIG1hdGNoaW5nCnRoZSBwYXR0ZXJuIGVzdGFibGlzaGVkIGZv
ciBhbGwgc2libGluZyBjYWxsYmFja3MuIE5vdGUgdGhhdApjcmVhdGVfYmlnX3N5bmMgbXVzdCBu
b3QgZGVyZWZlcmVuY2UgY29ubi0+aXNvX3FvcyBiZWZvcmUgdGhlIHZhbGlkaXR5CmNoZWNrLCBz
byB0aGUgJ3FvcycgcG9pbnRlciBhc3NpZ25tZW50IGlzIG1vdmVkIHBhc3QgdGhlIGNoZWNrLgoK
Rml4ZXM6IGVjYTBhZTRhZWE2NiAoIkJsdWV0b290aDogQWRkIGluaXRpYWwgaW1wbGVtZW50YXRp
b24gb2YgQklTIGNvbm5lY3Rpb25zIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVk
LW9mZi1ieTogS2FpIEFpemVuIDxrYWlAc25haWxzcGxvaXQuY29tPgotLS0KIG5ldC9ibHVldG9v
dGgvaGNpX2Nvbm4uYyB8IDEyICsrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lf
Y29ubi5jIGIvbmV0L2JsdWV0b290aC9oY2lfY29ubi5jCmluZGV4IDQ3MTlkYWMwNzE5MC4uMjgy
MWJmNzg2YTZiIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMKKysrIGIvbmV0
L2JsdWV0b290aC9oY2lfY29ubi5jCkBAIC0yMTE5LDkgKzIxMTksMTQgQEAgc3RhdGljIGludCBj
cmVhdGVfYmlnX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiB7CiAJc3Ry
dWN0IGhjaV9jb25uICpjb25uID0gZGF0YTsKLQlzdHJ1Y3QgYnRfaXNvX3FvcyAqcW9zID0gJmNv
bm4tPmlzb19xb3M7CiAJdTE2IGludGVydmFsLCBzeW5jX2ludGVydmFsID0gMDsKIAl1MzIgZmxh
Z3MgPSAwOwogCWludCBlcnI7CisJc3RydWN0IGJ0X2lzb19xb3MgKnFvczsKKworCWlmICghaGNp
X2Nvbm5fdmFsaWQoaGRldiwgY29ubikpCisJCXJldHVybiAtRUNBTkNFTEVEOworCisJcW9zID0g
JmNvbm4tPmlzb19xb3M7CiAKIAlpZiAocW9zLT5iY2FzdC5vdXQucGh5cyA9PSBCSVQoMSkpCiAJ
CWZsYWdzIHw9IE1HTVRfQURWX0ZMQUdfU0VDXzJNOwpAQCAtMjE5OCw2ICsyMjAzLDkgQEAgc3Rh
dGljIHZvaWQgY3JlYXRlX2JpZ19jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAq
ZGF0YSwgaW50IGVycikKIHsKIAlzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4gPSBkYXRhOwogCisJaWYg
KCFoY2lfY29ubl92YWxpZChoZGV2LCBjb25uKSkKKwkJcmV0dXJuOworCiAJYnRfZGV2X2RiZyho
ZGV2LCAiY29ubiAlcCIsIGNvbm4pOwogCiAJaWYgKGVycikgewotLSAKMi40My4wCg==
--000000000000d90779064c3917d9--
