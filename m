Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2a72630552.davehigton@dsl.pipex.com>
References: <1312990866.4e42a6925110a@netmail.pipex.net> <5B4B9A479BF6994B88EA975675EC5B790580AC7068@MES1OS2SXC003.mes1.tconet.net>
 <2a72630552.davehigton@dsl.pipex.com>
From: Ash K <ashoksarf@gmail.com>
Date: Mon, 22 Aug 2011 02:43:51 +0530
Message-ID: <CAMhHtTyp80q97Ue-UcPaRBYfzjSs1eSbh0h-40a9hUJcPSdNeg@mail.gmail.com>
Subject: Re: Bluetooth encryption algorithms
To: Dave Higton <davehigton@dsl.pipex.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Spec has dedicated sections for sample data:

For Core, you have sample data in Volume 2, Part G
For LE, you have sample data in Volume 6, part C.

As I said before if you are using a 2.1 or below controller,
authentication and encryption would be done in controller. If it is
4.0 authentication is performed in host using SMP and encryption is
done in controller.

If you are implementing controller functionality, the sample data in
spec would be enough!


On Sat, Aug 20, 2011 at 2:43 AM, Dave Higton <davehigton@dsl.pipex.com> wrote:
> In message <5B4B9A479BF6994B88EA975675EC5B790580AC7068@MES1OS2SXC003.mes1.tconet.net>
>          "Cufi, Carles" <carles.cufi@nordicsemi.no> wrote:
>
>> Hi there,
>> > So if anyone can point me to sources of information detailed and
>> > explicit enough to show me how Bluetooth encryption and decryption are
>> > done, I would very much appreciate it.  I have the Bluetooth core
>> > specification, but I'm not confident that I can implement correctly from
>> > it alone.  I'm also looking for test data, ideally for each step through
>> > each algorithm.
>>
>> Just register with bluetooth.org and get the Core Spec v4.0. All the
>> information you need is there.
>>
>> https://www.bluetooth.org/Technical/Specifications/adopted.htm
>
> Like I said in the bit you quoted, I have the specification (I have
> Core Spec v4.0, although I didn't specifically say that).  At least
> I have, since I first posted, found the test data - I was almost sure
> I'd seen them before, but I couldn't find them via the index.  I saw
> them by accident when browsing for something else.  (Encryption test
> data not in the Security section... who'd have thought it?)
>
> I'm still hoping for something more tutorial or explanatory, but if
> I can't find anything, at least the test data will give me more
> confidence to try implementing from the specification.
>
> Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ash
