Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v4 4/4] src/shared/att: Handle incoming response PDUs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QXfopPAeUbfkxkv0iuZLOnR8a2b1QSasWtR=0R4+OUXA@mail.gmail.com>
Date: Mon, 23 Jun 2014 10:25:46 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <4049FA5C-5AF3-4F35-A7B1-F5DB75F51539@holtmann.org>
References: <1402958640-1132-1-git-send-email-armansito@chromium.org> <1402958640-1132-5-git-send-email-armansito@chromium.org> <F0DE0097-7AD2-4C16-8A64-613495021AEB@holtmann.org> <CAHrH25QXfopPAeUbfkxkv0iuZLOnR8a2b1QSasWtR=0R4+OUXA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I am still not buying this tail call optimization. However we might need to thing about how we can make sure we do not need this. It feels bad to me every time I look at it. However this is not something that holds up merging this patchset. It is just something that I prefer to get somehow worked out. Especially since I am afraid we have then similar issues in the whole codebase if this holds true. Maybe we need a magic gcc option.
>> 
> 
> To be honest, this doesn't make sense to me either. Any decent
> compiler should be able to detect that a pointer to a local variable
> is being passed to the tail call and determine not to pop the stack. I
> don't really know why I've been getting these weird crashes; then
> again, they stopped happening after I moved things around. It is a
> mystery to me why the tail call actually made a difference, but for
> now I'm removing the comment and the weird work around from the patch.
> We can investigate later if this is actually an issue or has something
> to do with the compiler configuration I'm building with.
> 

quick question, are you sending a new version without the tail call optimization fix or do you want me to apply this set?

Regards

Marcel

