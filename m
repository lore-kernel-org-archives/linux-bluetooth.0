Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812301246.25781.siarhei.siamashka@nokia.com> <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com> <1231158516.9401.3.camel@hoene-desktop> <200901051522.25993.siarhei.siamashka@nokia.com>
In-Reply-To: <200901051522.25993.siarhei.siamashka@nokia.com>
Subject: RE: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 15:42:39 +0100
Message-ID: <002701c96f43$dc833c90$9589b5b0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> There are some parts that look a bit redundant/suspicious:
> 
> > @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t count)
> >         while (count > 0) {
> >                 len = read(fd, buf + pos, count);
> >                 if (len <= 0)
> > -                       return len;
> > +                       return pos > len ? pos : len;
> >
> >                 count -= len;
> >                 pos   += len;
> 
> Is the ternary '?' operator really needed here? In this part of code we know
> for sure that 'len' is less or equal to zero, also 'pos ' is a positive number
> or zero. Having just 'return pos' should be enough.

No. If read returns an error, the this error is passed to __read, too.

> > @@ -188,6 +188,8 @@ static void encode(char *filename, int subbands, int
> > bitpool, int joint,
> >
> >                 len = sbc_encode(&sbc, input, size,
> >                                         output, sizeof(output), &encoded);
> > +               if (len <= 0)
> > +                       break;
> >                 if (len < size)
> >                         memmove(input, input + len, size - len);
> 
> If the return value is negative, there was some error. Probably showing some
> kind of error message is appropriate here instead of just silently bailing
> out.

Yes, if len is -1 then errno depended message shall be printed and the program should quit.


CH



