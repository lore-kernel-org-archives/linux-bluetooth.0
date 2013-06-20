Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130619095717.GB6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
	<1371041841-21793-7-git-send-email-bruna.moreira@openbossa.org>
	<20130619095717.GB6370@x220>
Date: Thu, 20 Jun 2013 07:52:19 -0400
Message-ID: <CA+=zyVF6ybLdyt-gr4jZOiRjD-ash1CadsroY1sy_66+63si1Q@mail.gmail.com>
Subject: Re: [RFC BlueZ 06/35] emulator: Search virtual devices in LE scan mode
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Jefferson Delfes <jefferson.delfes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jun 19, 2013 at 5:57 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> +static void le_set_adv_enable_complete(struct btdev *btdev)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
>> +             if (!btdev_list[i] || btdev_list[i] == btdev)
>> +                     continue;
>> +
>> +             if (!btdev_list[i]->le_scan_enable)
>> +                     continue;
>> +     }
>> +}
>
> Same thing as with my earlier comment. This function doesn't seem to do
> anything useful and should probably be merged with some later patch that
> actually does something (assuming such a patch exists).

Same here. This function is used in a later patch. I will merge it too.

BR,
-- 
Bruna Moreira
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
