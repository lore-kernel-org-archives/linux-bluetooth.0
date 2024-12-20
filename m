Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BD208AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706051; cv=none; b=sLRXpKVurkORHQjAKyWd/cjG/pr7KatwwnCd3jjk2LEXivTO7M2d6SAWWVu1xQS4YjisFjDs97l39InHFAdVhK6KQ11L9MS9eT3E79lkp0ywbOVdor2kZV8YeOiCwj/aNHnJJCZqRi8K+AjhCcjG2MFeE7oJMlDxvDiH3sq3e+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706051; c=relaxed/simple;
	bh=9rjVwphuilDHneJFj/NWowBXkGTC/qz1C5cY3ZPK9vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHPTxFyhGbiA86Q+Gds45WHJsxV+/gI8GtBcU5CTR/J9fXkn0cf9IgPjSUjBrDi9PkKrGffphNGPVtNIQ0kNCCDIe581STSBVrPVagEWZApDbgUVEMNCy1XX1c1RLslkE4IcKo+ChN4cUk6T2pgmHATZSBKUnZy+jUsyCqVXLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQiBLfXv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQiBLfXv"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-300479ca5c6so21479751fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734706045; x=1735310845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9/P4NEVoHrkMb2hdxovclx4YWrVjeDVVCJSTlc3cac=;
        b=SQiBLfXvDrkHTVpcvfwwyHRF1m9M40mGePGJ5UzIU4euHxCTh5z+VflGWcQPJjd4U2
         AoWPm9GT4SBItd5c6bx0YbXjq8Z93oabA2+e2Tsb5vbNmH46apGZo51dOd9u2owZpopL
         GvIJ9J7/wJkvhDeweAeUd2VDfO9fepGVyJjL/2Bg2uZPDB1Aa9q1+lp98wjkW/O590XH
         JbdD/ejn2cVx9CAH003cjLqRZ7hfMMOol3X4cI+wIdM28oMpROYdoyuN19gXK0sPyM7z
         vmlUC8XLug0w46bV/qR8QGH2cnCY37Yph893ML4atXB4USPjsEC9itJR/Vx68htAD5+S
         1plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734706045; x=1735310845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9/P4NEVoHrkMb2hdxovclx4YWrVjeDVVCJSTlc3cac=;
        b=FDNjZii3/dLZTRb8dsMXM410P7StcEiBgmsfb58EmTUgck8r64T4c4qgKXt+ki+bJQ
         fmAKTJg8V+7aALsvwRXMEPbV0HPZXjJ3W4ZonQWcsVg7X6ZX0PXbjMLbBIoFodhkpATa
         SxfAAy9PypOmnZUMc+w9auh40g7jnkWbAlL+5O8FMAmhRT1c4JVqtJI7IqLhit0x5he+
         m7Ltst6ETte/LraqcZhg5QIV3z6t0KyuwbxCjBOrzTaz7WaaVCEoyAAf69MF30pMdHk3
         ZXrX+3YtIg+Ij8yA+9keOqqvJtMaw0hMDZ2PuGpOh3Qx+piYOB2ourn4iaGBMq0Jv9z4
         gWMw==
X-Gm-Message-State: AOJu0YxC4pl7bpbtiatgwsa2wUn9AhGmTr345YvCPFab1Q2YjDYUutC9
	7QD9yu8ysUqigWUjZ7mnoP/fNzptgwbTO5HZKIskGfcwmkZxOBjCkERTkKxSPYMNGDBRGsRxXTh
	nv6yHTWE3WVTL0C6RNZzr/DIU3PSMhQ==
X-Gm-Gg: ASbGnctabYRmInRlMCkdoC0n3NBdSdvf73HpuL8Rd4+4hUO4dq1CDL9fg7AUnwrsbml
	yVl2FOBBbyyC8vjBL05PPK6OIrJZMl/8EB7m6QpY=
