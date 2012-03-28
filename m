Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120328141402.GA31354@aemeltch-MOBL1>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
	<1332887487-13601-3-git-send-email-jprvita@openbossa.org>
	<20120328082641.GA21905@aemeltch-MOBL1>
	<CAAngNMYY=8Vpoh4izC-NXw0fnpUcS3fawu3ZGCCA5CVtzVypew@mail.gmail.com>
	<20120328141402.GA31354@aemeltch-MOBL1>
Date: Wed, 28 Mar 2012 15:42:40 -0300
Message-ID: <CAAngNMYXytk875yROH5FQCZ4LGMNc06OUBG4Sx2ZO--LLADt1g@mail.gmail.com>
Subject: Re: [RFC 2/8] HoG: register ATTIO callbacks
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org, dh.herrmann@googlemail.com,
	chen.ganir@ti.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 28, 2012 at 11:14 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi João,
>
> On Wed, Mar 28, 2012 at 10:55:18AM -0300, Joao Paulo Rechi Vita wrote:
>> Hello Andrei,
>>
>> 2012/3/28 Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>:
>> > Hi João,
>> >
>> > Minor comments:
>> >
>> > On Tue, Mar 27, 2012 at 07:31:21PM -0300, João Paulo Rechi Vita wrote:
>> > ...
>> >> +static struct hog_device *hog_device_new(struct btd_device *device,
>> >> +                                                     const char *path)
>> >> +{
>> > ...
>> >> +
>> >> +     hogdev->attioid = btd_device_add_attio_callback(device,
>> >> +                                                     attio_connected_cb,
>> >> +                                                     attio_disconnected_cb,
>> >> +                                                     hogdev);
>> >
>> > What is the coding style for the userspace? Shall it be at least the same?
>> >
>>
>> Unless something has changed lately we use the kernel coding style. I
>> don't see where I didn't follow it here, but I may be missing
>> something. Can you please point me what I'm missing if that is the
>> case?
>
> I mean are those parameters aligned to the right or at "(".
>

The parameters are aligned to the right and after the opening brace.
Isn't that right?

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
