Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6027313E31
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029971; cv=pass; b=QwmsfQ32ON2NM5k6jGS19rk5fvHx1qyaHayB+FbT8JK9JCftDhtzH+tQICWRgK40y8OHpHoRXncaXy3kDL0vrjRZKBAwI4c9Yhn0JHgcciQHeCfdJZ6EoBbVZPswqbnGONxaCjZF3yNmGly5P85htOJQ31M0ivOjlt+NexMUwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029971; c=relaxed/simple;
	bh=w5NtZAmYyTtSTtyPoh/JD/7V8iyrvlWclVVZ1N62wqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1b6+TYNfawJUHDtb5vYDUpjneQhQzggh29/e/pCK6eC2Fu+oEodQ+619CJ1doGEy2hnQMp7gtMx/4yBlHkIqfOLBgRQppWtYmXa8xNjAMpIdSBftPKG58ZnLDsS6fJLba6783zelwYj+qvabt19y0m2jcEbNclSVJmjCTNO8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClajEQbl; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClajEQbl"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79df972so1027157d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029969; cv=none;
        d=google.com; s=arc-20240605;
        b=B1Odumt87iFJUUcaUFYrSCabY7eQEwVqC/F6S2qjzen3DLNKK5hrQhokdb29k/Zg7H
         cns1aWJXUs3Km+Yljk6d70VoQJHqQRygQ7G3er/BfOEYDpu1O05Xg+YEn1zQf1Es9Ua0
         dzr6YCsrh0dHlIGzl0NyOb8cbIrhphEGqkHbLzsdBpYWyeda18tuE/ELLkQMy+iJjDQY
         JwcNH7+I7krsmfc2CEe0DnFF1VXOkmSRofZTaIOWpNj/nOMltuSJwbnoC9ndVQk8G0Cb
         SlSj0pVY2vYi9hbqEpcUP2sSua0ZCPgIcx5LcRSMhi7JWUKoqBr0vNaKTyzBFgT0SGAT
         PDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VH3ptaGI6uFGJTGGxQrr1dbuHGISnI3c66r4T4ExgYA=;
        fh=G7FL00PQJsOt3PYdjxvECRp+csodTO/dzt1YPk0wLec=;
        b=e0kvYTzumX5hclIM+diyEO7/fdavZL8ASJgX2UUEMQ1hbgiw5pTN5lFkcyThgDFY/9
         SEseTFpyrfW9muiU9PsvV0De4DzsEd2X72GIQHOGIcNh718aLH6dfwTLUKs7ZlUjcbI6
         Oe4hNl4pcbD3Wp+cEQUgi0+B+zNo0Gp6huxht4AiwpNAsQHDATizdqbzY5WIu9i8o/DJ
         ZRoRSBfUVVKXnPP1zhWhgobUbrquAmCrDR2PQfqiFMToIOZ4vVCv+friE6RbPrWhkYSv
         cFo5lGLPIjxb/+p7SdTHaR/u5gQTsAV0UD2iyNis29kNUjpqATgYnWplvfcJHWvt7MCI
         YmOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774029969; x=1774634769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH3ptaGI6uFGJTGGxQrr1dbuHGISnI3c66r4T4ExgYA=;
        b=ClajEQbl5FheZ0Oo5nGvaOckZl+FuSOXjCE2yy3UAULod0DNgCryaKX/C4li9wRPj4
         CUltFgNrL7ebd6LbjZhUR6pmlefuSyHxutmdR9CfFicektySdCnmMr/vnxEmlx1AH92I
         LTnnNd8gJD2C1KXPyDQJ7q55929Taoq8oM7jXQPQbajf529QiNXny38KsYSfulLLZYc1
         CFWJjuL/WG4M0E9IoTvjR19t+zug1Y1WRE6pBdipOXRin2Qw4hrpWjdABuu3M41MKYLa
         lVtG1zXyHFDsBio8Qq77/loRcCcWTuLWCL4y7AfgsL3jbCL2GileoOc3cDydLyYvBvQQ
         K28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029969; x=1774634769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VH3ptaGI6uFGJTGGxQrr1dbuHGISnI3c66r4T4ExgYA=;
        b=hJ0D2rff2Jrp3HMkfp/ZTVJC1RZZGorid7F4NoLI0RpBNXyJMZZAUX4xZw9WXltrjt
         U4kr5ylDuQ2eVmalwEeBuzhgBn2XjA3T6aaHn5A99/ww/lKE00H82HFKSFYkUhKi/4Vg
         zW92nTMH4d0gqIyUQt9cwt3gNszlUNyjwoinMBqKKb5Hj3JsZe3HJlK5A/meNYMotV4y
         na1W3U5r/eS6AsnMK+9eb27Z7QmO6/PMqQrOQ9hh1zdqYlCLOGMCbZcF7jilLfD6Von3
         Y1NTlFOryJ9eageFrQiklyB57UcRIyBynnsbGbSUOjEYil0QDT6aLLlJJaZ+KAmHPbVk
         ImsA==
