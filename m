Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429080130.GB21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-11-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429080130.GB21742@t440s.lan>
Date: Tue, 29 Apr 2014 12:41:16 +0200
Message-ID: <CAN_7+YZh6VxXb69=7yqeAhQfnfyzAKrZ+i0d36B9G-B5EFmeaw@mail.gmail.com>
Subject: Re: [PATCH 09/36] android/gatt: Add listening socket for GATT
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Tue, Apr 29, 2014 at 10:01 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> +static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
>> +{
>> +     struct gatt_device *dev = NULL;
>
fix in v2

> This looks like an unnecessary initialization upon declaration, looking
> at how the variable is handled in the rest of the function.
>
>> +     /*TODO: Attach to attrib db */
>
> Space after /*

fix in v2
>
>> +     if (listening_sk == NULL) {
>
> I think we're trying to make the coding style consistent by using
> if (!ptr)
>
fix in v2

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Lukasz
