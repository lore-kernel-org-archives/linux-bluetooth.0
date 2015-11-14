Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151114132010.GA19429@t440s.P-661HNU-F1>
References: <1447504138-3575-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
 <1447504138-3575-2-git-send-email-andrzej.kaczmarek@codecoup.pl> <20151114132010.GA19429@t440s.P-661HNU-F1>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Sat, 14 Nov 2015 14:31:55 +0100
Message-ID: <CADAkoF7qfwtxO2kRBzUQike_qxPt8bCKdO_ErLvOhyJv3Zbgkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] monitor/rfcomm: Fix frame names formatting
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sat, Nov 14, 2015 at 2:20 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrzej,
>
> On Sat, Nov 14, 2015, Andrzej Kaczmarek wrote:
>> ---
>>  monitor/rfcomm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
>> index bdf4000..91f0c39 100644
>> --- a/monitor/rfcomm.c
>> +++ b/monitor/rfcomm.c
>> @@ -422,10 +422,10 @@ struct rfcomm_data {
>>
>>  static const struct rfcomm_data rfcomm_table[] = {
>>       { 0x2f, "Set Async Balance Mode (SABM) " },
>> -     { 0x63, "Unnumbered Ack (UA)" },
>> -     { 0x0f, "Disconnect Mode (DM)" },
>> -     { 0x43, "Disconnect (DISC)" },
>> -     { 0xef, "Unnumbered Info with Header Check (UIH)" },
>> +     { 0x63, "Unnumbered Ack (UA) " },
>> +     { 0x0f, "Disconnect Mode (DM) " },
>> +     { 0x43, "Disconnect (DISC) " },
>> +     { 0xef, "Unnumbered Info with Header Check (UIH) " },
>
> I don't see any other users of print_indent() using this kind of extra
> space at the end of the strings. Why would RFCOMM need it if the other's
> don't?
>
> In general, I think it's a bad idea to have formatting details like this
> in the lookup table since that makes it more difficult to reuse the
> string in various scenarios. Instead, the needed spacing should be done
> in the format string that's used in the printf (or similar) function.

Agree, I actually fixed one more similar formatting issue (in a good
way this time) so will send v2 with both changes together.

BR,
Andrzej
