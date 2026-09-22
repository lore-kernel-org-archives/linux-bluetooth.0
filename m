Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0936A017
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039738; cv=pass; b=h02NjRn51/9r1fjAVmDxAOHkgPDaOMvRA+lihAtTw3nY129pwSN+69AIslMBP3zYrbJwWX4NDGQGx+517lMKrEDtxyjxdP6obuToNmS+CtYmgFHJIcpWJNO0BzViEYJ0Jz+DS3PwHOidmwJ4Z2TR26w/7z4NuBsOuXVxhiUtQe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039738; c=relaxed/simple;
	bh=RNxIktQz9Ys8nPNKZ3/5Tq4DO/2Q5ycbmgJVeYdl0Iw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KjKUMExUSbThHx+D5zU53X4c3zSutoHAcOYopIKqZLOZXK1wmSuiKjvwb0etaucOld8rzQBB4Mu1sehWLkEf3kR7QHDVn+HEXYv9+JwovbD1U7vmxRBHQsUlF/upt0/A0IBxwO176IKxxFdgbT2R87UkWftcLUXAci0yh/sX9Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP8CPR0r; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP8CPR0r"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9d8b323d9so979206e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 18:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039734; cv=none;
        d=google.com; s=arc-20260327;
        b=Ep289zQ8RhuypgCKCU5jC/ZqMqpZ1n+l9kjqT2RzbsbM08TEeHyidigzgTYepjC5H9
         AWqYg1KuU8VkGNmLR4joDWsiFRe6iuBGngOAqmp/8uZCMcZhpleI3225yZhdugQCR7br
         6OSUEoLPml97JZJzRDs9u6X1o8+FKgpgpT+Th5doJlTGzKw+Fcmr0+Hzxrvt6RfjrY+A
         lsPHE6bq+w5aAiO9FbDQxQXb2SMIPfhmI01FCw/NdSMf35q9R+qBH3sFfA3lnnHQQLUY
         Fb0VxMOYDavGZMvh1oXSwQZ2oRnhXlhI7FCvyfvy0PUC0CytSHxUXNDaooTBCWZG0/M8
         lupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature;
        bh=IsuAIO48ThaF0LOYLKvmy4Op4I9kTbXd9bEW/0x9Fck=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=VnpBimUtnU53eMiFKM+LX+CZ3lO2Am75UuxBbU9bBIC2QCuHDobKand7qoGJKaHYpy
         dlf4x02lU+iG/1svsmPsut5JCyBTkai0tWoUQoBBmY9lK9P0Ghvio4Znz/un3IfxKllo
         N9utPbXWgw/lSIPICjjedm0sh6Q5vq2BPfnlPzBTgumdA++GVv9e9jfehYnuJD+Y6zYk
         4h47BrTCVQ9+/elvxztPZMtwwVcNVnCll4cWgwEKDOHjFR7/8Iaj1CPOQEHs+OhtJ+B7
         6j9C/Dc1LGI+ZhR1dBQpwGuADxwFeiMWWzf+8ghPQofUPTOCzMTx0hPJdSeWSGwMx+LB
         FY/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039734; x=1790644534; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsuAIO48ThaF0LOYLKvmy4Op4I9kTbXd9bEW/0x9Fck=;
        b=qP8CPR0r6T43Rn0858Kk/o9YmrkVtqM+rMzekbINB6SStRseI9y9EUv5KEW1iszz25
         3h5zgIuL9U6nRajqm/ax1vApSQnvW/BzZ5nxGWKhOnpw69BjGvhVbAIOWsMVEYmX3sgA
         UjoELZ2fiVMDnpNxAPdfgNqvC66BmDv2GTOeed1G6ZPeM7zRjO/D1kIyL+e/tx6mBncU
         VnXMEreQHaD4t9eff0HT3ua54iOgg0CLXBvhrkHqmtnBl22Z+V6mCN8hEcS83BOrZkeQ
         gu3UiSVzpfBfUs9EU19uLIwun5f1bYDFO0yEHqP8lcgOgQvnv3Trjt+lA4AgMkQTAACV
         4tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039734; x=1790644534;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsuAIO48ThaF0LOYLKvmy4Op4I9kTbXd9bEW/0x9Fck=;
        b=MvqJQlqbpdzwhKneKYDfFh/i1priueQhq2RlUCHzGczJ/HhBuN5J8vQ5il8REOc9NO
         wU9xRcIPNRaTip7u0VKj9a6klYGhoVyYS1y+orT392sIsz8qfZB+bnFU7qIFWShbWvgk
         CEAVxT+b/RMQhZ4vsLh+OAWLUrlW3zbfwKVO2a659rK2OBpHxv8YmmSTuoB43+vB0YPy
         ew7qYNwtR0os17wJqKB64Ww4uBaLRmYmCggSojFRKg9bLYco6/wGbzLp0VGPUAhmZ7/i
         gTc4uwg6GcHqiy+Uv5g8SOEawe9KeHOCicxgbVHLXr1dxm54Cy8XvmFUkOUcXAaZtDzs
         lkhg==
