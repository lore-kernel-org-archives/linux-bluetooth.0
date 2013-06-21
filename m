Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH BlueZ v3 1/5] build-sys: Don't build gdbus several times
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 21 Jun 2013 18:02:23 -0400
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ED8EF8E2-B635-404D-A328-2DCC55EEBCA7@holtmann.org>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> We are currently compiling gdbus 3 times: one for tests, one for
> bluetoothd and another for obexd.

we recompile because of the different CFLAGS for these binaries.

> $ ls gdbus/*watch.o
> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
> 
> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
> a convenience library.

When we switched to non-recursive build, we stopped building interim libraries. What is the benefit of going back to building them. I am personally fine with building gdbus several times.

Regards

Marcel

