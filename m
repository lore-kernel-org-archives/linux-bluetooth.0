Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <F0DE0097-7AD2-4C16-8A64-613495021AEB@holtmann.org>
References: <1402958640-1132-1-git-send-email-armansito@chromium.org>
	<1402958640-1132-5-git-send-email-armansito@chromium.org>
	<F0DE0097-7AD2-4C16-8A64-613495021AEB@holtmann.org>
Date: Wed, 18 Jun 2014 12:59:02 -0700
Message-ID: <CAHrH25QXfopPAeUbfkxkv0iuZLOnR8a2b1QSasWtR=0R4+OUXA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] src/shared/att: Handle incoming response PDUs
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I am still not buying this tail call optimization. However we might need =
to thing about how we can make sure we do not need this. It feels bad to me=
 every time I look at it. However this is not something that holds up mergi=
ng this patchset. It is just something that I prefer to get somehow worked =
out. Especially since I am afraid we have then similar issues in the whole =
codebase if this holds true. Maybe we need a magic gcc option.
>

To be honest, this doesn't make sense to me either. Any decent
compiler should be able to detect that a pointer to a local variable
is being passed to the tail call and determine not to pop the stack. I
don't really know why I've been getting these weird crashes; then
again, they stopped happening after I moved things around. It is a
mystery to me why the tail call actually made a difference, but for
now I'm removing the comment and the weird work around from the patch.
We can investigate later if this is actually an issue or has something
to do with the compiler configuration I'm building with.
