Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <551BD9BD.9040501@message-id.googlemail.com>
References: <551BD9BD.9040501@message-id.googlemail.com>
Date: Wed, 1 Apr 2015 15:08:00 +0300
Message-ID: <CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
Subject: Re: unit/test-gatt broken again (as always :-)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Wed, Apr 1, 2015 at 2:42 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi all,
>
> in bluez-5.30, the testsuite again does not complete with
>
> MALLOC_CHECK_=3 MALLOC_PERTURB_=69 make check
>
> Valgrind complains about a use-after-free.
>
> I simply bisected the issue, this is the broken commit.
>
> commit 9a0d6d99c79e5cecb76b7a61b53556447f0ccbd1
> Author: Gowtham Anandha Babu <gowtham.ab@samsung.com>
> Date:   Thu Mar 26 18:29:06 2015 +0530
>
>     unit/test-gatt: Add TP/GAW/CL/BV-05-C test
>
>     Verify that a Generic Attribute Profile client can write a long
>     Characteristic Value selected by handle.
>
> This is on plain x86_64, gcc-4.8.3 (old)

This is actually a fault in our code that the test uncovered which is
good but we failed to see it happening, I actually have some plans to
have a check-valgrind target to catch this type of problems or maybe
there is a way to add MALLOC_CHECK_=3 MALLOC_PERTURB_=69 directly.


-- 
Luiz Augusto von Dentz
