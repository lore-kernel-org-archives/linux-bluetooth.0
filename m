Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKx=YWwA3y9LxG1yScByxXS2C9nhgjCpuXtkVVyMEmCjA@mail.gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
 <CAMOw1v6DkURj+MVoA99=E7Nihe3_97O5Dh2b+94WSnVM4Yixxg@mail.gmail.com> <CABBYNZKx=YWwA3y9LxG1yScByxXS2C9nhgjCpuXtkVVyMEmCjA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 11:49:25 -0300
Message-ID: <CAMOw1v67cXYEWFYQznVR7Gj6zbKodOmQSOr5hZ=4XpXrkq6b_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] AVRCP: use a vtable to simplify PDU parsing/handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 12, 2011 at 11:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Sep 12, 2011 at 4:25 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> It might be my CFLAGS, but aren't you getting warnings of unused
>> parameters since now every handler carries the transaction id?
>
> Nope and Im not sure why checking unused parameter would be a nice
> thing to have, specially dummy callbacks normally ignores some/all the
> parameters.
>

Right, I've just checked the file acinclude.m4 and BlueZ uses
"-Wno-unused-parameter" in its CFLAGS.

It's fine, then.


Lucas De Marchi
