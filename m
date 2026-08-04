Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7145C6E0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862060; cv=pass; b=szS47Sbn3+rdYSLRa7ws5Ued+A7/QE4VW4tNCD/khTK2i8FBAV5ZmmISqVe55PhTXWUnbRszxFmdV2vTmowQenv9+aqw98kpuN4wYnuj3gWC+stNovMODXuDGu0Jp+sAqjDijuOXU+lU2hcHn+obIlRQjPn4UDzamKxYqSl+sP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862060; c=relaxed/simple;
	bh=/u1M1jHLRXvaVo9JUVSvIZMqtocnq4ZHn9NqjK8qxQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdINPbzV9ydRXkTu1okCeJHszrdGqCE7FxpBX9WWqc00G9VwDoD9GOs/cj7q74z43lP4qA5FTVL33fr/ohQb24C1nAlpxXrrcGczjijpPv9aykm2fgSTWa4vaPXB0Mx74n8+0Px2+PmXb78q/EmpAmrxhtW9lYt+ntAWwrvhJ0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPfoWqvm; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPfoWqvm"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66843536f94so5573031d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 09:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862025; cv=none;
        d=google.com; s=arc-20260327;
        b=eby4yqN5FrdKIZav5oZ8yRQCIINmyMsa5KKFGKipivGaZZzgdv0NQA0q2qq7oM5TP7
         TSfsfyVYGAsUaQbxZk/BvkoXfwbdKj5jzO5JZ21iuqhE6lA4QjdjRu+4Hc2rV81q4ZPh
         ssiMrmlnl2086+uOFCO4pasJqT34qYqbg38okKenvnJ5NM4ooitcFz3uQb/rnFBEE0ZI
         37BxhhIG3JzFjctF1kFPAa5jJAaiQr+ZGNOGsyRjzMqSyvORaMBCaPz9Y47LTiQ1+gvi
         otMS5GneXdzTlNglLbapfUgG7afTta+go0uftULw/UrkAXr5VC/80Go1ttcuJFcvgIAm
         wG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfgKTWxv23+BNgSNAiqVggkSDwjfLWf6qHI2rywJaM4=;
        fh=ArdDmUQzzfkt7diMa+kfWdd+IJsnjcf7biWiU4/zryA=;
        b=QxibKGXZIvfS2srNCdbZ6nL8dsNYJ+w1dSC6oyLLTbDsnzz/7v9Miv7RLMNMmtemCW
         y9XFnP2C73Xz/w5m87buBLzYPL07/mE/FIP0BmaZMjgFJmK8r3jGIy5yCyz6OxUyKww3
         OgT74xTrGvlOpbmJlK+IQSkospmEErQWi7v5Py/81CopO/G6ffLe/GDF51RokS3u+Ysv
         rHqbpax0YYKDOijvIRnSXRAwZYSMKcHE2cLQI2WAhg/2tBXJTUmjyz8CHViHe42oQTTH
         QmcZXLNRjcqGxFdaevWCcwP5QFy2g19+aoRTZpAeCgAkseU6cDKCiSt9F7GpEZltDVJy
         br8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862025; x=1786466825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vfgKTWxv23+BNgSNAiqVggkSDwjfLWf6qHI2rywJaM4=;
        b=SPfoWqvmInX0n9IDSA0PHndY4PZTZ3QUjcx75TXU9MjbzBp+phhepiyYOR1qm308Hq
         KiwNa417KK3ZsSaoeY2u8EqjZYUDp4R5nxWOHgcZxWrdcurkrbBWhd6aNv15akwre9Qh
         S6B/F6kb84knkli3UZRgKRi1bVRzpwBV78a04oBv+Fhm+b4kjthaOak94q9wheo++aB9
         mBKPVDNxUPypyvTpu2WIW2FrAKgUUkpmdXVSiiAzrpzDLgAzgEZmxU5RTcasjyaoyx2J
         sAKkTc3mN9ZYePyfRY/IzpF1UF66hdeM9V6DTeTrhldBAF+l7H2Eij15Iuzgo73kvlEl
         qa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862025; x=1786466825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfgKTWxv23+BNgSNAiqVggkSDwjfLWf6qHI2rywJaM4=;
        b=Dgzbnh9lcWdwna1CUGb8etKld+yUC0nYxV3YdpRzabQZXiPZzHYWU0MlnX7u/Bn2sm
         LE17qmU7TqR9M6srkM7bEXAkh83YS/wBdIP1sWXx0xEzeE8VYL1GjUrUNs69aFqtxukF
         eUeVhiENg3RL12PVnlkqcBoN/6UXq6WFG+aS/8vofTUWhDNAY8o8wZFWjGLZxZTdmp/c
         frRu0kPNS0DtKoomHUUJxH2WFphm0Sdu/zqWtNKePWajZHxhE3yzTLFuE0JdHNurK9xC
         +sPt4dlgnSRaFoot/Or7wh9t9Cit+AX5B3Mlno3ft8HWiknE5cwI37m/1C+bFNPzq+4g
         4JSw==
X-Gm-Message-State: AOJu0YzEuSDniXc8jo8KMHtU1srs+G0gTJK09fJN+rcUN3PZKtVlneAx
	x1I83aa27QwkPYMCSmSt7Jj/F+T/eplLI+sBd6htAB3JW5F6/915rQbmrlmBN7G/9+8MFLPWKXC
	TakfjKMu5rouQ/408WZ032s95ZhtruNP6rQ==
