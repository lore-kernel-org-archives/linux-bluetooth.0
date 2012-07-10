Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 11:22:47 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v3 1/9] serial: remove the whole serial code
Message-ID: <20120710142247.GA728@x220>
References: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 10, 2012, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> ---
>  Makefile.am        |   19 +-
>  acinclude.m4       |    6 -
>  doc/serial-api.txt |   57 -----
>  serial/main.c      |   59 -----
>  serial/manager.c   |  127 -----------
>  serial/manager.h   |   25 --
>  serial/port.c      |  638 ----------------------------------------------------
>  serial/port.h      |   29 ---
>  serial/serial.conf |   10 -
>  9 files changed, 5 insertions(+), 965 deletions(-)
>  delete mode 100644 doc/serial-api.txt
>  delete mode 100644 serial/main.c
>  delete mode 100644 serial/manager.c
>  delete mode 100644 serial/manager.h
>  delete mode 100644 serial/port.c
>  delete mode 100644 serial/port.h
>  delete mode 100644 serial/serial.conf

All patches in this set have been applied. Thanks.

Seems that audio is still missing though.

Johan
