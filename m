Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw1Ws-aTyoaNH9Gmwc9-LtXaw+f-1se1NGU6aSvOzPU1dA@mail.gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
	<CABBYNZ+7ogaWV-9Xo6k6hKFRAAZ4tU1zd=FRcBF=w0EMJ0Zx+A@mail.gmail.com>
	<CA+i+Aw1Ws-aTyoaNH9Gmwc9-LtXaw+f-1se1NGU6aSvOzPU1dA@mail.gmail.com>
Date: Fri, 13 Jan 2012 13:55:23 +0100
Message-ID: <CA+i+Aw0YM3y=d-AUT8dp_ZP80Sv=QW3y-tzpFPuyEkiJa9frCA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/4] MAP: Implementation of MAP AP core functions
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 13, 2012 at 1:37 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> On Fri, Jan 13, 2012 at 1:02 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Slawomir,
>>
>> On Fri, Jan 13, 2012 at 12:48 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>>>  map_ap_t *map_ap_new(void)
>>>  {
>>> -       return NULL;
>>> +       return g_hash_table_new_full(NULL, NULL, NULL, ap_entry_free);
>>
>> I supposed you would like to use g_direct_hash and g_direct_equal
>> here, even if NULL mean the same it easier to understand and maintain
>> that way. Also it is not clear why the return of map_ap_new is
>> map_ap_t not a GHashTable?
>
> _I_ would like to use NULL - as you said yourself this is easier to
> understand and maintain. And this is explicitly documented default

I have misread you. You said fully spelled function are easier to
maintain. Although I do not believe so, I can see that both in BlueZ
and in oFono it is used that way, so I can make it that way for the
sake of consistency between projects.

> behavior. map_ap_t was agreed earlier for the implementation to be
> interchangeable - map_ap_t is opaque from the map_ap_* API user point
> of view.
>
>>
>>>  }
>>>
>>>  void map_ap_free(map_ap_t *ap)
>>>  {
>>> +       if (!ap)
>>> +               return;
>>
>> Are you sure you need this check, iirc most functions of glib does
>> NULL check already and sometime it even print warnings, so if this
>> check is to prevent warning I would suggest no to have because  it
>> will hide real bugs behind it.
>
> Destroy function here would print critical error message on NULL
> GHashTable. I like map_ap_free(NULL) call to be valid just like
> g_free(NULL).
>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> Slawomir Bochenski



-- 
Slawomir Bochenski
