Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101213132145.GA13767@jh-x301>
References: <AANLkTin4xG5KUEpn6QaZA0V6y3cDvxpWhwRJhMrE_8QO@mail.gmail.com>
	<20101213120003.GA12104@jh-x301>
	<AANLkTim2Q9dgj0t+AAcww33O=pdOHJp=sfQ_F7s8N08i@mail.gmail.com>
	<20101213132145.GA13767@jh-x301>
Date: Mon, 13 Dec 2010 14:56:05 +0100
Message-ID: <AANLkTin=vZ6rwx+8+KvdGtpSmWdSuvnyrwgCsLK_Axfo@mail.gmail.com>
Subject: Re: How to implement multiple instances of obexd service?
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 13, 2010 at 2:21 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Slawek,
>
> On Mon, Dec 13, 2010, Slawomir Bochenski wrote:
>> On Mon, Dec 13, 2010 at 1:00 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> >> And what about assigned bitmask values for services in src/obex.h?
>> >
>> > Do we need to change something there?
>>
>> In that case src/obex.h is the only place that will need simple
>> modification for now -- MAP service value for services bitmask. This
>> may be OBEX_MAP (or OBEX_MAS) and I supppose its value should be the
>> next one available -- (1 << 8).
>
> Right, we'll need that. I thought you were talking about something
> related to multiple MAS instances (which I don't think affect this
> bitmask in any way).
>
> Johan
>

Yes, if we were to implement multiple instances using multiple
obex_service_driver structures (which would be needed in order to
support additional sdp records and additional channels), then we would
again have to add one define for each planned instance as obexd allows
adding only one service driver per service.

-- 
Slawomir Bochenski
