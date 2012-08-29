Return-Path: <cyrus@holtmann.org>
Message-ID: <503DE40F.1050008@tieto.com>
Date: Wed, 29 Aug 2012 11:42:39 +0200
From: Garbat Rafal <rafal.garbat@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com> <1344870497-6929-2-git-send-email-rafal.garbat@tieto.com> <20120814095636.GA7055@x220>	<20120828152058.GA18913@x220.sheraton.com> <503CE72D.2030501@tieto.com>	<20120828165650.GA3165@x220.sheraton.com> <CAJdJm_PWn--HEsaex1zqL_CqEBvjKQXSABBnPeYP9CVKgeA6Wg@mail.gmail.com> <20120828181041.GA7686@x220.sheraton.com> <CAJdJm_NL5ALYLKcHJ7uzWdtgkC_72++58GWm=CRXea_YEaYcqg@mail.gmail.com> <CAJdJm_NTTyaKhmgnYJc40xpPLTRwAJ9EkLKCH67nmMJU8KvE+w@mail.gmail.com>
In-Reply-To: <CAJdJm_NTTyaKhmgnYJc40xpPLTRwAJ9EkLKCH67nmMJU8KvE+w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/28/2012 09:21 PM, Anderson Lizardo wrote:
> Hi,
>
> After some discussion with Johan on IRC, I think I understand what he
> is proposing, and it makes sense IMHO. The idea is to simply replace
> the object path for RegisterWatcher/UnregisterWatcher to [variable
> prefix]/{hci0,hci1,...} (adapter path) and have the watcher object
> methods accept a "object device" as first argument.
>
> This way, the application that wants to register wacthers will monitor
> only for new adapters (and not new devices) and register watchers on
> them. The D-Bus interface for RegisterWatcher() will still be profile
> specific (e.g. org.bluez.HeartRate in this case).
>
> One issue with this idea (and which still needs to be sorted out if we
> proceed with this), is that other methods specific to the profile
> (like Reset() for Heart Rate and EnableIntermediateMeasurement() for
> Thermometer) need to be in different interfaces.
>
> Johan, do you have any ideas for this?
>
> Regards,
I guess, that with such approach, the HeartRate API could look something 
like this :

BlueZ D-Bus Heart Rate API description
****************************************

Copyright (C) 2012    Santiago Carot-Nemesio <sancane@gmail.com>

Heart Rate Manager hierarchy
============================

Service        org.bluez
Interface    org.bluez.HeartRateManager
Object path    [variable prefix]/{hci0,hci1,...}

Methods        RegisterWatcher(object agent)

                           Registers a watcher to monitor heart rate 
measurements.

                           Possible Errors: org.bluez.Error.InvalidArguments

                       UnregisterWatcher(object agent)

                           Unregisters a watcher.

Heart Rate Profile hierarchy
============================

Service        org.bluez
Interface    org.bluez.HeartRate
Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

Methods        dict GetProperties()

                         Returns all properties for the interface. See the
                         Properties section for the available properties.

                       Reset()

                         Restart the accumulation of energy expended 
from zero.

                         Possible Errors: org.bluez.Error.NotSupported

Properties    boolean ResetSupported [readonly]

                         True if energy expended is supported.

Heart Rate Watcher hierarchy

============================
Service        unique name
Interface    org.bluez.HeartRateWatcher
Object path    freely definable

Methods        void MeasurementReceived(object device, dict measure)

             This callback is called whenever a heart rate
             measurement is received from the heart rate device.
             The unit for the Value is expressed in beats per
             minute (bpm). The energy field is optional and
             represents the accumulated energy expended in
             kilo Joules since last time it was reset. Furthermore,
             the device will be automatically reset when it
             is needed.
             The Contact field, if present, indicates
             that the device supports contact sensor, besides it
             will be true if skin contact is detected. The optional
             interval field is an array containing RR-Interval
             values which represent the time between two R-Wave
             detections, where the RR-Interval value 0 is older
             than the value 1 and so on.

             Dict is defined as below:
             {
                 "Value" : uint16,
                 "Energy" : uint16,
                 "Contact" : boolean,
                 "Location" : ("Other", "Chest", "Wrist","Finger",
                     "Hand", "Earlobe", "Foot"),
                 "Interval" : array{uint16}
             }


Just a proposal, please comment.

Rafal
