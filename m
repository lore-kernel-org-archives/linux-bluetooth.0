Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 15:22:25 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com> <1231158516.9401.3.camel@hoene-desktop>
In-Reply-To: <1231158516.9401.3.camel@hoene-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901051522.25993.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 14:28:36 ext Christian Hoene wrote:
> On Mon, 2009-01-05 at 09:22 -0300, Luiz Augusto von Dentz wrote:
> > Hi Christian
> >
> > > Yes, there was a bug in the encoder program. Attached the patch.
> > >
> > > Greetings
> > >  Christian
> >
> > Coding style:
> >
> > return pos > len ? pos : len;
>
> Thanks. I corrected it and even found another bug.
>
> Attached the new and corrected patch.

There are some parts that look a bit redundant/suspicious:

> @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t count)
>         while (count > 0) {
>                 len = read(fd, buf + pos, count);
>                 if (len <= 0)
> -                       return len;
> +                       return pos > len ? pos : len;
>
>                 count -= len;
>                 pos   += len;

Is the ternary '?' operator really needed here? In this part of code we know
for sure that 'len' is less or equal to zero, also 'pos ' is a positive number
or zero. Having just 'return pos' should be enough.

> @@ -188,6 +188,8 @@ static void encode(char *filename, int subbands, int
> bitpool, int joint,
>
>                 len = sbc_encode(&sbc, input, size,
>                                         output, sizeof(output), &encoded);
> +               if (len <= 0)
> +                       break;
>                 if (len < size)
>                         memmove(input, input + len, size - len);

If the return value is negative, there was some error. Probably showing some
kind of error message is appropriate here instead of just silently bailing
out.

-- 
Best regards,
Siarhei Siamashka
