Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110831075115.GA6348@dell.ger.corp.intel.com>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
	<1313798969-8772-2-git-send-email-vinicius.gomes@openbossa.org>
	<20110831075115.GA6348@dell.ger.corp.intel.com>
Date: Wed, 31 Aug 2011 14:25:20 +0300
Message-ID: <CABBYNZ++5EG+4w=VzBNKNPXQVJ_17aRyHdH6=X_LyYWxY7TZhw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] Add link_type information to the mgmt "Device
 Connected" event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 31, 2011 at 10:51 AM, Johan Hedberg <johan.hedberg@gmail.com> w=
rote:
> Hi Vinicius,
>
> On Fri, Aug 19, 2011, Vinicius Costa Gomes wrote:
>> --- a/lib/hci.h
>> +++ b/lib/hci.h
>> @@ -212,6 +212,8 @@ enum {
>> =A0#define SCO_LINK =A0 =A0 0x00
>> =A0#define ACL_LINK =A0 =A0 0x01
>> =A0#define ESCO_LINK =A0 =A00x02
>> +/* Low Energy links do not have defined link type. Use invented one */
>> +#define LE_LINK =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
>
> I remember Marcel being against any self-invented additions like this.
> Have you discussed this with him?

Actually this follows what kernel has being doing:

include/net/bluetooth/hci.h:175:#define LE_LINK		0x80

--=20
Luiz Augusto von Dentz