X-Gm-Message-State: AFuF++lmSPnrsPIb2nhF3MpAVlttfNdcu8Ie+01z3R1q/Uz/X2uBM0/S
	Xq4iXKdoUFXZ/WRLNmRxcUmF8as4S/RTCVcz+J9O9jBz0xFZ6f4hnxhCXkAqwybhZafd6XjRLoN
	i1j7tSBePMlsHQW/0e/rtlmOyzadZoqb7tw==
X-Gm-Gg: AYBFou3e7fwxqHoZt9ryaiWz8wV2cTrwxT2DG3N95cWNS/mbdhiR5S/prz0VOM1K2+Y
	CuLZwmWT3E1BBb0VPV1i9y3afGSr6nmHs9ZWzX8QGAhYstevkuLGrP54PL0RVZOwrqT5SzcD9k9
	71U5hslHKAt7D21nyTMUHEVsm71JUhdZ8OUZ0A6o2FAAHZfnDMaYWtG+goo6N8bGxSx9F8g0/nY
	2tb7TVIGOQbb1Ww49iR3YbliqbejgZnFo7D1yoh4igLz611XUv8L8oCBB47Qgyl5sV5jBnYa7o4
	zryiheMWk79Be5QMFqBJGJhKT0ysWXz1EhEaZPKDjrUS7WKzU3OWn4rkOEJ/WFcQeN6PCUwcViM
	QG2R7QRMmGHepMaR/JFnH
X-Received: by 2002:a05:6122:3116:b0:5c9:a60b:e5b1 with SMTP id
 71dfb90a1353d-5c9b5934364mr7991262e0c.10.1790039734263; Mon, 21 Sep 2026
 18:15:34 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:33 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
References: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
From: Nicholas Hammond <nicholas.hammond0@gmail.com>
Date: Mon, 21 Sep 2026 18:15:33 -0700
X-Gm-Features: AcwNN1VStQeLsvms3401qJwMCuaH2lOQI25bR0HEe2oCUx3IB2msBMTqRsiJKv4
Message-ID: <CAB2hQnQhLS1Wc0-m=vGiJY-6zdfd0wEjznWouf6+3-f_V85O3Q@mail.gmail.com>
Subject: [PATCH BlueZ 3/3] build: Register the HoG report lifetime tests
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Nick Hammond <blender7@gmail.com>

Build and run test-hog-lifetime with the existing unit test suite. Link
its support sources without a second copy of hog-lib.c, which the test
includes to exercise the private report callbacks.

Assisted-by: Codex:gpt-6 AddressSanitizer
---
 Makefile.am | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 1d46b9b93..87a3b4f64 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -779,6 +779,20 @@ unit_test_hog_SOURCES = unit/test-hog.c \
 unit_test_hog_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)

+unit_tests += unit/test-hog-lifetime
+
+unit_test_hog_lifetime_SOURCES = unit/test-hog-lifetime.c \
+			$(btio_sources) \
+			profiles/input/hog-lib.h \
+			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
+			profiles/battery/bas.h profiles/battery/bas.c \
+			profiles/deviceinfo/dis.h profiles/deviceinfo/dis.c \
+			src/log.h src/log.c \
+			attrib/att.h attrib/att.c \
+			attrib/gatt.h attrib/gatt.c \
+			attrib/gattrib.h attrib/gattrib.c
+unit_test_hog_lifetime_LDADD = $(unit_test_hog_LDADD)
+
 unit_tests += unit/test-gattrib

 unit_test_gattrib_SOURCES = unit/test-gattrib.c attrib/gattrib.c \
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
