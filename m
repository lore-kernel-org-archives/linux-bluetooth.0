Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87pobydq7u.fsf@intel.com>
References: <20170814104602.32013-1-luiz.dentz@gmail.com> <87pobydq7u.fsf@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Aug 2017 11:22:12 +0300
Message-ID: <CABBYNZJuvuR4zoODr=mHNg6DL_Wx92560g6CWGLHmpr92PQfyg@mail.gmail.com>
Subject: Re: [PATCH v2] gdbus: Fix calling GetAll while GetManagedObject is pending
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 14, 2017 at 8:16 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> If proxies are created while the client is not ready put them into a
>> pending list so only if they are not found in GetManagedObject reply
>> call GetAll.
>> ---
>>  gdbus/client.c | 96 ++++++++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 59 insertions(+), 37 deletions(-)
>>
>
> [...]
>
>> @@ -424,6 +435,7 @@ static GDBusProxy *proxy_new(GDBusClient *client, const char *path,
>>                                                       proxy->interface,
>>                                                       properties_changed,
>>                                                       proxy, NULL);
>> +     proxy->pending = TRUE;
>>
>>       return g_dbus_proxy_ref(proxy);
>>  }
>> @@ -478,15 +490,19 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
>>       if (client == NULL)
>>               return NULL;
>>
>> -     proxy = proxy_lookup(client, path, interface);
>> +     proxy = proxy_lookup(client->proxy_list, path, interface);
>>       if (proxy)
>>               return g_dbus_proxy_ref(proxy);
>>
>> +
>
> Extra empty line here.

Fixed this one, thanks for pointing out.

>>       proxy = proxy_new(client, path, interface);
>>       if (proxy == NULL)
>>               return NULL;
>>
>
> Just that nitpick, looking good.

Applied.

-- 
Luiz Augusto von Dentz
