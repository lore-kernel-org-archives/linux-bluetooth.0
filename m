Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-+NhN9PPSXh7=vrTsrZKGFmzsXe6Cr+RqG=SaSZnUUJZA@mail.gmail.com>
References: <1412375951-13940-1-git-send-email-armansito@chromium.org>
	<1412375951-13940-3-git-send-email-armansito@chromium.org>
	<CABBYNZLj2gGoCW-5hmkG2dA0i6Ss9RVJjjQhPzv=vk1ARephmQ@mail.gmail.com>
	<CAHrH25R28cLmLQH25TsTxXA=BRVMdbTec3atg5t6fMUEd_oSgw@mail.gmail.com>
	<CABBYNZJRX6vorDhW6_XecwKjEmvz3D6g97f9X_DjJRL=5dV5Ag@mail.gmail.com>
	<CAHrH25T+PiZtcNcR_Z+LcyO=mFyLWKRQie0fBHBCwVPU3zGzYQ@mail.gmail.com>
	<CABD6X-+NhN9PPSXh7=vrTsrZKGFmzsXe6Cr+RqG=SaSZnUUJZA@mail.gmail.com>
Date: Mon, 6 Oct 2014 16:53:49 -0400
Message-ID: <CAHrH25TgUBcWJ4woDs374=55kRX=DmtpyyYPxwKs1_S7iViYkg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] shared/gatt-server: Introduce shared/gatt-server.
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,


>> Yep, this is exactly what I had in mind. The problem though is that
>> somebody still needs to pass in that callback. So maybe we could
>> change gatt_db_read to accept an additional callback/user_data which
>> would then get forwarded to the registered gatt_db_read_t. That would
>> definitely fix the problem here. It would also not break the android
>> code, since it can already work without invoking the callback. I'll
>> experiment with this.
>
> I thought about simple callout, like gatt_db_result().Gatt_db can call
> read callback with
> specific data, like gatt_db_transaction_data, then, once app, server
> or anything will complete
> read or write operation, just simply call gatt_db_result() with
> previously passed transaction data.
>

That makes sense. For now, I'm leaving the callback out of the first
patch set. I'll think about this a little more and upload something
later this week.

Thanks,
Arman
