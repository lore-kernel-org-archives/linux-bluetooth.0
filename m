Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKQV8jJFeCPB_t+_Lv1FgPQYu72zj-nmXoatAZkA-A_tg@mail.gmail.com>
References: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1362064124-29787-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<CABBYNZKQV8jJFeCPB_t+_Lv1FgPQYu72zj-nmXoatAZkA-A_tg@mail.gmail.com>
Date: Fri, 1 Mar 2013 15:13:06 +0200
Message-ID: <CABBYNZLvDKP18EjgVqa9r4Dt7rTBcDEEz0jv8e6fs9LUSOnwaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] obexd: Add support for retrieving messages in fractions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Thu, Feb 28, 2013 at 5:24 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Christian,
>
> On Thu, Feb 28, 2013 at 5:08 PM, Christian Fetzer
> <christian.fetzer@oss.bmw-carit.de> wrote:
>> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>>
>> Fractioned messages can be requested if the reception_status is fractioned.
>> For requesting Message.Get has been extended with a FractionRequest
>> parameter that can be set to 'first' or 'next'.
>> After a part of the message has been transfered, the client can query
>> the message's properties. The property FractionDelivery is set to 'more'
>> or 'last' depending if more fractions exist or not.
>
> There is an import part missing in the description, the use case where
> this is necessary, I don't see how this can be useful, or it is just
> to show parts of the messages?

So from the discussion the IRC yesterday I think we can have this
transparently handled by the transfer, we can perhaps add
Suspend/Resume and suspended state API to Transfer interface which
probably in this case should auto suspend if FractionDelivery is set
so the application has to resume to get the parts but they all belong
to the same transfer and are saved in the same file.

--
Luiz Augusto von Dentz