X-Google-Smtp-Source: AGHT+IEql8TYj6OheiGZgJLO6zZg7QtV8+q8ceuhRIQy1Rc4H4UHsZ+mshCgEv0OnOzdmsLyH8nFbZ7zQZoxmjoRlgw=
X-Received: by 2002:a2e:a70e:0:b0:302:16da:a03e with SMTP id
 38308e7fff4ca-304686299b5mr8006481fa.38.1734706044880; Fri, 20 Dec 2024
 06:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220125812.84592-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241220125812.84592-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Dec 2024 09:47:12 -0500
Message-ID: <CABBYNZJKyPJu965k6yco17f-J6sqxEQ7kc49mJcVpBL8N1d7Kw@mail.gmail.com>
Subject: Re: [PATCH v1] obex: Implement support for message listing format
 version 1.1 for MCE
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Fri, Dec 20, 2024 at 7:58=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> As per spec, Messages-Listing Format Version 1.1 is being marked
> mandatory feature to be supported in MAP 1.3 & above versions.
> This change is added for MAP client role.
>
> This change is required for passing below testcases-
> 1) MAP/MCE/MFB/BV-01-C
> Verify that the MCE correctly advertises the correct feature bits
> in the MNS SDP record.
> 2) MAP/MCE/MFB/BV-03-C
> Verify that the MCE correctly advertises the correct MapSupportedFeatures
> bits in the MNS SDP record during MAS connection.
>
> Also add the Messages-Listing Format Version 1.1 as supported
> in mns sdp record.
>
> ---
>  obexd/client/map.c | 169 +++++++++++++++++++++++++++++++++++++++++++++
>  src/profile.c      |   2 +-
>  2 files changed, 170 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 29b0ed96e..c6f3dd342 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -123,6 +123,11 @@ struct map_msg {
>         uint64_t attachment_size;
>         uint8_t flags;
>         char *folder;
> +       char *delivery_status;
> +       uint64_t conversation_id;
> +       char *conversation_name;
> +       char *direction;
> +       char *attachment_mime_types;
>         GDBusPendingPropertySet pending;
>  };
>
> @@ -418,6 +423,10 @@ static void map_msg_free(void *data)
>         g_free(msg->recipient_address);
>         g_free(msg->type);
>         g_free(msg->status);
> +       g_free(msg->delivery_status);
> +       g_free(msg->conversation_name);
> +       g_free(msg->direction);
> +       g_free(msg->attachment_mime_types);
>         g_free(msg);
>  }
>
> @@ -778,6 +787,93 @@ static void set_deleted(const GDBusPropertyTable *pr=
operty,
>         set_status(property, iter, id, STATUS_DELETE, data);
>  }
>
> +static gboolean delivery_status_exists(const GDBusPropertyTable *propert=
y,
> +                                                               void *dat=
a)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       return msg->delivery_status !=3D NULL;
> +}
> +
> +static gboolean get_delivery_status(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +                                               &msg->delivery_status);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_conversation_id(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64,
> +                                               &msg->conversation_id);
> +
> +       return TRUE;
> +}
> +
> +static gboolean conversation_name_exists(const GDBusPropertyTable *prope=
rty,
> +                                                               void *dat=
a)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       return msg->conversation_name !=3D NULL;
> +}
> +
> +static gboolean get_conversation_name(const GDBusPropertyTable *property=
,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +                                               &msg->conversation_name);
> +
> +       return TRUE;
> +}
> +
> +static gboolean direction_exists(const GDBusPropertyTable *property,
> +                                                               void *dat=
a)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       return msg->direction !=3D NULL;
> +}
> +
> +static gboolean get_direction(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +                                                       &msg->direction);
> +
> +       return TRUE;
> +}
> +
> +static gboolean attachment_mime_exists(const GDBusPropertyTable *propert=
y,
> +                                                               void *dat=
a)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       return msg->attachment_mime_types !=3D NULL;
> +}
> +
> +static gboolean get_attachment_mime_types(const GDBusPropertyTable *prop=
erty,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct map_msg *msg =3D data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +                                               &msg->attachment_mime_typ=
es);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusMethodTable map_msg_methods[] =3D {
>         { GDBUS_METHOD("Get",
>                         GDBUS_ARGS({ "targetfile", "s" },
> @@ -809,6 +905,13 @@ static const GDBusPropertyTable map_msg_properties[]=
 =3D {
>         { "Sent", "b", get_sent },
>         { "Protected", "b", get_protected },
>         { "Deleted", "b", NULL, set_deleted },
> +       { "DeliveryStatus", "s", get_delivery_status, NULL, delivery_stat=
us_exists },
> +       { "ConversationId", "t", get_conversation_id },
> +       { "ConversationName", "s", get_conversation_name, NULL,
> +                                               conversation_name_exists =
},
> +       { "Direction", "s", get_direction, NULL, direction_exists },
> +       { "AttachmentMimeTypes", "s", get_attachment_mime_types, NULL,
> +                                                       attachment_mime_e=
xists },

Before you go ahead adding new properties you need to update
org.bluez.obex.Message interface explaining what each new property
represents, if they are optional, etc.

>         { }
>  };
>
> @@ -1061,6 +1164,67 @@ static void parse_protected(struct map_msg *msg, c=
onst char *value)
>                                                 MAP_MSG_INTERFACE, "Prote=
cted");
>  }
>
> +static void parse_delivery_status(struct map_msg *msg, const char *value=
)
> +{
> +       if (g_strcmp0(msg->delivery_status, value) =3D=3D 0)
> +               return;
> +
> +       g_free(msg->delivery_status);
> +       msg->delivery_status =3D g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                       MAP_MSG_INTERFACE, "DeliveryStatu=
s");
> +}
> +
> +static void parse_conversation_id(struct map_msg *msg, const char *value=
)
> +{
> +       uint64_t conversation_id =3D strtoull(value, NULL, 16);
> +
> +       if (msg->conversation_id =3D=3D conversation_id)
> +               return;
> +
> +       msg->conversation_id =3D conversation_id;
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                       MAP_MSG_INTERFACE, "ConversationI=
d");
> +}
> +
> +static void parse_conversation_name(struct map_msg *msg, const char *val=
ue)
> +{
> +       if (g_strcmp0(msg->conversation_name, value) =3D=3D 0)
> +               return;
> +
> +       g_free(msg->conversation_name);
> +       msg->conversation_name =3D g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Conve=
rsationName");
> +}
> +
> +static void parse_direction(struct map_msg *msg, const char *value)
> +{
> +       if (g_strcmp0(msg->direction, value) =3D=3D 0)
> +               return;
> +
> +       g_free(msg->direction);
> +       msg->direction =3D g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Direc=
tion");
> +}
> +
> +static void parse_mime_types(struct map_msg *msg, const char *value)
> +{
> +       if (g_strcmp0(msg->attachment_mime_types, value) =3D=3D 0)
> +               return;
> +
> +       g_free(msg->attachment_mime_types);
> +       msg->attachment_mime_types =3D g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Attac=
hmentMimeTypes");
> +}
> +
>  static const struct map_msg_parser {
>         const char *name;
>         void (*func) (struct map_msg *msg, const char *value);
> @@ -1081,6 +1245,11 @@ static const struct map_msg_parser {
>                 { "read", parse_read },
>                 { "sent", parse_sent },
>                 { "protected", parse_protected },
> +               { "delivery_status", parse_delivery_status},
> +               { "conversation_id", parse_conversation_id},
> +               { "conversation_name", parse_conversation_name},
> +               { "direction", parse_direction},
> +               { "attachment_mime_types", parse_mime_types},
>                 { }
>  };
>
> diff --git a/src/profile.c b/src/profile.c
> index 6bc6778de..70ac058f4 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -563,7 +563,7 @@
>                         <text value=3D\"%s\"/>                           =
 \
>                 </attribute>                                            \
>                 <attribute id=3D\"0x0317\">                              =
 \
> -                       <uint32 value=3D\"0x0000007f\"/>                 =
 \
> +                       <uint32 value=3D\"0x0000027f\"/>                 =
 \
>                 </attribute>                                            \
>                 <attribute id=3D\"0x0200\">                              =
 \
>                         <uint16 value=3D\"%u\" name=3D\"psm\"/>          =
   \

Are you bumping the version here? I guess we want to update the
documentation about the profiles versions as well.

> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
