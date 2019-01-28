Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041CC282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B65C20881
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8xjsoWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1MtG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:49:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55971 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1MtG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 07:49:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so13742328wmc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=QzZaC5NWfUMSVx39QXtELDS6f22R5xtgsQCnSKIqHUw=;
        b=k8xjsoWV5l9Z5scOAQrAGteCMi2woXYveFGbstOxXkApIkw5O5XOwPjTtORoL+ptCZ
         v4loAv+7GaHu4sXJcMukqt+cz59wMK+8j89FYs3YVIA3InA7tQ4CmYhKl/FqKkDYhqww
         4fIRvpB6gHydVOIXMKGiZAsb26MDOupqL+IfFfQfryoVZFYpfiiz0ny5D7cwmDXSYpGX
         a3OQsBscTBf5QWVXn+fKk+PcUGmrnx19HDb0xVvBMKnfbMJxYj74z/pl7yas7WpJCD3E
         SQgoo8fUHmypg5krG86S03A+OmHj1ODbpyzGOg+YHmM1oFe1YZofm6IqnsLKuR6zki7f
         Z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=QzZaC5NWfUMSVx39QXtELDS6f22R5xtgsQCnSKIqHUw=;
        b=gf+mxdt0LcVDwArxvJ6dm96+rtU3T0E/O1wI3amP0/175mTVyLkd+l5q5qkFXHtZan
         1g9WlPNldSLeiR5q6sSbPntjvy3HbPv+vNmHf6vHiKjDRGPKizjPJQRSuEhZU7T8xQai
         6z2AIrBH6Jp7ydB1CFaNdtZh0Y9AfaSeqIDl1ahV4285qI3AeX/vttPEssHcsec7Kg53
         cMRHEjs9HTUhtKbtJ7bFtBvQvARjvxsTGNrQKABwAp4BW3YNDY+0VBxOjT9C4mvljUOL
         Qk1pJu97gDdAfvz6MAjHqBLKSHC6atD+RiEwesDSJzRSbz7qP2iJ2Dk4xq7qoXMUkokn
         znXQ==
X-Gm-Message-State: AHQUAuaSDtoWzJ3m5PFCX4+7+GrnnJk9JUgtm18ovrAt0waiysFI2S0X
        LNpYGXQK7Spz1pAMcmmn7e7+5Wqx
X-Google-Smtp-Source: AHgI3IY4KSkoNnGCrTHZuq1Yu6GlCPKvHHC2nyeGIuzi1jxDWdJVeHIq4vDZfwbWIWmQXlBkWWryVg==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr17068829wmb.115.1548679742071;
        Mon, 28 Jan 2019 04:49:02 -0800 (PST)
Received: from ?IPv6:2001:a62:158e:8d01:cc30:47d5:a291:53d5? ([2001:a62:158e:8d01:cc30:47d5:a291:53d5])
        by smtp.gmail.com with ESMTPSA id k19sm193594476wre.5.2019.01.28.04.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 04:49:01 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
Message-Id: <78313A69-7D4E-4987-B03C-930D11F2B853@gmail.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_E31E779E-6A4D-43FB-912B-09A3CB5B5F80"
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ 0/2] Added config conversion tool
Date:   Mon, 28 Jan 2019 13:48:58 +0100
In-Reply-To: <D0326ED7-4865-4922-AC04-475FB0A9F213@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
To:     Marcel Holtmann <marcel@holtmann.org>
References: <20190127115646.5814-1-zimmermach@gmail.com>
 <D0326ED7-4865-4922-AC04-475FB0A9F213@holtmann.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--Apple-Mail=_E31E779E-6A4D-43FB-912B-09A3CB5B5F80
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Marcel,

i reviewed the TODO file of Bluez in Nov. 2018 in order to find an issue =
where i could support the project.
So i found the issue to remove the config conversion in adapter.c =
shortly after Bluez5 release. Therefore i made a patch to remove those =
conversions, but i got a hint of Luiz that there are still some =
platforms dealing with Bluez4 which must be considered.
As a consequence of this i first did an shell script approach for the =
config conversion, but had some issues with that, e.g. unit test for the =
script. So i started writing this config converter in order to remove =
the conversion parts in adapter.c in favour of an external conversion =
part, which could handle those conversions during install. Moreover it =
would be possible to handle other conversions due to config API changes =
with such an external application.

Best regards,
Christian

