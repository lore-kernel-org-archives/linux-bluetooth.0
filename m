Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGNu0TTWyAJVEPpPctY-=0JspHUUEgkHHnSgROvx_SV6JQ@mail.gmail.com>
References: <CAEZxfGOq_QkN65B=F_u+rb=6+O-4c=0dF0ZaDZ5t9D6nNtY2rw@mail.gmail.com>
 <CABBYNZ+XEFe1wp1Rr5TQ+SRsc0ZTRmZErYpvVQ=Txf2=a+EjGA@mail.gmail.com>
 <CAEZxfGO2WYCvwZUSpcn-ruULCAzPYuLt--yqP-PwyETK_dKnyg@mail.gmail.com> <CAEZxfGNu0TTWyAJVEPpPctY-=0JspHUUEgkHHnSgROvx_SV6JQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Jul 2016 12:23:20 +0300
Message-ID: <CABBYNZJQiX32CZ26Lpa-HsXDAGYWTfNNnaAOv34BsZm7Ey6tqQ@mail.gmail.com>
Subject: Re: Notify on succeeds while no apparent descriptor
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI François,

On Mon, Jul 18, 2016 at 11:52 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> For info, we'll track check for CCC descriptors at
> https://bugs.chromium.org/p/chromium/issues/detail?id=624763

Up to you, but we may as well just disallow that over D-Bus if we
don't have a reason to keep this policy, but then again this is a
reflection of stacks that don't manage notification themselves so
there is always a risk the application will not get these details
quite right breaking the notifications, if I were to enforce this I
would probably file an errata to the spec outlining the requirements
to support notification which may or may not end up allowing
unsolicited notifications/indications. Note that unsolicited
notifications may not be a bad idea since the implementation of CCC is
quite expensive given that it needs to be persisted, also for services
provided by application it may not be possible to restore the CCC
because the database may have changed.

Luiz Augusto von Dentz
