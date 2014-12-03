Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <003d01d00ec7$976a6f00$c63f4d00$@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
	<1416577665-21876-2-git-send-email-vikram.pal@samsung.com>
	<CABBYNZLhEKz3GQRg-NgwC=tEorV_ygV+FmR_65_r7Bx6tZzSxw@mail.gmail.com>
	<003d01d00ec7$976a6f00$c63f4d00$@samsung.com>
Date: Wed, 3 Dec 2014 10:20:39 +0200
Message-ID: <CABBYNZK8F+2sSeBBK6LRyOGTZ9pMNt=RaXpu7Z8zBrHEjkTETg@mail.gmail.com>
Subject: Re: [PATCH 1/7] monitor: Adjust for ERTM control bytes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Wed, Dec 3, 2014 at 9:05 AM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Friday, November 28, 2014 2:08 PM
>> To: Vikrampal Yadav
>> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
>> Subject: Re: [PATCH 1/7] monitor: Adjust for ERTM control bytes
>>
>> Hi Vikram,
>>
>> On Fri, Nov 21, 2014 at 3:47 PM, Vikrampal Yadav
>> <vikram.pal@samsung.com> wrote:
>> > Adjustment for ERTM control bytes fixed.
>> > ---
>> >  monitor/l2cap.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index ebdd20f..635b967
>> > 100644
>> > --- a/monitor/l2cap.c
>> > +++ b/monitor/l2cap.c
>> > @@ -2621,6 +2621,9 @@ static void l2cap_frame(uint16_t index, bool in,
>> uint16_t handle,
>> >                 connless_packet(index, in, handle, cid, data, size);
>> >                 break;
>> >         case 0x0003:
>> > +               /* Adjust for ERTM control bytes */
>> > +               data += 2;
>> > +               size -= 2;
>> >                 amp_packet(index, in, handle, cid, data, size);
>> >                 break;
>> >         case 0x0004:
>> > --
>> > 1.9.1
>>
>> What are those bytes, shouldn't they be printed?
>
> These bytes are not being printed even in hcidump.

Which is probably wrong, this is the ERTM control bytes that should be
parsed the same way regardless of the CID, hcidump apparently only
parse ERTM control in case of Connection oriented channel and ignores
the fact AMP Manager Channel also uses ERTM.

>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Regards,
> Vikram
>



-- 
Luiz Augusto von Dentz