X-Gm-Gg: AR+sD13iKLEl6zjZW26zKTw+wVXmgHHctkz/xHL2bF9sOL+RqKIlDxkYUbtoJyvlPUP
	CN/suRIHdtYNIHPgVVlQEkvT0gJ1ElX8S/eH7Itvu/ocYzMq9z69zqBr7rLXjYCLsA2Q0kUGlD/
	ADe+vJB9QBlM8r7opZe9eGzO7OJnsFRjAsi/gvFVktVQhrN2yZsQrkcX3SGmqY6mNtFUxUTCnCd
	onmWkJs/sCqt37qps0eRgKa7+IsRxRqZVizlgfaPxU6LWvfotqriDq7tedS1HiS3Ap7ZI1KC56x
	A+vxlVtehitMQBTee6TgIgSSgQoKfonLqMqvRLDWVArPgUTCSRuAIAfnpgURlFrVIi20r/vlSis
	EU0uGVyZVoEzUllrntoXcfl5WWy7BAMIbHBfQeyVc71A8Sw==
X-Received: by 2002:a53:b115:0:b0:668:99c8:bf15 with SMTP id
 956f58d0204a3-6699a8f6c97mr148197d50.11.1785862025197; Tue, 04 Aug 2026
 09:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804142419.2274153-1-hadess@hadess.net> <20260804142419.2274153-3-hadess@hadess.net>
In-Reply-To: <20260804142419.2274153-3-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Aug 2026 12:46:53 -0400
X-Gm-Features: AUfX_myPsPKDQ5jruA-AfNR8tsNYn1gAa0rxzyDN0X65KBNRAg6Q-SqJ-UTFWzM
Message-ID: <CABBYNZKoj_jr=msyTAiQ+AcV9Xf4MjCAjvcq0pDf8bWPBoypyQ@mail.gmail.com>
Subject: Re: [BlueZ, v2 2/3] unit: Adapt poc_*_oob.c test into a new test
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, 
	Elman Shahbazov <shahbazovelman97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.
>
> Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>
> ---
>  Makefile.am           |  9 +++++
>  unit/test-avrcp-sec.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 unit/test-avrcp-sec.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 19c468d3a504..e3baa4155c1f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -660,6 +660,15 @@ unit_test_avrcp_SOURCES =3D unit/test-avrcp.c \
>  unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
>
> +unit_tests +=3D unit/test-avrcp-sec
> +
> +unit_test_avrcp_sec_SOURCES =3D unit/test-avrcp-sec.c \
> +                       profiles/audio/avrcp-parse.c \
> +                       profiles/audio/avrcp-parse.h \
> +                       src/log.h src/log.c
> +unit_test_avrcp_sec_LDADD =3D lib/libbluetooth-internal.la \
> +                               src/libshared-glib.la $(GLIB_LIBS)

Any reason why this couldn't live inside test-avrcp.c?

>  unit_tests +=3D unit/test-hfp
>
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
> diff --git a/unit/test-avrcp-sec.c b/unit/test-avrcp-sec.c
> new file mode 100644
> index 000000000000..a100b2d68e35
> --- /dev/null
> +++ b/unit/test-avrcp-sec.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2026  Red Hat Inc.
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
> +#include "src/shared/util.h"
> +#include "src/shared/tester.h"
> +#include "src/log.h"
> +
> +#include "profiles/audio/avrcp-parse.h"
> +
> +static void avrcp_element_name_oob(gconstpointer data)
> +{
> +       char name[255];
> +       uint16_t namesize;
> +       gboolean ret;
> +
> +       /* Crafting a malicious payload.
> +        * Actual packet length (len) =3D 14 bytes */
> +       uint8_t malicious_packet[14] =3D {0};
> +
> +       /* Specify namesize =3D 1000 (0x03E8 in Big Endian) at offset 11 =
*/
> +       malicious_packet[11] =3D 0x03;
> +       malicious_packet[12] =3D 0xE8;
> +
> +       /* Launching the PoC. We transmit a 14-byte packet, but namesize=
=3D1000... */
> +       ret =3D parse_media_element_name(malicious_packet, sizeof(malicio=
us_packet),
> +                                      name, &namesize);
> +       if (ret)
> +               tester_test_passed();
> +       else
> +               tester_test_failed();
> +}
> +
> +static void avrcp_folder_name_oob(gconstpointer data)
> +{
> +       char name[255];
> +       gboolean ret;
> +
> +       /* Crafting a malicious payload.
> +        * Actual packet length (len) =3D 14 bytes */
> +       uint8_t malicious_packet[14] =3D {0};
> +
> +       /* Specify namesize =3D 1000 (0x03E8 in Big Endian) at offset 12 =
*/
> +       malicious_packet[12] =3D 0x03;
> +       malicious_packet[13] =3D 0xE8;
> +
> +       /* Launching the PoC. We transmit a 14-byte packet, but namesize=
=3D1000... */
> +       ret =3D parse_media_folder_name(malicious_packet, sizeof(maliciou=
s_packet),
> +                                     name);
> +       if (ret)
> +               tester_test_passed();
> +       else
> +               tester_test_failed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       tester_init(&argc, &argv);
> +
> +       tester_add("/avrcp-element-name-oob", NULL, NULL, avrcp_element_n=
ame_oob, NULL);
> +       tester_add("/avrcp-folder-name-oob", NULL, NULL, avrcp_folder_nam=
e_oob, NULL);
> +
> +       return tester_run();
> +}
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
