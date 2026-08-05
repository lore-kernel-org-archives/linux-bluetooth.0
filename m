Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619B4854F5
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947849; cv=pass; b=FxlvC5HsJWqLm8Z6hHz8T9924z+NQKA2SzA0ewFyhDtQZuzqzVgk/gxS3Za3uoGEWF/D/a+PjalnpZCTWZyUC3CqiTPHXLyWhuy+9ECPbkSBnLqoxHI+7R2Iw8tIWHsDeLD+Sg9ofDSPUYdEM8U50RYlCYLQ3tM/4Jg9yZ6y/Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947849; c=relaxed/simple;
	bh=EPAeWG08i9SbGi5/kA0AW0wtzE4O9ymvZJSqP//cZv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJVFDMvgsuzyA7ZW8X3EmQIV34osqiiqNFpoxXbIK8vpH6gBJqdf8gx2QNaBQO8O6bGwBMJgJ78s0kmLLki5I+iEK1M+DQFZNjzCNPzFlusgDOzFzqu1DwhNw7MQ97wGqVXo7b9HeglQVvY72JU17rMorSXcM3KLbLgssR7uR5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJXNIw5m; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJXNIw5m"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66807ba2f0fso1803174d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 09:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785947841; cv=none;
        d=google.com; s=arc-20260327;
        b=PpKH8wkctQdi99sCqFxosTaJItFJO6INu2miDyUAnOSDrP47JpCoOAI2cBCnuglhr9
         nEPSS91/mNe/T8mfb8H0XlJujAiGAypx2z3IXmTNs1Fl+fwtnTVY5+Glkr/1hyXmbBvG
         byyFbhbxdOxoTFZoihj7aXmQlTmAgokDujLsDZASG1o5vG8fv0kPR85NNU+IIfZ8FdJu
         uUDfii+vkiIR081HuJqMEG5aU8guoYFlPxxbHHvIhgkTvNVaIvVzrIMVLJ7WYJ+WWL5C
         cGwV5gp07OdaBJH41A0d2yLwgjvd1dNfVgBi2MBcb2jJyYQppMMN30UPMjgLMR5XnNCr
         sKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=spvRaLlDCPL97MUpZInPjPqdUfau+4Se8lUJrH2V8Oo=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=TNq4DSXPrx+TJR6ljPyQ1mkcuDPSFDC2ZO8SS1CEb6y8Do/TcRFgvK9VM69LnIFy6D
         3ha2ZLaX/fTGgd4QYVfx6BM2phnahqZggW7m7inNMP9wHxs/VfSfatqzSg8OlzHwyR1e
         cojybdZOsc+1r1EMmJCt22oJhUD0zp0NM3G/2kqkdiLAuyPOdbUB/n7dU87hjdyTjI8L
         4+mKlLuJ0w8A81f64yWotRP/4ILl6OGWTzxLUB9+FgQeGdssZGXbXAerp3AsZyszW+OD
         c9ZpRNbBE5VQEjf7Vhyqx/bCqQDRkt6PQqkY4fIWkONyNW90D1ElymKZXvTSTg1Jq1zq
         sU7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785947841; x=1786552641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=spvRaLlDCPL97MUpZInPjPqdUfau+4Se8lUJrH2V8Oo=;
        b=OJXNIw5mtEjUg6NNqs6slbG9iDrm13h+XOyHhJYE+o/yOW4VY1xxpDGx0bmvz9vf00
         1W57XXkkGadsIKcexye//im0Hg+fGCgXCfYI+X8A1ttl3qWM57RO6v6y4P6tVwoSNBfb
         XtWzkwFgvhCg+kCqKjsKqEDxRljR8Y3oit64BnT/tE/hZDHzHmCgbNy0JrYzo7QpZvMO
         GjAgTgQ4SAVx5MrEXt60Ilp9xwCmAD2Ny01f8oOq06by9IUSICuJn9eset+U2kez7jJx
         bfb4U8zPbmqwofcC0kZFf9XcmPV7evjUyOTpbhFMest2+kcJ/9XeINjECjPjYqngjwUk
         kqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947841; x=1786552641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spvRaLlDCPL97MUpZInPjPqdUfau+4Se8lUJrH2V8Oo=;
        b=gQK4WzIwFdyTmEyN6Gu7jz9qgbYIc3C9alY+EQLPGjI7r+aItUyUYyVYuHKyV1F9gh
         Mb3t4JWzEdCjn8JBRYLguSz3ED5m8TIRoziOXkVuwgdE/i6ILQ7bX5+oROV8kjUMDmc+
         cK4u6Pmri1uiLXRJq+waJC+nHVOtBnbQDnRf7l8BZ9GzziKYjcrMLh1YGUgoaX7qppnr
         e2PNeViIvDEP0gwHQBzWdeTmvHiKjKZcuXM1bQI1VNb+GTHEU0mnKYF6WpPuk8UaN5JY
         A1OiLl27cUI56FiNBnG/loL1uC+Mi9YRZ8zCk0hYC8LyeNg0dpSJYCB+qlaJZRrbhrjM
         2RJg==
