Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180521113957epcms5p214510537221c910e5f939baabe7f22af@epcms5p2>
References: <1526615048-23393-1-git-send-email-nagaraj.dr@samsung.com>
 <CGME20180518034418epcas2p3b31813a79452e5934a438347b8edc82a@epcms5p2>
 <CABBYNZLuEuo+N7oYhcUMC2H-mB9f+WKM5FAuXGcFym_XWwLR0Q@mail.gmail.com> <20180521113957epcms5p214510537221c910e5f939baabe7f22af@epcms5p2>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 May 2018 16:03:01 +0300
Message-ID: <CABBYNZLmUrsvZUZDt1j6BEUtD9fh8AcpV_VbABiGsnxYt7SZDw@mail.gmail.com>
Subject: Re: Re: [PATCH] Fix improper usage of g_free
To: Nagaraj D R <nagaraj.dr@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        SYAM SIDHARDHAN <s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 21, 2018 at 2:39 PM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> Hi,
>
>>Hi,
>
>>On Fri, May 18, 2018 at 6:44 AM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
>>> g_free should be used for only those memory allocations
>>> done through glib APIs
>>> ---
>>>  client/advertising.c | 2 +-
>>>  src/adapter.c        | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/client/advertising.c b/client/advertising.c
>>> index 045133a..5592be6 100644
>>> --- a/client/advertising.c
>>> +++ b/client/advertising.c
>>> @@ -757,7 +757,7 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
>>>                 return;
>>>
>>>         g_free(ad.local_name);
>>> -       ad.local_name = strdup(name);
>>> +       ad.local_name = g_strdup(name);
>>>
>>>         g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
>>>
>>> diff --git a/src/adapter.c b/src/adapter.c
>>> index c1c792a..07a4e42 100644
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -2258,7 +2258,7 @@ static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *filter)
>>>                 bt_uuid_to_uuid128(&uuid, &u128);
>>>                 bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
>>>
>>> -               filter->uuids = g_slist_prepend(filter->uuids, strdup(uuidstr));
>>> +               filter->uuids = g_slist_prepend(filter->uuids, g_strdup(uuidstr));
>>>
>>>                 dbus_message_iter_next(&arriter);
>>>         }
>>> --
>>> 1.9.1
>>I rather not use the g_str* then, so we might need to replace g_free
>>with free for local_name and also the filter.
>
> I agree. I will send a new patch

I actually fix this myself, but thanks for the feedback.

-- 
Luiz Augusto von Dentz
