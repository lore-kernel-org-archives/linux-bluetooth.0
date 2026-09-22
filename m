Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC56370AC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039737; cv=pass; b=dT/+9jdyFToJ09ymQkbWHS1V64K1e+Ojl9svzhAwGF1i/FcNukj9VSaBrSSxc/YgHtyETQx5T6AaZhAajimCI+RuZtOINZLZAibZ8hUWbLrotV33L35ulALKQXIRXGTk3JBXjcoT22txIlL7vO2vFeoF52TRsyo/8s7T2M6gcSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039737; c=relaxed/simple;
	bh=Uyd2OTvu5O6MaTZX00VeQ96AdLguQq+zOU0EwypyWbc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=siZpOXNoiIkc/BCFxN70h03w1CR3nkMTFVOBG8DSH4Jgxe+icVHlsYe10ndVAA+YS1LK2D0fbKgegCHfVWNdcupr5bshq3zaaEuL7r4bgOIK1BReuoa2/+p2KecuSdl5tfsoH4xcxbwQRf93BcdL5uAvIuMzsnDbXinDmkrRTs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8cguiEC; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8cguiEC"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4fff62so1354600e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 18:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039732; cv=none;
        d=google.com; s=arc-20260327;
        b=K1YnMh/jAQ8MUEILjUiU9ajfbZAtEESHprbWixF9Zisdsf2kti12EKm4kP2JtrySt0
         AxZBNnrWRpQPEIIdIgZW+zU2dDXWnZOr1VCcRDAP3GzMaHQolZ0cQUxM6HzqmOni/CeK
         RXOmpbmsxUaNHbxP7TJbom9swTMY5Sj8qGEZqyIoLGEf/mw6FZu5A3h35fvKNJwfCNGA
         8fFkQO4xCoDvboJQt2JwdkvJhTOaOO+ESPrKNe1DbP4swzZ6AZlx5VOHMl6Z7OAMzjvj
         1fZLnINaSuigZs9qrKwJ+sxVDQMhD4Q06CZq1YM8Ku3No2esat5FaGfBAv/C/ADD6VDR
         Kz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature;
        bh=tIIZOsQtQIwliMFXWp6mvizqCjdWbZZ68uM4ejxmiVE=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=W9Ud1r3NB1456yqElrXFig5S+C5ZNncyJ3RGtzNNONUmR+AVghvWw+gp3G4r/6SfCZ
         vQzcoPWpODSiUVxeWKAKVhlduYKDCmdBeqeT5xcRdiBcSjmLZh/fIp4GCaAiyMpCCnBw
         2FCY/5kSld4gqTi0+3/l0Br0UcZR1Z2vA7Hid8EtoCjkymGfzyaa9QQNk2UG0QAtZC4u
         H529tNKqeiaPmO3skCq3O4otMPfGeG3pn0fanyoTUt1J5wBGAjZZAndGmFu2fFFsrXuE
         WUv9TTEG8Ws1Px/IofZnw7fFkSowEMPTvWfF1DVm715Xa+uRSbcgkTnRHFxklY7S1z+4
         wArw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039732; x=1790644532; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIIZOsQtQIwliMFXWp6mvizqCjdWbZZ68uM4ejxmiVE=;
        b=S8cguiEC/6mrJ0q2O5qiGMA58sVH2/20AT5nDwGEryGm/RpBV9uwnz0yt8N5Ng6lb3
         vxQxM4nEobVt8w4gVfJk+RGm/YW06fCNz3BcqCbHOtZz9IOz3vyHv2xs35ap1BrEEZgz
         AshLTLi4qSempV6QqM7Nr7c9htZCr0UfBlUY0YYk3MdCW+/v5DS2g8mi2WknHx3/L0Ec
         pF8W0ra0w2dumeskvzi3IDeOTVik0++yQV1lpv/J/rx61BRCvWUY7Xu35iLym27J7LsM
         GTgZlzIsirYTUQ9F2TnGOGFs6gYWMmsV+je/kPc015+4Nw7nJVPqZORmOdSe+ZyNqEJ4
         55bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039732; x=1790644532;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tIIZOsQtQIwliMFXWp6mvizqCjdWbZZ68uM4ejxmiVE=;
        b=y0H6Ce7Xt3OfYOnB91+de7LPDowZUR0W0mJphdtsM+CiS2hZDLuP+7BHZ7QqJEjJE0
         eibNyrLWB1zRr67MFQBOY9cr8vVHniJ5uwgSwrkaWe92281VHk3OGOdv/7xUySrHn6aJ
         RUybhAPeKnpq6Vsm84gtr/JIeF8PEspb6m+m2I761DZ2kiXx0ygJ4FVWc3SuUE4VfgZ0
         +tQTERP3KQF7V0Uq5++0FEmd/Um/sDve9dm66DteAzdAV0O5KQRK+PPbWFsHCvaDIXDk
         wsyQgCD3F5GE9KKZzC2ppnYzDwkyR4Dn/81KL+zWS5atV4cTTH0lSqwq8ZoSiIXANXVb
         qmmg==
