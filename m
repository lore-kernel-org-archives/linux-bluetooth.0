Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C555294E
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087116; cv=pass; b=mU8X7iKVT8733cNaXELst5QAKDF4dgSJ32h4XaQEM+mO2mUrLdtURuSLfdXC7mQj+sWnMjr/YdIM0qaIW/CL1GCFoU9LR7RrH4g+0jHq0gS7dgEmH4pCMQixAPxxdH5sqm81ZTfIzhtaGL/jLBhdoTsKOHaunD6fpWldUPwb2UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087116; c=relaxed/simple;
	bh=SNn4s1bwUy62ux0BF4AznciIPeALYK2rwq6r20ixafM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyBzbKCQJp1YlodKRQ/2mchR01TAsF3Pk5KrSXUQS9ofr5fOrk7zx4tZiMjTlROh/eYaQLP+l/nrKVZvjRlAnWlWbGpqLwpmME2r+JF372LcKS3fdMB/f2nUh4+JZ2fL4O6OGAnEQM3iqfBa7NlT0s/2UvyIMyYD7R4P9MgT9rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVjtB+7e; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVjtB+7e"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-6713d20d375so3755715d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 07:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087114; cv=none;
        d=google.com; s=arc-20260327;
        b=QnXV/uWUlVfj2PVwqIFjNpBKP+N4Y+hXHMHxNIYylIxwOYF6hiO4y+/2Go+tmMo5oE
         VCGa63NSyhJzTxMr8kgB26OmDzy5DuwZ9a6L6vOWtSuF2qu0NZnQwalN6PihUvGOUh7/
         6qUzYn9opZHWyijpu4E1qeNjpCM4+6hGX2hMpGNP46TJRiitGyoD7cwGgQDEboffxFjF
         xFASg+gO77PN8nhFHxiUIdqltOwjnutzPWuggfAbYNdlVVnLP1ufwwhUTGG+vtQNIsix
         PY1m/ooI9/k6/cgx1Nq6To+JDnqVXBuutNQAbnRL5D1KOq7mcMK6XmrhY25/iJ4VIB3b
         LuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sw/n9Dah+g8GSv+pkRly+/ttFveOVfhBgUaZzg1tODM=;
        fh=HIlshhlMrveYD6qD+h8ihgNaUcieWAGO6qPePqi1+dI=;
        b=IfayXwA1eqn4DecG7BukpIHPmT34LSPQvspZ5TEIUrGn97uQOb+1LneTMznSn/oU/k
         J2rpgggEzUs2FeSItq4NpNzjikdft05sn7KwC/HnOwEIcI3ChBvPuCGREEtYBoWccyas
         5fopOm15JCJI0aiTuMtI9SnddvU8RHA/OeQlK/iURreizMDI9UiKJp25yh3wyrBOIHuq
         ksbCrU+qaH0wHPmHDMOQcUmK02RuOkUYTA1UdnO8ozNw0hpz86KXmgQ0qBcT3Ii2OmL0
         hZDv7J3PERo0V/LsBmvcuuzfllR9jMYP4RlGtNTs9whIm44i0PPmvjiECBDPVIeG4rFG
         Owaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087114; x=1790691914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sw/n9Dah+g8GSv+pkRly+/ttFveOVfhBgUaZzg1tODM=;
        b=kVjtB+7eapapVj+DVkp8j3hFh15uliN01mIy5ZuhORNUcqm5EomDFeBLZqSO0hg3JM
         ctp1IAd1IASi2hDxH71wryCrRpXuAN4up/LX8RlaJypfD/e5CuWoQ4o+2hkyX8lXVhfr
         Cy6ECSJbOvWCpEmAIkmc5bHibdeDtskcYlvIiItTI2/e1pwyD6/3XcC1q5+LtCvUh+yY
         f0vU3PKcrvTCOD6FxcptoRxYx12DBNEY83pTBVXRZerdv9jbzotNDoPLMkbE2F9I5bEN
         i0IyePprEKzKdTPOIvvYAT/TZt+kjspNRmV8EQ54RCnlP3KHh7Z0lizGNdkEvWKUbo03
         kLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087114; x=1790691914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw/n9Dah+g8GSv+pkRly+/ttFveOVfhBgUaZzg1tODM=;
        b=EVtyBNSUDAEYSLUROpiKX+uI3gbBqn/K4Mw9xA857A//mNrrILpaiRcArFrkD8Ipcd
         bEBDroRRzDsMXbOKPK7wwl5E+R9bLOQ9e2UPjd9KW79XhP2HOsmbQNM8thb+i3HDFjSV
         7ojHcGyB3g0UH19JeFOaQAUOYBfXdLasLvG0vMQiv/hYR6UumPCDxTKtQx+Rs48Zf6DR
         HB2KROtw4vmPmpGk1/c9RbALVG6vKUcmFHQL0Fx9W8kk55+s4MBGwE/+bX5pK494zHg+
         X9s4OU3APshTaYCSYf9n1VzVA63n1E5RFOoV+6GFTSF2p7k2H8n/RQHexylgQRfol2VT
         1RZQ==
