Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067617A2EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961627; cv=none; b=O+AJDijayrluGIRCnCqwCrI3F8ybcO5uZvgGVfOozmEFp0QThUaafQH0INrOGVDSrWhjy6Dp0abHFaIhVsbSK7Jdpj0rl+QHb0iIt9L0bTXRDzrmNpEheLa73yMHZZmbKnESEWsfXTU8EzFlVcHFg4aq0bOSKgGNPYkXPFzbd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961627; c=relaxed/simple;
	bh=A7CCVglTDU101rwNYEsR2liVRbLX6z45SVyzXY8yph8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVlOeWdP+tTte/jJ7fbtIh6Sp9+Q8CyoyQLGLpNbj9fvjXoDpXSpLI28d49npBtaQNBHtV9XsIvd/DpTd2h3e0MZwzvWRNhixMBdNPsxecY3Z2wxi+/jLh+4Bw08/oErctAqtECYYaSxtxW6rIJl5cnJp/JDb3XDAlcVnzzZiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQSt0is5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQSt0is5"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32a6a91f0easo20632861fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748961624; x=1749566424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRuw5WKcmAlsAR+ayNFh6QB6S3WLZRZGkoOeIym2dug=;
        b=ZQSt0is56aAWQOwNmk7AEhVpgMYdvIajonRvJsw6V3VdzSorSEyD5dQm3a5ku03rpd
         KlfqPo2l89fK2orUbkt/UsDdK8/IAlLM6zANC9nQjgJcurwowAwadgMr/9cKfh9Q9/sV
         yGhjrsSoGJfzpjXh/Jbj8hGBMILwiH5beASIGTTUecCD6axUOuWUNeKH09P94xDP7USw
         EFGvlDwwLwIRzIFstPJsSTG3ZvUWLNJyFKf2nebuj0PLtl/6kfiOhyR4XitY2gGzzaFf
         A4nFyQ6+Q34r/VtOqll89he5+4SESiXb6DQS99nmAtda9lDHOxahZDa0IiX628uc4a0Z
         cJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961624; x=1749566424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRuw5WKcmAlsAR+ayNFh6QB6S3WLZRZGkoOeIym2dug=;
        b=XHN6Wt9HTTbpEYkdtCdKhwypSC5kGXLOZT0jUPZ1TNPU+FmoBqc/ogyraN9VwLYb7t
         JZwVC+2N42ykKeMKUspm8Y/gnJ5XuNGaijRdJZiRzWE3iWa8dTgxbqtUVng2vh7AzwaQ
         v2NVxVu723XzkYNp5/ppZgLyor6faxVZ71IE0rGDgP5hUkD1GbVqWxgvb/Qr76deM4vV
         JPw5/8+P4pXHMIG05lNlAyiJ2CXlASjRPETf2L92/bWchtrVEyPmawpEbPzS3UCNFxhz
         Jye2CPHAGxsQQMOLfhsVwI/7X8ZE8GAbUEfaq6yxehHRhh4KFwPCBB01vGCKuA8P00Zg
         QnYg==
X-Gm-Message-State: AOJu0YwQVIXU8tTprCJzgUsgeCIEfbaAqUR8D3NN2TNqFsWlYwRQ4q9x
	94E4EcXakG2Iz2HaX9sUXt3ZguoIFns864wVs8ofPHI6YQeYEri44/zsG+jqvvC0N7TRjPgMBzA
	cFFNo/JbHxEMgDXe1GZEchnvBR2LVf/kLu/nXqLw=
X-Gm-Gg: ASbGnct8vAXZecP0+WfluZHe0S8A3IvOC7eqZZ/MTYbE5FIwPCNI8OAGJLSfCPtXZPn
	Nl0P/xPwixQP7ws7P1rW+36YNzTy6Ji/WUVdRvtevoDLyXCmvavz+SbJ3PqhWITdjWOY3ZAx0TA
	TwCFxK8hvFsLRqDjCaJXtPY1OsGC9zbwk=
