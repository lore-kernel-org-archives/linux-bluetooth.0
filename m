Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7DCC43215
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDD42084D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIaMooC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfK0ThM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:37:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43312 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfK0ThL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 14:37:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so21144944oie.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1q5afsWyKr3l+g0rXu4aUmzDS/Lf61S4UL5s7XdaqE=;
        b=vIaMooC+RkpBXOFfJ6T4Qcs5qjlPMJWRN5WxZHEK5E/tcpFuZwrFbePUywIyEujzRG
         KQviS800aJCUSFMNUT1ukpkeoO4IF/Zx0jDi11J+owLUSydw17xmcI1bfF6lzvybsUa4
         Aw5r74BGjVLem5rCM8NAddmV4mDkyjHxuC1AVX7VUkRqRiE/uyg+Vk2P3+BBu+Nl2z5H
         /snkTywZdiiedPl6XvQDOYP61/8ozizdYOvbTx247hPXuNmYO29VnBmHQ6PGFskhbACv
         qh7ZaD9tQpDBnWXkNAPNhCqTFgNgbGxeqRBG1xNUmDQ79JGXA0jRyCwjZIgNMd5yqNnu
         IK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1q5afsWyKr3l+g0rXu4aUmzDS/Lf61S4UL5s7XdaqE=;
        b=T98uny2cjAQy7RBfVUOSc6w84qIae0/Xn9pjbJVBr/6odzCCl4ec96ps8IrT1xylOw
         a8/PpEJokO+mO9uCXarXrU0oJZoe8gDFRXDMUaWi2smzDhDLWTmZqWoBonmPZ+n2Z3Cf
         z9VvU6qbMd/xrFthkejSxcyeO1/sMGS9M9sZ+iHWOUjv/7b5wAfw4X+esx290QwLC5iE
         CKOxg99frC2x3lbGiKO0g7+eA9JbVggU+CF/TMABiRTstFj2j6YM1kUwc5dTSPi5PNEP
         4JwWYIYgWegR56t2RDPVCACUS/a/CP1AkNwxiyMsSiY5yC+6KHeE1S6tLDiUh1oaBara
         d2Cg==
X-Gm-Message-State: APjAAAXOKW89SoukZrdQ4zuH/z6nuf/0/uc6P/XCwprKrCrUeXjocA6R
        ENnY8otzMplV7Q2eryxl8YSh4GXj96ABNbIvImc=
X-Google-Smtp-Source: APXvYqykm8BFUj1xjxrTwLirtyjcQcvn/MnxwQn31sb+nYyf6uuAxZWjGkkq4B/yU+Uwira1d9fLcqLHNxoRcbARNDo=
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr1216236oie.8.1574883430196;
 Wed, 27 Nov 2019 11:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
