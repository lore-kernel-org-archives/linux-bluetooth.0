Return-Path: <cyrus@holtmann.org>
Message-ID: <551BE5C2.3040101@gmail.com>
Date: Wed, 01 Apr 2015 14:34:10 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Multi-Advertising: implementation options, timing questions
References: <5515ECE9.9080101@gmail.com> <0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org> <55164DEC.6070009@gmail.com> <E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org> <5516AD7C.3040401@gmail.com> <CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com> <55188985.80001@gmail.com> <2F40B83E-682C-47A4-A7A3-BF2CDE2DA4D5@holtmann.org>
In-Reply-To: <2F40B83E-682C-47A4-A7A3-BF2CDE2DA4D5@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> See comment above, we can not really change legacy API.

Sure. I hoped that my proposal was just a change in implementation, not 
in behavior. But it doesn't seem to be an obvious improvement.

> It has to stay around for backwards compatibility. And that is why set advertising takes precedence over anything added by add advertising.

Yes, I understood that from the documentation of the mgmt api.

> What are you planning to verify here. The instance id is coming from userspace.

Oups. Seems so obvious but I overlooked it.

> Read up on what instance[0] actually does in a struct. We have used these constructs before. I am sensing that you misunderstood what this is for.

I think I understood what it does (struct hack?). I just didn't 
understand the intent of that field as it wasn't (yet) used anywhere in 
code. But I found it out in the meantime: You intend it to hold the 
currently occupied instance identifiers. I'll make sure it will be 
filled accordingly.

Thanks for your quick response!

Florian
