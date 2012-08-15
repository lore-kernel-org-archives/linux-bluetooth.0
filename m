Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.hjalmdahl@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Anurag GUPTA-1 <anurag.gupta@stericsson.com>
Date: Wed, 15 Aug 2012 13:17:16 +0200
Subject: RE: [PATCH] network: Check full BNEP UUID
Message-ID: <81C3A93C17462B4BBD7E272753C1057923B924CB0D@EXDCVYMBSTM005.EQ1STM.local>
References: <1343380000-24935-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
 <20120815103912.GA26379@x220>
In-Reply-To: <20120815103912.GA26379@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi and thanks for you comments Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: den 15 augusti 2012 12:39
> To: Par-Gunnar HJALMDAHL
> Cc: linux-bluetooth@vger.kernel.org; Anurag GUPTA-1
> Subject: Re: [PATCH] network: Check full BNEP UUID
> 
> There are a couple of things that bug me a bit with this patch. One is
> the re-definition of bluetooth_base_uuid which really should only exist
> in one central place (lib/uuid.c). Another is the way the code logic
> goes. It seems you want to test for two things:
> 
> 	1) That the UUID is a Bluetooth UUID. This is the memcmp
> with
> 	the last 12 bytes of the Bluetooth base UUID for the UUID128
> 	case. 16 and 32 bit values are already implicitly assumed to
> be
> 	Bluetooth UUIDs as they don't contain any information to
> reveal
> 	this as such.
> 
> 	2) That the (now determined) Bluetooth UUID has a value less
> 	than or equal to 0xffff. This is quite awkwardly tested for
> by
> 	comparing with the two first bytes from bluetooth_base_uuid,
> 	which are both zeros. Based on your code comment it sounds
> like
> 	this test should really be covered by bnep_setup_chk().
> 
> If you really want to have the "<= 0xffff" test be in bnep_setup_decode
> then I'd propose something like the attached patch. However, testing
> for the exact value of the Bluetooth UUID (once the UUID has been
> determined to be a Bluetooth UUID) seems like the task of
> bnep_setup_chk from the way you've laid out the functions.
> 
> Johan

Basically I tried to keep the patch to a minimum since it was quite a 
simple issue to fix.

I have no problems to use the UUID in lib/uuid.c. I could add a 2 new
exported functions for retrieving base UUID, one for little endian and
one for big endian, since uuid.c endian depends on CPU endian while
PAN endian is always big endian. So:
void get_le_bt_base_uuid(uint128_t *uuid);
void get_be_bt_base_uuid(uint128_t *uuid);

Your suggestion looks fine. It's a bit more effective than my original
code. The reason I did the check in bnep_setup_decode() rather than in
bnep_setup_chk is that only 16 bits are kept when exiting the function
(bnep_setup_decode is the only function aware of the UUID size) and I
thought that was a quite straightforward design.

If it's OK with you I can create a new patch with suggestion above
plus your patch.

/P-G

