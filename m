Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49525632
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503774; cv=none; b=pZ76uakIrxGAkvsO+g+EwEp1nKFj6OAcnYkg9VpFLCK+cY0XoPCM2+rxc+4J+zAh89vK8VWthxrGS33kNFawfa4avnQRINlgbhhAdEYrdkzy6tZZs33cbUZiEM7hkAzc0sgtPhaPeZIqXLaZYrVglYxNMbp9vfKsMCWb93ssqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503774; c=relaxed/simple;
	bh=QkHmI2N6maPwp8uMSV2r9LyJJaFfzOzq3Lq/2ES2n4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzhFPzlnePCXyeHGPmiNBTGAlpzFkD9UQkWomGEuOFZPefl3EXaVNHRDhUSZjPXp91g157aTWVIBWBU/i9XZvciCIdIz+E8DvVEGN2odtfR/kcndEk4PJiyLV/fgYG2SwBmPqMq3M3hb+XSI0FPxVP8eHWhDMu4/PptfhTC8FbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV0DHaEV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV0DHaEV"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f78b28ddb6so39396281fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726503771; x=1727108571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o+LpTmJOOgOI1O9t7SeMmiCfzjEk4FIeJ8+Tp0tG7I=;
        b=eV0DHaEVqF9cQk58HRMjbfMn66RXNF4uatzAUR9epo9ZG/mQtPV4tP1A6FQO9Nxejg
         e+oewey07LwzIhYJADniLj8cIkMBT7mnuhQy8Botw/WzYAxAfSmHX9AjNAqichM1JSt7
         qNv3Hsi2II/zdh7QvStj9lYhIZ9DIRw3ia1EuXW8Vy5Z3tjYyB7ADBTCf6qoCJnfXN2Z
         aMWrB4eZmczg1QMj4QWGTvaQy5p/sciMausd5aYH5Iu7vhFRDxCWH6MERiWiezZ0gu21
         BtowOGUXQb4Vs6K1yLHu6xDGN6lElvix8wUTyjjxvJgMbuVUcS5q8xNXs1vZyLFhRN9R
         Hswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503771; x=1727108571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o+LpTmJOOgOI1O9t7SeMmiCfzjEk4FIeJ8+Tp0tG7I=;
        b=doSWFksXATlVwYe9DovjaBTZVxZJBovwjpr6dRAbeoBqw/H3Gjsmc3dPc1dBz83Vs2
         nvHSjbY49Iu6UkCAtQWA2GHCQWTintmOryzczhwyY0n7OOcsDRovnwQtqrNLV31fOnFy
         hRhioA8kku9s17NmLR8tzTwK6QlIF9b1NT7yPBp6bGGeKAu+485MvbexgXUIHFiBEHn2
         gtUEQklpYDyP54/yCJNVh+H1WhL6RR6BaSE+y5u9GmcpUbZNqzYv4s+BA+SkbAF4bgpV
         XrIEfJQpARTwbv3vhEGpfCqScWMWvGGSBS9FBpOf0TC3XAWoeZr2poB8Px/2gBYClnos
         +WhQ==
X-Gm-Message-State: AOJu0YxtAMS1ON+wNTIj6tKVyxsqcVpKBD7gNhxMxbS/3qTuSjUDOOdx
	0QqOEYGo6C3LkwDzAe6faaxjWructN38bUamUZEdfSKn9AIhds/iGwQYfmbH5W5cYIifPlmrCDN
	fMCsjPeOwha4tgkRJ6V+CjJC1igY=
X-Google-Smtp-Source: AGHT+IH8/9iC/LV4A0sT2aq+skjQAU8FqqI7SPy58vI1LWNK+9ckoQWUgVUEiYwKm3EH+COYvA/bvJ4ZFKy4goLZpBg=
X-Received: by 2002:a05:651c:2c9:b0:2f3:a06a:4c5 with SMTP id
 38308e7fff4ca-2f787f2fc40mr60385081fa.29.1726503770266; Mon, 16 Sep 2024
 09:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
 <CABBYNZ+YMC856CdhETpCM9u4OYeO5+R+3hSbgigLszVaa+UPQQ@mail.gmail.com>
 <098e9614-7a88-405c-8fb4-e13bc4f40efc@gmail.com> <5f11a98c-9f41-44a4-9e30-df33b8a0560e@gmail.com>
