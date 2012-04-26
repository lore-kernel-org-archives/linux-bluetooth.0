Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NkNC2ohPnobJPwR6GvmRg6Zb6hnMBeqQnb0wz8bZ4ahg@mail.gmail.com>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-5-git-send-email-jprvita@openbossa.org>
	<CAJdJm_NkNC2ohPnobJPwR6GvmRg6Zb6hnMBeqQnb0wz8bZ4ahg@mail.gmail.com>
Date: Thu, 26 Apr 2012 16:42:21 -0300
Message-ID: <CAAngNMYKffkxujGf49XWf_5goiZrapr=bW_TQrPrAJONUg2jqA@mail.gmail.com>
Subject: Re: [RFC v2 04/16] HoG: discover all characteristics declaration
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/20 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi João,
>
> 2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
>> +static void report_free(struct report *report)
>> +{
>> +       g_free(report->decl);
>> +       g_free(report);
>> +}
>
> We usually avoid casts (like you do later on the g_slist_free_full()
> call), by having:
>
> static void report_free(void *data)
> {
>        struct report *report = data;
> ...
> }
>
>> @@ -153,6 +203,7 @@ int hog_device_register(struct btd_device *device, const char *path)
>>  static void hog_device_free(struct hog_device *hogdev)
>>  {
>>        btd_device_unref(hogdev->device);
>> +       g_slist_free_full(hogdev->reports, (GDestroyNotify) report_free);
>
> You can then drop the cast above.
>
>>        g_free(hogdev->path);
>>        g_free(hogdev->hog_primary);
>>        g_free(hogdev);
>

Fixed.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
