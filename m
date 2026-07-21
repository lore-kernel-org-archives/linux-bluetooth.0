Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153D3FBB77
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644631; cv=pass; b=cAhfZOFHsVrS5mZKXCZ3e9LcMBSYXBXM7MWz3lmOMVKr+52/XT8rW8peBhRXsOqeHgQGp7I6yHlilUYHoGxvfjJDDartAoKnJRtyl1vQHgxDwluOrGfF3jn1L7mNOjpBulYBrpNlyO9oxUpJ0g2eTzOaTVy8x6qgHBNzZnvbOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644631; c=relaxed/simple;
	bh=wbMhfQdUy5DU1kDMwP+UHV4LJpOxpBtoRYT4TaJwris=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM49s9wrtHwKE3ISdioA2w0maplETImb0+75diZ7Gi4gWloY8ZRyG0y/UQ/7S4WlZ6zirCvQVsf1YOYQ1X99dfJKJWXXraxXQgkHVnBkrlT+DikFrl/yyeiLeLxJS6gLgEDUFUFJJmoPcwfL0hTiN1QnIej6iw1dGtjMiaZTNTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt6zcnaS; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt6zcnaS"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e95760e42so15862787b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784644629; cv=none;
        d=google.com; s=arc-20260327;
        b=C8YsHj9J8XknfzPM1zQvV1xV989kCHsTN+C7ecEOoeZilkmv9HeILxxkTR8Lix8Q/v
         H+FcHMSY7j3G/wZcaStLRaBCDW9EkAutzQXsRSlP8uwrH4a8CgrWoZ4Hwo9ptt3wYXAs
         JCAjxNgu+CpPs9gE5JzMPFE8Dlb5yRJYtLxjsYTRuMgJe5CUSrXPuB1763CHlLCesJht
         QTMm2D2YiLhzpcuy1Ot4YZxV39xlQ1uM/oLo6TYIjxyRq0vLrJSJyjHTyDZGIikCsDAi
         2mwSe2PrqhW0UFVM1vijAx2INsVOplRxmbCHsWNJo9laZtaS9ByFnx0o6VPuOEiJXajP
         GqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IpUQEua7nLEY2KnnAo2ZNfwJkcH3p1ESHpDkGqjJxaY=;
        fh=h0t8UKtdkJEtExGnMDmoafJH1yFcBNHSNlp+JUzL/60=;
        b=UsHEoc0Owios1kbEntpFi1AnQIfdyNpGr+Z5HoqIz/HMFxrmIKjN/ryrv/19We8fHf
         YmoLm9PkopvHGTJTbUW5lXvegR6CxFXDNHuiqLyqN+oJqz0MBUmLMgV3tNsvtRgt6AO9
         oCHnHStFhjFjEt1/u0LIV9YqQsUDJMpFz4HsslCyrfO6RSy1UYUncsKAk56MS9KXDw3+
         sz1qs4L9TZoaFn8M6mgq2NzvGvBWRW1fUfFiBW+P28x0XjUqvvbGzX1n5gvTeVA+wEij
         Kygqd0qcUuS6BZaDQ+ciuTI2j45katKHNrh0Q8UwbntwBP12XAZy9wKKjKZtEMXsAAUk
         VqkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644629; x=1785249429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IpUQEua7nLEY2KnnAo2ZNfwJkcH3p1ESHpDkGqjJxaY=;
        b=Wt6zcnaS4AgnxJp4lVJ677HwLIVt8VSt75OnmST92YMvKhKYZfSAQII2dfT5Jx8DBY
         OlEKiPN0hGXcAff1p/vci42ymYtPXGbx1mDrT+QZb/TFrE6mmV+axW1Sq5EEQowXey59
         1ziIMsrvrqjzuxUimvKTnT3hOSqeJ1EKRb8GQKb+0bP1hy+RuFpTZeTTuFY39As/USeU
         +3I5yiAqf16psRwiNB+Q3kE/341wu+iSHz/TopyKjLrA+VAojeFvgw28S4k+R6RB7i3R
         MR0IzrQwVoS/viaweaiGk0nYDSpcM/u1zel2JumLZPCLPTB6zWZdAG3+HFLrkLHA71hv
         sRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644629; x=1785249429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpUQEua7nLEY2KnnAo2ZNfwJkcH3p1ESHpDkGqjJxaY=;
        b=KP3ofZ6ddM65aNoJirsrFgf7jiZMTzUX0vV9nzOQCDomnwu0X+6oCAWxHUq/qnn2lQ
         eK8St2bqDVbY5K+l85jWxF04oPOO8ebBDep+b8EF1Oy6HTj73D4lB2QCGA9kuPD8lM0s
         jMutN5+GQVjMbLEe5BkT0LEdxjIGcRPGtKXQTrogt9RcjaaKtlF8BN0bkaZ8TJBBMjFY
         lITjtYHn+ZOyHAX8FskrQbA/MjkUum7rDq3VKsbyYsMaTRdyvFRC7R3fjXFEfMPxx20C
         zjCbVCopcTbjPC3ZRAfP8ANoeSwo1GovUUv+UAlaSVxJwY00VvETfJH3pD2Fq+vE7kt6
         2Isw==
