Return-Path: <cyrus@holtmann.org>
Message-ID: <4ED5D11D.1040709@codeaurora.org>
Date: Tue, 29 Nov 2011 22:45:49 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Jaganath <jaganath.k@samsung.com>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: FTP file authorization and transfer progress support
References: <4ED4A576.8030102@globaledgesoft.com> <CABBYNZ+UP2o0-pL3FUAyrPeJi4JeNGR2Xj9DbB8FNWgYTyY9Tg@mail.gmail.com> <4ED4C45E.4090606@globaledgesoft.com> <4928F261E93B4ADD83272E364EF54224@sisodomain.com> <20111129135338.GA31479@x220> <CABBYNZLfMUuDpxbLDXkPOE_ebzeeToayMFsAmdOJorUq6LQ5Gw@mail.gmail.com> <B88DC7925BB14C2F8529CEC03B90B575@sisodomain.com>
In-Reply-To: <B88DC7925BB14C2F8529CEC03B90B575@sisodomain.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On 11/29/2011 10:34 PM, Jaganath wrote:
> From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
>> On Tue, Nov 29, 2011 at 3:53 PM, Johan Hedberg
>> <johan.hedberg@gmail.com> wrote:
>>> On Tue, Nov 29, 2011, Jaganath wrote:
>>>> Currently in OBEXD, only OPP put has authorization and file progress
>>>> indication. I am planning to implement the same in FTP
>>>> put/get/delete the
>>>> same way as it does in OPP. But application may need to know the
>>>> type of the
>>>> obex operation to which the Authorize method is invoked. So I am
>>>> planning to
>>>> add a new method namely GetProperties in transfer, which returns the
>>>> type of
>>>> the operation (put/get/delete) so that application can use it in
>>>> Authorize
>>>> method. Please let me know your suggestions.
>>>
>>> We try to avoid such extra round-trips in our D-Bus APIs. If such a
>>> feature is really needed the essential context information should be
>>> provided as parameters to the "authorize" call.
>>
>> Im not so sure authorize here is really useful since FTP requires
>> connection authorization anyway, we can create transfers if the
>> purpose is to log them.
>
> Thanks for your reply.
> Even if FTP has connection authorization I think it is better to ask
> file authorization for put/get/delete. This gives more flexibility to
> application. It is up to application to decide whether to ask end user
> or simply accept. Also in put case if a file with same filename is already
> there, then this approach will be useful for application to handle that.

I think you may be confusing use cases.

If you are an FTP server, you are giving authorized remote users blanket 
authority to read, write or browse, or some combination, your exposed 
FTP file system.  I suppose you could require additional 
operation-by-operation request/confirm, but that would quickly make the 
system very clumsy. It's not the usage model that FTP was designed for.

That is why we have the OPP profile, which is specifically for single 
object sharing, and that has that kind of request/confirm model.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
