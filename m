Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKcTf+86cJXTzrGSeSUDGXb0fZHV_Tvb_9uziqghvZqgQ@mail.gmail.com>
References: <20170811125815.964-1-luiz.dentz@gmail.com> <87shgxev4u.fsf@intel.com>
 <CABBYNZKcTf+86cJXTzrGSeSUDGXb0fZHV_Tvb_9uziqghvZqgQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Aug 2017 12:42:53 +0300
Message-ID: <CABBYNZ+UaeQGYOb1N8P1STd_=JcT0CkdD6pNSi0==EhufLrDHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix calling GetAll while GetManagedObject is pending
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Aug 14, 2017 at 11:23 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Vinicius,
>
> On Fri, Aug 11, 2017 at 10:56 PM, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> Hi Luiz,
>>
>> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>>
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> If proxies are created while the client is not ready put them into a
>>> pending list so only if they are not found in GetManagedObject reply
>>> call GetAll.
>>
>> I tested this with a hacked gdbus/object.c to get into that
>> GetAll/GetManagedObjects condtion, and it works.
>>
>> I just think that it could be simplified somewhat. What I am thinking is
>> that we don't need a "pending" list, each proxy can have a 'pending'
>> boolean, and instead we add it to proxy_list as soon as it is allocated.
>
> Tried that, but that felt a little more complicated than maintaining a
> list since we have to iterate the entire proxy_list to find which ones
> are pending.
>
>> I didn't try it, but it feels like it would work.
>>
>> What do you think?
>>
>> If you don't think it would work, or that it would end up harder to
>> read, this patch looks good to me.
>
> Will apply it then.

Actually, I went back on this and did a v2 with the boolean flag, the
thing I said about reiterating is actually cheaper than doing the
lookup on on the proxy_list then is not found append the proxy and
remove it from the pending_list.

-- 
Luiz Augusto von Dentz
