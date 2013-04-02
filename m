Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1364943285-12463-7-git-send-email-lucas.demarchi@profusion.mobi>
References: <1364943285-12463-1-git-send-email-lucas.demarchi@profusion.mobi> <1364943285-12463-7-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 2 Apr 2013 20:39:02 -0300
Message-ID: <CAMOw1v6OF5a7FVG8wgEcZa+0OMqERNfoqRAZxusbKm=-49U_pg@mail.gmail.com>
Subject: Re: [RFC 6/6] obexd: Use gcc builtin instead of g_atomic
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 2, 2013 at 7:54 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> g_atomic_* end up using G_STATIC_ASSERT, causing gcc 4.8 to yell due to
> -Wunused-local-typedefs.
>
> /usr/include/glib-2.0/glib/gmacros.h:162:53: error: typedef ‘_GStaticAssertCompileTimeAssertion_2’ locally defined but not used [-Werror=unused-local-typedefs]
>  #define G_STATIC_ASSERT(expr) typedef char G_PASTE (_GStaticAssertCompileTimeAssertion_, __COUNTER__)[(expr) ? 1 : -1]
> ---

This patch was laying in my /tmp when I sent the patches. Please
ignore this one and use the other with subject "[RFC 5/6] obexd: Use
gcc builtin instead of g_atomic"

Sorry for the noise.

Lucas De Marchi