X-Gm-Message-State: AOJu0Yz7MfAYqAYpbfl23fLrIwfXdJQ8CD2QfzfUHBkPZJlJEj/lWCjo
	zBkZjOdS1HfP/d2ILFUq41h+svkYcFpiTCvvWxe/bIERk4sMbBnW0GzTiWXl4MhFESqbSOuCA3W
	OroHmdu4ncpctwkiNywKypFpmDZWVrCfNgg==
X-Gm-Gg: AR+sD13Rnlt1YR3H0Pi45BQjASz56HN8Cwo94b4R/bcWPaX+oUxS5z7KI+9sBHmT8Cg
	zi16MUgX1G053fb6IkKUCb+uLBvm3kcTV75mHnh3b80X3SfpPkTbuCiWXnn16pV1DDIl4GTIfuI
	GG6NACpwyMuAPx2E0+xT60q8LS1uMNeec6e5l5AaZVUE6AhUBZg8zvhnodTAiAGTlLeo04ynY+8
	5mRLkMRrpZNCBoxXBxHKsXnXar1SRs+1h8P8ZaeJezP2SBTMuab5lbpB8+E/dHTpcygZEFKBnPj
	lRC75ItP5KUygcArtil/FvPY9U92j7x/MXdlYe1FVU6xbzAuEhFcovUje6+HkJYLIESuf3Z8dq6
	LMfaHt4EKkj60vwYyQZyfMOZyqCwIOeCqwzs=
X-Received: by 2002:a53:a942:0:b0:667:c09c:4a36 with SMTP id
 956f58d0204a3-6699a84c611mr3886738d50.11.1785947840884; Wed, 05 Aug 2026
 09:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805150327.2669078-1-hadess@hadess.net>
In-Reply-To: <20260805150327.2669078-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Aug 2026 12:37:09 -0400
X-Gm-Features: AUfX_mzQpBN-mZq5aGbsi-SXn2UfdbsQvYJEjhVZO5MJ1Eweh64YuCA0TE6ReNA
Message-ID: <CABBYNZKpGvzN4BUxEFKH6WDpC5tq7iih3uBWrxR9aLRn_RBxpQ@mail.gmail.com>
Subject: Re: [BlueZ, v2] unit: Add test for sdp_xml_parse_record()
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> This adds 2 example XML files from other repositories, under a fair use
> license exception.
> ---
> Changes since v1:
> - Added an "expected result" field, so expected failures can also pass
>   tests.
>
>  Makefile.am                               |  10 ++
>  unit/sdp-xml/Bluetooth_HID-sdp_record.xml | 123 ++++++++++++++++++++++
>  unit/sdp-xml/qt-SerialPortSDPRecord.xml   |  57 ++++++++++
>  unit/test-sdp-xml.c                       |  81 ++++++++++++++
>  4 files changed, 271 insertions(+)
>  create mode 100644 unit/sdp-xml/Bluetooth_HID-sdp_record.xml
>  create mode 100644 unit/sdp-xml/qt-SerialPortSDPRecord.xml
>  create mode 100644 unit/test-sdp-xml.c

Why no reuse test-sdp?

