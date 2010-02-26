Return-Path: <cyrus@holtmann.org>
Message-ID: <4b87e4aa.1408c00a.502e.056f@mx.google.com>
MIME-Version: 1.0
From: Bao Liang <tim.bao@gmail.com>
Subject: Re: [PATCH] Allow disable park state in main.conf
Date: Fri, 26 Feb 2010 23:11:37 +0800
To: Johan Hedberg <johan.hedberg@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your comment . The reason I do this is that only park mode makes=
 trouble when used  by certain models as far as I know . But I'm open to  m=
ake this parameter an hex value if it make more sense .

----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Johan Hedberg <johan.hedberg@gmail.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2010=E5=B9=B42=E6=9C=8826=E6=97=A5 22=
:38
=E6=94=B6=E4=BB=B6=E4=BA=BA: Liang Bao <tim.bao@gmail.com>; marcel@holtmann=
.org
=E6=8A=84=E9=80=81: linux-bluetooth@vger.kernel.org
=E4=B8=BB=E9=A2=98: Re: [PATCH] Allow disable park state in main.conf

Hi,

On Fri, Feb 26, 2010, Liang Bao wrote:
> Currently BlueZ is hard-coding the default link policy to include
> hold mode, role switch, sniff mode and park state. However, some
> device will have problem to maintain the connection or setup SCO
> if they are in park state. Making the park state configurable in
> main.conf improves flexibility so it can be disabled when needed.
>=20
> Signed-off-by: Tim Bao <tim.bao@gmail.com>
> ---
>  src/main.c    |   13 +++++++++----
>  src/main.conf |    5 +++++
>  2 files changed, 14 insertions(+), 4 deletions(-)

In principle the patch looks ok to me, however we might want to discuss
a little bit about the naming of the parameter in the config file and
its possible values. E.g. would it make sense to be able to define the
link policy more flexibly than just toggling park mode on and off.
Marcel, do you have any thoughts on this?

Johan
