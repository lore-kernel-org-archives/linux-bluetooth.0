Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120208082123.GA5917@aemeltch-MOBL1>
References: <1328621205-14440-1-git-send-email-sancane@gmail.com>
	<20120208082123.GA5917@aemeltch-MOBL1>
Date: Wed, 8 Feb 2012 09:47:47 +0100
Message-ID: <CACLukz+4snXFn5RX+zG8JLydNOqr3BX5_vrRw=4X5GqG-jKo3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] attrib-server: Fix memory leak attaching attribute channels
From: Santiago Carot <sancane@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

2012/2/8 Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>:
> Hi Santiago,
>
> On Tue, Feb 07, 2012 at 02:26:44PM +0100, Santiago Carot-Nemesio wrote:
>> Channel is not being released when the channel is attached over
>> an uninitialized GATT server.
>> ---
>>  src/attrib-server.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/attrib-server.c b/src/attrib-server.c
>> index 2995167..e51f695 100644
>> --- a/src/attrib-server.c
>> +++ b/src/attrib-server.c
>> @@ -1020,8 +1020,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
>>       }
>>
>>       server = find_gatt_server(&channel->src);
>> -     if (server == NULL)
>> +     if (server == NULL) {
>> +             char src[18];
>
> Don't we have a good define for this magic number? I saw it in several
> places.
>

That's a good point, I've also seen it in too many places but I don't
know if there is any macro for that, at least I didn't see it.

Regards.