X-Gm-Message-State: AOJu0YwEMXCLosDVfE1OlQjnx8cisOHwRxYaC5oW2mKEwHAP5rJLQu9e
	vAwWwVUp13u5hxTZAzvkoSZf+dnwqxBrSFpmkz/T11aNYymPcZbpKQyK3Ky8cJAAyLKXJcg2E7W
	zthtxRbbhtPX0Z/cAf4fIja8DxODoJEI=
X-Gm-Gg: AR+sD13wfTL0KHgEFbpeZt41Cgr+8VA8E6jZYJUq0I6t5Ds45UgprAM41HLhDqkdmN/
	pdu3NYokFgiQL/mfTc+DRnD1jeEtJYwHsvZn+BEGwEz1rrFPlD8hrCYs0qmhAkoGZryn7w6ts1a
	i+KFlmxrMBmLY1SEsu2g97jFTPH4cb6Tfl1cix00lJ/xPmKAomCYgSSNo4QFwRoOAoelXkq9DBj
	6cNch3ZBnO2bw0Lv9DSILeOazXdd39O2TqH0KBUv6iSGYRGsDooFuxlTXN2b8OYfQlpblDLC56e
	t1fFMMt0SY16XNu8vB0y/aaQ96zNd9Yi/8/IysiW0aF4SW0q
X-Received: by 2002:a05:690c:6b0b:b0:81d:26f9:bc82 with SMTP id
 00721157ae682-81ef26b4f7dmr63747957b3.57.1784644628546; Tue, 21 Jul 2026
 07:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753084800.git.Pakrohk@users.noreply.github.com> <patch.1753084802.git.Pakrohk@users.noreply.github.com>
In-Reply-To: <patch.1753084802.git.Pakrohk@users.noreply.github.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 10:36:57 -0400
X-Gm-Features: AUfX_mwysLUMyy6sfSg1yDUUACSSQj-nC4mSLOZESe4l3wgVinnuIE_oeU8hBrk
Message-ID: <CABBYNZJUNQjaeiy6PrDLWZ1wwgfaEFjgozfZF91J=sPq2Uxp_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/3] input: add HID gamepad quirk fallback for
 broken SDP records
To: Pakrohk <rhpcir@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	Pakrohk <Pakrohk@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pakrohk,

