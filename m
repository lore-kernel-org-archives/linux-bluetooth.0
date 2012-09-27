Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50642ED8.3090007@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com>
	<50642ED8.3090007@tieto.com>
Date: Thu, 27 Sep 2012 08:03:46 -0400
Message-ID: <CAJdJm_NLz-rd1w59pBDP_QMWKVcZ3-N0FMNqy1UCisBzZL-VNQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] Thermometer watchers API change + fixes
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 27, 2012 at 6:47 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
>> Maybe we should consider implementing a simple Thermometer role in
>> BlueZ for testing purposes. It is a relatively simple profile.
>
>
> So you mean something like optional org.bluez.ThermometerSensor interface on
> adapter, similar to what is done for reporter role for Proximity?

Yes. There has been some interest on the past on the mailing list from
people willing to implement this role on BlueZ (although I have not
heard anymore from them), so it would become not just a test plugin,
but have an API that allows for BlueZ to expose some external
thermometer measurements over LE. But for now a "dummy" thermometer
which sends dummy measurements in various formats should be enough
(probably enabled only with --enable-test so it is not installed in
production).

Do you have interest/time for working on something like this?

BTW, I definitely plan to test both your HRP implementation and the
HTP changes, but currently I'm working in other things... I'll let you
know once I have these tested (probably with patches if I find any
issues).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
