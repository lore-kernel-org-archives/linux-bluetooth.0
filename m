Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120124104623.GA26322@x220>
References: <20120123132915.GA2879@samus>
	<1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
	<CAJdJm_N+FXcJfXm_1eEmjJUp0c4Ek2OL3gJrSnRyfjmoCPNG5A@mail.gmail.com>
	<20120124104623.GA26322@x220>
Date: Tue, 24 Jan 2012 07:46:30 -0400
Message-ID: <CAJdJm_MX9tmqm3gOCcQo9jbD8SGtXMvhq2Kp5eiw-KV=Eo5oHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix memory leak when loading keys
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jan 24, 2012 at 6:46 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Tue, Jan 24, 2012, Anderson Lizardo wrote:
>> On Mon, Jan 23, 2012 at 8:21 PM, Vinicius Costa Gomes
>> <vinicius.gomes@openbossa.org> wrote:
>> > @@ -3570,7 +3571,16 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
>> >        if (dev->keys != NULL)
>> >                return -EEXIST;
>> >
>> > -       dev->keys = keys;
>> > +       for (l = keys; l; l = l->next) {
>> > +               struct link_key_info *orig, *dup;
>> > +
>> > +               orig = l->data;
>> > +
>> > +               dup = g_memdup(orig, sizeof(*orig));
>> > +
>> > +               dev->keys = g_slist_prepend(dev->keys, dup);
>> > +       }
>> > +
>>
>> No need to cleanup dev->keys first?
>
> Take a look at the first two lines of context. The function bails out if
> dev->keys is anything else than NULL.

Right. Oops :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
