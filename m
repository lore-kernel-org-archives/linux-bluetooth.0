Return-Path: <cyrus@holtmann.org>
Message-ID: <5232F7F7.7030407@oss.bmw-carit.de>
Date: Fri, 13 Sep 2013 13:33:11 +0200
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/4] obexd: Add folder property to map_msg_create
References: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1379064212-30056-2-git-send-email-christian.fetzer@oss.bmw-carit.de> <CABBYNZKYBd=S0G3Hvno7wQxgtCy5nwnamTD=1sKcVw+kBkAVVg@mail.gmail.com>
In-Reply-To: <CABBYNZKYBd=S0G3Hvno7wQxgtCy5nwnamTD=1sKcVw+kBkAVVg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 09/13/2013 12:11 PM, Luiz Augusto von Dentz wrote:
> Hi Christian,
> 
> On Fri, Sep 13, 2013 at 12:23 PM, Christian Fetzer
> <christian.fetzer@oss.bmw-carit.de> wrote:
>> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>>
>> Message interfaces are not necessarily created for the current folder,
>> therefore the folder needs to be specified in a parameter.
>>
>> For example, messages can be created for sub folders when using the folder
>> parameter in ListMessages.
>> ---
>>  obexd/client/map.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/obexd/client/map.c b/obexd/client/map.c
>> index f0dcf72..9a1b140 100644
>> --- a/obexd/client/map.c
>> +++ b/obexd/client/map.c
>> @@ -779,7 +779,8 @@ static const GDBusPropertyTable map_msg_properties[] = {
>>         { }
>>  };
>>
>> -static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
>> +static struct map_msg *map_msg_create(struct map_data *data, const char *handle,
>> +                                                       const char *folder)
>>  {
>>         struct map_msg *msg;
>>
>> @@ -788,7 +789,7 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
>>         msg->path = g_strdup_printf("%s/message%s",
>>                                         obc_session_get_path(data->session),
>>                                         handle);
>> -       msg->folder = g_strdup(obc_session_get_folder(data->session));
>> +       msg->folder = g_strdup(folder);
>>
>>         if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
>>                                                 map_msg_methods, NULL,
>> @@ -1057,7 +1058,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
>>
>>         msg = g_hash_table_lookup(data->messages, values[i]);
>>         if (msg == NULL) {
>> -               msg = map_msg_create(data, values[i]);
>> +               msg = map_msg_create(data, values[i],
>> +                                       obc_session_get_folder(data->session));
> 
> Is this really fixing anything? Because it seems it is just changing
> places where obc_session_get_folder is called when what you should
> probably be doing is to store the folder parameter given to
> ListMessages. 


The fix itself is in patch 2. But as explained in the cover letter,
I'll need the parameter as well when creating new messages from
event reports. (I have a first notification API patchset ready but
wanted to wait until this is applied.)


> I actually regret to have this parameter as it makes
> things a little bit more complicated just to avoid SetFolder.
> 
> Probably Session.SetPath would make more sense than having each
> profile interface treating it differently but that would require to
> break APIs so it is better not to do it right now.
> 


Fully agree. Maybe it's a good thing to keep 
those points in mind for future API changes.

Christian
