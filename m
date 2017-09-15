Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87shfoixsd.fsf@intel.com>
References: <20170914131509.13624-1-luiz.dentz@gmail.com> <87shfoixsd.fsf@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Sep 2017 10:44:13 +0300
Message-ID: <CABBYNZ+G6SuPyWqHD1W0agOLoT=VdNQjFk-W6VJEYvbxDFUGfQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] adapter: Fix not waiting for start discovery result
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Sep 15, 2017 at 3:57 AM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> We should not reply until the start discovery completes otherwise
>> clients may attempt to stop the discovery before it even has started.
>>
>> On top of this it will now block clients so they so not be able to
>> queue more requests.
>> ---
>>  src/adapter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index a571b1870..4b9f5a1cd 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -160,6 +160,7 @@ struct discovery_filter {
>>
>>  struct watch_client {
>>       struct btd_adapter *adapter;
>> +     DBusMessage *msg;
>>       char *owner;
>>       guint watch;
>>       struct discovery_filter *discovery_filter;
>> @@ -1421,13 +1422,17 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>>                                       const void *param, void *user_data)
>>  {
>>       struct btd_adapter *adapter = user_data;
>> +     struct watch_client *client = adapter->discovery_list->data;
>
> What if the client exits the bus after issuing StartDiscovery(), but
> before receiving the reply. It seems that 'adapter->discovery_list'
> could be empty, no?

Yep, we would have to check if the client has been removed, I will add
a check for that.

-- 
Luiz Augusto von Dentzy
