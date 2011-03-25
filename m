Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=Yebkv+B=8WvaPkV1-Q+UifKX+UohN5p=977pq@mail.gmail.com>
References: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
	<AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
	<20110325163549.GA9894@jh-x301>
	<AANLkTi=Yebkv+B=8WvaPkV1-Q+UifKX+UohN5p=977pq@mail.gmail.com>
Date: Fri, 25 Mar 2011 13:26:06 -0400
Message-ID: <AANLkTimmyZK07X_CfDOseTXSaA+KSXvZKwMB9csX0jj=@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add local Extended Inquiry Response (EIR) support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 25, 2011 at 1:23 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Johan,
>
> On Fri, Mar 25, 2011 at 12:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Lizardo,
>>
>> On Fri, Mar 25, 2011, Anderson Lizardo wrote:
>>> > +static u16 get_uuid16(u8 *uuid128)
>>> > +{
>>> > +       u8 *b = bluetooth_base_uuid;
>>> > +       u32 val;
>>> > +       int i;
>>> > +
>>> > +       for (i = 4; i < 16; i++) {
>>> > +               if (b[i] != uuid128[i])
>>> > +                       return 0;
>>>
>>> Don't you need to check bytes 0 and 1 as well, i.e. only bytes 2 and 3
>>> are changed?
>>
>> The first four bytes can have any value for Bluetooth UUIDs. The purpose
>> of this part of the function is to determine whether it's a Bluetooth
>> UUID or not (i.e. derived from the Bluetooth base UUID), so the four
>> first bytes don't matter.
>
> At least for UUIDs used in attribute types I see this on the spec (page 1835):
>
> "Or, to put it more simply, the 16-bit Attribute UUID replaces the x’s
> in the follow-
> ing:
> 0000xxxx-0000-1000-8000-00805F9B34FB"
>
> I.e. , only third and fourth bytes being part of 16-bit UUID.

Hmm, now I see you implicitly do what I was proposing by using:

+       if (val > 0xffff)
+               return 0;

So you can just ignore this comment :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
