Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110223032608.GE16014@jh-x301>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
	<1298408491-11154-2-git-send-email-anderson.lizardo@openbossa.org>
	<20110223032608.GE16014@jh-x301>
Date: Wed, 23 Feb 2011 11:29:15 -0300
Message-ID: <AANLkTinN+MmEOcUTCXrzGNg4du3GxMAXeHorKN2jSGoP@mail.gmail.com>
Subject: Re: [PATCHv2 2/5] Initial Client Characteristic Configuration implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 23, 2011 at 12:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Tue, Feb 22, 2011, Anderson Lizardo wrote:
>> +static uint8_t client_set_notifications(struct attribute *attr,
>> +                                                     gpointer user_data)
>> +{
>> +     struct gatt_channel *channel = user_data;
>> +     struct attribute *a, *last_chr_val = NULL;
>> +     uint16_t handle, cfg_val;
>> +     uuid_t uuid;
>> +     GSList *l;
>> +
>> +     cfg_val = att_get_u16(attr->data);
>> +
>> +     sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
>> +     for (l = database, handle = 0; l != NULL; l = l->next) {
>> +             a = l->data;
>
> The variable "a" is only used inside the for-loop so it should be
> declared inside it as well. I think you can move handle inside the loop
> as well as long as you declare it static (so it only gets initialized to
> 0 on the first iteration).

Both changes will be incorporated on the v3.

>
> Johan
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
