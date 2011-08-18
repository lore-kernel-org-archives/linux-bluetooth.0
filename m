Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
Date: Thu, 18 Aug 2011 10:11:03 +0300
Message-ID: <CABBYNZLMe5wAOcQGX_3zkArygObhL3muQLgM_BOLc2UuX3x_Mg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] Initial VDP implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, Aug 16, 2011 at 4:43 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
> ---
>  Makefile.am |    1 +
>  audio/vdp.c | 2026 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  audio/vdp.h |  112 ++++
>  3 files changed, 2139 insertions(+), 0 deletions(-)
>  create mode 100644 audio/vdp.c
>  create mode 100644 audio/vdp.h
>

This is pretty much a duplicate of a2dp.{c,h}, so it would be nice to
have this in a common file e.g. sep.{c,h} as suggested last time.

-- 
Luiz Augusto von Dentz
