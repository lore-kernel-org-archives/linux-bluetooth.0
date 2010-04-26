Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <r2h2c3916b71004260229p48a39235m917ee7ebb0006efe@mail.gmail.com>
References: <r2h2c3916b71004260229p48a39235m917ee7ebb0006efe@mail.gmail.com>
Date: Mon, 26 Apr 2010 13:39:22 +0300
Message-ID: <x2z2c3916b71004260339j3cd86068g3b4adf5cd523c450@mail.gmail.com>
Subject: Re: no client session close in obexd 0.23?
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops, didn't notice the (also new) client method "RemoveSession"

Out of curiosity, what's the benefit of moving close/remove from
session scope to client scope?


On Mon, Apr 26, 2010 at 12:29 PM, Daniel Abraham
<daniel.shrugged@gmail.com> wrote:
> I noticed that the client session close method is missing in obexd 0.23
> (and also from the API document, so I guess it's intentional)
>
> So how can I trigger it?
>
> Thanks
>