> Am 28.01.2019 um 13:22 schrieb Marcel Holtmann <marcel@holtmann.org>:
>=20
> Hi Christian,
>=20
>> Added a config conversion tool for Bluez4 config, instead of doing =
the conversion in adapter.c
>>=20
>> Christian Zimmermann (2):
>> Renamed Bluez4 config read functions
>> Added config converter for Bluez4 config conversion
>=20
> so what is the intention here. I was going to just remove any 4.x =
support and more to BlueZ 6.0 soon. Actually BlueZ 5.x has been release =
over 6 years ago. I have pretty much zero interest in carrying / =
maintaining anything for BlueZ 4.x support.
>=20
> Regards
>=20
> Marcel
>=20

--Apple-Mail=_E31E779E-6A4D-43FB-912B-09A3CB5B5F80
Content-Disposition: attachment;
	filename*0="Re: [PATCH BlueZ] src_adapter: Removed obsolete conversion funct";
	filename*1="ions for persistant settings.eml"
Content-Type: message/rfc822;
	x-mac-hide-extension=yes;
	x-unix-mode=0666;
	name="Re: [PATCH BlueZ] src_adapter: Removed obsolete conversion functions for persistant settings.eml"
Content-Transfer-Encoding: 7bit

Delivered-To: zimmermach@gmail.com
Received: by 2002:a8a:104e:0:0:0:0:0 with SMTP id y14-v6csp1830857ocs;
        Sat, 10 Nov 2018 09:58:17 -0800 (PST)
