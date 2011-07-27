Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
References: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 27 Jul 2011 15:05:43 -0500
Message-ID: <CAB7rCTihq=vZBhUSNvFuJmtEPU_OOCABXugZKVTnFe61TkaGMQ@mail.gmail.com>
Subject: Re: [PATCH] Fix compilation with --disable-sap and glib < 2.28
From: Mike <puffy.taco@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> +#include <bluetooth/sdp.h>

I must be missing something, because I'm trying to compile from git
(d7f192a) and I get an error "audio/telephony-ofono.c:38: fatal error:
bluetooth/sdp.h: No such file or directory".  I was previously
compiling bluez 4.94 just fine.  Ideas?

Mike
