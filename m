Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH BlueZ 2/2] build-sys: Don't build gdbus several times
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1372854560-8731-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 18 Jul 2013 07:44:14 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7ECE8CDC-42C6-4D2E-91C5-D88956259A54@holtmann.org>
References: <1372854560-8731-1-git-send-email-lucas.demarchi@profusion.mobi> <1372854560-8731-2-git-send-email-lucas.demarchi@profusion.mobi>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> We are currently compiling gdbus 3 times: one for tests, one for
> bluetoothd and another for obexd.
> 
> $ ls gdbus/*watch.o
> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
> 
> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
> a convenience library.
> ---
> Makefile.am    | 16 +++++++++++-----
> Makefile.obexd |  5 +++--
> Makefile.tools | 29 +++++++++++++++--------------
> 3 files changed, 29 insertions(+), 21 deletions(-)

patch has been applied.

Regards

Marcel

