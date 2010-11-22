Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101122071243.GA23443@jh-x301>
References: <1290111749-8968-1-git-send-email-johan.hedberg@gmail.com>
	<1290111749-8968-2-git-send-email-johan.hedberg@gmail.com>
	<AANLkTinMq-3K09y-bCWM1Z254FsWoRuZ=QEuZM11WPMb@mail.gmail.com>
	<20101122071243.GA23443@jh-x301>
Date: Mon, 22 Nov 2010 22:35:51 +0200
Message-ID: <AANLkTikHPWyjS+m2NMrxcL0FP6WhX+APExNELRuw4=Pe@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Automate remote name requests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Arun K. Singh" <arunkat@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 22, 2010 at 9:12 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arun,
>
> On Mon, Nov 22, 2010, Arun K. Singh wrote:
>> > The code will work sub-optimally with userspace versions that still
>> > do the name requesting themselves (it shouldn't break anything
>> > though) so it is recommended to combine this with a userspace
>> > software version that doesn't have automated name requests.
>>
>> Could you be bit more explicit about such user space versions that you
>> recommend? Would latest bluez versions such as 4.80 qualify for your
>> recommendation?
>
> The automated name requests upon "connect complete" events were removed
> in 4.78 so any version from there onwards would qualify.

Maybe there is some way to detect that the kernel is not doing it, or
at least force bluetoothd to resolve once to make sure it can be used
with older kernel versions so it doesn't have to always update as it
was used to be but if we are to authenticate or authorize a device it
should have a name so the ui can display it to the user.

-- 
Luiz Augusto von Dentz
Computer Engineer