On Tue, Jul 21, 2026 at 10:17=E2=80=AFAM Pakrohk <rhpcir@gmail.com> wrote:
>
> From: Pakrohk <Pakrohk@users.noreply.github.com>
>
> Add a modular gamepad quirk system to profiles/input/ that provides HID
> report descriptor fallbacks when BlueZ's SDP parser fails.
>
> When extract_hid_record() returns -ENOENT for a known gamepad, the quirk
> system checks registered quirks and injects a fallback HID descriptor so
> the kernel's HID driver can create an input device.
>
> Two tiers of quirk support:
>
> Built-in quirks:
>   Hardcoded C entries for known broken controllers. Currently supports
>   DualShock 4 v2 / TG170W (054c:09cc) with a minimal BT HID descriptor
>   matching report ID 0x11 (78 bytes, as expected by hid-playstation).
>
> External quirk profiles:
>   JSON files in /var/lib/bluez/quirks/ with HMAC-SHA256 signatures.
>   Loaded at bluetoothd startup. Enables community-maintained support
>   without BlueZ source modifications.
>
> Architecture:
>   quirk.h     - quirk struct definition and dispatch API
>   quirk.c     - quirk registry and dispatch logic
>   quirk-profile.h/c - external JSON profile loader with HMAC verification
>   quirks/tg170w.c - built-in quirk for DualShock 4 v2
>
> The quirk only activates when SDP parsing fails AND the device matches
> a registered quirk. This does not globally weaken HID parsing.
>
> Multi-factor matching avoids false positives:
>   match =3D (vendor_id =3D=3D 0x054c && product_id =3D=3D 0x09cc)
>        || (device_name =3D=3D "Wireless Controller"
>            && SDP provider contains "Sony")
>
> Signed-off-by: Pakrohk <Pakrohk@users.noreply.github.com>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 8017e07..0089c3d 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1089,11 +1089,8 @@ static int hidp_add_connection(struct input_device=
 *idev)
