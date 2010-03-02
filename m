Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <aa6ee971003020826m7e6db9b2jd5b9456a1aa1d368@mail.gmail.com>
References: <aa6ee971003020826m7e6db9b2jd5b9456a1aa1d368@mail.gmail.com>
Date: Tue, 2 Mar 2010 14:14:10 -0300
Message-ID: <2a9506371003020914q3786eb70k57f5b1adda62c05@mail.gmail.com>
Subject: Re: Bluetooth SPP on Nokia N900 (Maemo 5)
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Henry Owens <owens.henry@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henry,

On Tue, Mar 2, 2010 at 1:26 PM, Henry Owens <owens.henry@googlemail.com> wrote:
> Hi All,
>
> My first mail to this list. I am currently trying to get a bluetooth
> SPP connection going on my Nokia N900, but I'm having some
> difficulties using the examples on the HOWTO Wiki.
>
> Specifically, I get an error related to the ActivateService call in
> the example - I have seen reference to this being obselete in Bluez
> 4.x, is this the problem in the example code?
>

Yeah, the example code in the wiki is outdated, take a look at the
example in the sources [1],
for a working one.

Also, in that same directory there are a few more examples that could be useful.


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

[1] http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=test/test-serial;hb=HEAD
