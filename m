Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130619095630.GA6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
	<1371041841-21793-6-git-send-email-bruna.moreira@openbossa.org>
	<20130619095630.GA6370@x220>
Date: Thu, 20 Jun 2013 07:49:18 -0400
Message-ID: <CA+=zyVFMOB9VQaxa67fs_V6PQjUseZrz2weo5qsbBaDa5UaE1A@mail.gmail.com>
Subject: Re: [RFC BlueZ 05/35] emulator: Search virtual devices in LE
 advertising mode
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Jefferson Delfes <jefferson.delfes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> +static void le_set_scan_enable_complete(struct btdev *btdev)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
>> +             if (!btdev_list[i] || btdev_list[i] == btdev)
>> +                     continue;
>> +
>> +             if (!btdev_list[i]->le_adv_enable)
>> +                     continue;
>> +     }
>> +}
>
> What's the purpose of this function? It doesn't seem to do anything but
> iterate through the btdev list. Should it be merged with some later
> patch (which actually does something useful)?
>
> Johan

Yes, this function is used in a later patch "emulator: Implement LE
advertising report". I will merge it.

BR,
-- 
Bruna Moreira
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