X-Gm-Message-State: AFuF++nzXwwQ41ESHxXS3kM63smpJewQKuabaDkwn5gEf9bSEpfxnr5R
	DPRRyiBCVI/9QBYTT3d/gbRS7OlnqwIfcS6cvXMJZAyoC8qlGPNuoFEORTtqT0izDGIycQy7BIt
	TRZv/tLR78cbrkZKsQl8AQig6UwEvznQ=
X-Gm-Gg: AYBFou16rsYLepUu3NGdONoHLstNiK5vvQ226kxQO2w0K6dmuniDHl2FefgF+xVbS78
	C9gTlpaCV4PS9LJdKynx6JUTxEvFwEMvuxH+jqtF0oqXSopZiiQpg1+tVd6WK8eRXQfGedQ2JvE
	bp885NjmuntexjFuBpgBvO+5d0rW/vxrELW9cIlzcCEpEqKc+LH43euMjBjBZkND4Q92b8DbvGO
	vuV+4/R26TeMeghRB+dI/RqeMwwY/77k8JmgrAKNgP/ywzE4MlJGlpNcgSBMDls1V6OjLJzIrUY
	3XjWOYpMk8l1PBIvmKIDyu9nLhIMo+hETOKHaGGG5t5WFKGzY0Zf9P9KtdjhNF6+Ah6gHPAzdr4
	I+UHe2jDdWIsxyaQ3oiW/dL2+2ujc/tOXlh0mjRJq9R9QDmETYd4E
X-Received: by 2002:a05:690e:1513:b0:671:506a:9fb5 with SMTP id
 956f58d0204a3-672c535b6d4mr969424d50.35.1790087113438; Tue, 22 Sep 2026
 07:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
 <CAB2hQnRNL1ivYNupM6fKfP=Z-r-4yQ58NpAUU4WLRFu3qfUPYQ@mail.gmail.com>
In-Reply-To: <CAB2hQnRNL1ivYNupM6fKfP=Z-r-4yQ58NpAUU4WLRFu3qfUPYQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Sep 2026 10:25:01 -0400
X-Gm-Features: AcwNN1WfMfr3VnKr_aqHvy4Zp5Ls8Omgslz-7BRWMDzWxqhqHgq25u_DGOY75dw
Message-ID: <CABBYNZKEjygOZbCJf=bp_dM+Yr1aad-9g0wHTMWHQM-veXgOKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] unit: Test pending HoG reports across detach
To: Nicholas Hammond <nicholas.hammond0@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicholas,

On Mon, Sep 21, 2026 at 9:16=E2=80=AFPM Nicholas Hammond
<nicholas.hammond0@gmail.com> wrote:
>
> From: Nick Hammond <blender7@gmail.com>
>
> Exercise the real HoG, GAttrib and ATT implementations with socketpairs
> for ATT and UHID, without requiring a controller or /dev/uhid.

While the fix on 1/3 looks good, adding unit testing for this may not
be worth it, we should really replace the HoG implementation to use
the likes of bt_gatt_client instead of deprecated GAttrib.

