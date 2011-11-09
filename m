Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320850111.15441.342.camel@aeonflux>
References: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>
	<1320441040.15441.303.camel@aeonflux>
	<alpine.DEB.2.02.1111041513330.11981@mathewm-linux>
	<201111091446.28192.szymon.janc@tieto.com>
	<1320850111.15441.342.camel@aeonflux>
Date: Wed, 9 Nov 2011 19:15:49 +0200
Message-ID: <CABBYNZLhjcj57ZPHUWD7qCL6EtSsQ5gmjCYn1+0aqOEtwrjzvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add ability to force local busy condition
 on L2CAP ERTM
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>, Mat Martineau <mathewm@codeaurora.org>,
	Gustavo Padovan <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 9, 2011 at 4:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> @Marcel
>> This test case is to "Verify the IUT will send an S-Frame [RNR] when it detects a Local Busy condition."
>>
>> "Pass verdict:
>> - ALT 1: The IUT immediately sends an S-Frame with function RNR after the Local
>> Busy condition is set by the Upper Tester.
>> - ALT 2: The IUT sends an S-Frame with function RNR after receiving I-Frame(s) from
>> the Tester when the Local Busy condition is set by the Upper Tester."
>>
>>
>> I was trying to pass ALT2 with Mat's suggestions but couldn't trigger local busy.
>> Minimum possible value for SO_RCVBUF (at least here on 3.0 kernel) is 2224 bytes and this is
>> still too high to allow PTS to trigger local busy (PTS tries to send txwin i-frames with 4 bytes of
>> data only).
>> [If it would possible to force PTS to send larger i-frames than it should work as well but I wasn't
>> able to find any option that would do that... please correct me if it is possible]
>>
>> With forcing local busy on channels it is possible to pass ALT1 scenario: PTS ask IUT to enter
>> local busy condition and just waits for RNR to be send.
>>
>> @Gustavo
>> If you prefer not to temper with normal code path I could just get rid of force_local_busy variable
>> and not hold channels in local busy state. This should be enough to pass test.
>
> so I like the idea to make this work with standard socket options. That
> is how we should be doing this. So lets figure out on how to make Mat's
> suggestion work for us.

Any idea why it is not possible to overwrite the minimum for the
socket buffer, its a bit annoying not being able to set them to 0
which would be useful for making readonly/writeonly sockets when using
the force socket option.

-- 
Luiz Augusto von Dentz