In-Reply-To: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Nov 2019 21:36:57 +0200
Message-ID: <CABBYNZLbxR51OzKRk6rTdSMG7JTE2apsqB2TXOmbEr_kdFdU2w@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/2] input: Update virtual input devices with
 correct info
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Wed, Nov 27, 2019 at 9:09 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Update uhid and uinput devices with lowercase addresses (to match how
> kernel prints it via %pMR). Also update uinput to include the phys
> attribute and correctly set the vendor/product/version during init.
>
> ---
> I was just checking through udev to see if I could correlate virtual
> devices created by bluez (via uhid and uinput) to the hci interface that
> owns it. While doing that, I found that the printed addresses were upper
> case but other addresses in udev were lower case. (i.e. udevinfo -a -p
> /sys/class/net/eth0). To keep things consistent and comparable, I opted
> to convert these addresses to lower case.
>
> I was able to compare the `phys` attribute with the value in
> /sys/kernel/debug/hci0/identity to figure out which virtual devices were
> created for bluetooth.
>
> For systems that don't mount debugfs, would it be a good idea to expose
> the identity in sysfs?  i.e. /sys/class/bluetooth/hci0/identity?
>
> Thanks
> Abhishek
>
>
>  lib/bluetooth.c          |  7 +++++++
>  lib/bluetooth.h          |  1 +
>  profiles/audio/avctp.c   | 21 ++++++++++++++-------
>  profiles/input/device.c  |  4 ++--
>  profiles/input/hog-lib.c | 10 ++++++++++
>  5 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bluetooth.c b/lib/bluetooth.c
> index effc7f49d..7cba509d8 100644
> --- a/lib/bluetooth.c
> +++ b/lib/bluetooth.c
> @@ -81,6 +81,13 @@ int ba2str(const bdaddr_t *ba, char *str)
>                 ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
>  }
>
> +/* Match kernel's lowercase printing of mac address (%pMR) */
> +int ba2strlc(const bdaddr_t *ba, char *str)
> +{
> +       return sprintf(str, "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
> +               ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
> +}

Lets split this change into it own patch.

>  int str2ba(const char *str, bdaddr_t *ba)
>  {
>         int i;
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index eb279260e..756dce164 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -325,6 +325,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
>  bdaddr_t *strtoba(const char *str);
>  char *batostr(const bdaddr_t *ba);
>  int ba2str(const bdaddr_t *ba, char *str);
> +int ba2strlc(const bdaddr_t *ba, char *str);
>  int str2ba(const char *str, bdaddr_t *ba);
>  int ba2oui(const bdaddr_t *ba, char *oui);
>  int bachk(const char *str);
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 70a3e40b2..42136f94b 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1161,7 +1161,8 @@ failed:
>         return FALSE;
>  }

We might as well put these helpers into a mini library like we did
with uhid, but Im fine leaving it for later if you don't want to do as
part of this set.

> -static int uinput_create(char *name)
> +static int uinput_create(struct btd_device *device, const char *name,
> +                        const char *phys)
>  {
>         struct uinput_dev dev;
>         int fd, err, i;
> @@ -1185,9 +1186,9 @@ static int uinput_create(char *name)
>                 strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
>
>         dev.id.bustype = BUS_BLUETOOTH;
> -       dev.id.vendor  = 0x0000;
> -       dev.id.product = 0x0000;
> -       dev.id.version = 0x0000;
> +       dev.id.vendor  = btd_device_get_vendor(device);
> +       dev.id.product = btd_device_get_product(device);
> +       dev.id.version = btd_device_get_version(device);
>
>         if (write(fd, &dev, sizeof(dev)) < 0) {
>                 err = -errno;
> @@ -1202,6 +1203,9 @@ static int uinput_create(char *name)
>         ioctl(fd, UI_SET_EVBIT, EV_REP);
>         ioctl(fd, UI_SET_EVBIT, EV_SYN);
>
> +       /* Also set the phys */
> +       ioctl(fd, UI_SET_PHYS, phys);
> +
>         for (i = 0; key_map[i].name != NULL; i++)
>                 ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
>
> @@ -1220,7 +1224,7 @@ static int uinput_create(char *name)
>
>  static void init_uinput(struct avctp *session)
>  {
> -       char address[18], name[248 + 1];
> +       char address[18], phys[18], name[248 + 1];
>
>         device_get_name(session->device, name, sizeof(name));
>         if (g_str_equal(name, "Nokia CK-20W")) {
> @@ -1230,8 +1234,11 @@ static void init_uinput(struct avctp *session)
>                 session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
>         }
>
> -       ba2str(device_get_address(session->device), address);
> -       session->uinput = uinput_create(address);
> +       ba2strlc(device_get_address(session->device), address);
> +       ba2strlc(btd_adapter_get_address(device_get_adapter(session->device)),
> +                phys);
> +
> +       session->uinput = uinput_create(session->device, address, phys);

You could have moved the code related to address and phys directly
into uinput_create since you are passing the device it could self
generate these.

>         if (session->uinput < 0)
>                 error("AVRCP: failed to init uinput for %s", address);
>         else
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index a711ef527..2cb3811c8 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -855,8 +855,8 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_CREATE;
>         strncpy((char *) ev.u.create.name, req->name, sizeof(ev.u.create.name));
> -       ba2str(&idev->src, (char *) ev.u.create.phys);
> -       ba2str(&idev->dst, (char *) ev.u.create.uniq);
> +       ba2strlc(&idev->src, (char *) ev.u.create.phys);
> +       ba2strlc(&idev->dst, (char *) ev.u.create.uniq);
>         ev.u.create.vendor = req->vendor;
>         ev.u.create.product = req->product;
>         ev.u.create.version = req->version;
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index d9ed80689..9c5c814a7 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -32,6 +32,7 @@
>  #include <stdbool.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <ctype.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> @@ -992,6 +993,15 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                         BT_IO_OPT_SOURCE, ev.u.create.phys,
>                         BT_IO_OPT_DEST, ev.u.create.uniq,
>                         BT_IO_OPT_INVALID);
> +
> +       /* Phys + uniq are the same size (hw address type) */
> +       for (i = 0;
> +           i < (int)sizeof(ev.u.create.phys) && ev.u.create.phys[i] != 0;
> +           ++i) {
> +               ev.u.create.phys[i] = tolower(ev.u.create.phys[i]);
> +               ev.u.create.uniq[i] = tolower(ev.u.create.uniq[i]);
> +       }
> +
>         if (gerr) {
>                 error("Failed to connection details: %s", gerr->message);
>                 g_error_free(gerr);
> --
> 2.24.0.432.g9d3f5f5b63-goog
>


-- 
Luiz Augusto von Dentz
