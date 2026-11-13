Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587714;
	b=3tVc2l+8kzdcAngrRc7Yt9Z8lTIkb9q1/nb4Jpdfd7zsrbUQqFsZNerqrS3xxT1zVviC
	 6AraFWcjq8jeLdVb9vlVyCkeGGTzOb3VIa63PHYYt7NmhDE83pKRo6Pwco+ldmoSiLbuh
	 DbTOFEVli7jOo2f2sn8Q0Sl8sB9fUPbPJ6PK+xceq/Jg/ASYqUZk+SuYClR12l6vuJQb0
	 CFLxnu6J5HBZGh+w/d4yhABUtHL5K39QJsKcEjbSzLZL7Z7Q/FKCfab2gfBIVmEXWXRWQ
	 XG++qdkOCDnEw9pJjUMcfN1ctee3zPHmdi96H2VnxxTCPFAVqgi2yS3uvxKCr/vt9AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ugJuXIYSqVs6yIyNot5gPvrUJQmnkiieeHizPCV5toc=;
	b=CrG28d06XEDdViIPIasUtzshhGl7xLJXcQiwl5dnkqvmV2tFDa1XrbUrmakHERBiY9B1
	 dYYDFbR6ImIbOwmTtt/GGf+zh09iHlIY+udaBryudMkT3UwbaiWQPhG08qfStifk5Xt2a
	 DUhislfeGSxDWXCTvB3e2omZfm9xOhj0G5JT8jZR4Q/xFNJKtNUHp40WW4ZDNiLBr5upa
	 o+T6g6xonBeaaI/GYBRfWwKOzzlf7+n3EbuMNf/12nNLWIPJqhh2wFbaIb2ARecz7BL8f
	 HD/CfJKQ/1ovtc4tWBuayHHcHFKbMNURiZ5F8foX4G3j50ycTtS8vSCZJz4gSRELu9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBwvzn4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9D606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D9D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBwvzn4W
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4d7034a99a9so1497897b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587712; cv=none;
        d=google.com; s=arc-20260327;
        b=HcB1ucVoVyQVJsfw3iBjjg2IJgJJFIpDPCdyUvTVy6koJF1wMgYvMTVdwn2ULe2rJj
         xi6ZCWJ0a51tSyWG0Rs37J3m7XtZZgdyrgxfmRiftIRSjj1H5AANEmPnsP2lA0Ux2Hzs
         dvKiolXDqzKonwZVt3VN8lGxTF9MoLk9sx0LF+rhYHONf6Q9kVS4xPtFPa5nXe8Dqyj3
         Cbo/Hq6HTevFVAcwTttJQHVsh4PZXOtv8YHxARPjvXSq1dJ7fu3uyp4lXEGoevRHT8Y0
         CijjvKg0Z/NiUS+Yh39ch9TF4UWez+NRYhH4QDEdBigaf4FDGEpLVSKJdnfWxNQWZ4PT
         1NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ugJuXIYSqVs6yIyNot5gPvrUJQmnkiieeHizPCV5toc=;
        fh=8YdDLNuzsIMzjnjgYj+MnckE1cFSh6boOSpKGXdrQHE=;
        b=s37SXdlilvhKQ8IPEq9+3gZT3QSphn17i44YTKP0YRTRDrlve5osF12A0xpQzFZsvK
         f7QdDXthG+gsqsEqCFHsHqavkKtHQEE9rS/l/9qyHdfh6clVw+4qZkYasaNiBsaSkxG5
         l4gVROCKF6LLv9UmtBgUGtkHErmS8b2DjXMfgMriVOA/JlJXOx5JpF2h/+XU92xuOSng
         x4aWNIZSU3V6FaPLHl21JqcSNqfNCvuVoU2FUqvUaD3s09bZi3l3rdCF8+gmDTxtU+Tw
         EN+EdnLXTOvil5kN8TvpAoni4A1HpPTnZKjCYHfI9KyXnQ570q0rCpxu+rN0sN1W1vN/
         zQSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587712; x=1795192512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ugJuXIYSqVs6yIyNot5gPvrUJQmnkiieeHizPCV5toc=;
        b=WBwvzn4WZRmK8ju05wCP3lrDsNkAyLTUN4COSQifIlpN/FgV/KrrZQctZeo5PJM2K2
         p/HsI1p/5Yf6e3NumkP+o7jtaJ7Amx2H25mgusCCaru4TqfJl4APRWLvg5CEadagA2da
         RspWn3bb8wwxvDl0rr497S1Kk4NxA96ADP7asqKwYE2xUSvdWXZyO+eNhbugYfM3UI0K
         O3bKfbn62InDgBkHcCC+kUnl7QF11b7Caj1OSCiHf6DNxKwcAyszTNSofUyrH/KyiBWc
         1i/z6p5LZRabT6aNIXMclXPM+WEFY8p0beSrb9ez/vY6O8AwQTF2WFE3xuXQ1k+p+zZ1
         D3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587712; x=1795192512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugJuXIYSqVs6yIyNot5gPvrUJQmnkiieeHizPCV5toc=;
        b=nc4OPHcZbb6B9yYpuCeqpcrLeWIPSSVrNrcAwIMHIqaELhaHFHNbhjIcDeoLYn6Qix
         AV8Om5F+/i2Wx4DKSN6sFP400agrr4tk7YfxXLYK9cPyM/m0AetCzaE+0Qo4rseSOjij
         GXoO2JdH8Znzacbp9DXmvY7Cbv4ZSElI6/8AtHb2Uf2Ni+9pAuE89CbiUCy8TFhDhew+
         hTooYFWw8JGDEumLrZrOn70j9/JZAn7wjTqsvwX+X+w4TWDqy7nA3t+UrFBfxQrOweV3
         XgXjvz16BTT6YcYFEls27cz6LQklvsHRULD+qAEI25UXDolVYgTzZYPBjTtVuxHwawsQ
         mfjA==