> diff --git a/Makefile.am b/Makefile.am
> index 19c468d3a504..1c62ee66bdce 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -637,6 +637,16 @@ unit_test_sdp_SOURCES =3D unit/test-sdp.c \
>  unit_test_sdp_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
>
> +unit_tests +=3D unit/test-sdp-xml
> +
> +unit_test_sdp_xml_SOURCES =3D unit/test-sdp-xml.c \
> +                               src/sdp-xml.c src/sdp-xml.h \
> +                               src/log.h src/log.c
> +unit_test_sdp_xml_LDADD =3D lib/libbluetooth-internal.la \
> +                               src/libshared-glib.la $(GLIB_LIBS)
> +unit_test_sdp_xml_CFLAGS =3D $(AM_CFLAGS) $(GLIB_CFLAGS) -DTOP_SRCDIR=3D=
\""$(srcdir)"\"
> +unit_test_sdp_xml_CPPFLAGS =3D -I$(srcdir)/lib
> +
>  unit_tests +=3D unit/test-avdtp
>
>  unit_test_avdtp_SOURCES =3D unit/test-avdtp.c \
> diff --git a/unit/sdp-xml/Bluetooth_HID-sdp_record.xml b/unit/sdp-xml/Blu=
etooth_HID-sdp_record.xml
> new file mode 100644
> index 000000000000..687b0b15b520
> --- /dev/null
> +++ b/unit/sdp-xml/Bluetooth_HID-sdp_record.xml
> @@ -0,0 +1,123 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" ?>
> +
> +<!--
> +
> + From: https://github.com/AnesBenmerzoug/Bluetooth_HID/blob/master/sdp_r=
ecord.xml
> + A description of these fields can be found in the following links:
> + http://www.bluecove.org/bluecove/apidocs/javax/bluetooth/ServiceRecord.=
html
> + https://www.bluetooth.com/specifications/assigned-numbers/service-disco=
very
> +
> + -->
> +
> +<record>
> +       <attribute id=3D"0x0001"> <!-- Service Class ID List -->
> +               <sequence>
> +                       <uuid value=3D"0x1124" /> <!-- Human Interface De=
vice -->
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0004"> <!-- Protocol Descriptor List -->
> +               <sequence>
> +                       <sequence>
> +                               <uuid value=3D"0x0100" /> <!-- L2CAP -->
> +                               <uint16 value=3D"0x0011" /> <!-- HIDP -->
> +                       </sequence>
> +                       <sequence>
> +                               <uuid value=3D"0x0011" /> <!-- HIDP -->
> +                       </sequence>
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0005"> <!-- Browse Group List -->
> +               <sequence>
> +                       <uuid value=3D"0x1002" />
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0006"> <!-- Language Based Attribute ID List -=
->
> +               <sequence>
> +                       <uint16 value=3D"0x656e" /> <!-- code_ISO639 -->
> +                       <uint16 value=3D"0x006a" /> <!-- encoding -->
> +                       <uint16 value=3D"0x0100" /> <!-- base_offset -->
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0009"> <!-- Bluetooth Profile Descriptor List =
-->
> +               <sequence>
> +                       <sequence>
> +                               <uuid value=3D"0x1124" /> <!-- Human Inte=
rface Device -->
> +                               <uint16 value=3D"0x0100" /> <!-- L2CAP --=
>
> +                       </sequence>
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x000d"> <!-- Additional Protocol Descriptor Lis=
ts -->
> +               <sequence>
> +                       <sequence>
> +                               <sequence>
> +                                       <uuid value=3D"0x0100" /> <!-- L2=
CAP -->
> +                                       <uint16 value=3D"0x0013" />
> +                               </sequence>
> +                               <sequence>
> +                                       <uuid value=3D"0x0011" /> <!-- HI=
DP -->
> +                               </sequence>
> +                       </sequence>
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0100">
> +               <text value=3D"Bluetooth_Keyboard/Mouse" />
> +       </attribute>
> +       <attribute id=3D"0x0101">
> +               <text value=3D"USB > BT Keyboard/Mouse" />
> +       </attribute>
> +       <attribute id=3D"0x0102">
> +               <text value=3D"Raspberry Pi 3" />
> +       </attribute>
> +       <attribute id=3D"0x0200">
> +               <uint16 value=3D"0x0100" />
> +       </attribute>
> +       <attribute id=3D"0x0201">
> +               <uint16 value=3D"0x0111" />
> +       </attribute>
> +       <attribute id=3D"0x0202">
> +               <uint8 value=3D"0x40" />
> +       </attribute>
> +       <attribute id=3D"0x0203">
> +               <uint8 value=3D"0x00" />
> +       </attribute>
> +       <attribute id=3D"0x0204">
> +               <boolean value=3D"false" />
> +       </attribute>
> +       <attribute id=3D"0x0205">
> +               <boolean value=3D"false" />
> +       </attribute>
> +       <attribute id=3D"0x0206">
> +               <sequence>
> +                       <sequence>
> +                               <uint8 value=3D"0x22" />
> +                               <text encoding=3D"hex" value=3D"05010906A=
1018501A100050719E029E71500250175019508810295017508810195087508150025650507=
190029658100C0C005010902A10185020901A10005091901290315002501750195038102750=
59501810105010930093109381581257F750895038106C0C0"/>
> +                       </sequence>
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x0207">
> +               <sequence>
> +                       <sequence>
> +                               <uint16 value=3D"0x0409" />
> +                               <uint16 value=3D"0x0100" />
> +                       </sequence>
> +               </sequence>
> +       </attribute>
> +       <attribute id=3D"0x020b">
> +               <uint16 value=3D"0x0100" />
> +       </attribute>
> +       <attribute id=3D"0x020c">
> +               <uint16 value=3D"0x0c80" />
> +       </attribute>
> +       <attribute id=3D"0x020d">
> +               <boolean value=3D"true" />
> +       </attribute>
> +       <attribute id=3D"0x020e">
> +               <boolean value=3D"false" />
> +       </attribute>
> +       <attribute id=3D"0x020f">
> +               <uint16 value=3D"0x0640" />
> +       </attribute>
> +       <attribute id=3D"0x0210">
> +               <uint16 value=3D"0x0320" />
> +       </attribute>
> +</record>
> diff --git a/unit/sdp-xml/qt-SerialPortSDPRecord.xml b/unit/sdp-xml/qt-Se=
rialPortSDPRecord.xml
> new file mode 100644
> index 000000000000..1f62ccf11a41
> --- /dev/null
> +++ b/unit/sdp-xml/qt-SerialPortSDPRecord.xml
> @@ -0,0 +1,57 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" ?>
> +
> +<!--
> + This is an XML file describing an SDP service record for a Serial Port
> + service.
> +
> + You can use the linux sdptool command to create a file like this for
> + publishing your Bluetooth services. See the "Creating a Bluetooth servi=
ce"
> + tutorial for more details.
> +
> + From: https://radekp.github.io/qtmoko/api/bluetooth-bluetoothservice-se=
rialportsdprecord-xml.html
> +-->
> +
> + <record>
> +         <attribute id=3D"0x0001">
> +                 <sequence>
> +                         <uuid value=3D"0x1101" />
> +                 </sequence>
> +         </attribute>
> +         <attribute id=3D"0x0004">
> +                 <sequence>
> +                         <sequence>
> +                                 <uuid value=3D"0x0100" />
> +                         </sequence>
> +                         <sequence>
> +                                 <uuid value=3D"0x0003" />
> +                                 <uint8 value=3D"0x05" />
> +                         </sequence>
> +                 </sequence>
> +         </attribute>
> +         <attribute id=3D"0x0005">
> +                 <sequence>
> +                         <uuid value=3D"0x1002" />
> +                 </sequence>
> +         </attribute>
> +         <attribute id=3D"0x0006">
> +                 <sequence>
> +                         <uint16 value=3D"0x656e" />
> +                         <uint16 value=3D"0x006a" />
> +                         <uint16 value=3D"0x0100" />
> +                 </sequence>
> +         </attribute>
> +         <attribute id=3D"0x0009">
> +                 <sequence>
> +                         <sequence>
> +                                 <uuid value=3D"0x1101" />
> +                                 <uint16 value=3D"0x0100" />
> +                         </sequence>
> +                 </sequence>
> +         </attribute>
> +         <attribute id=3D"0x0100">
> +                 <text value=3D"Serial Port" />
> +         </attribute>
> +         <attribute id=3D"0x0101">
> +                 <text value=3D"COM Port" />
> +         </attribute>
> + </record>
> diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
> new file mode 100644
> index 000000000000..aef22b280498
> --- /dev/null
> +++ b/unit/test-sdp-xml.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2026  Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <glib.h>
> +
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +
> +#include "src/shared/util.h"
> +#include "src/shared/tester.h"
> +#include "src/log.h"
> +#include "src/sdp-xml.h"
> +
> +struct test_data {
> +       GString *s;
> +       char *filename;
> +       gboolean expected_result;
> +};
> +
> +static void parse_xml(gconstpointer data, gsize len, gboolean expected_r=
esult)
> +{
> +       sdp_record_t *rec =3D NULL;
> +       gboolean ret;
> +
> +       rec =3D sdp_xml_parse_record(data, len);
> +       ret =3D rec ? TRUE : FALSE;
> +       if (ret =3D=3D expected_result)
> +               tester_test_passed();
> +       else
> +               tester_test_failed();
> +       if (rec)
> +               sdp_record_free(rec);
> +}
> +
> +static void parse_xml_for_filename(gconstpointer data)
> +{
> +       struct test_data *t =3D (struct test_data *) data;
> +       char *path =3D NULL;
> +       GError *error =3D NULL;
> +       char *contents =3D NULL;
> +       gsize len;
> +
> +       path =3D g_build_filename(TOP_SRCDIR, "unit", "sdp-xml", t->filen=
ame, NULL);
> +       if (!g_file_get_contents(path, &contents, &len, &error)) {
> +               g_warning("Can't load file '%s': %s", path, error->messag=
e);
> +               g_free(path);
> +               g_error_free(error);
> +               tester_test_failed();
> +       }
> +       parse_xml(contents, len, t->expected_result);
> +       g_free(contents);
> +       g_free(path);
> +}
> +
> +#define DEFINE_TEST(fname, res)                                         =
               \
> +       data.expected_result =3D res;                                    =
         \
> +       data.filename =3D fname;                                         =
         \
> +       tester_add("/" fname, &data, NULL, parse_xml_for_filename, NULL);
> +
> +int main(int argc, char *argv[])
> +{
> +       struct test_data data;
> +
> +       tester_init(&argc, &argv);
> +
> +       DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
> +       DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
> +
> +       return tester_run();
> +}
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