X-Gm-Message-State: AFuF++mA8XeTDFk+GJFrCAmzND7VxBrqRAleZrBNzaaJp863Y71/JOK1
	eUkpSNtbD8R/w+Hs89THNbDFv0CF2aBQejyJXc9UCrWr3G7FomhNgvgGcd+Fa576l2qD2F7JVUC
	StTz50yOU33VTibkAzOJUyfVHD4YCS9Z2Ag==
X-Gm-Gg: AYBFou1zaHB66M60wvOvCtbmuc8RCUS+MaJ43klgvuefGaE48+eei9Qb+/CeCzZMpuL
	CYyoyleycj3SqJpJpQmwFugcRHJRobTPBsKzZ75nHZhWvDiUs1/6vwxQtW8cwIhxkTgiXkZ6fFF
	YRPQWUy5yV7Q2nZauCy8veUeoVlb/TQieITOkuzpJHpVCfcPOZ+OgHGN2O1LAIjViBJH5ykQtw7
	tMLWpqBdS87RnKt778kQkV3f+f67OReHcFnYzIbGVOq3fZzYCmxH4O+EJC05rYJ5JUxUrMQSWHn
	LnX0DFugBZVZScne6pvVlZc2TGhnLfsIQzxHhQCMIKveUH7QK0k9p2l7hLXMwWgoDixnsoa6U89
	w6zryiX2BBg==
X-Received: by 2002:a05:6122:181a:b0:5c9:a60b:e5bf with SMTP id
 71dfb90a1353d-5c9b5980fb9mr6852927e0c.15.1790039732089; Mon, 21 Sep 2026
 18:15:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:31 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
References: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
From: Nicholas Hammond <nicholas.hammond0@gmail.com>
Date: Mon, 21 Sep 2026 18:15:31 -0700
X-Gm-Features: AcwNN1VCXkET3qfwFlICySdjl3eiG5d9CTA3sCL8UnrtBViCQhFQD2rGQ4SS9kc
Message-ID: <CAB2hQnT9LEYHqAk2k5=C9o32JBN3PHb9URLpA_Srw35dEdvGLQ@mail.gmail.com>
Subject: [PATCH BlueZ 1/3] input/hog: Cancel pending report requests on detach
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Nick Hammond <blender7@gmail.com>

GET_REPORT and SET_REPORT requests are tracked by getrep_att and
setrep_att rather than gatt_op. Cancelling gatt_op during detach leaves
these callbacks registered on the shared GAttrib connection.

A reply delivered after the HoG object is freed can therefore access a
freed report in get_report_cb or a freed hog in set_report_cb. A long
GET_REPORT read can also retain its callback through a READ_BLOB
continuation. If the HoG object survives detach, the callback can instead
send a stale UHID reply.

Cancel both outstanding requests before releasing attrib and clear their
IDs so a later attachment starts without stale request state.

This was investigated following a bluetoothd crash on Ubuntu BlueZ 5.72
during keyboard reconnection. A socketpair regression reproduces the
use-after-free on current master with AddressSanitizer as well.

