Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505F369D7D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039722; cv=pass; b=Gywrhbk7mebb9b+vkIOOhpFKB2o01QDWzYWvGBNKwTiBsZzQ+I43xyncR++oMpoRcV7X15bd6Gz/DUtfe9dhp9BM94ZGjPL3Vu3M+ih75BSVkxiGf4pcz8bGa1oErltd/+/dWvoI5sD+YvMOa4u5y5uJDRSFoyMLYEiXPLW8N+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039722; c=relaxed/simple;
	bh=F54JZPbRfK0bZVE1nNvt5/4pV3YNcDhjEtwCMgFhNSA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IdiItR6R5hyB6/sK21Kdzml9aNOGm5BekLIZjeRXzr9LgSqQ13eJORyXo5rcqeFrHjYWbEoQB8p1PSZ3u/u5l/rVGR11rJoSdikeBRXNQ2COWF4GAMWMPDc/OyC5fKjl1LI+gg/PY5Wn1nZi39fyyPSa/84QF94AYOinK6Ag3Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7uPRYOA; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7uPRYOA"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98dc46a95so2706800e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 18:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039716; cv=none;
        d=google.com; s=arc-20260327;
        b=hA8MXvDcxqgpDyTaZP7jSxDY1nMlra3b+zJbUd1iqgvKOLe4JCaXHCt25XKfUcFX/z
         noA0L8iVR3IffpKBdbmOFaHzpusiXAVGM9zdjbODbBZoS/5dS5HWoyc083swmwVzWn0X
         m/kiIWA/MBVyVCMJ9nYm2/V2qdBQJUNpbf6Uks5jLwiJQvF2DrR9OvWY3xBhLFEilrbM
         NyDAikEaxDoiRgyoKE/TUr1WmwyX+KgjqBYIsk1knu5B9C4piB13tl4wtJxPxLIDBmlv
         6jX+sCfPgA6uV93K9qqk4dNZ+YUzkzzlpNqF4U1/x2OKQwJV04YWREda8HkHcWt4VYCM
         e0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fRqYPs+w0/1TlNHed3tQKBhUlJTJnL7FaTbE1ekj61k=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=IJiLDtUHxm7OBEMSzUVWG2jzytVCEaZ91pVrYyskP9fxHXk0t5mc1c/ebDvR4Vzfx8
         L57+VSCWRnGsO8bt+IB0e4fmEyscrMuIgmDc5cPhMGBrzPOXKrhONQWyD5u80ryRy1tF
         weUzFg6/++fV6DSLreymEzrV09kXFUhIkFfpsP8L+txuZ0HWXhhEAu00UoWFr+rGgS7H
         n45JY1b4PDcpnIpXDB2j+Cxdqorg2YnNkjfAh0IUPYJcwW9U40DAxmsMF2Jn8G5R0El/
         CMkDYjyxzELMXtInFxxgUK0f+A+sQtFWIU+xnHsG6V/7oAshlu52wV4cncn3L13ZgtHX
         p6Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039716; x=1790644516; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fRqYPs+w0/1TlNHed3tQKBhUlJTJnL7FaTbE1ekj61k=;
        b=e7uPRYOAb38kPSMdzz4ZkgU1FXc6TU22EFghkg+ZK+IjcMegMSDvDyNX79J+HwtFlH
         lDN/FDubY2fGZ9SJy+jdtB1QLLIGCHptxo+9NDhXT2mc9eWlFu+7VE1I8R9FxFkQKm0Y
         X1hDRA6J00jCrrCSt3fBFHw84nrfXsR3ECFC6/1t4C5nGaNQQj1w5dsfIML/Px9X/hRm
         muWXbtDwLH9KRsfSoEMvcFAX5DmPyXahawCAP945kpEtMITIBdgAUbJLubkXsFEP7g7u
         CqOAP5Bja3R4nxCRTskLl6qsW9rOn50F36CusDrfMJx7sDSKEAT4cfRIjjb0gs6VnnKB
         Vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039716; x=1790644516;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRqYPs+w0/1TlNHed3tQKBhUlJTJnL7FaTbE1ekj61k=;
        b=QezeKs3qlYoJd1qkzQ0Bg49tzC/xZNcXtly9e6red54ERVOMXjOST+tBt0IW5RKfqf
         bVKGSdqKP0Sv4DJ52EO6/HyC+zJAr5Nshq5Cc0KupFMIzeC+HfjWODhg5JMx17bqvtIj
         xD/tvAHfvWNWbYyMVd5WX+6BTUd/zAwKOvOwk2jM+T3ACdFaV2oM7Lw5oFu7KZwTazRy
         KVXwOodrC3pPNeRNoiOyz8rnuyl+YFgdZKobUQ/27NyF+fmy5l/EBKAHfbgC2y+wlSr+
         03hW/D+5oUZ/RIE7yHfPZow5qB0GOMSK3XTqFeKaYurolMqNYPtLKb6y6D+hw3YjdtQ8
         NIeQ==
