Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 15:40:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Par-Gunnar HJALMDAHL <par-gunnar.hjalmdahl@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Anurag GUPTA-1 <anurag.gupta@stericsson.com>
Subject: Re: [PATCH] network: Check full BNEP UUID
Message-ID: <20120815124030.GA2498@x220>
References: <1343380000-24935-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
 <20120815103912.GA26379@x220>
 <81C3A93C17462B4BBD7E272753C1057923B924CB0D@EXDCVYMBSTM005.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057923B924CB0D@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi P-G,

On Wed, Aug 15, 2012, Par-Gunnar HJALMDAHL wrote:
> Basically I tried to keep the patch to a minimum since it was quite a 
> simple issue to fix.
> 
> I have no problems to use the UUID in lib/uuid.c. I could add a 2 new
> exported functions for retrieving base UUID, one for little endian and
> one for big endian, since uuid.c endian depends on CPU endian while
> PAN endian is always big endian. So:
> void get_le_bt_base_uuid(uint128_t *uuid);
> void get_be_bt_base_uuid(uint128_t *uuid);

Note that the uuid.{c,h} name space is bt_uuid_*

So far uuid.c has been fully hiding any endianness issues in its public
API by only talking host-endianness. So, if this was to be really done
in a clean way I'd say the calling code should look like:

	uint128_t u128;
	bt_uuid_t uuid;

	u128 = bt_get_be128(dest);

	bt_uuid128_create(&uuid, u128);
	if (!bt_uuid_is_bluetooth(&uuid))
		return BNEP_CONN_INVALID_DST;

	/* same for source */

However, as this would require at least two new functions
(bt_get_be128() in lib/bluetooth.h and bt_uuid_is_bluetooth() in
lib/uuid.c) and like you say the use case is quite trivial, I think this
might be a bit overkill.

So, since you were fine with my alteration of your patch I think I'll
just go ahead and push it upstream. If you still want to add the
necessary APIs for the "truly clean" approach, feel free, but I won't be
bugging you about it ;)

Johan
