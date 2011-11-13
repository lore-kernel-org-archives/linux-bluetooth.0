Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321177515-2908-1-git-send-email-alon.barlev@gmail.com>
References: <1321177515-2908-1-git-send-email-alon.barlev@gmail.com>
Date: Sun, 13 Nov 2011 11:56:46 +0200
Message-ID: <CAOazyz2FAWxBAqwTR8JNvXXJ=JeufgF44QUYNByuN2cf=4yQxQ@mail.gmail.com>
Subject: Re: [PATCH] Support libtool-2
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Nov 13, 2011 at 11:45 AM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Replace now obsolete AC_PROG_LIBTOOL with LT_INIT if available.
> Add m4 aclocal directory where libtool will place its macros.

It would be nice to know why the following was added to configure.ac:
---
m4_define([_LT_AC_TAGCONFIG], [])
m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
---

What is the use case exactly?

Thanks,
Alon.
