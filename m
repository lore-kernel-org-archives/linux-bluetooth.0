Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000b01cfe94c$216de430$6449ac90$@samsung.com>
References: <000b01cfe94c$216de430$6449ac90$@samsung.com>
Date: Fri, 17 Oct 2014 13:41:20 +0200
Message-ID: <CABBYNZKPex1xe0yJQkfOopBWj3QRiwF4cQd=1Jxj=xOLV69QJw@mail.gmail.com>
Subject: Re: Query regarding creation of multiple MAS Instance ID:
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 16, 2014 at 4:18 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi All,
>
> I am working on obexd MAP profile. Is it possible to create multiple MAS
> Instance in bluez?
> Because right now bluez has only one MAS Instance support (only one
> MAS_UUID), which is advertised to MCE based on the XML format followed in
> src/profile.c.
> When I add one more record to MAS_RECORD XML format by changing the value as
> 0x01, I am not able see two instances getting loaded.
>                 <attribute id=\"0x0315\">                               \
>                         <uint8 value=\"0x01\"/>                 \
>                 </attribute>                                            \

How you are doing that? You should be able to call
ProfileManager1.RegisterProfile if that is what you doing and it is
not working perhaps we have a bug somewhere. Two very important things
you need to check:

1. It cannot use the same path for both instances
2. Each instance needs a different channel

So if you are register via XML you need to take care of those details,
but perhaps you are using the default record by just providing the
UUID, that probably will not work because apparently we have hardcoded
the channel, if that is the case we should probably add a check if
there is another instance already register and use a different
channel/psm.

> Do we need to create one more UUID like OBEX_MAS1_UUID and OBEX_MAS2_UUID to
> support multiple mas instances?
> Or what could be the possible solutions?

Each instance has to have the service class set to MAS UUID, otherwise
no one will be able to discover it.

>
> Regards.
> Gowtham Anandha Babu
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
