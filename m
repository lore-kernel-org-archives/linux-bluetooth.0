Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix compilation when --enable-test is passed
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268089292-18303-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1268089292-18303-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 16:35:48 -0800
Message-ID: <1268094948.3712.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> When --enable-test is passed along with --disable-alsa and
> --disable-gstreamer, the SBC lib is not built, which breaks
> compilation of the ipctest test program.
> ---
>  acinclude.m4 |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


