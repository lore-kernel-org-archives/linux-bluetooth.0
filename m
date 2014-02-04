Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD81oNbWcjW_vEzf-C8VkS9Mkh92jdaKLHc_sTY9yt1wvboM3g@mail.gmail.com>
References: <CAD81oNbWcjW_vEzf-C8VkS9Mkh92jdaKLHc_sTY9yt1wvboM3g@mail.gmail.com>
Date: Wed, 5 Feb 2014 00:06:42 +0200
Message-ID: <CABBYNZLBPwp1gtgO4Wt86nrfBd=z3Uy6_NCHJObZu-waPbp_Sg@mail.gmail.com>
Subject: Re: Bluetooth qualification, AVDTP test case
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Artem Rakhov <arakhov@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

On Tue, Feb 4, 2014 at 10:36 PM, Artem Rakhov <arakhov@google.com> wrote:
> Hi Luiz,
>
> We are currently working on the Bluetooth SIG qualification, and we are
> failing AVDTP test case "TP/SIG/SMG/BI-28-C". I've found your test in the
> BlueZ source (unit/test-avdtp.c), which seems to contain implementation of
> this test case. Could you please give us some clue on how to use it to do
> the actual testing and to produce a log?

Interesting, apparently the test spec suggests resetting the signal
identifier to 0x00:

Pass verdict
The lower tester receives the AVDTP signaling message with the fields:
Transaction_label = Transaction LowerTester
Other 10 bits = All set to '0'.

While the spec suggests to keep the original signal identifier that is
being rejected see Table 8.42: General Reject response format.

We are following the spec text in this respect, thus our unit test
checks for the original signal identifier skipping the RFA bits which
is what our AVDTP implementation does when responding when receiving
such command, either way it is easy to fix but we probably need to
file an errata so the spec and test spec are more consistent regarding
general reject response.

For the purpose of qualification I think we need the full trace up to
HCI so the unit test are not enough, but there are plans to do that
via emulator.

-- 
Luiz Augusto von Dentz
