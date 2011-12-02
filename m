Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PQbm-gmiquCKd08_3YZwQmj71-m_ds4xhDayq2wbP_Bw@mail.gmail.com>
References: <CA+_sZW8MnOX_oGThrTr6sb9xtoRBHx6vPabHHgtY4bR+8YyKnA@mail.gmail.com>
	<CAJdJm_PQbm-gmiquCKd08_3YZwQmj71-m_ds4xhDayq2wbP_Bw@mail.gmail.com>
Date: Fri, 2 Dec 2011 11:17:52 +0530
Message-ID: <CA+_sZW-goZkbRoNEd2HsBQ0TqWWSGVR2_yPZ4YEgYUJZZdfkDQ@mail.gmail.com>
Subject: Re: [RFC] FindMe: Proposal to have separate dbus interface
From: vishal agarwal <vishal.bluez@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Thanks for your comments.

I will implement that part above DBus then.

Thanks
Vishal

On Wed, Nov 30, 2011 at 6:11 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Vishal,
>
> On Wed, Nov 30, 2011 at 7:40 AM, vishal agarwal <vishal.bluez@gmail.com> wrote:
>>  There is an existing DBus interface for proximity -
>> PROXIMITY_INTERFACE. SetProperty, GetProperties methods and
>> PropertyChanged signal is registered on this interface.
>>  SetProperty takes two arguments - Property(LinkLossAlertLevel or
>> ImmediateAlertLevel) and the value of alertlevel.
>>  Same is true for PropertyChanged signal. it returns - Property
>> (LinkLossAlertLevel or ImmediateAlertLevel) and the value of
>> alertlevel
>>
>>  Now if user wants to find the other device (using FindMe profile)
>> which is already connected to the Proximity monitor, for this,
>> SetProperty should be called. But now there is no way for BlueZ to
>> figure out whether it is called for Proximity(in this case, action
>> will be taken when PathLoss condition met) or for FindMe(it has to
>> write the alert level immediately).
>
> If you do a SetProperty("ImmediateAlertLevel", <level>) it will always
> take immediately (i.e. try to connect if not already connected, and
> then write to the Immediate Alert Level characteristic). This is not
> specific to any profile (Proximity or FindMe), but to the Immediate
> Alert Service (IAS) behavior documented on the service spec.
>
> You should remember that, on the Reporter/Target side, there is only
> one Immediate Alert Service. If the device supports both profiles,
> they share this service. So it has no way (and no need, as far as I
> know) to tell the difference on which role is triggering the immediate
> alert.
>
>>  Same thing applies when we receive PropertyChanged signal. There is
>> no way for framework over DBus to figure out whether PropertyChanged
>> is for FindMe or for Proximity. If implementation is such that
>> Proximity reporter will alarm when it receives the PropertyChanged due
>> to path loss and there will be no alarm when PropertyChanged is called
>> for FindMe profile, framework has to know this.
>
> Sorry, but your paragraph above seems confusing to me. We do not
> implement a D-Bus API for Proximity Reporter or to Find Me Target, but
> only for monitor/locator. BlueZ's Proximity Reporter implementation is
> only for testing, and does not have a D-Bus API (see
> proximity/reporter.c).
>
> On the *proximity monitor* side, we may want to know if/when the
> ImmediateAlertLevel was written on the server (actually you can't tell
> it was successfully written, because the IAS uses Write Without
> Response, but you may want to know when it was attempted). If you want
> to monitor path loss (to issue alert on the monitor side), you should
> be watching for changes on the "SignalLevel" property.
>
> You cannot tell for sure whether the remote device is alerting. You
> can confirm by the visual/audible alert itself.
>
>>  One way to resolve these issues is to have seperate DBus interface
>> for Proximity and FindMe profiles.
>> Some benefits of using seperate interfaces for both the profiles -
>> 1. Code will be more clear
>> 2. Both BlueZ and framework above Dbus will easily distinguish
>> different methods and signals for these profiles
>> 3. Existing code will not break
>
> Please, take into consideration the points  I mentioned here, and let
> us know if you have any questions/doubts.
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>
