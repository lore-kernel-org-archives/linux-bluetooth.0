Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110504060357.GA3711@jh-x301>
References: <1304030229-6672-3-git-send-email-claudio.takahasi@openbossa.org>
	<1304458357-21571-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110504060357.GA3711@jh-x301>
Date: Wed, 4 May 2011 07:14:52 -0400
Message-ID: <BANLkTikUJ43T6bfMwKgH0Z07=Vp4dM2TPw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] Add Bluetooth address type definition
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, May 4, 2011 at 2:03 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, May 03, 2011, Claudio Takahasi wrote:
>> Values defined to LE(public and random) are defined in the Bluetooth
>> Core Specification. For basic rate, there isn't address type concept.
>> The constants introduced by this commit will be used to identify the
>> remote address type, basically to distinguish LE/BR devices before
>> to request the L2CAP connection.
>> ---
>>  lib/bluetooth.h |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
>> index 738e07a..98b8f1c 100644
>> --- a/lib/bluetooth.h
>> +++ b/lib/bluetooth.h
>> @@ -130,6 +130,10 @@ typedef struct {
>>  #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
>>  #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
>>
>> +#define BDADDR_TYPE_LE_PUBLIC        0x00
>> +#define BRADDR_TYPE_LE_RANDOM        0x01
>> +#define BDADDR_TYPE_BR               0xff
>
> Firstly this still needs Marcel's blessing (though I don't really see
> any other solution than an address type with three possible values).
> Secondly, if this is ever going to be added to the L2CAP socket address
> you'd have to have 0x00 as BDADDR_TYPE_BR for backwards compatibility.

The values for LE public/random were chosen to match the "address
type" field on HCI LE commands. We can of course use other values and
map to the HCI ones.

Also, as mentioned on the cover letter of the first version, we have
suggested using "BDADDR_TYPE_NON_LE" instead of "BDADDR_TYPE_BR", to
make it clear that value is more a "fallback" for non-LE addresses.

IIRC there is no current plan to put these types on the socket address
struct (the idea is to use, for instance, on device found events), but
if we go that path, I agree using 0x00 for BR/EDR makes more sense.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
