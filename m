Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=Windows-1252;
 reply-type=original
Message-id: <5D61CDA944344E1594934D74E325448D@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
 <CABBYNZLWnOZZGWHb5dwbbAt9pQXxdYz7ULn7JYx9mmbhBs3phQ@mail.gmail.com>
 <CABBYNZLGm+AhfdhUHJv33cQvxGpznGmneetQX-6zPRFb26yO6Q@mail.gmail.com>
Subject: Re: [PATCH obexd v1 1/4] build: BlueZ version 4.100 or later is
 required
Date: Thu, 23 Aug 2012 21:21:05 +0530
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
----- Original Message ----- 
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Thursday, August 23, 2012 7:42 PM
Subject: Re: [PATCH obexd v1 1/4] build: BlueZ version 4.100 or later is 
required


> Hi Syam,
>
> On Thu, Aug 23, 2012 at 5:04 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Syam,
>>
>> On Wed, Aug 22, 2012 at 7:35 PM, Syam Sidhardhan <s.syam@samsung.com> 
>> wrote:
>>> If we use the BlueZ version less than 4.100, then the following
>>> compilation error happens.
>>>
>>> Error:
>>> ======
>>> btio/btio.c: In function ‘l2cap_connect’:
>>> btio/btio.c:301:6: error: ‘struct sockaddr_l2’ has no member named
>>>  ‘l2_bdaddr_type’
>>> btio/btio.c: In function ‘parse_set_opts’:
>>> btio/btio.c:707:19: error: ‘BDADDR_BREDR’ undeclared (first use in
>>>  this function)
>>> btio/btio.c:707:19: note: each undeclared identifier is reported only
>>>  once for each function it appears in
>>> make[1]: *** [btio/btio.o] Error 1
>>> make: *** [all] Error 2
>>> ---

>>
>> Strange I don't get this error with 4.99, anyway I guess it is fine to
>> bump 4.100


May be in your case bluetooth.h installed at different path.
You will get this error with BlueZ 4.99 as the changes related to 
sockaddr_l2 is added after
4.99 release. commit id: ba801fcd67e4fa5169e8c8b73fd87b6c08fca335.

>
> Patches 1,3 and 4 are now upstream, for the issue about glib Im
> figuring out how to fix it properly.
>

Regarding the glib issue, either we have to bump Glib 2.32 or fix it with an 
extra
variable similar to what Johan did for BlueZ. No other methods comes into my
mind. If you are ok with resolving the issue with an extra variable, then 
I'm ready to
send a patch. PLMKO.

Thanks for applying other patches.

Regards,
Syam. 

