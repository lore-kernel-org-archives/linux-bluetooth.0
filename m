Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OYkodB5ChynpfD6ALzKW7xWq30F-TZwGuE19QWu8TZGQ@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
	<1320835923-10989-3-git-send-email-sancane@gmail.com>
	<1320835923-10989-4-git-send-email-sancane@gmail.com>
	<1320835923-10989-5-git-send-email-sancane@gmail.com>
	<1320835923-10989-6-git-send-email-sancane@gmail.com>
	<1320835923-10989-7-git-send-email-sancane@gmail.com>
	<CAJdJm_OYkodB5ChynpfD6ALzKW7xWq30F-TZwGuE19QWu8TZGQ@mail.gmail.com>
Date: Wed, 9 Nov 2011 15:49:55 +0100
Message-ID: <CACLukzJ-TaCNWqnTegG=Wjtj8dCrDARJToE4R2nMMkh0K_AGzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] Notify intermediate measurements
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

2011/11/9 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Wed, Nov 9, 2011 at 6:52 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>>  static void recv_measurement(struct thermometer *t, struct measurement *msmt)
>>  {
>> -       GSList *l;
>> +       GSList *l, *ll;
>>
>> -       if (g_strcmp0(msmt->msmnt, "Intermediate") == 0) {
>> -               DBG("Notification of intermediate measurement not implemented");
>> -               return;
>> -       }
>> +       if (g_strcmp0(msmt->msmnt, "Intermediate") == 0)
>> +               ll = t->iwatchers;
>> +       else
>> +               ll = t->fwatchers;
>>
>> -       for (l = t->fwatchers; l; l = l->next)
>> +       for (l = ll; l; l = l->next)
>>                update_watcher(l->data, msmt);
>>  }
>
> What about using g_slist_foreach() above? Also "ll" seems too generic,
> what about "wlist".

Ok, I'll prepare a new set of patches, but I would rather wait to get
comments and advices to the question regarding to how we should manage
GATT attribute indications.

Thank you very much for your comments.
Santiago
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>
