Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <12072518.xz8sZz3RZr@uw000953>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org>
	<12072518.xz8sZz3RZr@uw000953>
Date: Tue, 30 Sep 2014 09:58:13 -0700
Message-ID: <CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property
 updates on Device1.
From: Arman Uguray <armansito@chromium.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,


> I'm not sure if having this so small is good... ie those few devices I have
> they tend to have ~4 dBm RSSI oscillation when just lying next to each other
> on the desk.
>
>>               DBG("rssi %d delta %d", rssi, delta);
>>

Yeah, I'm not exactly sure if 2 is the right value to use here, though
8 is definitely too large. I basically want to be able to detect a
user walking away / coming back within a short distance and I saw
variations around 4-5 dBm there. Would 4 be a better threshold?

-Arman
