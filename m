Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
	<CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
Date: Tue, 15 May 2012 11:10:05 +0300
Message-ID: <CABBYNZJwOvn48nx7y=T=64A+8MnmxS2vdVD+3A9TK7v89T2wHQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 15, 2012 at 9:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

> The connection/reconnection policy is manufacturer and model-specific.
> Therefore I find it difficult that we could include this inside
> bluetoothd.

Well the Simultaneous Use of HFP, A2DP and AVRCP has a recommendation
to re-connect:

Recommendation 9:
An automatic re-connection policy can be used to re-connect the
signaling connections after link loss. In this case only the RD side
should reconnect. The number of attempts and periodicity are
implementation dependant, but it is recommended to have a relatively
small limit on the number of attempts to avoid battery drainage.
Motivation 9:
Since a link loss is an unexpected behavior for the user, an automatic
action of attempting to reconnect improves the user experience. MP
should not try to reconnect to avoid collisions.

So if it is recommended by the white paper I don't see why it should
be manufacture/model specific, note that only the number of attempts
to re-connect is implementation dependent, but we can have an option
in audio.conf where the platform configure the number of attempts and
perhaps the interval between them if we cannot find a good default.

> Having said that, I would be happy to review any proposal.
>
>> Btw, none of this is useful without tuning the link supervision
>> timeout because the current one used by BlueZ iirc is 20 seconds, far
>> too big for being able to recover the audio.
>
> That should definitely be tuned. However it's not always about
> recovering audio, but knowing to which phone the car should connect.
> With HFP there might be no audio and no voicecall during connection.

Still 20 seconds to detect link-loss will be noticeable by the user,
which is the whole point of the recommendation.


-- 
Luiz Augusto von Dentz
