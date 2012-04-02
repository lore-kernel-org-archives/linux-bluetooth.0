Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120402145415.GB31518@x220.P-661HNU-F1>
References: <1333365444-9029-1-git-send-email-arik@wizery.com> <20120402145415.GB31518@x220.P-661HNU-F1>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 2 Apr 2012 21:35:54 +0300
Message-ID: <CA+XVXfdq-7eS8Rsv4Q9RgRagPad=SfmFxjS-AZk_v6v14rCaWg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] att: add remote btd_device to ATT read/write callbacks
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 2, 2012 at 17:54, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arik,
>
> On Mon, Apr 02, 2012, Arik Nemtsov wrote:
>> +     uint8_t (*read_cb)(struct attribute *a, struct btd_device *device,
>> +                        gpointer user_data);
>> +     uint8_t (*write_cb)(struct attribute *a, struct btd_device *device,
>> +                         gpointer user_data);
>
> Please don't mix tabs and spaces for indentation. We only use tabs.

Ah sorry, I missed the space fixup on this patch. I'll resubmit shortly.

Arik