X-Google-Smtp-Source: AGHT+IGl7yspY1w0edG59cnrTL8iaAOMVanYUvqTYCnfomjrj/CAipUkQxSoB9SDHsBESJzITrlBhtSvKFZ/qV81474=
X-Received: by 2002:a05:651c:30c7:b0:32a:6af3:aead with SMTP id
 38308e7fff4ca-32a906cf358mr57098031fa.16.1748961623530; Tue, 03 Jun 2025
 07:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603095617.92785-1-sdoregor@sdore.me> <20250603095617.92785-3-sdoregor@sdore.me>
In-Reply-To: <20250603095617.92785-3-sdoregor@sdore.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Jun 2025 10:40:10 -0400
X-Gm-Features: AX0GCFtHX1FoOc6ivQgEdZdwWU-oY2DcUFwj1hPX0k5E0KzutGi5V7KHVto_JAk
Message-ID: <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for DualSense
To: Egor Vorontsov <sdoregor@sdore.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Egor,

On Tue, Jun 3, 2025 at 6:05=E2=80=AFAM Egor Vorontsov <sdoregor@sdore.me> w=
rote:
>
> The code is very similar to that for DS4, but I found it's better
> to separate the matters instead of generalizing it via constants.
>
> Also added a request to enable Bluetooth on the controller to initiate
> pairing without the need to disconnect it and power on again wirelessly,
> basically emulating what PS itself does. Only for DualSense family now,
> but can be expanded to DS4 too (I don't have one at hand to test this).
> ---
>  plugins/sixaxis.c | 107 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 1fab8ae59..a583c8b82 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -131,12 +131,36 @@ static int ds4_get_device_bdaddr(int fd, bdaddr_t *=
bdaddr)
>         return 0;
>  }
>
> +static int dualsense_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +       uint8_t buf[20];
> +       int ret;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       buf[0] =3D 0x09;
> +
> +       ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +       if (ret < 0) {
> +               error("sixaxis: failed to read DualSense device address (=
%s)",
> +                     strerror(errno));
> +               return ret;
> +       }
> +
> +       /* address is little-endian on DualSense */
> +       bacpy(bdaddr, (bdaddr_t*) (buf + 1));
> +
> +       return 0;
> +}
> +
>  static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType =
type)
>  {
>         if (type =3D=3D CABLE_PAIRING_SIXAXIS)
>                 return sixaxis_get_device_bdaddr(fd, bdaddr);
>         else if (type =3D=3D CABLE_PAIRING_DS4)
>                 return ds4_get_device_bdaddr(fd, bdaddr);
> +       else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +               return dualsense_get_device_bdaddr(fd, bdaddr);
>         return -1;
>  }
>
> @@ -183,12 +207,36 @@ static int ds4_get_central_bdaddr(int fd, bdaddr_t =
*bdaddr)
>         return 0;
>  }
>
> +static int dualsense_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +       uint8_t buf[20];
> +       int ret;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       buf[0] =3D 0x09;
> +
> +       ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +       if (ret < 0) {
> +               error("sixaxis: failed to read DualSense central address =
(%s)",
> +                     strerror(errno));
> +               return ret;
> +       }
> +
> +       /* address is little-endian on DualSense */
> +       bacpy(bdaddr, (bdaddr_t*) (buf + 10));
> +
> +       return 0;
> +}
> +
>  static int get_central_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType=
 type)
