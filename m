Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] obexd: Emit file information for client
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <abac898f-8f93-7a35-06b7-d23186895818@jp.fujitsu.com>
 <CABBYNZKT5SH_YevAXk+hQBxpPA_AmwK6+Kxo9nGmb-1uW5J51w@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <b34caeca-968f-7b7f-cc74-4500ff4b7935@jp.fujitsu.com>
Date: Mon, 15 Jan 2018 15:50:45 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZKT5SH_YevAXk+hQBxpPA_AmwK6+Kxo9nGmb-1uW5J51w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/13/2018 02:37 AM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Fri, Jan 12, 2018 at 4:23 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> When running obexctl and then starting to transfer a file, obexctl does
>> not retrieve the "Size" property. Thus it outputs the huge remaining time
>> as below:
>>
>>   [NEW] Transfer /org/bluez/obex/server/session1/transfer0
>>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Status: active
>>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 32683 (@32KB/s 4286681714:4294967273)
>>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 65444 (@32KB/s 428259:59)
>>
>> This change makes obexd emit the file information including the "Size"
>> property, since obexctl may output the huge remaining time first if
>> obexctl calls g_dbus_proxy_refresh_property(). As the result, obexctl can
>> retrieve the "Size" property and the info command of obexctl can output
>> the filename of the transferring file.
>> ---
>>  obexd/src/manager.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
>> index 78b138c85..6c83479f4 100644
>> --- a/obexd/src/manager.c
>> +++ b/obexd/src/manager.c
>> @@ -533,10 +533,15 @@ void manager_cleanup(void)
>>
>>  void manager_emit_transfer_started(struct obex_transfer *transfer)
>>  {
>> +       const GDBusPropertyTable *property;
>> +
>>         transfer->status = TRANSFER_STATUS_ACTIVE;
>>
>> -       g_dbus_emit_property_changed(connection, transfer->path,
>> -                                       TRANSFER_INTERFACE, "Status");
>> +       for (property = transfer_properties;
>> +                               property && property->name; property++)
>> +               g_dbus_emit_property_changed(connection, transfer->path,
>> +                                               TRANSFER_INTERFACE,
>> +                                               property->name);
>>  }
> 
> Im not following why we need to emit every single property? Isn't that
> enough to send the Size only?

I want to make obexctl print out as much as possible of file information.

For example,
  - If obexd sends the Size property only, the info command of obexctl
    prints out the Session/Status/Size/Transferred properties and does
    not print out the Name property etc..
  - If obexctl retrieves the Name property at cmd_info(), the info
    command does not first print out it as below:

    # info /org/bluez/obex/server/session2/transfer1
    Transfer /org/bluez/obex/server/session2/transfer1
            Session: /org/bluez/obex/server/session2
            Status: active
            Size: 395755855
            Transferred: 949991
    [CHG] Transfer /org/bluez/obex/server/session2/transfer1 Transferred: 982752 (@32KB/s 200:50)
    [CHG] Transfer /org/bluez/obex/server/session2/transfer1 Name: bluez.tar.gz

I will modify this commit message and resend this patch set.


Regards,
Eramoto

