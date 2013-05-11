Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJDL478uFzA2qAdj1ubav4FXEVvHix5Z37mv7oLyL0=ZQ@mail.gmail.com>
References: <1368232149-9974-1-git-send-email-vinicius.gomes@openbossa.org>
	<1368232149-9974-2-git-send-email-vinicius.gomes@openbossa.org>
	<CABBYNZJDL478uFzA2qAdj1ubav4FXEVvHix5Z37mv7oLyL0=ZQ@mail.gmail.com>
Date: Sat, 11 May 2013 11:26:18 -0300
Message-ID: <CAE6HaMnsJgsmL9nGVMm7x4ET5RYUj4rG0NPYrLK1yO2Oq0TmSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] avrcp: Fix crash using the wrong AVRCP role
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, May 11, 2013 at 5:18 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

[snip]

>
> Are you still seeing this problem after we have applied Mikel's patch?
> Perhaps we should do a late detection if we cannot find any A2DP role,
> we can figure out by looking at the get_capabilities response, but
> this would only work for 1.3 and latter. But perhaps we should use the
> initiator as under these conditions it should be the controller.

Yes, this is with Mikel's patch applied.

The second alternative sounds good to me, but just sounds, as I am not
completely
familiar with avrcp.


Cheers,
--
Vinicius