> Cover pending reads, READ_BLOB continuations and writes whose responses
> arrive after detach and object destruction. Also check normal completion
> and reuse of a surviving object after detach. Keep another GAttrib
> reference alive to model the connection shared with other profiles.
>
> Include hog-lib.c to construct a single report and invoke its request
> handlers without unrelated service discovery or new production APIs.
> The follow-up build change registers this test with make check.
>
> Without the preceding fix, the three teardown cases fail under
> AddressSanitizer and the reuse case receives a stale reply. All five
> cases pass with the fix and leak detection enabled.
>
> Assisted-by: Codex:gpt-6 AddressSanitizer
> ---
>  unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 unit/test-hog-lifetime.c
>
> diff --git a/unit/test-hog-lifetime.c b/unit/test-hog-lifetime.c
> new file mode 100644
> index 000000000..53a563c40
> --- /dev/null
> +++ b/unit/test-hog-lifetime.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Regression for outstanding HID report requests surviving detach.
> + * Uses socketpairs and the real HoG/GAttrib/ATT implementation; no hard=
ware.
> + */
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +
> +#include <glib.h>
> +
> +#include "profiles/input/hog-lib.c"
> +
> +static void pump(void)
> +{
> +       while (g_main_context_iteration(NULL, FALSE))
> +               ;
> +}
> +
> +static void test_report(gconstpointer data)
> +{
> +       const char *name =3D data;
> +       bool blob =3D !strcmp(name, "blob");
> +       bool write_test =3D !strcmp(name, "write");
> +       bool normal =3D !strcmp(name, "normal");
> +       bool reconnect =3D !strcmp(name, "reconnect");
> +       int attfd[2], uhidfd[2];
> +       GIOChannel *io;
> +       GAttrib *attrib;
> +       struct bt_hog *hog;
> +       struct report *report;
> +       struct uhid_event ev =3D { 0 }, reply;
> +       uint8_t pdu[64];
> +       uint8_t response[2] =3D {
> +               write_test ? 0x13 : blob ? 0x0d : 0x0b, 0x55
> +       };
> +       size_t size =3D write_test ? 1 : 2;
> +       ssize_t n;
> +
> +       g_assert_cmpint(socketpair(AF_UNIX,
> +                       SOCK_SEQPACKET | SOCK_NONBLOCK, 0, attfd), =3D=3D=
, 0);
> +       g_assert_cmpint(socketpair(AF_UNIX,
> +                       SOCK_SEQPACKET | SOCK_NONBLOCK, 0, uhidfd), =3D=
=3D, 0);
> +       io =3D g_io_channel_unix_new(attfd[0]);
> +       g_io_channel_set_close_on_unref(io, TRUE);
> +       attrib =3D g_attrib_new(io, 23, false);
> +       g_io_channel_unref(io);
> +       hog =3D bt_hog_new(uhidfd[0], "lifetime-test", 2, 1, 1, 0, NULL);
> +       g_assert(hog && attrib);
> +       hog->attrib =3D g_attrib_ref(attrib);
> +       report =3D g_new0(struct report, 1);
> +       report->hog =3D hog;
> +       report->type =3D HOG_REPORT_TYPE_FEATURE;
> +       report->value_handle =3D 0x31;
> +       hog->reports =3D g_slist_append(hog->reports, report);
> +
> +       if (write_test) {
> +               ev.type =3D UHID_SET_REPORT;
> +               ev.u.set_report.id =3D 123;
> +               ev.u.set_report.rtype =3D UHID_FEATURE_REPORT;
> +               ev.u.set_report.size =3D 1;
> +               ev.u.set_report.data[0] =3D 0x55;
> +               set_report(&ev, hog);
> +               g_assert(hog->setrep_att !=3D 0);
> +       } else {
> +               ev.type =3D UHID_GET_REPORT;
> +               ev.u.get_report.id =3D 123;
> +               ev.u.get_report.rtype =3D UHID_FEATURE_REPORT;
> +               get_report(&ev, hog);
> +               g_assert(hog->getrep_att !=3D 0);
> +       }
> +
> +       pump();
> +       n =3D read(attfd[1], pdu, sizeof(pdu));
> +       g_assert(n >=3D 3 && pdu[0] =3D=3D (write_test ? 0x12 : 0x0a));
> +
> +       if (blob) {
> +               uint8_t first[23] =3D { 0x0b };
> +
> +               g_assert_cmpint(write(attfd[1], first, sizeof(first)),
> +                                               =3D=3D, sizeof(first));
> +               pump();
> +               n =3D read(attfd[1], pdu, sizeof(pdu));
> +               g_assert(n =3D=3D 5 && pdu[0] =3D=3D 0x0c);
> +       }
> +
> +       if (!normal) {
> +               bt_hog_detach(hog, true);
> +
> +               if (!reconnect) {
> +                       bt_hog_unref(hog);
> +                       hog =3D NULL;
> +               }
> +       }
> +
> +       g_assert(write(attfd[1], response, size) =3D=3D size);
> +       pump();
> +       n =3D read(uhidfd[1], &reply, sizeof(reply));
> +
> +       if (normal) {
> +               g_assert(n =3D=3D sizeof(reply));
> +               g_assert(reply.type =3D=3D UHID_GET_REPORT_REPLY);
> +               g_assert(reply.u.get_report_reply.id =3D=3D 123);
> +               g_assert(reply.u.get_report_reply.err =3D=3D 0);
> +               g_assert(reply.u.get_report_reply.data[0] =3D=3D 0x55);
> +       } else {
> +               g_assert(n =3D=3D -1 && errno =3D=3D EAGAIN);
> +       }
> +
> +       if (reconnect) {
> +               /* Reuse the detached object for another report request. =
*/
> +               g_assert(hog->getrep_att =3D=3D 0 && hog->setrep_att =3D=
=3D 0);
> +               hog->attrib =3D g_attrib_ref(attrib);
> +               ev.u.get_report.id =3D 124;
> +               get_report(&ev, hog);
> +               pump();
> +               n =3D read(attfd[1], pdu, sizeof(pdu));
> +               g_assert(n =3D=3D 3 && pdu[0] =3D=3D 0x0a);
> +               g_assert(write(attfd[1], response, 2) =3D=3D 2);
> +               pump();
> +               g_assert_cmpint(read(uhidfd[1], &reply, sizeof(reply)),
> +                                               =3D=3D, sizeof(reply));
> +               g_assert(reply.u.get_report_reply.id =3D=3D 124);
> +               g_assert(reply.u.get_report_reply.err =3D=3D 0);
> +       }
> +
> +       if (hog)
> +               bt_hog_unref(hog);
> +
> +       g_attrib_unref(attrib);
> +       close(attfd[1]);
> +       close(uhidfd[0]);
> +       close(uhidfd[1]);
> +       pump();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       g_test_init(&argc, &argv, NULL);
> +
> +       g_test_add_data_func("/hog/detach/read", "read", test_report);
> +       g_test_add_data_func("/hog/detach/blob", "blob", test_report);
> +       g_test_add_data_func("/hog/detach/write", "write", test_report);
> +       g_test_add_data_func("/hog/normal", "normal", test_report);
> +       g_test_add_data_func("/hog/reconnect", "reconnect", test_report);
> +
> +       return g_test_run();
> +}
> --
> 2.43.0
>
>
>
> On Mon, 21 Sep 2026 18:15:15 -0700, Nicholas Hammond
> <nicholas.hammond0@gmail.com> wrote:
> > From: Nick Hammond <blender7@gmail.com>
> >
> > This series fixes outstanding HID report callbacks surviving HoG detach=
.
> >
> > The investigation started with a bluetoothd crash on Ubuntu BlueZ
> > 5.72-0ubuntu5.5 while reconnecting an MX Keys S keyboard after switchin=
g
> > hosts. The saved stack passes through report_reply/get_report_cb,
> > read_blob_helper and attrib_callback_result. The original core and devi=
ce
> > identifiers are intentionally not included.
> >
> > On current master (17e624d1c), getrep_att and setrep_att still bypass t=
he
> > gatt_op queue cancelled by bt_hog_detach. If another owner retains the
> > GAttrib connection, a late response can invoke a callback after its HoG
> > object/report is freed. A surviving HoG object can also receive a stale
> > reply after detach.
> >
> > A socketpair test on that revision reproduces the read, long-read and
> > write use-after-free under AddressSanitizer. For example, the long-read
> > case reports:
> >
> >   ERROR: AddressSanitizer: heap-use-after-free
> >     get_report_cb       profiles/input/hog-lib.c:929
> >     read_blob_helper    attrib/gatt.c:791
> >     attrib_callback_result attrib/gattrib.c:235
> >     handle_rsp          src/shared/att.c:913
> >
> > This is a lifetime regression test with a shared live GAttrib reference=
,
> > not an over-the-air reproducer or a claim of unauthenticated reachabili=
ty.
> > It does not establish that every historical keyboard outage had this
> > cause.
> >
> > Patch 1 cancels the separately tracked report requests before dropping
> > attrib. Patches 2 and 3 add and register five hardware-independent test=
s.
> > The test includes hog-lib.c to access private report state, avoiding ne=
w
> > production APIs and unrelated discovery traffic.
> >
> > Validation on current master plus this series:
> > - AddressSanitizer with detect_leaks=3D1: all five new tests pass.
> > - Existing test-hog (6), test-gattrib (6), test-gatt (193): all pass.
> > - checkpatch --no-tree --no-signoff: no errors or warnings.
> > - A backport to Ubuntu 5.72 is installed on the affected host; keyboard
> >   and mouse reconnected after restarting the daemon. Long-term stabilit=
y
> >   is not yet established.
> >
> > To reproduce the failures, apply only patches 2 and 3 to the base revis=
ion
> > and build with --enable-asan. Run unit/test-hog-lifetime -p followed by
> > /hog/detach/read, /hog/detach/blob or /hog/detach/write. Each detects a
> > use-after-free without patch 1. /hog/reconnect catches the stale reply;
> > /hog/normal passes before and after the fix.
> >
> > AI assistance disclosure: Codex:gpt-6 analyzed the saved crash, prepare=
d
> > the fix and tests, and ran the validation commands. This contribution
> > includes Assisted-by tags. No claim of an independent human code review
> > is made.
> >
> > Thanks,
> > Nick Hammond
> >
> > Nick Hammond (3):
> >   input/hog: Cancel pending report requests on detach
> >   unit: Test pending HoG reports across detach
> >   build: Register the HoG report lifetime tests
> >
> >  Makefile.am              |  14 ++++
> >  profiles/input/hog-lib.c |  11 +++
> >  unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 177 insertions(+)
> >  create mode 100644 unit/test-hog-lifetime.c
> >
> >
> > base-commit: 17e624d1cd9a4d94f90e0ca008548456c3455492
> > --
> > 2.43.0
>


--=20
Luiz Augusto von Dentz
