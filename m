Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=qrkSSmDNcVNpFm=3=5mSzs9Se08h8JDryDcOu@mail.gmail.com>
References: <AANLkTimXDqAej=LAVDvDgspKuH_SAKivp9eL8R9tXPJc@mail.gmail.com>
	<AANLkTi=qrkSSmDNcVNpFm=3=5mSzs9Se08h8JDryDcOu@mail.gmail.com>
Date: Tue, 31 Aug 2010 10:15:58 -0500
Message-ID: <AANLkTi=NqwG-DRHPe-SQ0Dca1CDgQuDnqW28yFCByHhW@mail.gmail.com>
Subject: Re: BlueZ's A2DP sink role
From: Pavan Savoy <pavan_savoy@sify.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 19, 2010 at 3:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Pavan,
>
> On Wed, Aug 18, 2010 at 11:22 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
>> As I understand, the A2DP sink role is @ audio/source.c and A2DP
>> source role is at sink.c ? (or what is called as the interfaces?..)
>> Also How do I test out a2dp sink role in BlueZ, any test audio-server
>> I can run ?
>
> You can use PA as explained in Joao Paulo's blog:
>
> http://jprvita.wordpress.com/2009/12/15/1-2-3-4-a2dp-stream/
>

Thanks....
Something regarding AVRCP target and controller role, So Just saying
Enable=Control,Source
gets me both AVRCP TG and AVRCP CT why? isn't there specific option for it?

Also is there a man page/wiki for audio.conf which gets updated now
and then? with all these new options...

> --
> Luiz Augusto von Dentz
> Computer Engineer
>
