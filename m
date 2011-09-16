Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110916103553.15662dyub01c99wk@mail.hendrik-sattler.de>
References: <1316113131-10944-1-git-send-email-anderson.lizardo@openbossa.org>
	<20110916103553.15662dyub01c99wk@mail.hendrik-sattler.de>
Date: Fri, 16 Sep 2011 07:05:36 -0400
Message-ID: <CAJdJm_N9e+7pfcsxBFWSMrv-97rq8GcnMZ0gVi_Z-c-i-pT7UQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix allocation of attribute values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Fri, Sep 16, 2011 at 4:35 AM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
>>                /* Create a private copy of the Client Characteristic
>>                 * Configuration attribute */
>> -               a = g_malloc0(sizeof(*a) + vlen);
>> +               a = g_new0(struct attribute, 1);
>> +               a->data = g_malloc0(vlen);
>
> Here you assign the pointer...
>
>> +
>>                memcpy(a, orig_attr, sizeof(*a));
>
> ...and here your overwrite it.
> Hint: if that is written as
>   *a = *orig_attr;
> you get a compile-time type check for free.

You are right, this is simpler and safer, I'll change it.

>
>>                memcpy(a->data, value, vlen);
>
> And here you do...hmm...hard to tell since the pointer now shows to...where?
> Even if that pointer is valid and is assigned the right size memory, you
> just leaked memory.

This is the main point of this patch. a->data used to be allocated
together with struct attribute, because of this:

struct attribute {
...
       uint8_t data[0];
};

This has now been changed on this commit so that the data field is
just a pointer to a separately allocated buffer:

struct attribute {
...
       uint8_t *data;
};

In this new version, the "data" field is a (initially NULL) pointer
that is allocated along with its container (struct attribute). But you
reminded me that I need to optimize this:

a->data = g_malloc0(vlen);
...
memcpy(a->data, value, vlen);

Into this:

a->data = g_memdup(value, vlen);

(much more readable). Plain assignment can't be used here because
a->data is a dynamic array whose size is only known at run-time.

>
>> @@ -1242,7 +1252,9 @@ struct attribute *attrib_db_add(uint16_t handle,
>> bt_uuid_t *uuid, int read_reqs,
>>        if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
>>                return NULL;
>>
>> -       a = g_malloc0(sizeof(struct attribute) + len);
>> +       a = g_new0(struct attribute, 1);
>> +       a->data = g_malloc0(len);
>> +
>>        a->handle = handle;
>>        memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
>
> This could also use assignement-instead-of-memcpy but that's out-of-scope of
> this patch?

Correct, but we can fix this in a separate patch as it has a few other
places on BlueZ code to be fixed as well.

>> -       attrib_notify_clients(a);
>> +       if (uuid != NULL)
>> +               memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
>
> But here you could write: a->uuid = *uuid;

Yes, will change.

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