X-Gm-Message-State: APuU4Z/HmlMFHeXCTpIhYZAtDCqL8YvtIUmQM5AWM/0voZc19KIMq71B
	fH17KNxnsrA0xVdHmzfIpsbHZyBl8Ud6j1NoF3xqGiv7zMXM+QA/XUufxT8MmCxnpKND8mTcITu
	hAICNUaTkBEFIWR87k5h7BBCW28zAonB0XEoj5oYBkw==
X-Gm-Gg: AYBFou0VNjrrcwGg38l3Egcoomvgc9laxaKv3FMXno80GwWsvbpTNzkZhbzwMad6YvN
	o+jIH6tNNIcx8+LfG2DCrFKu+YtsyloHrbnJ0msEl6UtGCZc/lx9MatNzfTtaMMNul077Hbzq6+
	1RbMC5cCzNoruz/2QWs7MEq5PbWyHVsfH0bFnKoN+ZyEP9nChazzkVaq6aQp/dndYgTDruxq0/M
	pfYE3QmBcmIlQXORk2AetllL3vJnQokzfiitIvGhEVcSJTZiOidSLTRTihsHdnixafAgVUsw+kn
	huX84CcS58Qvz0FB1C+ix/1m4C3GaTlM6SMTH9U/JcMLwbnqKY16+YbvQcBap4EQ2GZWplUkkrB
	fyq9HKvaJnUzgN8gR6wVdoxkdTPh3vy3BfJFuFVgakYeP7cMHVRaq4jgo4Ff3DzjyVl/HARTMgA
	KqhJ9N2SKAo7jrkUDOtykrGBo5z1JLSnSD1DvArQ+b3wlSpYlq/3DB7/jiAzc=
X-Received: by 2002:a05:6808:244c:b0:556:82f5:5aaf with SMTP id
 5614622812f47-56e645df451mr2936471b6e.49.1794587712125; Fri, 13 Nov 2026
 08:35:12 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113093428.2971436-1-bernie@codewiz.org> <20261113093428.2971436-2-bernie@codewiz.org>
In-Reply-To: <20261113093428.2971436-2-bernie@codewiz.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2026 11:35:00 -0500
X-Gm-Features: AclHuK9qR1MDCW1ifdWD21YnJoU4DAN6z3wvegvtu93zMVhng3D27YFGO1NBAjU
Message-ID: <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] cups: Read the IEEE 1284 device ID over SDP
To: Bernie Innocenti <bernie@codewiz.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernie,

