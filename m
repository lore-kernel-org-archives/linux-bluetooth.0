Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTitrvDEsOGy_RAXS4=2D0YUBmLhQAyejvPVacc_sTXHpA@mail.gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
	<CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
	<CABBYNZJwOvn48nx7y=T=64A+8MnmxS2vdVD+3A9TK7v89T2wHQ@mail.gmail.com>
	<CANT-zCXBoa+SsSqrMahPFumww65GaNVyYKCWefZK-a+pzS+RXg@mail.gmail.com>
	<CABBYNZ+030STq_Z4iNFCThAbLv5ZMaxkiMUzv4CtSi656ohkRw@mail.gmail.com>
	<CANT-zCV57v6yPy=eLg8g9LfC8igZt5Pete3t=OUsJ31z8m0kXw@mail.gmail.com>
	<CAB7rCTitrvDEsOGy_RAXS4=2D0YUBmLhQAyejvPVacc_sTXHpA@mail.gmail.com>
Date: Thu, 17 May 2012 16:41:46 +0300
Message-ID: <CABBYNZ+sDobFgES_V8HLYfb46MSNNmRwOA1=3_PsCmDgWaGPEQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Wed, May 16, 2012 at 5:28 PM, Mike <puffy.taco@gmail.com> wrote:
>> I do agree that anything that could cause IOP problems should be
>> handled inside BlueZ. And the immediate reconnection try after a link
>> loss does sound an example of this kind. So I would be fine if BlueZ
>> internally handles this, but I still think we need to expose this in
>> D-Bus somehow.
>
> The reason this is per model is that there is no spec on this and
> hence it will be very implementation specific.  If you are a desktop
> hooked up to AC, you really don't care, but an embedded device will
> need to implement something that meets its battery constraints.  As
> well, the efforts of bluez will be fruitless if the rest of the system
> goes into suspend.  In my case, my device goes to suspend as soon as
> possible (and wakes if there is BT UART traffic).  Hence, timers that
> implement re-connection need to let the system know when the next
> attempt will occur.

Yes, but that can be implemented in audio.conf, so you can enter the
number of retries and the interval between them that you want per
platform, but I think 99% will just pick the default. Btw, you need to
elaborate a bit more about your requirements, this work is focuses on
IVI system where I don't expect the system to go into suspend that
often.


-- 
Luiz Augusto von Dentz
