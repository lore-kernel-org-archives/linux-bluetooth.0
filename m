Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121218202458.GA8716@samus>
References: <CANT-zCWNUkTW9pmcvuDEhaEuSxdhphYLwvQkSYz5dLvYE2ENjg@mail.gmail.com>
	<CANT-zCVXOjncycx6GSghO6T5y3TEM0FDA1Ke3W8FZSE=ZOhbVQ@mail.gmail.com>
	<20121218202458.GA8716@samus>
Date: Wed, 19 Dec 2012 12:07:44 +0100
Message-ID: <CANT-zCUt1OnyrhX+aJV7yGRBm5jv0TWUbWy82nsWeJKw5cD_PA@mail.gmail.com>
Subject: Re: PulseAudio branch to test BlueZ master
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, Tanu Kaskinen <tanuk@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 18, 2012 at 9:24 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Mikel,
>
> On 11:19 Tue 18 Dec, Mikel Astiz wrote:
>> On the other hand, A2DP is not working for me any more. I think this
>> might be an unrelated issue, probably a regression in BlueZ, but I
>> have to do further research.
>>
>
> This problem may have been caused by me :-) The commit "bluetooth: Add
> HFP 1.6 codec ID" was buggy, and was registering the A2DP endpoint with
> the wrong codec. Sorry about that. I pushed an updated version to my
> fork of pulseaudio[1].

You're right, it was caused by this patch. Thanks for testing.

I updated now and it seems to work both with A2DP and HFP.

Btw, now that the PulseAudio "next" branch has been merged to the
master branch, I'll send the patches as RFC to the PulseAudio mailing
list.

Cheers,
Mikel