X-Forwarded-Encrypted: i=1; AJvYcCVeXMA/Da+csGq7uukFyLthfsdesVB+M7z3o7off9rAYxGRhSsR7/lDd63xSegTbHAalEJ88UmNN0GUKIC0xjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcsHJ0VoivN2ZTDSdlCKXtl/1QE3u8E/2w6iqqjU1WgXVdb8I
	st+dc4wpfUfxDUeBfbvXIMxdHGdx4UnTtpzitfc56ShSmdB101P8DcOFo73Cpkgi1NbNiRst2EU
	UU0hFCZc21h/knaua5H4LTDjzPB/uS6I=
X-Gm-Gg: ATEYQzwbqV9HgEXaZe3AnWXB5jk9ViiJHgJFM45V8TezivdgsGfar9qSOjv7FYvJW1V
	otgzz64nZq/4jU9ipHpv9BwnweaT/Q9khRbj5O5E1XJ1iGXQLCDuh2QsZZlBOZitqhY0dSHA2kc
	lZTJLm18VDQBvrhtO2YJ/VYX7F3zrIEIwq/sl4etdWaPjxpijAUE1w+z0DkL0q7XYvpWYkByWa1
	2UeR/p7OT7ximS4RCHo9cPVMASj82n8xYRXwb96471f3l4Nr0KtlwZL6Dt0TV9IyMBuMLt1WJfY
	/hVyxKj2wDb2RYpshz7IZq7NJ10LfHaUqksualQSFLirKIwHnghAsWHFOWrr0WSkXmO+bo9qUBG
	e1JTZ
X-Received: by 2002:a05:690e:2406:b0:649:c36a:a9bb with SMTP id
 956f58d0204a3-64eaa7dd497mr3111845d50.61.1774029968854; Fri, 20 Mar 2026
 11:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320151958.851-1-sarveshwar.bajaj@nxp.com> <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 14:05:57 -0400
X-Gm-Features: AaiRm52Ok3B9z39WSAnIIsunfKvWBdOh0JLcRxkiskLb8gFRF8AIVXBOJh24Q8I
Message-ID: <CABBYNZJyr3-J1pVj_kGWLjjPn1_tYNhkYY9wEoahY-8s2kdWVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] test: Fix pbap-client to work with system
 bus obexd
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org, 
	vinit.mehta@nxp.com, devyani.godbole@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sarveshwar,

On Fri, Mar 20, 2026 at 11:37=E2=80=AFAM Sarveshwar Bajaj
<sarveshwar.bajaj@nxp.com> wrote:
>
> commit 765356e80262 ("obexd: Unregister profiles when the user is
> inactive") added support for running obexd on the system bus with
> --system-bus flag. However, test/pbap-client was not updated to
> match this change.
>
> As a result, pbap-client fails when obexd runs on the system bus and
> prints a NoReply error due to connecting over the session bus instead
> of the system bus.
>
> Fix by switching dbus.SessionBus() to dbus.SystemBus() and replacing
> deprecated GObject.MainLoop with GLib.MainLoop and removing the legacy
> GObject import fallback.
>
> Tested with obexd running with --system-bus and with a paired Bluetooth
> device.
> ---
>  test/pbap-client | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/test/pbap-client b/test/pbap-client
> index 6dada4a11..4ff301059 100755
> --- a/test/pbap-client
> +++ b/test/pbap-client
> @@ -8,10 +8,7 @@ import sys
>  import dbus
>  import dbus.service
>  import dbus.mainloop.glib
> -try:
> -  from gi.repository import GObject
> -except ImportError:
> -  import gobject as GObject
> +from gi.repository import GLib
>
>  BUS_NAME=3D'org.bluez.obex'
>  PATH =3D '/org/bluez/obex'
> @@ -31,7 +28,7 @@ class PbapClient:
>                 self.transfers =3D 0
>                 self.props =3D dict()
>                 self.flush_func =3D None
> -               bus =3D dbus.SessionBus()
> +               bus =3D dbus.SystemBus()

Are these tests supposed to work only over system bus though? Perhaps
we should attempt to detect it somehow, or actually deprecate
pbap-client since obexctl can problably do the same thing with a
script or something.

>                 obj =3D bus.get_object(BUS_NAME, session_path)
>                 self.session =3D dbus.Interface(obj, SESSION_INTERFACE)
>                 self.pbap =3D dbus.Interface(obj, PHONEBOOK_ACCESS_INTERF=
ACE)
> @@ -114,9 +111,8 @@ class PbapClient:
>  if  __name__ =3D=3D '__main__':
>
>         dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> -
> -       bus =3D dbus.SessionBus()
> -       mainloop =3D GObject.MainLoop()
> +       bus =3D dbus.SystemBus()
> +       mainloop =3D GLib.MainLoop()
>
>         client =3D dbus.Interface(bus.get_object(BUS_NAME, PATH),
>                                                         CLIENT_INTERFACE)
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
