Return-Path: <cyrus@holtmann.org>
Message-id: <B88DC7925BB14C2F8529CEC03B90B575@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <4ED4A576.8030102@globaledgesoft.com>
 <CABBYNZ+UP2o0-pL3FUAyrPeJi4JeNGR2Xj9DbB8FNWgYTyY9Tg@mail.gmail.com>
 <4ED4C45E.4090606@globaledgesoft.com>
 <4928F261E93B4ADD83272E364EF54224@sisodomain.com>
 <20111129135338.GA31479@x220>
 <CABBYNZLfMUuDpxbLDXkPOE_ebzeeToayMFsAmdOJorUq6LQ5Gw@mail.gmail.com>
In-reply-to: <CABBYNZLfMUuDpxbLDXkPOE_ebzeeToayMFsAmdOJorUq6LQ5Gw@mail.gmail.com>
Subject: Re: FTP file authorization and transfer progress support
Date: Wed, 30 Nov 2011 12:04:58 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan and Luiz

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Tuesday, November 29, 2011 7:46 PM
To: "Jaganath" <jaganath.k@samsung.com>; <linux-bluetooth@vger.kernel.org>
Subject: Re: FTP file authorization and transfer progress support

> Hi Jaganath,
>
> On Tue, Nov 29, 2011 at 3:53 PM, Johan Hedberg <johan.hedberg@gmail.com> 
> wrote:
>> Hi Jaganath,
>>
>> On Tue, Nov 29, 2011, Jaganath wrote:
>>> Currently in OBEXD, only OPP put has authorization and file progress
>>> indication. I am planning to implement the same in FTP put/get/delete 
>>> the
>>> same way as it does in OPP. But application may need to know the type of 
>>> the
>>> obex operation to which the Authorize method is invoked. So I am 
>>> planning to
>>> add a new method namely GetProperties in transfer, which returns the 
>>> type of
>>> the operation (put/get/delete) so that application can use it in 
>>> Authorize
>>> method. Please let me know your suggestions.
>>
>> We try to avoid such extra round-trips in our D-Bus APIs. If such a
>> feature is really needed the essential context information should be
>> provided as parameters to the "authorize" call.
>
> Im not so sure authorize here is really useful since FTP requires
> connection authorization anyway, we can create transfers if the
> purpose is to log them.

Thanks for your reply.
Even if FTP has connection authorization I think it is better to ask
file authorization for put/get/delete. This gives more flexibility to
application. It is up to application to decide whether to ask end user
or simply accept. Also in put case if a file with same filename is already
there, then this approach will be useful for application to handle that. 

