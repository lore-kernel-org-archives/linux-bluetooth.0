Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <66BD268F973E3544A665E5F503FB38B71AE959AEBF@DC01.bmw-carit.intra>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-4-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZLaMoMuCQ9vY6oiUMa5P0dW-WZLvhWQ19AtmgyZezms1Q@mail.gmail.com>
	<66BD268F973E3544A665E5F503FB38B71AE959AEBF@DC01.bmw-carit.intra>
Date: Mon, 19 Mar 2012 14:27:13 -0300
Message-ID: <CABBYNZ+Jfbipf=Ji2rWyZFBGx34h+KmPW+L2=oS3CpA1aLtO=g@mail.gmail.com>
Subject: Re: [PATCH obexd v0 03/11] client: refactor transfer callback use
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Mar 19, 2012 at 11:40 AM, Mikel Astiz <Mikel.Astiz@bmw-carit.de> wrote:
> Hi Luiz,
>
>> >
>> > -static void obc_transfer_abort(struct obc_transfer *transfer)
>> > +static void transfer_notify_progress(struct obc_transfer *transfer)
>> {
>> > +       struct transfer_callback *callback = transfer->callback;
>> > +
>> > +       DBG("%p", transfer);
>> > +
>> > +       if ((callback != NULL) && (transfer->transferred !=
>> > +transfer->size))
>> > +               callback->func(transfer, transfer->transferred, NULL,
>> > +
>> > +callback->data); }
>>
>> Usually we use early returns and simple statements to be more readable,
>> so if (callback == NULL) return would have been better. Also I guess we
>> don't really need this check for transferred != size since gobex has a
>> complete callback and latter you set it to NULL.
>>
>
> This patch was refactoring code so the size check has been kept there, exactly as it was.
>
> We can try to drop it if you want, but I guess it would be in another patch. However I think it's actually necessary.

I guess that was to prevent sending the same progress twice, once in
progress and another one in complete, so maybe it is fine to keep it
for now, but perhaps when we are changing the API we should have a
separated signal when the transfer is complete to match gobex.

-- 
Luiz Augusto von Dentz
