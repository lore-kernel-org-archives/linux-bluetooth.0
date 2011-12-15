Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111215115009.GB8056@x220>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
	<1323703867-20577-4-git-send-email-bulislaw@linux.com>
	<20111215115009.GB8056@x220>
Date: Thu, 15 Dec 2011 12:54:32 +0100
Message-ID: <CAPGrrxWWRPkCyKgRu2SkEmdhjdZgkjEQ+ES0DhfuoshvsVBUfw@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP client
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 15, 2011 at 12:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bartosz,
>
> On Mon, Dec 12, 2011, Bartosz Szatkowski wrote:
>> +     { "GetMessagesListing", "sa{ss}", "s",  map_get_messages_listing,
>> +                                             G_DBUS_METHOD_FLAG_ASYNC },
>
> The name should be GetMessageListing and not GetMessagesListing (the
> latter isn't really proper english). I went ahead and changed it through
> a separate patch since I didn't notice before having already applied
> your patch. Also, all this seems to be missing from the API
> documentation (doc/*). Please send a patch for that.

The function name is "GetMessagesListing" in spec.
There is no doc as at the moment there is no apparams handling and no
xml parsing, so I'll send patch with doc when we reach full
functionality.

-- 
Pozdrowienia - Cheers,
Bartosz Szatkowski
