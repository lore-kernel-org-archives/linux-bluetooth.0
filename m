Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikULKr_9PjxdxFDRoHQF04xLDdzBg@mail.gmail.com>
References: <BANLkTikULKr_9PjxdxFDRoHQF04xLDdzBg@mail.gmail.com>
Date: Mon, 11 Apr 2011 13:42:17 +0200
Message-ID: <BANLkTi=ZykM=UiWcpo+X+ZPOoozSXcukQA@mail.gmail.com>
Subject: Re: Bug report in Obex code
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Claudiu Coman <claud.coman@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 11, 2011 at 12:56 AM, Claudiu Coman <claud.coman@gmail.com> wrote:
> Hello,
>
> While doing some documentation for my GSOC application, I found a small
> bug in the Obex code, in src/obex.c, function "obex_write_stream".
> There's the declaration:
> "uint8_t hi;"
> If the "if" statement body between lines 640-648 is executed, after the jump
> to the "add_header" tag, the switch statement will test an
> uninitialized variable.
> At first I thought about sending a patch myself, but I don't know what value
> the header index variable should be initialized with.
>
> Cheers,
> Claudiu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

In this case, I'd say that for a quick fix setting it to OBEX_HDR_BODY will do.

However I believe that this if block doesn't actually do anything now. Does it?

I think it was needed for old folder listing support (introduced in
commit c42eff92a9c2c177f788dd1ec429250e64f69a78) when the ftp plugin
was using os->buf directly. It doesn't seem that anything uses this
approach any more. Also not a single piece of code using os->finished
(this was for some old PBAP version). I think we can get rid of this
code. What do you think, guys?

-- 
Slawomir Bochenski
