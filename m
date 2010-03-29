Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1269851341.11714.203.camel@localhost.localdomain>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
	 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
	 <20100329074539.GA20839@jh-x301>
	 <1269851341.11714.203.camel@localhost.localdomain>
Date: Mon, 29 Mar 2010 21:48:49 +0300
Message-ID: <2d5a2c101003291148u1836742w1222097fb865ef61@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Francisco Alecrim <francisco.alecrim@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 29, 2010 at 11:29 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Johan,
>
>> > Emitting Adapter.PropertyChanged signal when UUIDs change. D-Bus messa=
ge
>> > to inform that adapter properties changed.
>> > ---
>> > =A0src/adapter.c =A0 =A0 =A0 | =A0 75 ++++++++++++++++++++++++++++++++=
++++++++++++------
>> > =A0src/adapter.h =A0 =A0 =A0 | =A0 =A01 +
>> > =A0src/sdpd-database.c | =A0 =A03 ++
>> > =A03 files changed, 70 insertions(+), 9 deletions(-)
>>
>> Thanks for the patches. In principle they look good, but I haven't
>> applied them yet due to one thing that looks a bit strange: both the SDP
>> server record UUID (0x1000) as well as the public browse group UUID
>> (0x1001) always show up in the UUIDs list. I wonder if there'd be any
>> clean way to avoid getting them into the list. Marcel, do you have any
>> idea about this or is it even a problem that these UUIDs are always in
>> the list?
>
> these UUIDs are always in the server, but not in the public browse group
> and we skip them on purpose. The only reason why they are always present
> is that the specification requires it.

IMO, it should be the same list as we export in extended inquiry
response, so perhaps we could use the data from
create_ext_inquiry_response which already filter those away. Perhaps
some refactoring could also be done since this code seems to be called
multiple times in case of new services because it also changes class
which then triggers create_ext_inquiry_response again.


--=20
Luiz Augusto von Dentz
Computer Engineer