X-Received: by 2002:aca:3389:: with SMTP id z131-v6mr7892711oiz.86.1541872696994;
        Sat, 10 Nov 2018 09:58:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1541872696; cv=none;
        d=google.com; s=arc-20160816;
        b=CDGQ8TPhxwWJL99rnuPalv2La/hUMwUcgfcPlso8Yi9rg+3yABo9sxCIPUD7R52fER
         uhrCD8ACXnahBxgrbl+urtc899UtswhfJoD0Nbrj8yK7NnhbxeSfL6MuGw1iplMGTIs9
         ZJpgvR4djbxzqlNes2QklCmlMQuedbW7ivCz+WsnhYkbPQXR9JBC1YgqBTkDa1syKkKL
         114/gf80gt0SRfb9BWRuT8oNQUmOq3xXgulxzmHidWmG7JeNh8ya9IUta4xM/+TGmSjg
         5JMump4MadEJmVDJq6nZU9Jw/qHe1yhZUBV6KNu5eRh4d60wWL0MOdsf5rWTk4dF6Yxv
         sNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iORXXL/RUFw+d9U3aY+y0DrQPiQjNJ5yl9wWohBXHC8=;
        b=v/05z7mxsUKvUG9jeVZMVT4kXN5ejkW9ZVFqHezLk2+LCXodZsZGDh3i0LrFm+kn4k
         58+610ACPIZqMclwh8UEyPaDPvPhpAwQMIzezYQDSldJkBhxdi2fqH5+M+St3AgE323I
         xt18owG8DeWqq4+kAb7SWNIisUqoqgfD/p5k0iH77JMBGQL6FWHpPf2l8+57+C9drm/W
         0K4aegNyFJTCRcoXPNNPFTc6rdAe7v4i5yHR0bH88wT0EJ34GSUSd57EWpu43WMLvleN
         oa/86I36PVs9rwuYHugyDZBbXUxV5E4ikPljZ/JGCQXkfzV0HYp7J8dT573+/kzmSwC7
         3Fcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IbK5xi0b;
       spf=pass (google.com: domain of luiz.dentz@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luiz.dentz@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Return-Path: <luiz.dentz@gmail.com>
Received: from mail-sor-f65.google.com (mail-sor-f65.google.com. [209.85.220.65])
        by mx.google.com with SMTPS id q45sor5764066otb.175.2018.11.10.09.58.16
        for <zimmermach@gmail.com>
        (Google Transport Security);
        Sat, 10 Nov 2018 09:58:16 -0800 (PST)
Received-SPF: pass (google.com: domain of luiz.dentz@gmail.com designates 209.85.220.65 as permitted sender) client-ip=209.85.220.65;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IbK5xi0b;
       spf=pass (google.com: domain of luiz.dentz@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luiz.dentz@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iORXXL/RUFw+d9U3aY+y0DrQPiQjNJ5yl9wWohBXHC8=;
        b=IbK5xi0bFr8qigoFNv7gZQSPM3nkvU/ScsttBgCkOLIYntmD7yt83rm2bMupA/2cTK
         lsy8LsOS2ZGNHfZ8YeiM+xXplOAdRQ3krd2w4duHXo8g1zfdRgQZUrY8312brUHR6kQi
         gG6b5FgbhR0utTSnEz8lJDE0umaDTtS2kzcjrm0SM1OZ2lF9IA7UbUYpKgHkN5XPQWBV
         g8Hou1Svtjlfvr2dzTOc3022NvVA5A8/jbT2sPd13TDZMK9bx90e2Fh2rfKvIEP1URbV
         L+UqLJY8os8H7ymMagaDeAJMahfaG/HNaKwewuNY4GkihXSbUKoOOBZb/uj9MGILqPon
         BRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iORXXL/RUFw+d9U3aY+y0DrQPiQjNJ5yl9wWohBXHC8=;
        b=P5AODvnyggETdkS8LHdZHY0t7j6WzpBuqBuceDbKOUY1qE99q9uo4h9BP/NqkvSG10
         OpVJnTBb7ROTpfE6uotdOfmavG+cAdSiw3bm2KGe4yEXK2WmGQcojgx5UtFoyhfsfJWt
         n8UpN8mDP12HUO6SnWddE8YN8Yxi5ut5G11+J7Y8betXbBFfK99TL3uZpnEEFU8a9owP
         D4S+eqFXj/Ws/pYDO18hlNql4JWWA2QJG9KKjPvnSroIb7cuLOJxidDwPlBs4JPCRC+j
         oF+NEdwfidSlTqLYSRVg6+vu/zGoMCNiXNdoxAXig8MtuClaprLX1/qtmHCfaNcgTB5q
         IIBA==
X-Gm-Message-State: AGRZ1gIZsKNP9JN+j6m0yHOmIsFyc/hk22RzpWfKdMdPxA1ra5VfK+TC
	iZunNE3KCwBe16UArL6kpPHEt8ZIEvFIYb1LLKn3QQ==
X-Google-Smtp-Source: AJdET5cBW0SG7qAjhD4uS+1NJBRNnMTLYPVVFePPSKu1CKOXuGmSWKl0TIykUufd6A+6LEXKqQ594ghLcfv5BPr8aII=
X-Received: by 2002:a9d:2831:: with SMTP id m46mr7717600otb.291.1541872695949;
 Sat, 10 Nov 2018 09:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20181105160342.29434-1-zimmermach@gmail.com> <CABBYNZ+A+iU4wAw6LVy6toi+Qb7=2trkbx+HJmQYtdYyTHwSEA@mail.gmail.com>
 <447CAA92-87E8-4E79-B850-EA22A682E5C5@gmail.com>
In-Reply-To: <447CAA92-87E8-4E79-B850-EA22A682E5C5@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 10 Nov 2018 19:58:03 +0200
Message-ID: <CABBYNZLs5Aw=+dkBuid_YbQvkyiHLiAvHG9muQJRnXXwve7qtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/adapter: Removed obsolete conversion functions
 for persistant settings
To: zimmermach@gmail.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,
On Sat, Nov 10, 2018 at 4:34 PM Christian Zimmermann
<zimmermach@gmail.com> wrote:
>
> Hi Luiz,
>
> thank you for your response.
> How about having a shell or python script which does the necessary conversion during bluez install? Would this be sufficient?

Yep, that way the distro can actually run those in case of updating an
old installation.

> Regards,
> Christian
>
> > Am 07.11.2018 um 12:37 schrieb Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> >
> > Hi Christian,
> >
> > On Mon, Nov 5, 2018 at 6:10 PM Christian Zimmermann
> > <zimmermach@gmail.com> wrote:
> >>
> >> According to TODO file:
> >> Removal of conversion functions for persistant settings
> >> since they're obsolete with Bluez5 after certain time of it's first release
> >
> > We probably need to consider if there are still platforms using BlueZ
> > 4 then removing this code would make the transition, perhaps we could
> > have a tool to do that so we can remove this from the daemon.
> >
> >> ---
> >> TODO          |   6 -
> >> src/adapter.c | 832 ----------------------------------------------------------
> >> 2 files changed, 838 deletions(-)
> >>
> >> diff --git a/TODO b/TODO
> >> index d88349e06..ae2d69dfa 100644
> >> --- a/TODO
> >> +++ b/TODO
> >> @@ -37,12 +37,6 @@ General
> >>   Priority: Medium
> >>   Complexity: C2
> >>
> >> -- Function in src/adapter.c to convert old storage files to new ini-file format
> >> -  should be removed 6-8 months after first BlueZ 5 release.
> >> -
> >> -  Priority: Low
> >> -  Complexity: C1
> >> -
> >> - Remove usage of symlinks for drivers, such as profiles/input/suspend.c and
> >>   profiles/sap/sap.c. Instead, select drivers at runtime by using config
> >>   options or probing for running D-Bus services (using e.g.
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index c24432125..5709ee956 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -423,18 +423,6 @@ void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
> >>        set_dev_class(adapter);
> >> }
> >>
> >> -static uint8_t get_mode(const char *mode)
> >> -{
> >> -       if (strcasecmp("off", mode) == 0)
> >> -               return MODE_OFF;
> >> -       else if (strcasecmp("connectable", mode) == 0)
> >> -               return MODE_CONNECTABLE;
> >> -       else if (strcasecmp("discoverable", mode) == 0)
> >> -               return MODE_DISCOVERABLE;
> >> -       else
> >> -               return MODE_UNKNOWN;
> >> -}
> >> -
> >> const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter)
> >> {
> >>        static char dir[25];
> >> @@ -4927,824 +4915,10 @@ void btd_adapter_unref(struct btd_adapter *adapter)
> >>                                                ADAPTER_INTERFACE);
> >> }
> >>
> >> -static void convert_names_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *address = user_data;
> >> -       char *str = key;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       if (strchr(key, '#'))
> >> -               str[17] = '\0';
> >> -
> >> -       if (bachk(str) != 0)
> >> -               return;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
> >> -       create_file(filename, S_IRUSR | S_IWUSR);
> >> -
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -       g_key_file_set_string(key_file, "General", "Name", value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       g_file_set_contents(filename, data, length, NULL);
> >> -       g_free(data);
> >> -
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -struct device_converter {
> >> -       char *address;
> >> -       void (*cb)(GKeyFile *key_file, void *value);
> >> -       gboolean force;
> >> -};
> >> -
> >> -static void set_device_type(GKeyFile *key_file, char type)
> >> -{
> >> -       char *techno;
> >> -       char *addr_type = NULL;
> >> -       char *str;
> >> -
> >> -       switch (type) {
> >> -       case BDADDR_BREDR:
> >> -               techno = "BR/EDR";
> >> -               break;
> >> -       case BDADDR_LE_PUBLIC:
> >> -               techno = "LE";
> >> -               addr_type = "public";
> >> -               break;
> >> -       case BDADDR_LE_RANDOM:
> >> -               techno = "LE";
> >> -               addr_type = "static";
> >> -               break;
> >> -       default:
> >> -               return;
> >> -       }
> >> -
> >> -       str = g_key_file_get_string(key_file, "General",
> >> -                                       "SupportedTechnologies", NULL);
> >> -       if (!str)
> >> -               g_key_file_set_string(key_file, "General",
> >> -                                       "SupportedTechnologies", techno);
> >> -       else if (!strstr(str, techno))
> >> -               g_key_file_set_string(key_file, "General",
> >> -                                       "SupportedTechnologies", "BR/EDR;LE");
> >> -
> >> -       g_free(str);
> >> -
> >> -       if (addr_type)
> >> -               g_key_file_set_string(key_file, "General", "AddressType",
> >> -                                       addr_type);
> >> -}
> >> -
> >> -static void convert_aliases_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_key_file_set_string(key_file, "General", "Alias", value);
> >> -}
> >> -
> >> -static void convert_trusts_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
> >> -}
> >> -
> >> -static void convert_classes_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_key_file_set_string(key_file, "General", "Class", value);
> >> -}
> >> -
> >> -static void convert_blocked_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_key_file_set_boolean(key_file, "General", "Blocked", TRUE);
> >> -}
> >> -
> >> -static void convert_did_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       char *vendor_str, *product_str, *version_str;
> >> -       uint16_t val;
> >> -
> >> -       vendor_str = strchr(value, ' ');
> >> -       if (!vendor_str)
> >> -               return;
> >> -
> >> -       *(vendor_str++) = 0;
> >> -
> >> -       if (g_str_equal(value, "FFFF"))
> >> -               return;
> >> -
> >> -       product_str = strchr(vendor_str, ' ');
> >> -       if (!product_str)
> >> -               return;
> >> -
> >> -       *(product_str++) = 0;
> >> -
> >> -       version_str = strchr(product_str, ' ');
> >> -       if (!version_str)
> >> -               return;
> >> -
> >> -       *(version_str++) = 0;
> >> -
> >> -       val = (uint16_t) strtol(value, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "DeviceID", "Source", val);
> >> -
> >> -       val = (uint16_t) strtol(vendor_str, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "DeviceID", "Vendor", val);
> >> -
> >> -       val = (uint16_t) strtol(product_str, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "DeviceID", "Product", val);
> >> -
> >> -       val = (uint16_t) strtol(version_str, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "DeviceID", "Version", val);
> >> -}
> >> -
> >> -static void convert_linkkey_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       char *type_str, *length_str, *str;
> >> -       int val;
> >> -
> >> -       type_str = strchr(value, ' ');
> >> -       if (!type_str)
> >> -               return;
> >> -
> >> -       *(type_str++) = 0;
> >> -
> >> -       length_str = strchr(type_str, ' ');
> >> -       if (!length_str)
> >> -               return;
> >> -
> >> -       *(length_str++) = 0;
> >> -
> >> -       str = g_strconcat("0x", value, NULL);
> >> -       g_key_file_set_string(key_file, "LinkKey", "Key", str);
> >> -       g_free(str);
> >> -
> >> -       val = strtol(type_str, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "LinkKey", "Type", val);
> >> -
> >> -       val = strtol(length_str, NULL, 16);
> >> -       g_key_file_set_integer(key_file, "LinkKey", "PINLength", val);
> >> -}
> >> -
> >> -static void convert_ltk_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       char *auth_str, *rand_str, *str;
> >> -       int i, ret;
> >> -       unsigned char auth, master, enc_size;
> >> -       unsigned short ediv;
> >> -
> >> -       auth_str = strchr(value, ' ');
> >> -       if (!auth_str)
> >> -               return;
> >> -
> >> -       *(auth_str++) = 0;
> >> -
> >> -       for (i = 0, rand_str = auth_str; i < 4; i++) {
> >> -               rand_str = strchr(rand_str, ' ');
> >> -               if (!rand_str || rand_str[1] == '\0')
> >> -                       return;
> >> -
> >> -               rand_str++;
> >> -       }
> >> -
> >> -       ret = sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &master,
> >> -                                                       &enc_size, &ediv);
> >> -       if (ret < 4)
> >> -               return;
> >> -
> >> -       str = g_strconcat("0x", value, NULL);
> >> -       g_key_file_set_string(key_file, "LongTermKey", "Key", str);
> >> -       g_free(str);
> >> -
> >> -       g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> >> -       g_key_file_set_integer(key_file, "LongTermKey", "Master", master);
> >> -       g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
> >> -       g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
> >> -
> >> -       str = g_strconcat("0x", rand_str, NULL);
> >> -       g_key_file_set_string(key_file, "LongTermKey", "Rand", str);
> >> -       g_free(str);
> >> -}
> >> -
> >> -static void convert_profiles_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_strdelimit(value, " ", ';');
> >> -       g_key_file_set_string(key_file, "General", "Services", value);
> >> -}
> >> -
> >> -static void convert_appearances_entry(GKeyFile *key_file, void *value)
> >> -{
> >> -       g_key_file_set_string(key_file, "General", "Appearance", value);
> >> -}
> >> -
> >> -static void convert_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       struct device_converter *converter = user_data;
> >> -       char type = BDADDR_BREDR;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       if (strchr(key, '#')) {
> >> -               key[17] = '\0';
> >> -               type = key[18] - '0';
> >> -       }
> >> -
> >> -       if (bachk(key) != 0)
> >> -               return;
> >> -
> >> -       if (converter->force == FALSE) {
> >> -               struct stat st;
> >> -               int err;
> >> -
> >> -               snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
> >> -                               converter->address, key);
> >> -
> >> -               err = stat(filename, &st);
> >> -               if (err || !S_ISDIR(st.st_mode))
> >> -                       return;
> >> -       }
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> >> -                       converter->address, key);
> >> -
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       set_device_type(key_file, type);
> >> -
> >> -       converter->cb(key_file, value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_file(char *file, char *address,
> >> -                               void (*cb)(GKeyFile *key_file, void *value),
> >> -                               gboolean force)
> >> -{
> >> -       char filename[PATH_MAX];
> >> -       struct device_converter converter;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);
> >> -
> >> -       converter.address = address;
> >> -       converter.cb = cb;
> >> -       converter.force = force;
> >> -
> >> -       textfile_foreach(filename, convert_entry, &converter);
> >> -}
> >> -
> >> -static gboolean record_has_uuid(const sdp_record_t *rec,
> >> -                               const char *profile_uuid)
> >> -{
> >> -       sdp_list_t *pat;
> >> -
> >> -       for (pat = rec->pattern; pat != NULL; pat = pat->next) {
> >> -               char *uuid;
> >> -               int ret;
> >> -
> >> -               uuid = bt_uuid2string(pat->data);
> >> -               if (!uuid)
> >> -                       continue;
> >> -
> >> -               ret = strcasecmp(uuid, profile_uuid);
> >> -
> >> -               free(uuid);
> >> -
> >> -               if (ret == 0)
> >> -                       return TRUE;
> >> -       }
> >> -
> >> -       return FALSE;
> >> -}
> >> -
> >> -static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
> >> -                                       uint16_t end, char *att_uuid,
> >> -                                       uuid_t uuid)
> >> -{
> >> -       char handle[6], uuid_str[33];
> >> -       int i;
> >> -
> >> -       switch (uuid.type) {
> >> -       case SDP_UUID16:
> >> -               sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
> >> -               break;
> >> -       case SDP_UUID32:
> >> -               sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
> >> -               break;
> >> -       case SDP_UUID128:
> >> -               for (i = 0; i < 16; i++)
> >> -                       sprintf(uuid_str + (i * 2), "%2.2X",
> >> -                                       uuid.value.uuid128.data[i]);
> >> -               break;
> >> -       default:
> >> -               uuid_str[0] = '\0';
> >> -       }
> >> -
> >> -       sprintf(handle, "%hu", start);
> >> -       g_key_file_set_string(key_file, handle, "UUID", att_uuid);
> >> -       g_key_file_set_string(key_file, handle, "Value", uuid_str);
> >> -       g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
> >> -}
> >> -
> >> -static void store_sdp_record(char *local, char *peer, int handle, char *value)
> >> -{
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       char handle_str[11];
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
> >> -
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       sprintf(handle_str, "0x%8.8X", handle);
> >> -       g_key_file_set_string(key_file, "ServiceRecords", handle_str, value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_sdp_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *src_addr = user_data;
> >> -       char dst_addr[18];
> >> -       char type = BDADDR_BREDR;
> >> -       int handle, ret;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       struct stat st;
> >> -       sdp_record_t *rec;
> >> -       uuid_t uuid;
> >> -       char *att_uuid, *prim_uuid;
> >> -       uint16_t start = 0, end = 0, psm = 0;
> >> -       int err;
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       ret = sscanf(key, "%17s#%hhu#%08X", dst_addr, &type, &handle);
> >> -       if (ret < 3) {
> >> -               ret = sscanf(key, "%17s#%08X", dst_addr, &handle);
> >> -               if (ret < 2)
> >> -                       return;
> >> -       }
> >> -
> >> -       if (bachk(dst_addr) != 0)
> >> -               return;
> >> -
> >> -       /* Check if the device directory has been created as records should
> >> -        * only be converted for known devices */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> >> -
> >> -       err = stat(filename, &st);
> >> -       if (err || !S_ISDIR(st.st_mode))
> >> -               return;
> >> -
> >> -       /* store device records in cache */
> >> -       store_sdp_record(src_addr, dst_addr, handle, value);
> >> -
> >> -       /* Retrieve device record and check if there is an
> >> -        * attribute entry in it */
> >> -       sdp_uuid16_create(&uuid, ATT_UUID);
> >> -       att_uuid = bt_uuid2string(&uuid);
> >> -
> >> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> >> -       prim_uuid = bt_uuid2string(&uuid);
> >> -
> >> -       rec = record_from_string(value);
> >> -
> >> -       if (record_has_uuid(rec, att_uuid))
> >> -               goto failed;
> >> -
> >> -       /* TODO: Do this through btd_gatt_database */
> >> -       if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
> >> -               goto failed;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
> >> -                                                               dst_addr);
> >> -
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -       g_key_file_free(key_file);
> >> -
> >> -failed:
> >> -       sdp_record_free(rec);
> >> -       free(prim_uuid);
> >> -       free(att_uuid);
> >> -}
> >> -
> >> -static void convert_primaries_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *address = user_data;
> >> -       int device_type = -1;
> >> -       uuid_t uuid;
> >> -       char **services, **service, *prim_uuid;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       int ret;
> >> -       uint16_t start, end;
> >> -       char uuid_str[MAX_LEN_UUID_STR + 1];
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       if (strchr(key, '#')) {
> >> -               key[17] = '\0';
> >> -               device_type = key[18] - '0';
> >> -       }
> >> -
> >> -       if (bachk(key) != 0)
> >> -               return;
> >> -
> >> -       services = g_strsplit(value, " ", 0);
> >> -       if (services == NULL)
> >> -               return;
> >> -
> >> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> >> -       prim_uuid = bt_uuid2string(&uuid);
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
> >> -                                                                       key);
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       for (service = services; *service; service++) {
> >> -               ret = sscanf(*service, "%04hX#%04hX#%s", &start, &end,
> >> -                                                               uuid_str);
> >> -               if (ret < 3)
> >> -                       continue;
> >> -
> >> -               bt_string2uuid(&uuid, uuid_str);
> >> -               sdp_uuid128_to_uuid(&uuid);
> >> -
> >> -               store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> >> -       }
> >> -
> >> -       g_strfreev(services);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length == 0)
> >> -               goto end;
> >> -
> >> -       create_file(filename, S_IRUSR | S_IWUSR);
> >> -       g_file_set_contents(filename, data, length, NULL);
> >> -
> >> -       if (device_type < 0)
> >> -               goto end;
> >> -
> >> -       g_free(data);
> >> -       g_key_file_free(key_file);
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, key);
> >> -
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -       set_device_type(key_file, device_type);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -end:
> >> -       g_free(data);
> >> -       free(prim_uuid);
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_ccc_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *src_addr = user_data;
> >> -       char dst_addr[18];
> >> -       char type = BDADDR_BREDR;
> >> -       uint16_t handle;
> >> -       int ret, err;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       struct stat st;
> >> -       char group[6];
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
> >> -       if (ret < 3)
> >> -               return;
> >> -
> >> -       if (bachk(dst_addr) != 0)
> >> -               return;
> >> -
> >> -       /* Check if the device directory has been created as records should
> >> -        * only be converted for known devices */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> >> -
> >> -       err = stat(filename, &st);
> >> -       if (err || !S_ISDIR(st.st_mode))
> >> -               return;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
> >> -                                                               dst_addr);
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       sprintf(group, "%hu", handle);
> >> -       g_key_file_set_string(key_file, group, "Value", value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_gatt_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *src_addr = user_data;
> >> -       char dst_addr[18];
> >> -       char type = BDADDR_BREDR;
> >> -       uint16_t handle;
> >> -       int ret, err;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       struct stat st;
> >> -       char group[6];
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
> >> -       if (ret < 3)
> >> -               return;
> >> -
> >> -       if (bachk(dst_addr) != 0)
> >> -               return;
> >> -
> >> -       /* Check if the device directory has been created as records should
> >> -        * only be converted for known devices */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
> >> -
> >> -       err = stat(filename, &st);
> >> -       if (err || !S_ISDIR(st.st_mode))
> >> -               return;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/gatt", src_addr,
> >> -                                                               dst_addr);
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       sprintf(group, "%hu", handle);
> >> -       g_key_file_set_string(key_file, group, "Value", value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_proximity_entry(char *key, char *value, void *user_data)
> >> -{
> >> -       char *src_addr = user_data;
> >> -       char *alert;
> >> -       char filename[PATH_MAX];
> >> -       GKeyFile *key_file;
> >> -       struct stat st;
> >> -       int err;
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       if (!strchr(key, '#'))
> >> -               return;
> >> -
> >> -       key[17] = '\0';
> >> -       alert = &key[18];
> >> -
> >> -       if (bachk(key) != 0)
> >> -               return;
> >> -
> >> -       /* Check if the device directory has been created as records should
> >> -        * only be converted for known devices */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, key);
> >> -
> >> -       err = stat(filename, &st);
> >> -       if (err || !S_ISDIR(st.st_mode))
> >> -               return;
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_addr,
> >> -                                                                       key);
> >> -       key_file = g_key_file_new();
> >> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> >> -
> >> -       g_key_file_set_string(key_file, alert, "Level", value);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       if (length > 0) {
> >> -               create_file(filename, S_IRUSR | S_IWUSR);
> >> -               g_file_set_contents(filename, data, length, NULL);
> >> -       }
> >> -
> >> -       g_free(data);
> >> -       g_key_file_free(key_file);
> >> -}
> >> -
> >> -static void convert_device_storage(struct btd_adapter *adapter)
> >> -{
> >> -       char filename[PATH_MAX];
> >> -       char address[18];
> >> -
> >> -       ba2str(&adapter->bdaddr, address);
> >> -
> >> -       /* Convert device's name cache */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
> >> -       textfile_foreach(filename, convert_names_entry, address);
> >> -
> >> -       /* Convert aliases */
> >> -       convert_file("aliases", address, convert_aliases_entry, TRUE);
> >> -
> >> -       /* Convert trusts */
> >> -       convert_file("trusts", address, convert_trusts_entry, TRUE);
> >> -
> >> -       /* Convert blocked */
> >> -       convert_file("blocked", address, convert_blocked_entry, TRUE);
> >> -
> >> -       /* Convert profiles */
> >> -       convert_file("profiles", address, convert_profiles_entry, TRUE);
> >> -
> >> -       /* Convert primaries */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
> >> -       textfile_foreach(filename, convert_primaries_entry, address);
> >> -
> >> -       /* Convert linkkeys */
> >> -       convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
> >> -
> >> -       /* Convert longtermkeys */
> >> -       convert_file("longtermkeys", address, convert_ltk_entry, TRUE);
> >> -
> >> -       /* Convert classes */
> >> -       convert_file("classes", address, convert_classes_entry, FALSE);
> >> -
> >> -       /* Convert device ids */
> >> -       convert_file("did", address, convert_did_entry, FALSE);
> >> -
> >> -       /* Convert sdp */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
> >> -       textfile_foreach(filename, convert_sdp_entry, address);
> >> -
> >> -       /* Convert ccc */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
> >> -       textfile_foreach(filename, convert_ccc_entry, address);
> >> -
> >> -       /* Convert appearances */
> >> -       convert_file("appearances", address, convert_appearances_entry, FALSE);
> >> -
> >> -       /* Convert gatt */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
> >> -       textfile_foreach(filename, convert_gatt_entry, address);
> >> -
> >> -       /* Convert proximity */
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
> >> -       textfile_foreach(filename, convert_proximity_entry, address);
> >> -}
> >> -
> >> -static void convert_config(struct btd_adapter *adapter, const char *filename,
> >> -                                                       GKeyFile *key_file)
> >> -{
> >> -       char address[18];
> >> -       char str[MAX_NAME_LENGTH + 1];
> >> -       char config_path[PATH_MAX];
> >> -       int timeout;
> >> -       uint8_t mode;
> >> -       char *data;
> >> -       gsize length = 0;
> >> -
> >> -       ba2str(&adapter->bdaddr, address);
> >> -       snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
> >> -
> >> -       if (read_pairable_timeout(address, &timeout) == 0)
> >> -               g_key_file_set_integer(key_file, "General",
> >> -                                               "PairableTimeout", timeout);
> >> -
> >> -       if (read_discoverable_timeout(address, &timeout) == 0)
> >> -               g_key_file_set_integer(key_file, "General",
> >> -                                               "DiscoverableTimeout", timeout);
> >> -
> >> -       if (read_on_mode(address, str, sizeof(str)) == 0) {
> >> -               mode = get_mode(str);
> >> -               g_key_file_set_boolean(key_file, "General", "Discoverable",
> >> -                                       mode == MODE_DISCOVERABLE);
> >> -       }
> >> -
> >> -       if (read_local_name(&adapter->bdaddr, str) == 0)
> >> -               g_key_file_set_string(key_file, "General", "Alias", str);
> >> -
> >> -       create_file(filename, S_IRUSR | S_IWUSR);
> >> -
> >> -       data = g_key_file_to_data(key_file, &length, NULL);
> >> -       g_file_set_contents(filename, data, length, NULL);
> >> -       g_free(data);
> >> -}
> >> -
> >> -static void fix_storage(struct btd_adapter *adapter)
> >> -{
> >> -       char filename[PATH_MAX];
> >> -       char address[18];
> >> -       char *converted;
> >> -
> >> -       ba2str(&adapter->bdaddr, address);
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/config", address);
> >> -       converted = textfile_get(filename, "converted");
> >> -       if (!converted)
> >> -               return;
> >> -
> >> -       free(converted);
> >> -
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/aliases", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/trusts", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/blocked", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/profiles", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/linkkeys", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/longtermkeys", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/did", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/appearances", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
> >> -       textfile_del(filename, "converted");
> >> -
> >> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
> >> -       textfile_del(filename, "converted");
> >> -}
> >> -
> >> static void load_config(struct btd_adapter *adapter)
> >> {
> >>        GKeyFile *key_file;
> >>        char filename[PATH_MAX];
> >> -       struct stat st;
> >>        GError *gerr = NULL;
> >>
> >>        key_file = g_key_file_new();
> >> @@ -5752,11 +4926,6 @@ static void load_config(struct btd_adapter *adapter)
> >>        snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
> >>                                        btd_adapter_get_storage_dir(adapter));
> >>
> >> -       if (stat(filename, &st) < 0) {
> >> -               convert_config(adapter, filename, key_file);
> >> -               convert_device_storage(adapter);
> >> -       }
> >> -
> >>        g_key_file_load_from_file(key_file, filename, 0, NULL);
> >>
> >>        /* Get alias */
> >> @@ -8124,7 +7293,6 @@ static int adapter_register(struct btd_adapter *adapter)
> >>
> >> load:
> >>        load_config(adapter);
> >> -       fix_storage(adapter);
> >>        load_drivers(adapter);
> >>        btd_profile_foreach(probe_profile, adapter);
> >>        clear_blocked(adapter);
> >> --
> >> 2.11.0
> >>
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz

--Apple-Mail=_E31E779E-6A4D-43FB-912B-09A3CB5B5F80--
