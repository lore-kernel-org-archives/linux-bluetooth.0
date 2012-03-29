Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120328095841.GA30867@x220>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
	<1332854978-26072-4-git-send-email-bruna.moreira@openbossa.org>
	<20120328095841.GA30867@x220>
Date: Thu, 29 Mar 2012 10:22:00 -0400
Message-ID: <CA+=zyVHpgY1rG6Z4FBqRZpdEmd70gSLRvZTQ2DG1eUgi-pcKxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] device: Appearance characteristic from GAP service
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 28, 2012 at 5:58 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bruna,
>
> On Tue, Mar 27, 2012, Bruna Moreira wrote:
>> @@ -363,15 +367,19 @@ static DBusMessage *get_properties(DBusConnection *conn,
>>
>>       /* Class */
>>       if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
>> -             const char *icon = class_to_icon(class);
>> +             icon = class_to_icon(class);
>>
>>               dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
>> +     } else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0) {
>> +             /* Appearance */
>> +             icon = gap_appearance_to_icon(app);
>> +             class = 0;
>>
>> -             if (icon)
>> -                     dict_append_entry(&dict, "Icon",
>> -                                             DBUS_TYPE_STRING, &icon);
>> +             dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
>>       }
>
> If we don't have a proper remote class value wouldn't it be simpler to
> just leave it out from the properties list instead of including a 0
> value?

Agreed, I am sending a new patch fixing that. Thanks.

BR,
-- 
Bruna Moreira
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