In-Reply-To: <5f11a98c-9f41-44a4-9e30-df33b8a0560e@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Sep 2024 12:22:36 -0400
Message-ID: <CABBYNZ+fm3y4NXc1WTjoc6E-ZiSeVeADgGsmRjuOEU7FjdL4pA@mail.gmail.com>
Subject: Re: [PATCH bluez v2] monitor: fix buffer overflow when terminal width
 > 255
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 16, 2024 at 11:57=E2=80=AFAM Celeste Liu <coelacanthushex@gmail=
.com> wrote:
>
>
> On 2024-09-16 23:39, Celeste Liu wrote:
> >
> > On 2024-09-16 23:10, Luiz Augusto von Dentz wrote:
> >> Hi Celeste,
> >>
> >> On Sat, Sep 14, 2024 at 12:10=E2=80=AFPM Celeste Liu <coelacanthushex@=
gmail.com> wrote:
> >>>
> >>> In current code, we create line buffer with size 256, which can conta=
ins
> >>> 255 ASCII characters. But in modern system, terminal can have larger
> >>> width. It may cause buffer overflow in snprintf() text.
> >>>
> >>> We need allocate line buffer with size which can contains one line in
> >>> terminal. The size should be difficult to calculate because of multib=
yte
> >>> characters, but our code using line buffer assumed all characters has
> >>> 1 byte size (e.g. when we put packet text into line buffer via
> >>> snprintf(), we calculate max size by 1B * col.), so it's safe to
> >>> allocate line buffer with col + 1.
> >>>
> >>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Add free() forgot in v1.
> >>> - Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overfl=
ow-v1-1-733cb4fff673@gmail.com
> >>> ---
> >>>  monitor/packet.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/monitor/packet.c b/monitor/packet.c
> >>> index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff2=
24454ac3fa593cd8221 100644
> >>> --- a/monitor/packet.c
> >>> +++ b/monitor/packet.c
> >>> @@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, stru=
ct ucred *cred, char ident,
> >>>                                         const char *text, const char =
*extra)
> >>>  {
> >>>         int col =3D num_columns();
> >>> -       char line[256], ts_str[96], pid_str[140];
> >>> +       char ts_str[96], pid_str[140];
> >>> +       char *line =3D (char *) malloc(sizeof(char) * col + 1);
> >>
> >> Perhaps we could replace malloc with alloca here so we allocate the
> >> line on the heap rather than stack.
> >
> > I will replace it with alloca() in the next version.
> > But to be honest, I think alloca() is not a good choice. The compiler w=
ill
> > prevent the functions that call alloca() be inline, otherwise it may tr=
igger
> > unexpected stack overflow because it's not a scope-based lifetime. It m=
ay be
> > better to replace it with VLA once we bump the standard requirement to =
C99 or
> > above.
>
> But I found a VLA usage in monitor/display.h:82, which was introduced by =
Marcel Holtmann
> in d9e3aab39d2af7d7a822993ededaa41cd0311c53 in 2012. Could we use VLA dir=
ectly? Or we
> need to treat that usage as a bug and fix it?

Afaik VLA has more problems than using alloca, because depending on
the C (11-23) version VLA is optional, so afaik alloca is a safer
option provided the length is not considered too big, anyway perhaps
we should use some define like LINE_MAX instead:

       {LINE_MAX}
             Unless otherwise noted, the maximum length, in bytes, of a
             utility's input line (either standard input or another
             file), when the utility is described as processing text
             files. The length includes room for the trailing <newline>.
             Minimum Acceptable Value: {_POSIX2_LINE_MAX}
https://www.man7.org/linux/man-pages/man0/limits.h.0p.html

So something like the following:

diff --git a/monitor/packet.c b/monitor/packet.c
index c2599fe6864a..32a440bbea68 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -26,6 +26,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/socket.h>
+#include <limits.h>

 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
@@ -376,7 +377,7 @@ static void print_packet(struct timeval *tv,
struct ucred *cred, char ident,
                                        const char *text, const char *extra=
)
 {
        int col =3D num_columns();
-       char line[256], ts_str[96], pid_str[140];
+       char line[LINE_MAX], ts_str[96], pid_str[140];
        int n, ts_len =3D 0, ts_pos =3D 0, len =3D 0, pos =3D 0;
        static size_t last_frame;

> >
> >>
> >>>         int n, ts_len =3D 0, ts_pos =3D 0, len =3D 0, pos =3D 0;
> >>>         static size_t last_frame;
> >>>
> >>> @@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, stru=
ct ucred *cred, char ident,
> >>>                 printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", =
ts_str);
> >>>         } else
> >>>                 printf("%s\n", line);
> >>> +       free(line);
> >>>  }
> >>>
> >>>  static const struct {
> >>>
> >>> ---
> >>> base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
> >>> change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8
> >>>
> >>> Best regards,
> >>> --
> >>> Celeste Liu <CoelacanthusHex@gmail.com>
> >>>
> >>>
> >>
> >>
>


--=20
Luiz Augusto von Dentz