Assisted-by: Codex:gpt-6 AddressSanitizer
---
 profiles/input/hog-lib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 054356371..6c75c607f 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1896,6 +1896,17 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
 	if (hog->dis)
 		bt_dis_detach(hog->dis);

+	/* Report requests are tracked separately from gatt_op. */
+	if (hog->getrep_att) {
+		g_attrib_cancel(hog->attrib, hog->getrep_att);
+		hog->getrep_att = 0;
+	}
+
+	if (hog->setrep_att) {
+		g_attrib_cancel(hog->attrib, hog->setrep_att);
+		hog->setrep_att = 0;
+	}
+
 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
-- 
2.43.0



On Mon, 21 Sep 2026 18:15:15 -0700, Nicholas Hammond
<nicholas.hammond0@gmail.com> wrote:
> From: Nick Hammond <blender7@gmail.com>
>
> This series fixes outstanding HID report callbacks surviving HoG detach.
>
> The investigation started with a bluetoothd crash on Ubuntu BlueZ
> 5.72-0ubuntu5.5 while reconnecting an MX Keys S keyboard after switching
> hosts. The saved stack passes through report_reply/get_report_cb,
> read_blob_helper and attrib_callback_result. The original core and device
> identifiers are intentionally not included.
>
> On current master (17e624d1c), getrep_att and setrep_att still bypass the
> gatt_op queue cancelled by bt_hog_detach. If another owner retains the
> GAttrib connection, a late response can invoke a callback after its HoG
> object/report is freed. A surviving HoG object can also receive a stale
> reply after detach.
>
> A socketpair test on that revision reproduces the read, long-read and
> write use-after-free under AddressSanitizer. For example, the long-read
> case reports:
>
>   ERROR: AddressSanitizer: heap-use-after-free
>     get_report_cb       profiles/input/hog-lib.c:929
>     read_blob_helper    attrib/gatt.c:791
>     attrib_callback_result attrib/gattrib.c:235
>     handle_rsp          src/shared/att.c:913
>
> This is a lifetime regression test with a shared live GAttrib reference,
> not an over-the-air reproducer or a claim of unauthenticated reachability.
> It does not establish that every historical keyboard outage had this
> cause.
>
> Patch 1 cancels the separately tracked report requests before dropping
> attrib. Patches 2 and 3 add and register five hardware-independent tests.
> The test includes hog-lib.c to access private report state, avoiding new
> production APIs and unrelated discovery traffic.
>
> Validation on current master plus this series:
> - AddressSanitizer with detect_leaks=1: all five new tests pass.
> - Existing test-hog (6), test-gattrib (6), test-gatt (193): all pass.
> - checkpatch --no-tree --no-signoff: no errors or warnings.
> - A backport to Ubuntu 5.72 is installed on the affected host; keyboard
>   and mouse reconnected after restarting the daemon. Long-term stability
>   is not yet established.
>
> To reproduce the failures, apply only patches 2 and 3 to the base revision
> and build with --enable-asan. Run unit/test-hog-lifetime -p followed by
> /hog/detach/read, /hog/detach/blob or /hog/detach/write. Each detects a
> use-after-free without patch 1. /hog/reconnect catches the stale reply;
> /hog/normal passes before and after the fix.
>
> AI assistance disclosure: Codex:gpt-6 analyzed the saved crash, prepared
> the fix and tests, and ran the validation commands. This contribution
> includes Assisted-by tags. No claim of an independent human code review
> is made.
>
> Thanks,
> Nick Hammond
>
> Nick Hammond (3):
>   input/hog: Cancel pending report requests on detach
>   unit: Test pending HoG reports across detach
>   build: Register the HoG report lifetime tests
>
>  Makefile.am              |  14 ++++
>  profiles/input/hog-lib.c |  11 +++
>  unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 unit/test-hog-lifetime.c
>
>
> base-commit: 17e624d1cd9a4d94f90e0ca008548456c3455492
> --
> 2.43.0
