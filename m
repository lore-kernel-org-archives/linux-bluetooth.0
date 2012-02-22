Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <919F33058BA546BA91090A7991629B24@sisodomain.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
	<921769CBC00A43F9A939E3FA39843F27@sisodomain.com>
	<236C00190BB34FF5B78832896F9E9947@sisodomain.com>
	<CABBYNZ+uxo6Sze7EG6Q-e+A-MK4AGFBJvC3YMW86fThRg0dSeA@mail.gmail.com>
	<919F33058BA546BA91090A7991629B24@sisodomain.com>
Date: Wed, 22 Feb 2012 14:39:32 +0200
Message-ID: <CABBYNZKTuFpk-bWHJfrj-iFqRmNU24+4O2Afpw95DagqeJ6gRA@mail.gmail.com>
Subject: Re: [PATCH obexd v2 7/8] client: fix canceling queued transfers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, Feb 22, 2012 at 2:24 PM, Jaganath <jaganath.k@samsung.com> wrote:
>> Yep, this is the transfer reference, btw what test are you referring
>> to? I don't remember having problem with PTS in case of OpenOBEX and
>> we didn't wait any abort to be sent, but perhaps that is because
>> OpenOBEX had the blocking write logic while gobex wait for POLL_OUT,
>
>
> Correct. Because of POLL_OUT logic only it is not working. It was working
> earlier
> with OpenOBEX.

Ok, we should be able to fix it somehow, if we have something on
tx_queue we should perhaps just send it before disconnecting. But this
has nothing to do with this patch so lets avoid confusion here.

>> perhaps we should flush when disconnecting. Anyway PTS is pretty lame
>> since the abort request is useless if it is followed by a disconnect.
>
>
> I agree. But I think we should pass PTS test of qualification.

Yes, no questions about it.

-- 
Luiz Augusto von Dentz
