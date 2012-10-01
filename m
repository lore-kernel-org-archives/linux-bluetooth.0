Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50698235.10804@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com>
	<50642ED8.3090007@tieto.com>
	<CAJdJm_NLz-rd1w59pBDP_QMWKVcZ3-N0FMNqy1UCisBzZL-VNQ@mail.gmail.com>
	<50698235.10804@tieto.com>
Date: Mon, 1 Oct 2012 07:51:33 -0400
Message-ID: <CAJdJm_OWk=DmodAPyEpxgSJNT31vWg3GG9xOOUWhZTrU8U6ixg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Thermometer watchers API change + fixes
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Oct 1, 2012 at 7:44 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> By "dummy" thermometer you mean separate plugin (dummythermometer or sth)
> which, once enabled, will register service in GATT and send dummy
> measurements when configured by remote? Or perhaps develop it inside
> thermometer profile (implemented as described above) so it can be changed
> into full blown thermometer role with API etc. later?

I was thinking having it under profiles/thermometer (just like
proximity reporter is currently in profiles/proximity). The "dummy"
code could then be replaced later with the API. As long as nothing is
enabled until the CCC is written, I don't see any problem having it
running along HTP collector.

>> BTW, I definitely plan to test both your HRP implementation and the
>> HTP changes, but currently I'm working in other things... I'll let you
>> know once I have these tested (probably with patches if I find any
>> issues).
>
>
> I should have BLE PTS dongle this week so will test both implementations as
> well in case you won't manage to do this until then.

Great!

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
