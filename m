Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349370976.8332.21.camel@novo.hadess.net>
References: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi> <1349370976.8332.21.camel@novo.hadess.net>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 4 Oct 2012 14:21:20 -0300
Message-ID: <CAKi4VALw4TTh0z3Yppov71Anf4g1sNPnRYaQPouaaiYcEb79_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Fix walking the list while removing elements
To: Bastien Nocera <hadess@hadess.net>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 4, 2012 at 2:16 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2012-10-04 at 14:07 -0300, Lucas De Marchi wrote:
>> -       for (l = device->profiles; l != NULL; l = g_slist_next(l)) {
>> +       for (l = device->profiles; l != NULL; l = next) {
>
> +       for (l = device->profiles; l != NULL; l = l->next) {

nops. you can't access "l" if it was deleted from the list

>
>>                 struct btd_profile *profile = l->data;
>>                 GSList *probe_uuids;
>>
>> +               next = l->next;
>
> Remove.

nops.


See previous patch.



Lucas De Marchi
