Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add conf file support
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
References: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 May 2011 17:39:58 -0700
Message-ID: <1306283998.2681.17.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This should reduce the amount of options which normally don't change
> each time obexd is executed.
> ---
>  Makefile.am   |    2 +-
>  plugins/ftp.c |    8 ++-
>  src/main.c    |  173 +++++++++++++++++++++++++++++++++++++++-----------------
>  3 files changed, 127 insertions(+), 56 deletions(-)

I do not want to have config file support for obexd.

Regards

Marcel


