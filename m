Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLoJJfVMSstVMXicYpi126HfaxxNRLRsy9e9Os1F7=ocw@mail.gmail.com>
References: <1341865311-21266-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZLoJJfVMSstVMXicYpi126HfaxxNRLRsy9e9Os1F7=ocw@mail.gmail.com>
Date: Tue, 24 Jul 2012 17:39:31 +0200
Message-ID: <CANT-zCV5NiSP4Cfcv=FyYRaN_n06QPCeCbMtB1XQPkQUpiokCw@mail.gmail.com>
Subject: Re: [RFC v0] media: Extend media API with optional acquire
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jul 16, 2012 at 11:17 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Mon, Jul 9, 2012 at 5:21 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>  unsigned int gateway_request_stream(struct audio_device *dev,
>> +                               gboolean try_only,
>>                                 gateway_stream_cb_t cb, void *user_data)
>>  {
>>         struct gateway *gw = dev->gateway;
>>         GError *err = NULL;
>>         GIOChannel *io;
>>
>> +       if (try_only && !gw->sco)
>> +               return 0;
>
> Perhaps if we store the status of the transport we don't need to even
> call gateway_request_stream.

I tried to follow this approach by adding a flag (gboolean playing)
inside struct media_transport, avoiding changes in the transport
callbacks.

Patches will be submitted soon.

Cheers,
Mikel