X-Gm-Message-State: AFuF++lbu1fMQFKIVc2wpBdhMRYLqwW+ADxr4kFsKfsWOpHT/imj1q74
	5OLTll3v1efaSZFFeTLQ91YYLNV8scZ248P3Lx+jMy526kEoVVkhOH5ZTWI774YZYjDP7wpHRPJ
	57fJG5d4CpruFN2Kgfst/81zh8XVVvxiO1g==
X-Gm-Gg: AYBFou3njnSjGvnYykSgbAuEDZ2rCn8y2hASUivrmOUwx3IE70jHS3VMcZAFWyp/kTu
	8Dkiz+GprRxXrxJhkj0vllsMxEAgmlLABOPDTQsvAsBBJYecC5+cj3ZjE5qgfWk16mf8RygxfLs
	MGtnfjUtJxpJDRnadMqJSvioNSGZ+lCNS42+40SLkzFxNpv52SiI1E7ZTlodgzYS3GBprM3k+ZR
	8L9oMajw1kPHgsW9hy/i3Iv9NGCNic0ci0AK1TjDi96D6Sk/ZOBtLalFstNFUPuZkkapwAEniSo
	NCmexCkzGbfqdW5VBtk3QqZBerMEMqVT8d+CDb9wsEItEO5pW6oOUfoKBlSVNZTAtA1qd9kFXbt
	bKPFJQPxLRQ==
X-Received: by 2002:a05:6122:29ce:b0:5c9:a60b:e5aa with SMTP id
 71dfb90a1353d-5c9b5976941mr8179214e0c.12.1790039715820; Mon, 21 Sep 2026
 18:15:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:15 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:15 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicholas Hammond <nicholas.hammond0@gmail.com>
Date: Mon, 21 Sep 2026 18:15:15 -0700
X-Gm-Features: AcwNN1USoanyKVvxMQkUib6p7HrxhCl5LpzLF9k03uYkT42GUPs5unWq4BgXfcI
Message-ID: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
Subject: [PATCH BlueZ 0/3] Cancel pending HoG reports before detach
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Nick Hammond <blender7@gmail.com>

This series fixes outstanding HID report callbacks surviving HoG detach.

The investigation started with a bluetoothd crash on Ubuntu BlueZ
5.72-0ubuntu5.5 while reconnecting an MX Keys S keyboard after switching
hosts. The saved stack passes through report_reply/get_report_cb,
read_blob_helper and attrib_callback_result. The original core and device
identifiers are intentionally not included.

On current master (17e624d1c), getrep_att and setrep_att still bypass the
gatt_op queue cancelled by bt_hog_detach. If another owner retains the
GAttrib connection, a late response can invoke a callback after its HoG
object/report is freed. A surviving HoG object can also receive a stale
reply after detach.

A socketpair test on that revision reproduces the read, long-read and
write use-after-free under AddressSanitizer. For example, the long-read
case reports:

  ERROR: AddressSanitizer: heap-use-after-free
    get_report_cb       profiles/input/hog-lib.c:929
    read_blob_helper    attrib/gatt.c:791
    attrib_callback_result attrib/gattrib.c:235
    handle_rsp          src/shared/att.c:913

This is a lifetime regression test with a shared live GAttrib reference,
not an over-the-air reproducer or a claim of unauthenticated reachability.
It does not establish that every historical keyboard outage had this
cause.

Patch 1 cancels the separately tracked report requests before dropping
attrib. Patches 2 and 3 add and register five hardware-independent tests.
The test includes hog-lib.c to access private report state, avoiding new
production APIs and unrelated discovery traffic.

Validation on current master plus this series:
- AddressSanitizer with detect_leaks=1: all five new tests pass.
- Existing test-hog (6), test-gattrib (6), test-gatt (193): all pass.
- checkpatch --no-tree --no-signoff: no errors or warnings.
- A backport to Ubuntu 5.72 is installed on the affected host; keyboard
  and mouse reconnected after restarting the daemon. Long-term stability
  is not yet established.

To reproduce the failures, apply only patches 2 and 3 to the base revision
and build with --enable-asan. Run unit/test-hog-lifetime -p followed by
/hog/detach/read, /hog/detach/blob or /hog/detach/write. Each detects a
use-after-free without patch 1. /hog/reconnect catches the stale reply;
/hog/normal passes before and after the fix.

AI assistance disclosure: Codex:gpt-6 analyzed the saved crash, prepared
the fix and tests, and ran the validation commands. This contribution
includes Assisted-by tags. No claim of an independent human code review
is made.

Thanks,
Nick Hammond

Nick Hammond (3):
  input/hog: Cancel pending report requests on detach
  unit: Test pending HoG reports across detach
  build: Register the HoG report lifetime tests

 Makefile.am              |  14 ++++
 profiles/input/hog-lib.c |  11 +++
 unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 unit/test-hog-lifetime.c


base-commit: 17e624d1cd9a4d94f90e0ca008548456c3455492
-- 
2.43.0
