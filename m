Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140328175116.GA20397@t440s.P-661HNU-F1>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
	<1396016350-16943-4-git-send-email-claudio.takahasi@openbossa.org>
	<20140328175116.GA20397@t440s.P-661HNU-F1>
Date: Fri, 28 Mar 2014 16:53:56 -0300
Message-ID: <CAKT1EBdHqrAR2rusqyjLzLq0KzHgNw=4d2rzemLU=Eoqh06tVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 3/5] tools: Add testing descriptor for IAS Alert Level
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Fri, Mar 28, 2014 at 2:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Mar 28, 2014, Claudio Takahasi wrote:
>> This patch adds a testing purpose only characteristic descriptor to
>> allow reading and writing descriptors "Value" property.
>> ---
>>  tools/gatt-service.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> I've applied the first two patches but noticed something with this one:
>
>> +static gboolean register_characteristic(const char *chr_uuid,
>>                                               const uint8_t *value, int vlen,
>>                                               const char **props,
>> +                                             const char *desc_uuid,
>>                                               const char *service_path)
>>  {
>>       struct characteristic *chr;
>>       static int id = 1;
>> -     char *path;
>> +     char *chr_path, *desc_path;
>>       gboolean ret = TRUE;
>>
>> -     path = g_strdup_printf("%s/characteristic%d", service_path, id++);
>> +     chr_path = g_strdup_printf("%s/characteristic%d", service_path, id++);
>>
>>       chr = g_new0(struct characteristic, 1);
>>
>> -     chr->uuid = g_strdup(uuid);
>> +     chr->uuid = g_strdup(chr_uuid);
>>       chr->value = g_memdup(value, vlen);
>>       chr->vlen = vlen;
>> -     chr->path = path;
>> +     chr->path = chr_path;
>>       chr->props = props;
>>
>> -     if (!g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
>> +     if (!g_dbus_register_interface(connection, chr_path, GATT_CHR_IFACE,
>>                                       NULL, NULL, chr_properties,
>>                                       chr, chr_iface_destroy)) {
>>               printf("Couldn't register characteristic interface\n");
>> +             return FALSE;
>> +     }
>> +
>> +     if (!desc_uuid)
>> +             return ret;
>> +
>> +     desc_path = g_strdup_printf("%s/descriptor%d", chr_path, id++);
>> +     if (!g_dbus_register_interface(connection, desc_path,
>> +                                     GATT_DESCRIPTOR_IFACE,
>> +                                     NULL, NULL, desc_properties,
>> +                                     g_strdup(desc_uuid), g_free)) {
>> +             printf("Couldn't register descriptor interface\n");
>> +             g_dbus_unregister_interface(connection, chr_path,
>> +                                                     GATT_CHR_IFACE);
>> +             g_free(desc_path);
>>               ret = FALSE;
>>       }
>>
>
> Looks like you're leaking desc_path here if register_interface succeeds.
> In general it seems a bit unnecessary to go for a dynamically allocated
> approach since you only need the variable in the same function. Probably
> a stack variable and snprintf would do an equally good or better job.
>
> Johan

OK. I will send a new patch fixing this memory leak.

In this case specifically, I prefer to use dynamically allocated
memory because in the next patch, the object path will be necessary to
emit the PropertiesChanged signal.

Regards,
Claudio
