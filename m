Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511532398.11411.8.camel@hadess.net>
Subject: Re: [PATCH 2/2] obex: Work-around compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 24 Nov 2017 15:06:38 +0100
In-Reply-To: <20171102140953.21684-2-hadess@hadess.net>
References: <20171102140953.21684-1-hadess@hadess.net>
         <20171102140953.21684-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-11-02 at 15:09 +0100, Bastien Nocera wrote:
> obexd/plugins/bluetooth.c: In function 'register_profile':
> obexd/plugins/bluetooth.c:310:7: error: format not a string literal,
> argument types not checked [-Werror=format-nonliteral]
>        profile->driver->port);
>        ^~~~~~~
> obexd/plugins/bluetooth.c:314:7: error: format not a string literal,
> argument types not checked [-Werror=format-nonliteral]
>        profile->driver->name);
>        ^~~~~~~


And so does this one.
