Return-Path: <cyrus@holtmann.org>
Message-ID: <54bbe4e00901051145w7fb30fc9xc2211c87b0fc97fa@mail.gmail.com>
Date: Mon, 5 Jan 2009 19:45:30 +0000
From: "Marcin Tolysz" <tolysz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] SBC Encoder program
Cc: "ext Christian Hoene" <hoene@uni-tuebingen.de>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901051718.44559.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <200901051522.25993.siarhei.siamashka@nokia.com>
	 <002701c96f43$dc833c90$9589b5b0$@de>
	 <200901051718.44559.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/1/5 Siarhei Siamashka <siarhei.siamashka@nokia.com>:
> On Monday 05 January 2009 16:42:39 ext Christian Hoene wrote:
>> > There are some parts that look a bit redundant/suspicious:
>> > > @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t
>> > > count) while (count > 0) {
>> > >                 len = read(fd, buf + pos, count);
>> > >                 if (len <= 0)
>> > > -                       return len;
>> > > +                       return pos > len ? pos : len;
>> > >
>> > >                 count -= len;
>> > >                 pos   += len;
>> >
>> > Is the ternary '?' operator really needed here? In this part of code we
>> > know for sure that 'len' is less or equal to zero, also 'pos ' is a
>> > positive number or zero. Having just 'return pos' should be enough.
>>
>> No. If read returns an error, the this error is passed to __read, too.
>
> I mean that 'return pos > len ? pos : len' and 'return pos' expressions are
> completely interexchangeable in this context.
>

I wonder if you
shouldn't check before you read if position is not exceeding the length?

+                   if (pos > len)  // if we are beyond end then why
bother to read more
+                         return pos;

>                 len = read(fd, buf + pos, count);
>                 if (len <= 0)
+                        return len; //to report an error
-> -                       return len;
-> +                       return pos > len ? pos : len;
and as position is always >0 and len < 0 in this place it would always
be reduced to pos
>
>                 count -= len;
>                 pos   += len;

Best wishes
Marcin Tolysz
