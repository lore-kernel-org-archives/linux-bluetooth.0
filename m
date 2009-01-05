Return-Path: <cyrus@holtmann.org>
Message-ID: <54bbe4e00901051236i305cd062w513093bb24bf7c1e@mail.gmail.com>
Date: Mon, 5 Jan 2009 20:36:35 +0000
From: "Marcin Tolysz" <tolysz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] SBC Encoder program
Cc: "ext Christian Hoene" <hoene@uni-tuebingen.de>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901051522.25993.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com>
	 <1231158516.9401.3.camel@hoene-desktop>
	 <200901051522.25993.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I want to apologize  for my previous post :)

If what you want is to know is if there was an error & how much you red?
that it might not work as you cann't return two value at once (not this way).

But if you want to now if there was an error on first reading?

> @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t count)
>         while (count > 0) {
>                 len = read(fd, buf + pos, count);
>                 if (len <= 0)
-> -                       return len;
-> +                       return pos > len ? pos : len;
+                        return pos > 0 ? pos : len;
>
>                 count -= len;
>                 pos   += len;
this will return error code on first reading and the position
successfully red (i.e. before the error) on sequent readings. (all
assuming that pos==on entry)

You probably do not want to know the variant with position(=0) on the
first reading and error code on subsequent(before your patch)

Before your patch it was an error code all the time
After your patch it was the position all the time

Best Wishes
Marcin Tolysz
