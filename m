Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130204083030.GA1147@x220>
References: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
	<20130204083030.GA1147@x220>
Date: Mon, 4 Feb 2013 02:34:07 -0600
Message-ID: <CABBYNZ+u55P_TVMUEcfwJkc9KpT2GVnYjZzG6RuFVfWhReGpsg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] AVRCP: Handler player features as a byte array
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Feb 4, 2013 at 2:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Sun, Feb 03, 2013, Luiz Augusto von Dentz wrote:
>> --- a/profiles/audio/player.c
>> +++ b/profiles/audio/player.c
>> @@ -67,7 +67,7 @@ struct media_player {
>>       char                    *name;          /* Player name */
>>       char                    *type;          /* Player type */
>>       char                    *subtype;       /* Player subtype */
>> -     uint64_t                features[2];    /* Player features */
>> +     uint8_t                 *features;      /* Player features */
>
> Why not just have this as features[16] here as well so you don't need to
> do g_memdup and g_free?

I was planning to have a NULL check if the features are valid.


--
Luiz Augusto von Dentz