>
>         err =3D extract_hid_record(idev, req);
>         if (err < 0) {
> -               /* Try gamepad quirk fallback for known broken devices */
> -               if (gamepad_quirk_match(idev)) {
> -                       DBG("HID SDP failed, trying gamepad quirk");
> -                       err =3D gamepad_quirk_apply(idev, req);
> -               }
> +               DBG("HID SDP failed, trying gamepad quirk");
> +               err =3D gamepad_quirk_apply(idev, req);
>         }
>
>         if (err < 0) {
> diff --git a/profiles/input/quirk-profile.c b/profiles/input/quirk-profil=
e.c
> index 8ec3835..4240154 100644
> --- a/profiles/input/quirk-profile.c
> +++ b/profiles/input/quirk-profile.c
> @@ -28,22 +28,20 @@
>
>  #include "bluetooth/bluetooth.h"
>  #include "bluetooth/hidp.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/log.h"
>
>  #include "quirk.h"
>  #include "quirk-profile.h"
>
> -/* Accessors from src/device.h and src/service.h */
> -extern struct btd_service *input_device_get_service(
> -                                       struct input_device *idev);
> -extern struct btd_device *btd_service_get_device(
> -                                       const struct btd_service *service=
);
> -extern uint16_t btd_device_get_vendor(struct btd_device *device);
> -extern uint16_t btd_device_get_product(struct btd_device *device);
> -extern bool device_name_known(struct btd_device *device);
> -extern void device_get_name(struct btd_device *device,
> -                                       char *name, size_t len);
> +#include "gdbus/gdbus.h"
> +
> +#include "src/device.h"
> +#include "src/service.h"
> +#include "src/shared/crypto.h"
> +#include "device.h"
>
>  #define MAX_EXTERNAL_QUIRKS 32
>  #define HMAC_KEY_PATH QUIRK_PROFILE_DIR "/.hmac_key"
> @@ -67,6 +65,7 @@ struct external_quirk {
>
>  static struct external_quirk *ext_quirks[MAX_EXTERNAL_QUIRKS + 1];
>  static int num_ext_quirks;
> +static struct bt_crypto *crypto;
>
>  /*
>   * Parse a hex string like "0501 0905" into a byte buffer.
> @@ -139,77 +138,23 @@ static char *read_file(const char *path, size_t *ou=
t_len)
>  }
>
>  /*
> - * Compute HMAC-SHA256 using openssl CLI.
> - */
> -static char *hmac_sha256(const uint8_t *key, int key_len,
> -                        const void *data, size_t data_len)

This file doesn't even exist upstream, so how come you're modifying
it? Looks like there is something off with this patch-set, beside it
is saying that it doesn't use openssl so this seem to be a left over
or something.

> -{
> -       char key_hex[HMAC_KEY_SIZE * 2 + 1];
> -       char *cmd;
> -       char *result =3D NULL;
> -       FILE *p, *tmpf;
> -       int i;
> -       const char *tmpfile =3D "/tmp/.bluez_quirk_hmac_input";
> -       char line[256];
> -       char *eq, *end;
> -
> -       for (i =3D 0; i < key_len; i++)
> -               snprintf(key_hex + i * 2, 3, "%02x", key[i]);
> -       key_hex[key_len * 2] =3D '\0';
> -
> -       tmpf =3D fopen(tmpfile, "we");
> -       if (!tmpf)
> -               return NULL;
> -
> -       fwrite(data, 1, data_len, tmpf);
> -       fclose(tmpf);
> -
> -       cmd =3D malloc(strlen(key_hex) + 128);
> -       if (!cmd) {
> -               unlink(tmpfile);
> -               return NULL;
> -       }
> -
> -       snprintf(cmd, strlen(key_hex) + 128,
> -               "openssl dgst -sha256 -hmac '%s' -hex < %s 2>/dev/null",
> -               key_hex, tmpfile);
> -
> -       p =3D popen(cmd, "re");
> -       free(cmd);
> -       unlink(tmpfile);
> -
> -       if (!p)
> -               return NULL;
> -
> -       while (fgets(line, sizeof(line), p)) {
> -               eq =3D strstr(line, "=3D ");
> -               if (eq) {
> -                       eq +=3D 2;
> -                       end =3D eq + strlen(eq) - 1;
> -                       while (end > eq && (*end =3D=3D '\n' || *end =3D=
=3D '\r'
> -                                               || *end =3D=3D ' '))
> -                               *end-- =3D '\0';
> -                       result =3D strdup(eq);
> -                       break;
> -               }
> -       }
> -
> -       pclose(p);
> -       return result;
> -}
> -
> -/*
> - * Verify HMAC signature.
> + * Verify HMAC-SHA256 signature using bt_crypto (kernel AF_ALG).
>   */
>  static bool verify_signature(const char *json_path,
>                              const uint8_t *hmac_key, int key_len)
>  {
>         char sig_path[1024];
>         size_t sig_len, json_len;
> -       char *sig_hex, *json_data, *expected_sig;
> +       char *sig_hex, *json_data;
>         char *end;
> +       uint8_t computed[32];
> +       char computed_hex[65];
> +       int i;
>         bool valid;
>
> +       if (!crypto)
> +               return false;
> +
>         snprintf(sig_path, sizeof(sig_path), "%s" SIG_EXT, json_path);
>
>         sig_hex =3D read_file(sig_path, &sig_len);
> @@ -228,21 +173,25 @@ static bool verify_signature(const char *json_path,
>                 return false;
>         }
>
> -       expected_sig =3D hmac_sha256(hmac_key, key_len, json_data, json_l=
en);
> -       free(json_data);
> -
> -       if (!expected_sig) {
> +       if (!bt_crypto_hmac_sha256(crypto, hmac_key, key_len,
> +                               (const uint8_t *) json_data, json_len,
> +                               computed)) {
> +               free(json_data);
>                 free(sig_hex);
>                 return false;
>         }
> +       free(json_data);
> +
> +       for (i =3D 0; i < 32; i++)
> +               snprintf(computed_hex + i * 2, 3, "%02x", computed[i]);
> +       computed_hex[64] =3D '\0';
>
> -       valid =3D (strcmp(sig_hex, expected_sig) =3D=3D 0);
> +       valid =3D (strcmp(sig_hex, computed_hex) =3D=3D 0);
>
>         if (!valid)
>                 DBG("Signature mismatch for %s", json_path);
>
>         free(sig_hex);
> -       free(expected_sig);
>         return valid;
>  }
>
> @@ -516,6 +465,12 @@ int load_external_quirks(const char *dir)
>         if (!dir)
>                 dir =3D QUIRK_PROFILE_DIR;
>
> +       if (!crypto) {
> +               crypto =3D bt_crypto_new();
> +               if (!crypto)
> +                       DBG("quirk-profile: failed to init crypto");
> +       }
> +
>         d =3D opendir(dir);
>         if (!d) {
>                 DBG("quirk-profile: cannot open %s: %s", dir, strerror(er=
rno));
> @@ -586,4 +541,9 @@ void free_external_quirks(void)
>                 ext_quirks[i] =3D NULL;
>         }
>         num_ext_quirks =3D 0;
> +
> +       if (crypto) {
> +               bt_crypto_unref(crypto);
> +               crypto =3D NULL;
> +       }
>  }
> diff --git a/profiles/input/quirk.c b/profiles/input/quirk.c
> index 053f45b..fa5e7e6 100644
> --- a/profiles/input/quirk.c
> +++ b/profiles/input/quirk.c
> @@ -36,23 +36,6 @@ static struct gamepad_quirk *quirks[] =3D {
>         NULL
>  };
>
> -bool gamepad_quirk_match(struct input_device *idev)
> -{
> -       int i;
> -
> -       /* Check built-in quirks first */
> -       for (i =3D 0; quirks[i]; i++) {
> -               if (quirks[i]->match(idev))
> -                       return true;
> -       }
> -
> -       /* Then check external (file-based) quirks */
> -       if (external_quirk_match(idev))
> -               return true;
> -
> -       return false;
> -}
> -
>  int gamepad_quirk_apply(struct input_device *idev,
>                         struct hidp_connadd_req *req)
>  {
> @@ -69,9 +52,5 @@ int gamepad_quirk_apply(struct input_device *idev,
>         }
>
>         /* Try external quirks */
> -       if (external_quirk_match(idev)) {
> -               return external_quirk_apply(idev, req);
> -       }
> -
> -       return -1;
> +       return external_quirk_apply(idev, req);
>  }
> diff --git a/profiles/input/quirk.h b/profiles/input/quirk.h
> index 08e0bce..f2fc81b 100644
> --- a/profiles/input/quirk.h
> +++ b/profiles/input/quirk.h
> @@ -24,13 +24,10 @@ struct gamepad_quirk {
>                         struct hidp_connadd_req *req);
>  };
>
> -bool gamepad_quirk_match(struct input_device *idev);
> -
>  int gamepad_quirk_apply(struct input_device *idev,
>                         struct hidp_connadd_req *req);
>
>  /* External quirk support (quirk-profile.c) */
> -bool external_quirk_match(struct input_device *idev);
>  int external_quirk_apply(struct input_device *idev,
>                         struct hidp_connadd_req *req);
>
> diff --git a/profiles/input/quirks/tg170w.c b/profiles/input/quirks/tg170=
w.c
> index d3f37a8..d82c3fa 100644
> --- a/profiles/input/quirks/tg170w.c
> +++ b/profiles/input/quirks/tg170w.c
> @@ -38,9 +38,14 @@
>  #include "bluetooth/sdp.h"
>  #include "bluetooth/sdp_lib.h"
>
> +#include "gdbus/gdbus.h"
> +
>  #include "src/log.h"
> +#include "src/device.h"
> +#include "src/service.h"
>
>  #include "../quirk.h"
> +#include "../device.h"
>
>  /*
>   * DualShock 4 Bluetooth HID Report Descriptor.
> @@ -124,25 +129,6 @@ static const uint8_t tg170w_hid_report_descriptor[] =
=3D {
>  #define TG170W_VID  0x054c  /* Sony */
>  #define TG170W_PID  0x09cc  /* DualShock 4 v2 */
>
> -/* Opaque structs - we don't pull in heavy headers */
> -struct input_device;
> -struct btd_device;
> -struct btd_service;
> -
> -/* Declarations from src/device.h and src/service.h */
> -extern struct btd_service *input_device_get_service(
> -                                       struct input_device *idev);
> -extern struct btd_device *btd_service_get_device(
> -                                       const struct btd_service *service=
);
> -extern uint16_t btd_device_get_vendor(struct btd_device *device);
> -extern uint16_t btd_device_get_product(struct btd_device *device);
> -extern const sdp_record_t *btd_device_get_record(
> -                                       struct btd_device *device,
> -                                       const char *uuid);
> -extern bool device_name_known(struct btd_device *device);
> -extern void device_get_name(struct btd_device *device,
> -                                       char *name, size_t len);
> -
>  static bool tg170w_match(struct input_device *idev)
>  {
>         struct btd_service *service;
>


--=20
Luiz Augusto von Dentz
