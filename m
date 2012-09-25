Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 25 Sep 2012 11:21:21 -0400
Message-ID: <CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] Thermometer watchers API change + fixes
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Sep 25, 2012 at 10:52 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Hi,
>
> Here's series of patches to move watchers from per-device to per-adapter
> interface (basically the same as done for HRP, see other series of patches).
> This applies to both final and intermediate temperature watchers - once
> watcher is registered, all connected devices are setup to send measurement
> notifications and the opposite when last watcher is unregistered.
>
> This major change is done in patches 1-6.
>
> Patches 7-11 contain some code and documentation refactoring, i.e. to
> remove duplicated code.
>
> Patches 12-14 are trival coding style fixes.
>
> Unfortunately, I wasn't able to fully test this code due to lack of proper
> thermometer device and sample device from CC2540 devkit does not quite
> work as expected (e.g. I can see CCC is written properly when watcher is
> registered but remote does not send any indications for unknown reason).

Unfortunately, the thermometer demo app (at least on TI's BLE stack
v1.1 installation) has several bugs. I haven't tested yet the latest
release (1.2.1), which version are you using?

Do you have access to PTS? You could test with it as well.

Maybe we should consider implementing a simple Thermometer role in
BlueZ for testing purposes. It is a relatively simple profile.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