>  {
>         if (type =3D=3D CABLE_PAIRING_SIXAXIS)
>                 return sixaxis_get_central_bdaddr(fd, bdaddr);
>         else if (type =3D=3D CABLE_PAIRING_DS4)
>                 return ds4_get_central_bdaddr(fd, bdaddr);
> +       else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +               return dualsense_get_central_bdaddr(fd, bdaddr);
>         return -1;
>  }
>
> @@ -230,6 +278,26 @@ static int ds4_set_central_bdaddr(int fd, const bdad=
dr_t *bdaddr)
>         return ret;
>  }
>
> +static int dualsense_set_central_bdaddr(int fd, const bdaddr_t *bdaddr)
> +{
> +       uint8_t buf[27];
> +       int ret;
> +
> +       buf[0] =3D 0x0A;
> +       bacpy((bdaddr_t*) (buf + 1), bdaddr);
> +       /* TODO: we could put the key here but
> +          there is no way to force a re-loading
> +          of link keys to the kernel from here. */

Not quite following, what key are you talking about? I thought the
link keys are still generated over Bluetooth, or are you talking about
passkeys here?

> +       memset(buf + 7, 0, 16);
> +
> +       ret =3D ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
> +       if (ret < 0)
> +               error("sixaxis: failed to write DualSense central address=
 (%s)",
> +                     strerror(errno));
> +
> +       return ret;
> +}
> +
>  static int set_central_bdaddr(int fd, const bdaddr_t *bdaddr,
>                                         CablePairingType type)
>  {
> @@ -237,6 +305,32 @@ static int set_central_bdaddr(int fd, const bdaddr_t=
 *bdaddr,
>                 return sixaxis_set_central_bdaddr(fd, bdaddr);
>         else if (type =3D=3D CABLE_PAIRING_DS4)
>                 return ds4_set_central_bdaddr(fd, bdaddr);
> +       else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +               return dualsense_set_central_bdaddr(fd, bdaddr);
> +       return -1;
> +}
> +
> +static int dualsense_set_bluetooth_state(int fd, bool state)
> +{
> +       uint8_t buf[48];
> +       int ret;
> +
> +       buf[0] =3D 0x08;
> +       buf[1] =3D state?1:2;
> +
> +       ret =3D ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
> +       if (ret < 0)
> +               error("sixaxis: failed to set DualSense Bluetooth state (=
%s)",
> +                     strerror(errno));
> +
> +       return ret;
> +}
> +
> +static int set_bluetooth_state(int fd, CablePairingType type,
> +                                       bool state)
> +{
> +       if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +               return dualsense_set_bluetooth_state(fd, state);
>         return -1;
>  }
>
> @@ -297,12 +391,13 @@ static void agent_auth_cb(DBusError *derr, void *us=
er_data)
>         remove_device =3D false;
>         btd_device_set_temporary(closure->device, false);
>
> -       if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS) {
> +       if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS)
>                 btd_device_set_record(closure->device, HID_UUID,
>                                                  SIXAXIS_HID_SDP_RECORD);
>
> +       if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS ||
> +                               closure->type =3D=3D CABLE_PAIRING_DUALSE=
NSE) {
>                 device_set_cable_pairing(closure->device, true);
> -
>                 server_set_cable_pairing(adapter_bdaddr, true);
>         }
>
> @@ -312,6 +407,11 @@ static void agent_auth_cb(DBusError *derr, void *use=
r_data)
>         DBG("remote %s old_central %s new_central %s",
>                                 device_addr, central_addr, adapter_addr);
>
> +       if (closure->type =3D=3D CABLE_PAIRING_DUALSENSE) {
> +               DBG("Enabling Bluetooth connection on the device");
> +               set_bluetooth_state(closure->fd, closure->type, true);
> +       }
> +
>  out:
>         g_hash_table_steal(pending_auths, closure->sysfs_path);
>
> @@ -432,7 +532,8 @@ static void device_added(struct udev_device *udevice)
>
>         cp =3D get_pairing_type_for_device(udevice, &bus, &sysfs_path);
>         if (!cp || (cp->type !=3D CABLE_PAIRING_SIXAXIS &&
> -                               cp->type !=3D CABLE_PAIRING_DS4)) {
> +                               cp->type !=3D CABLE_PAIRING_DS4 &&
> +                               cp->type !=3D CABLE_PAIRING_DUALSENSE)) {
>                 g_free(sysfs_path);
>                 return;
>         }
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
