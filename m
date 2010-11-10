Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101110062030.GE20384@null>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
	<AANLkTina_HUT3SGEUMemVLrD4N3+Ni+xCsaC57whHDZG@mail.gmail.com>
	<20101110062030.GE20384@null>
Date: Wed, 10 Nov 2010 06:46:47 -0400
Message-ID: <AANLkTi=iCXfycMzHbgwS3jbvCxJvzVh97iSDRf4WhQeQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth Low energy support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 10, 2010 at 2:20 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> On Tue, Nov 09, 2010 at 05:25:10PM +0100, ext Anderson Lizardo wrote:
>> While doing tests with your most recent trees (using devel HW from
>> TI), I'm getting consistent panic on the following test:
>>
>> (dev1) hciconfig hciX leadv
>> (dev2) hcitool -i hciX lecc <dev2_addr>
>
> Did you have server listening on dev 2 on ATT socket?

I had no bluetoothd running on any side (not sure if that was your question).

>> I attached two logs. One is from dev1 machine (which has the oops),
>> the other is from the dev2 machine.
>
> I'll try to fix this today.

Thanks,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
