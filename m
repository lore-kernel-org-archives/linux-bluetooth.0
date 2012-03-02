Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330692190.20578.15.camel@novo.hadess.net>
References: <1330692190.20578.15.camel@novo.hadess.net>
Date: Fri, 2 Mar 2012 14:57:38 +0200
Message-ID: <CABBYNZKQWvNmTrqjKrkVKxeWGzVN9eV1KwkNXZChgUS6nSwydQ@mail.gmail.com>
Subject: Re: obexd 0.45 compilation problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Mar 2, 2012 at 2:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> Trying to compile obexd 0.45 with bluez-4.98, I get:
> btio/btio.c: In function 'get_key_size':
> btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'
>
> Do you need to either up the bluez dependency, or is obexd lagging?
>
> Install log:
> http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=root.log
> Compile log:
> http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=build.log

It is a known problem, until we are depending on a new release of
bluez (4.99) then we can add the build dependency properly, after that
we will probably have a new release for obexd as well.

-- 
Luiz Augusto von Dentz
