Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504601609.5928.3.camel@hadess.net>
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 05 Sep 2017 10:53:29 +0200
In-Reply-To: <20170905083534.19184-1-hadess@hadess.net>
References: <20170905083534.19184-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-09-05 at 10:35 +0200, Bastien Nocera wrote:
> GCC's "format-nonliteral" security check is enabled as an error in
> recent versions of Fedora. Given the reduced scope of use, mark the
> error as ignorable through pragma.
> 
> tools/csr_usb.c: In function 'read_value':
> tools/csr_usb.c:82:2: error: format not a string literal, argument
> types not checked [-Werror=format-nonliteral]
>   n = fscanf(file, format, &value);
>   ^

I also ran into this, which looks suspicious:
obexd/plugins/bluetooth.c: In function 'register_profile':
obexd/plugins/bluetooth.c:310:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
       profile->driver->port);
       ^~~~~~~
obexd/plugins/bluetooth.c:314:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
       profile->driver->name);
       ^~~~~~~
