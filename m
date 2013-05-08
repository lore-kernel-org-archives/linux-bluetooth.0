Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 May 2013 10:41:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
Message-ID: <20130508074138.GA11502@x220>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org>
 <5135D965.8020604@tieto.com>
 <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org>
 <513703AA.2090206@tieto.com>
 <514021F5.1040005@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <514021F5.1040005@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Mar 13, 2013, Rymarkiewicz Waldemar wrote:
>>>>+Interface	org.bluez.BloodPressure1
>>>>+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>>>>+
>>>>+Methods		RegisterWatcher(object watcher)
>>>>+
>>>>+			Registers a watcher to monitor blood pressure
>>>>+			measurements. This watcher will be notified about
>>>>+			final pressure measurements.
>>>>+
>>>>+			Possible Errors: org.bluez.Error.InvalidArguments
>>>>+
>>>>+		UnregisterWatcher(object watcher)
>>>>+
>>>>+			Unregisters a watcher.
>>>>+
>>>>+		EnableIntermediateMeasurement(object watcher)
>>>>+
>>>>+			Enables intermediate measurement notifications
>>>>+			for this watcher. Intermediate measurements will
>>>>+			be enabled only for devices which support it.
>>>>+
>>>>+			Possible Errors: org.bluez.Error.InvalidArguments
>>>>+					org.bluez.Error.NotSupported
>>>>+
>>>>+		DisableIntermediateMeasurement(object watcher)
>>>>+
>>>>+			Disables intermediate measurement notifications
>>>>+			for this watcher. It will disable notifications in
>>>>+			devices when the last watcher is removed for
>>>>+			intermediate measurements.
>>>>+
>>>>+			Possible Errors: org.bluez.Error.InvalidArguments
>>>>+					org.bluez.Error.NotFound
>>>
>>> why don't we make these two methods parts of a dict for
>>> RegisterWatcher. Enabling them manually seems rather pointless.
>>
>> It's been done intentionally to be able to return "not supported" error
>> when intermediate measurement is not available.
>>
>> Having RegisterWatcher(object watcher, boolean intermediate) and
>> additionally Intermediate property [read only] is an another option.
>>
>> In this case app will check intermediate property and set intermediate
>> param to RegisterWatcher appropriately.
>
> Any comments on this.

Are you still working on this? Seems this discussion was forgotten or
just abandoned.

Having the intermediate measurement enabling in the registration instead
of a separate method and you being fine with it (assuming that an
Intermediate property is added) raises some questions.

Apparently it was never a requirement to be able to enable/disable this
an arbitrary amount of times during the watcher life time, and instead
just leave it disabled or enabled until the watcher gets unregistered?

Also, do you think there will be UIs that will refuse to work if a
device does not support intermediate measurement or that any UI that is
interested in intermediate measurement will forgive devices that do not
support it and simply get on with working without it being enabled? If
the latter is true then why not make an API which allows requesting
"register watcher and enable intermediate measurement if it's
supported". In such a case you wouldn't need a separate property and the
registration would succeed even if intermediate measurement isn't
supported. Thoughts?

Johan
