Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511532398.11411.8.camel@hadess.net>
References: <20171102140953.21684-1-hadess@hadess.net> <20171102140953.21684-2-hadess@hadess.net>
 <1511532398.11411.8.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Nov 2017 16:48:04 +0200
Message-ID: <CABBYNZ+SJ0maQVjyfxgawvqiV6z-RrpYaCwb0cdCQpw5dzvMuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] obex: Work-around compilation failure
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Nov 24, 2017 at 4:06 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-11-02 at 15:09 +0100, Bastien Nocera wrote:
>> obexd/plugins/bluetooth.c: In function 'register_profile':
>> obexd/plugins/bluetooth.c:310:7: error: format not a string literal,
>> argument types not checked [-Werror=format-nonliteral]
>>        profile->driver->port);
>>        ^~~~~~~
>> obexd/plugins/bluetooth.c:314:7: error: format not a string literal,
>> argument types not checked [-Werror=format-nonliteral]
>>        profile->driver->name);
>>        ^~~~~~~
>
>
> And so does this one.

I really hope we can avoid GCC specific pragmas, there got to be a
better way avoid this error or just disable
-Werror=format-nonliteral, actually is that our error or
g_markup_printf_escaped?

-- 
Luiz Augusto von Dentz