On Fri, Nov 13, 2026 at 10:25=E2=80=AFAM Bernie Innocenti <bernie@codewiz.o=
rg> wrote:
>
> Device1 has no DiscoverServices method, so the device ID was never
> found. Read the 1284ID attribute of the HCRP record directly, as the
> print path already does for the channel and PSMs.
>
> Assisted-by: Claude:claude-fable-5
> ---
>  profiles/cups/cups.h |   1 +
>  profiles/cups/main.c | 217 ++++---------------------------------------
>  profiles/cups/sdp.c  |  48 ++++++++++
>  3 files changed, 65 insertions(+), 201 deletions(-)
>
> diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
> index bdaa89498..f2ec8aec7 100644
> --- a/profiles/cups/cups.h
> +++ b/profiles/cups/cups.h
> @@ -20,6 +20,7 @@ enum {                                        /**** Bac=
kend exit codes ****/
>
>  int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
>  int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsign=
ed short *data_psm);
> +char *sdp_search_ieee1284_id(sdp_session_t *sdp);
>
>  int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int=
 copies, const char *cups_class);
>  int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, un=
signed short data_psm, int fd, int copies, const char *cups_class);
> diff --git a/profiles/cups/main.c b/profiles/cups/main.c
> index d56c942b9..bcd6d2f9f 100644
> --- a/profiles/cups/main.c
> +++ b/profiles/cups/main.c
> @@ -44,136 +44,21 @@ static GMainLoop *loop =3D NULL;
>  static DBusConnection *conn =3D NULL;
>  static gboolean doing_disco =3D FALSE;
>
> -#define ATTRID_1284ID 0x0300
> -
> -struct context_data {
> -       gboolean found;
> -       char *id;
> -};
> -
> -static void element_start(GMarkupParseContext *context,
> -                               const char *element_name,
> -                               const char **attribute_names,
> -                               const char **attribute_values,
> -                               gpointer user_data, GError **err)
> +static char *device_get_ieee1284_id(const char *address)
>  {
> -       struct context_data *ctx_data =3D user_data;
> -
> -       if (!strcmp(element_name, "record"))
> -               return;
> -
> -       if (!strcmp(element_name, "attribute")) {
> -               int i;
> -               for (i =3D 0; attribute_names[i]; i++) {
> -                       if (strcmp(attribute_names[i], "id") !=3D 0)
> -                               continue;
> -                       if (strtol(attribute_values[i], 0, 0) =3D=3D ATTR=
ID_1284ID)
> -                               ctx_data->found =3D TRUE;
> -                       break;
> -               }
> -               return;
> -       }
> -
> -       if (ctx_data->found  && !strcmp(element_name, "text")) {
> -               int i;
> -               for (i =3D 0; attribute_names[i]; i++) {
> -                       if (!strcmp(attribute_names[i], "value")) {
> -                               ctx_data->id =3D g_strdup(attribute_value=
s[i] + 2);
> -                               ctx_data->found =3D FALSE;
> -                       }
> -               }
> -       }
> -}
> -
> -static GMarkupParser parser =3D {
> -       element_start, NULL, NULL, NULL, NULL
> -};
> -
> -static char *sdp_xml_parse_record(const char *data)
> -{
> -       GMarkupParseContext *ctx;
> -       struct context_data ctx_data;
> -       int size;
> -
> -       size =3D strlen(data);
> -       ctx_data.found =3D FALSE;
> -       ctx_data.id =3D NULL;
> -       ctx =3D g_markup_parse_context_new(&parser, 0, &ctx_data, NULL);
> -
> -       if (g_markup_parse_context_parse(ctx, data, size, NULL) =3D=3D FA=
LSE) {
> -               g_markup_parse_context_free(ctx);
> -               g_free(ctx_data.id);
> -               return NULL;
> -       }
> -
> -       g_markup_parse_context_free(ctx);
> -
> -       return ctx_data.id;
> -}
> -
> -static char *device_get_ieee1284_id(const char *adapter, const char *dev=
ice)
> -{
> -       DBusMessage *message, *reply;
> -       DBusMessageIter iter, reply_iter;
> -       DBusMessageIter reply_iter_entry;
> -       const char *hcr_print =3D "00001126-0000-1000-8000-00805f9b34fb";
> -       const char *xml;
> -       char *id =3D NULL;
> -
> -       /* Look for the service handle of the HCRP service */
> -       message =3D dbus_message_new_method_call("org.bluez", device,
> -                                               "org.bluez.Device1",
> -                                               "DiscoverServices");
> -       dbus_message_iter_init_append(message, &iter);
> -       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_prin=
t);
> -
> -       reply =3D dbus_connection_send_with_reply_and_block(conn,
> -                                                       message, -1, NULL=
);
> +       sdp_session_t *sdp;
> +       bdaddr_t bdaddr;
> +       char *id;
>
> -       dbus_message_unref(message);
> +       str2ba(address, &bdaddr);
>
> -       if (!reply)
> +       sdp =3D sdp_connect(BDADDR_ANY, &bdaddr, SDP_RETRY_IF_BUSY);
> +       if (!sdp)
>                 return NULL;
>
> -       dbus_message_iter_init(reply, &reply_iter);
> -
> -       if (dbus_message_iter_get_arg_type(&reply_iter) !=3D DBUS_TYPE_AR=
RAY) {
> -               dbus_message_unref(reply);
> -               return NULL;
> -       }
> +       id =3D sdp_search_ieee1284_id(sdp);
>
> -       dbus_message_iter_recurse(&reply_iter, &reply_iter_entry);
> -
> -       /* Hopefully we only get one handle, or take a punt */
> -       while (dbus_message_iter_get_arg_type(&reply_iter_entry) =3D=3D
> -                                                       DBUS_TYPE_DICT_EN=
TRY) {
> -               guint32 key;
> -               DBusMessageIter dict_entry;
> -
> -               dbus_message_iter_recurse(&reply_iter_entry, &dict_entry)=
;
> -
> -               /* Key ? */
> -               dbus_message_iter_get_basic(&dict_entry, &key);
> -               if (!key) {
> -                       dbus_message_iter_next(&reply_iter_entry);
> -                       continue;
> -               }
> -
> -               /* Try to get the value */
> -               if (!dbus_message_iter_next(&dict_entry)) {
> -                       dbus_message_iter_next(&reply_iter_entry);
> -                       continue;
> -               }
> -
> -               dbus_message_iter_get_basic(&dict_entry, &xml);
> -
> -               id =3D sdp_xml_parse_record(xml);
> -               if (id !=3D NULL)
> -                       break;
> -               dbus_message_iter_next(&reply_iter_entry);
> -       }
> -
> -       dbus_message_unref(reply);
> +       sdp_close(sdp);
>
>         return id;
>  }
> @@ -362,9 +247,9 @@ static void remote_device_found(const char *adapter, =
const char *bdaddr,
>                 return;
>         }
>
> -       id =3D device_get_ieee1284_id(adapter, object_path);
> +       id =3D device_get_ieee1284_id(bdaddr);
>         add_device_to_list(name, bdaddr, id);
> -       g_free(id);
> +       free(id);
>
>         dbus_message_unref(reply);
>  }
> @@ -434,9 +319,9 @@ static gboolean list_known_printers(const char *adapt=
er)
>                 if (device_is_printer(adapter, object_path, &name, &bdadd=
r)) {
>                         char *id;
>
> -                       id =3D device_get_ieee1284_id(adapter, object_pat=
h);
> +                       id =3D device_get_ieee1284_id(bdaddr);
>                         add_device_to_list(name, bdaddr, id);
> -                       g_free(id);
> +                       free(id);
>                 }
>                 g_free(name);
>                 g_free(bdaddr);
> @@ -601,84 +486,14 @@ static gboolean list_printers(void)
>
>  static gboolean print_ieee1284(const char *bdaddr)
>  {
> -       DBusMessage *message, *reply, *adapter_reply;
> -       DBusMessageIter iter;
> -       char *object_path =3D NULL;
> -       char *adapter;
>         char *id;
>
> -       adapter_reply =3D NULL;
> -
> -       conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
> -       if (conn =3D=3D NULL)
> +       id =3D device_get_ieee1284_id(bdaddr);
> +       if (id =3D=3D NULL)
>                 return FALSE;
>
> -       message =3D dbus_message_new_method_call("org.bluez", "/",
> -                       "org.bluez.Manager",
> -                       "DefaultAdapter");
> -
> -       adapter_reply =3D dbus_connection_send_with_reply_and_block(conn,
> -                       message, -1, NULL);
> -
> -       dbus_message_unref(message);
> -
> -       if (!adapter_reply)
> -               return FALSE;
> -
> -       if (dbus_message_get_args(adapter_reply, NULL,
> -                       DBUS_TYPE_OBJECT_PATH, &adapter,
> -                       DBUS_TYPE_INVALID) =3D=3D FALSE) {
> -               dbus_message_unref(adapter_reply);
> -               return FALSE;
> -       }
> -
> -       message =3D dbus_message_new_method_call("org.bluez", adapter,
> -                       "org.bluez.Adapter1",
> -                       "FindDevice");
> -       dbus_message_iter_init_append(message, &iter);
> -       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
> -
> -       if (adapter_reply !=3D NULL)
> -               dbus_message_unref(adapter_reply);
> -
> -       reply =3D dbus_connection_send_with_reply_and_block(conn,
> -                       message, -1, NULL);
> -
> -       dbus_message_unref(message);
> -
> -       if (!reply) {
> -               message =3D dbus_message_new_method_call("org.bluez", ada=
pter,
> -                               "org.bluez.Adapter1",
> -                               "CreateDevice");
> -               dbus_message_iter_init_append(message, &iter);
> -               dbus_message_iter_append_basic(&iter,
> -                               DBUS_TYPE_STRING, &bdaddr);
> -
> -               reply =3D dbus_connection_send_with_reply_and_block(conn,
> -                               message, -1, NULL);
> -
> -               dbus_message_unref(message);
> -
> -               if (!reply)
> -                       return FALSE;
> -       }
> -
> -       if (dbus_message_get_args(reply, NULL,
> -                                       DBUS_TYPE_OBJECT_PATH, &object_pa=
th,
> -                                       DBUS_TYPE_INVALID) =3D=3D FALSE) =
{
> -               dbus_message_unref(reply);
> -               return FALSE;
> -       }
> -
> -       id =3D device_get_ieee1284_id(adapter, object_path);
> -       if (id =3D=3D NULL) {
> -               dbus_message_unref(reply);
> -               return FALSE;
> -       }
>         printf("%s", id);
> -       g_free(id);
> -
> -       dbus_message_unref(reply);
> +       free(id);
>
>         return TRUE;
>  }
> diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
> index 5d83b8ea9..d34d732c1 100644
> --- a/profiles/cups/sdp.c
> +++ b/profiles/cups/sdp.c
> @@ -15,6 +15,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <string.h>
>  #include <signal.h>
>  #include <sys/socket.h>
>
> @@ -24,6 +25,8 @@
>
>  #include "cups.h"
>
> +#define ATTRID_1284ID 0x0300
> +
>  int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsign=
ed short *data_psm)
>  {
>         sdp_list_t *srch, *attrs, *rsp;
> @@ -104,3 +107,48 @@ int sdp_search_spp(sdp_session_t *sdp, uint8_t *chan=
nel)
>
>         return -1;
>  }
> +
> +char *sdp_search_ieee1284_id(sdp_session_t *sdp)
> +{
> +       sdp_list_t *srch, *attrs, *rsp, *l;
> +       uuid_t svclass;
> +       uint16_t attr;
> +       char *id =3D NULL;
> +       int err;
> +
> +       if (!sdp)
> +               return NULL;
> +
> +       sdp_uuid16_create(&svclass, HCR_PRINT_SVCLASS_ID);
> +       srch =3D sdp_list_append(NULL, &svclass);
> +
> +       attr =3D ATTRID_1284ID;
> +       attrs =3D sdp_list_append(NULL, &attr);
> +
> +       err =3D sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIV=
IDUAL,
> +                                                               attrs, &r=
sp);
> +       sdp_list_free(srch, NULL);
> +       sdp_list_free(attrs, NULL);
> +       if (err)
> +               return NULL;
> +
> +       for (l =3D rsp; l; l =3D l->next) {
> +               sdp_record_t *rec =3D l->data;
> +               sdp_data_t *data =3D sdp_data_get(rec, ATTRID_1284ID);
> +               int len;
> +
> +               /* The device ID is preceded by its two length bytes */
> +               if (!id && data && SDP_IS_TEXT_STR(data->dtd)) {
> +                       len =3D data->unitSize - sizeof(uint8_t);
> +
> +                       if (len > 2)
> +                               id =3D strndup(data->val.str + 2, len - 2=
);
> +               }
> +
> +               sdp_record_free(rec);
> +       }
> +
> +       sdp_list_free(rsp, NULL);
> +
> +       return id;
> +}
> --
> 2.56.1
>

Copilot found a problem:

https://github.com/bluez/bluez/pull/2822#pullrequestreview-5894605131


--=20
Luiz Augusto von Dentz
