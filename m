Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DFB3E01-48C3-4F80-8040-6165B4456ABE@holtmann.org>
References: <1403123143-17543-1-git-send-email-armansito@chromium.org>
	<4DFB3E01-48C3-4F80-8040-6165B4456ABE@holtmann.org>
Date: Mon, 23 Jun 2014 06:13:14 -0700
Message-ID: <CAHrH25RGq=xzjrNqjGj1iTmbnnTZxkGxPgExSmrO5=tzQmVJPA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] bt_att initial implementation
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> However, you really need to use a proper compiler that gives you a decent=
 amount of warnings.
>
>   CC       src/shared/bluetoothd-att.o
> src/shared/att.c: In function =E2=80=98encode_pdu=E2=80=99:
> src/shared/att.c:194:2: error: label =E2=80=98dafault=E2=80=99 defined bu=
t not used [-Werror=3Dunused-label]
>   dafault:
>   ^
> src/shared/att.c: In function =E2=80=98handle_error_rsp=E2=80=99:
> src/shared/att.c:447:8: error: unused variable =E2=80=98result=E2=80=99 [=
-Werror=3Dunused-variable]
>   bool result;
>         ^
> src/shared/att.c: In function =E2=80=98handle_mtu_rsp=E2=80=99:
> src/shared/att.c:464:8: error: unused variable =E2=80=98result=E2=80=99 [=
-Werror=3Dunused-variable]
>   bool result;
>         ^
> src/shared/att.c: In function =E2=80=98bt_att_set_mtu=E2=80=99:
> src/shared/att.c:689:11: error: pointer targets in assignment differ in s=
ignedness [-Werror=3Dpointer-sign]
>   att->buf =3D buf;
>            ^
>
> I fixed them all up for you since they were dead simple fixes, but please=
 be a bit more careful for the next set of patches.
>

Thanks for doing that. I've been compiling for Chrome OS using the
portage based toolchain, which really just runs the included configure
scripts and compiles with gcc. I'll just explicitly stick in -Werror
somewhere next time.

Thanks!
Arman
