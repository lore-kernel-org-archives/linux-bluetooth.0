Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: arakhov@google.com
In-Reply-To: <CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
	<CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com>
	<CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
	<CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
	<574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org>
	<CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com>
	<CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
Date: Mon, 18 Aug 2014 00:11:00 -0700
Message-ID: <CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com>
Subject: Re: [A2DP] Incoming connections do not succeed
From: Artem Rakhov <arakhov@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I have also tried kernel 3.14, it didn't help.
How can I use avinfo for test? Looks like it shows only basic
information for the device. And it works fine with the speaker.
I tried to use avtest: when I try to connect to the speaker,
everything seems to be working good. Is there any way to use it to
test incoming connections?

Thanks,
Artem

On Sun, Aug 10, 2014 at 12:32 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Artem,
>
> On Fri, Aug 8, 2014 at 10:32 AM, Artem Rakhov <arakhov@chromium.org> wrote:
>> Hi Marcel,
>>
>> Please find Packet Logger's btsnoop log in the attachment.
>>
>> So far I have 2 observations:
>> 1. Mac does not require any authorization (most likely it's not the cause)
>> 2. I found another BT speaker which works properly. At first, I'm
>> seeing the same behavior: speaker initiates connection, BlueZ sends
>> Configure Request (with no MTU), then speaker disconnects. But after
>> that the device tries to initiate connection for the second time, and
>> this time it is successful: after BlueZ sends Configure Request with
>> no MTU, speaker answers with another Configure Request (with some
>> MTU), and connection is established normally. Is it possible, that
>> BlueZ is doing something wrong, but then this new speaker tries
>> something else, while the old one does not?
>
> I could not find anything l2cap related in this logs, but I notice
> there a LE scanning ongoing perhaps you have should try disabling it
> with Disconnect method for now. Anyway A2DP code is not really
> involved with L2CAP connection setup so we would have to look at the
> kernel changes but I quick check doesn't show anything and you said
> you have tried with 3.10 so Im afraid this is only reproducible with
> some specific device.
>
> Btw, if you want to really isolate the problem you can try to connect
> using avinfo or l2test directly.
>
>
> --
> Luiz Augusto von Dentz
