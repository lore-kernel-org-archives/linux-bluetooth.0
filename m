Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120508134859.GC29352@aemeltch-MOBL1>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
	<1336483706-1533-2-git-send-email-dh.herrmann@googlemail.com>
	<20120508134859.GC29352@aemeltch-MOBL1>
Date: Tue, 8 May 2012 16:02:39 +0200
Message-ID: <CANq1E4S_JihNzBipfduBz+=Bcud_OKNSjK6rKLvGJ1tJhx86vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Replace unsafe batostr() calls with ba2str()
From: David Herrmann <dh.herrmann@googlemail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei

On Tue, May 8, 2012 at 3:49 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi David,
>
> On Tue, May 08, 2012 at 03:28:25PM +0200, David Herrmann wrote:
>> batostr() is not thread-safe so we _must_ use ba2str() in all un-protect=
ed
>> paths (which is pretty everywhere in our source).
>>
>> All places where BT_DBG() is used we call ba2str() as parameter so the
>> static buffer is unused if debug is disabled during compilation and gcc
>> should be clever enough to remove the buffers.
>>
>> Reported-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0net/bluetooth/bnep/core.c =A0 | =A0 =A04 +++-
>> =A0net/bluetooth/cmtp/core.c =A0 | =A0 =A03 ++-
>> =A0net/bluetooth/hci_conn.c =A0 =A0| =A0 =A09 ++++++---
>> =A0net/bluetooth/hci_core.c =A0 =A0| =A0 32 ++++++++++++++++++++++------=
----
>> =A0net/bluetooth/hci_event.c =A0 | =A0 17 +++++++++++------
>> =A0net/bluetooth/hci_sysfs.c =A0 | =A0 14 ++++++++++----
>> =A0net/bluetooth/hidp/core.c =A0 | =A0 =A04 ++--
>> =A0net/bluetooth/l2cap_core.c =A0| =A0 23 ++++++++++++++---------
>> =A0net/bluetooth/rfcomm/core.c | =A0 15 +++++++++------
>> =A0net/bluetooth/rfcomm/sock.c | =A0 10 ++++++----
>> =A0net/bluetooth/rfcomm/tty.c =A0| =A0 10 +++++++---
>> =A0net/bluetooth/sco.c =A0 =A0 =A0 =A0 | =A0 20 ++++++++++++++------
>> =A012 files changed, 106 insertions(+), 55 deletions(-)
>>
>> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
>> index a779ec7..03a3cb3 100644
>> --- a/net/bluetooth/bnep/core.c
>> +++ b/net/bluetooth/bnep/core.c
>> @@ -166,6 +166,7 @@ static int bnep_ctrl_set_netfilter(struct bnep_sessi=
on *s, __be16 *data, int len
>> =A0static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, i=
nt len)
>> =A0{
>> =A0 =A0 =A0 int n;
>> + =A0 =A0 char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
>
> NAK in this form. You are always allocating unneeded memory.

That's on the stack. I think gcc should be smart enough to _not_
allocate this on code paths not using it. Furthermore, there is only
one other way to do this and this is introducing a new format
specifier for snprintf() that takes as argument a bdaddr_t but I tried
to avoid this.

I also don't know what the problem is with using the stack for both
buffers? That's definitely no speed problem so you must be concerned
about stack size. But again, both are not even available when
disabling debug and thats just 18 bytes per buffer...

Please be more specific about what's bothering you here.

> PS: It is not OK to put extra #ifdef's as well.
>
> Best regards
> Andrei Emeltchenko

Cheers
David
