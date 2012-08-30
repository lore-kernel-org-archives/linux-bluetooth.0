Return-Path: <cyrus@holtmann.org>
Message-ID: <1346339333.23377.10.camel@aeonflux>
Subject: Re: [PATCH BlueZ] build: Use AC_USE_SYSTEM_EXTENSIONS for POSIX/C
 extensions
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Aug 2012 08:08:53 -0700
In-Reply-To: <1346332740-29319-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346332740-29319-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Using this macro in configure.ac enables certain extensions that BlueZ
> currently depends on. The macro is recommended instead of defining
> _GNU_SOURCE on each C file.

what is the advantage of this. I am actually fine with using _GNU_SOURCE
in the C files. It is according to the man pages.

Regards

Marcel


