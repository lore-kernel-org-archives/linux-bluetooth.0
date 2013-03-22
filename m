Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130322105754.GC10769@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1363678855-12765-4-git-send-email-mikel.astiz.oss@gmail.com>
	<20130322105754.GC10769@x220.ger.corp.intel.com>
Date: Fri, 22 Mar 2013 13:17:30 -0400
Message-ID: <CAJdJm_N57Q+d4ObHyUEuD3CyYAXo26yU2gn8WUtb-GtURqeF7Q@mail.gmail.com>
Subject: Re: [RFC v0 03/11] device: Replace connected_profiles with btd_service
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 22, 2013 at 6:57 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Tue, Mar 19, 2013, Mikel Astiz wrote:
>> +static gint service_state_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +     struct btd_service *service = (gpointer) a;
>
> Couldn't you just declare the local variable const to avoid the ugly
> cast?
>
>> +     service_state_t state = (service_state_t) GPOINTER_TO_INT(b);
>
> I think it'd be cleaner to just have:
>
>         const service_state_t *state = b;
>
>> +     if (service_get_state(service) == state)
>
> And this would then become:
>
>         if (service_get_state(service) == *state)

I don't think these are equivalent, unless the caller is also changed
to use "&state" instead of "GINT_TO_POINTER(state)".

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
