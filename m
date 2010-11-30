Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101130010939.GB5919@vigoh>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20101130010939.GB5919@vigoh>
Date: Tue, 30 Nov 2010 10:41:56 +0200
Message-ID: <AANLkTimDn_oVX2YMHhEAqyw=YpeYZuX5WL6mr_F463dC@mail.gmail.com>
Subject: Re: [RFC 2/4] Bluetooth: clean up rfcomm code
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo,

On Tue, Nov 30, 2010 at 3:09 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-11-26 17:2=
2:43 +0200]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Remove extra spaces, assignments in if statement, zeroing static
>> variables.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0include/net/bluetooth/rfcomm.h | =A0 18 +++++++++---------
>> =A0net/bluetooth/rfcomm/core.c =A0 =A0| =A0 =A08 ++++----
>> =A0net/bluetooth/rfcomm/sock.c =A0 =A0| =A0 =A05 +++--
>> =A0net/bluetooth/rfcomm/tty.c =A0 =A0 | =A0 28 ++++++++++++++++---------=
---
>> =A04 files changed, 32 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfco=
mm.h
>> index 71047bc..6eac4a7 100644
>> --- a/include/net/bluetooth/rfcomm.h
>> +++ b/include/net/bluetooth/rfcomm.h
>> @@ -1,5 +1,5 @@
>> -/*
>> - =A0 RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>> +/*
>> + =A0 RFCOMM implementation for Linux Bluetooth stack (BlueZ)
>> =A0 =A0 Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>> =A0 =A0 Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>>
>> @@ -11,13 +11,13 @@
>> =A0 =A0 OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCH=
ANTABILITY,
>> =A0 =A0 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PA=
RTY RIGHTS.
>> =A0 =A0 IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABL=
E FOR ANY
>> - =A0 CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DA=
MAGES
>> - =A0 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN=
 AN
>> - =A0 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING O=
UT OF
>> + =A0 CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DA=
MAGES
>> + =A0 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN=
 AN
>> + =A0 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING O=
UT OF
>> =A0 =A0 OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>>
>> - =A0 ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS=
,
>> - =A0 COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>> + =A0 ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS=
,
>> + =A0 COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>> =A0 =A0 SOFTWARE IS DISCLAIMED.
>
> Marcel refused a patch from me in the past because its was touching legal
> stuff, so or you remove these changes for your patches or wait for
> Marcel's comments here.

I fixed extra spaces at the end of the sentences, no legal stuff
touched in legal terms :-)
I believe that it is better to have legal text identical to other
parts of the kernel otherwise
the legal stuff looks different when comparing with diff tools.

Regards,
Andrei

>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>
