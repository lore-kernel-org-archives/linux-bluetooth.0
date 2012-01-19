Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N9f0Za56Xh3gD55iT7vO5bSkT-ujXX9pdv-hjZrFS9PQ@mail.gmail.com>
References: <1326143081-30005-2-git-send-email-claudio.takahasi@openbossa.org>
	<1326485995-707-1-git-send-email-claudio.takahasi@openbossa.org>
	<20120118121731.GC6655@x220>
	<CAJdJm_N9f0Za56Xh3gD55iT7vO5bSkT-ujXX9pdv-hjZrFS9PQ@mail.gmail.com>
Date: Thu, 19 Jan 2012 15:21:38 -0300
Message-ID: <CAKT1EBfCGV8GjzVdJ-UKRZOuKRZ_ftijCwJ_DRuRssac7+yYiw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Add Proximity Reporter API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 18, 2012 at 9:49 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Johan,
>
> On Wed, Jan 18, 2012 at 8:17 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Claudio,
>>
>> On Fri, Jan 13, 2012, Claudio Takahasi wrote:
>>> +Proximity Reporter hierarchy
>>> +===========================
>>> +
>>> +Service used by Proximity Path Loss and Find Me. Allows per device
>>> +alert level handling.
>>> +
>>> +Service              org.bluez
>>> +Interface    org.bluez.ProximityReporter
>>> +Object path  [variable prefix]/{hci0,hci1,...}
>>> +
>>> +Methods
>>> +
>>> +
>>> +Signals              ImmediateAlertLevelChanged(object device, string value)
>>> +
>>> +                     This signal indicates that Immediate Alert Level
>>> +                     characteristic was changed by the remote device.
>>> +                     Values: "none", "mild", "high".
>>> +
>>> +Properties
>>
>> Shouldn't ImmediateAlertLevel and LinkLossAlertLevel be defined as
>> properties and then you'd have PropertyChanged instead of these custom
>> signals?
>
> Initially, we discarded one approach where we could have Properties on
> the _device_ object path, because we would need to monitor each new
> created device, check if it has the Immediate/LinkLossAlertLevel
> property on the ProximityReporter interface, and if so, listen to the
> PropertyChanged signal. This seems too much overhead IMHO.
>
> Unless you are proposing keeping the interface and properties on the
> adapter object path? In this case, we will lose the information about
> the peer device which issued the alert. I'm unsure if this is a big
> problem or not (given that the alert is "global" to the Proximity
> Reporter, not a per peer state).
>
> On the other hand, this "custom signal" approach allows to have only
> one (or two) listener, no matter how many devices are connected to the
> reporter, and still know which peer triggered the alert.
>
> One benefit of knowing which device triggered the alert, is to have
> custom alerts (e.g. different sounds) for each device, or if the
> reporter has a display, show which device is making alerts.
>
> Any ideas?
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil

I will send the proposal that you are suggesting to collect more
feedbacks, it is the RFC "proposal "1 sent some weeks ago.
Complementing what Lizardo wrote, use the device object path is not
aligned with the current APIs.
PropertyChanged for ImmediateAlertLevel or LinkLossAlertLevel will be
sent when the remote device(GATT client) writes a new value in the
alert level characteristic of the local GATT service(Link Loss or
Immediate Alert). If this concept of sending PropertyChanged signal
using the device's object path for an action triggered by the remote
is clear to everyone we can continue this approach.

BR,
Claudio
