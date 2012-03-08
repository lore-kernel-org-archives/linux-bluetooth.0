Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331147816.3392.182.camel@aeonflux>
References: <1331118699-10591-1-git-send-email-luiz.dentz@gmail.com>
	<1331147816.3392.182.camel@aeonflux>
Date: Thu, 8 Mar 2012 11:28:34 +0200
Message-ID: <CABBYNZKvv-+FLNHoOr7M6by9MS+aChsDigZEjoL2x=5pGskhiQ@mail.gmail.com>
Subject: Re: [PATCH obexd] build: Fix libbluetooth dependency
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 7, 2012 at 9:16 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Luiz,
>
>> Building with libbluetooth prior to 4.99 cause an error:
>>
>> btio/btio.c: In function 'get_key_size':
>> btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key=
_size
>>
>> Thanks to Bastien Nocera for reporting it.
>> ---
>> =A0configure.ac | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> I rather not have this patch included since it makes things complicated
> for people to build this. Copying over just the header is good enough to
> fix this.

I would agree if we do static linking the whole libbluetooth, but just
a header IMO that is asking for trouble e.g. it could still cause
linking problems due to missing implementation or even crashes.

Maybe we should think more seriously about moving obexd inside BlueZ.


--=20
Luiz Augusto von Dentz
