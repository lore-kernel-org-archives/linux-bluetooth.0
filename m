Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5134D134.6020101@oss.bmw-carit.de>
References: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1362064124-29787-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<CABBYNZKQV8jJFeCPB_t+_Lv1FgPQYu72zj-nmXoatAZkA-A_tg@mail.gmail.com>
	<CABBYNZLvDKP18EjgVqa9r4Dt7rTBcDEEz0jv8e6fs9LUSOnwaw@mail.gmail.com>
	<5134D134.6020101@oss.bmw-carit.de>
Date: Mon, 4 Mar 2013 23:05:09 +0200
Message-ID: <CABBYNZ+28dtWeppPuiN9AQ7k5MUsn9kUHvSgQ80VyKEAwGO1pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] obexd: Add support for retrieving messages in fractions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Mar 4, 2013 at 6:52 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> Hi Luiz,
>
> On 03/01/2013 02:13 PM, Luiz Augusto von Dentz wrote:
>>
>> So from the discussion the IRC yesterday I think we can have this
>> transparently handled by the transfer, we can perhaps add Suspend/Resume and
>> suspended state API to Transfer interface which probably in this case should
>> auto suspend if FractionDelivery is set so the application has to resume to
>> get the parts but they all belong to the same transfer and are saved in the
>> same file. -- Luiz Augusto von Dentz -- To unsubscribe from this list: send
>> the line "unsubscribe linux-bluetooth" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>
>
> The first fraction is already a valid bMessage object, further fractions
> contain enclosed bBody objects.
> Since the application has to deal with the bMessage format already, there is
> no need to hide the fractions in the transfer objects.

If they are all bmsg then you are right, they should be in their own transfer.

> The proposed way of simply adding a FractionDeliver parameter to the message
> meta data, allows the application to easily
> deal with the fractions without adding too much complexity to itself or
> BlueZ.

Im still not sure why the spec haven't done this in some other way,
but Im fine wit the parameter provide we can actually tell when it is
supported.

-- 
Luiz Augusto von Dentz
