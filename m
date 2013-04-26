Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OqM0w78sFzVtS5aOcvRDS0jZp9G2TqWVw3OHX=jGjETw@mail.gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1366957043-2383-13-git-send-email-mikel.astiz.oss@gmail.com>
	<CAJdJm_OqM0w78sFzVtS5aOcvRDS0jZp9G2TqWVw3OHX=jGjETw@mail.gmail.com>
Date: Fri, 26 Apr 2013 13:58:59 +0200
Message-ID: <CANT-zCXQ3mH2rZk12nQH_Z93VUnF94qwN5qoxq3egzzFvB4FUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 12/27] device: Use btd_service to represent profiles
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Apr 26, 2013 at 1:48 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Mikel,
>
> On Fri, Apr 26, 2013 at 2:17 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> +static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
>> +{
>> +       GSList *l;
>> +
>> +       for (l = list; l != NULL; l = g_slist_next(l)) {
>> +               struct btd_service *service = l->data;
>> +
>> +               if (btd_service_get_profile(service) == p)
>> +                       return l;
>
> Why you don't return service directly here? It should avoid the caller
> having to do "service = l->data;".

The patch has already been applied, but please go ahead with the
review since there's been a lot of code being changed, and testing was
fairly limited due to lack of hardware.

The purpose of this was to be able to delete the node more efficiently
in case that's the intention of the caller, but it's certainly of
little use considering that it's a singly-linked list.

Feel free to submit a patch to simplify this, or otherwise I'll
consider this for a later cleanup patchset.

>
> Another option: you could try using g_slist_find_custom() on the
> callers and turn this into a comparison callback for it.

Johan preferred this approach over find_custom() in a very similar
scenario, so I changed this one as well for consistency.

Cheers,
Mikel
