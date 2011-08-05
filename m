Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110805094201.GA29768@dell>
References: <1312528777-4152-1-git-send-email-dmitriy.paliy@nokia.com>
	<20110805094201.GA29768@dell>
Date: Fri, 5 Aug 2011 12:54:33 +0300
Message-ID: <CAHMBquUuWHVyz=zTwpk85SMtcSbCFjbMitJLAwxGVNdzesSWLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add stop playing ringtone to maemo6 telephony driver
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Aug 5, 2011 at 12:42 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Dmitriy,
>
> On Fri, Aug 05, 2011, Dmitriy Paliy wrote:
>> If ringtone is loud enough, it may leak to microphone when call is
>> answered via Bluetooth headset. As result, it can be heard on remote
>> end. Therefore, playing ringtone shall be stopped as fast as possible
>> before answering a call.
>> ---
>>  audio/telephony-maemo6.c |   34 +++++++++++++++++++++++++++++++++-
>>  1 files changed, 33 insertions(+), 1 deletions(-)
>
> Both patches have been applied. Thanks. I also pushed a patch which
> moves around the static functions so that forward-declarations of them
> are not needed.

Thanks. Actually I have added forward declaration on purpose in order
not to move functions anymore.

Dmitriy
