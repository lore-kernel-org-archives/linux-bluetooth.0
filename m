Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <CAKT1EBeNMDh4CYigJM4tfF=7V80EtZg4BjPPCVg4C+TcQtuN_A@mail.gmail.com>
Date: Wed, 6 Jul 2011 10:09:17 -0300
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <64409A01-A392-4BA5-9817-6F10D3D51297@signove.com>
References: <1309772865-5083-1-git-send-email-sancane@gmail.com> <CAKT1EBeNMDh4CYigJM4tfF=7V80EtZg4BjPPCVg4C+TcQtuN_A@mail.gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Jul 6, 2011, at 10:02 AM, Claudio Takahasi wrote:

> Hi Santiago,
> 
> <snip>
> 
>> +               RegisterWatcher(object agent)
>> +
>> +                       Registers a watcher to monitor scanned measurements.
>> +                       This agent will be notified about final temperature
>> +                       measurements.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +
>> +               UnregisterWatcher(object agent)
>> +
>> +                       Unregisters a watcher.
>> +
>> +                       Final and intermediate temperatures won't be notified to
>> +                       this agent any more.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +                                       org.bluez.Error.NotFound
>> +
>> +               EnableIntermediateMeasurement(object agent)
> 
> It'd be good to try hide from the apps notifications and indications.
> My opinion is: watchers doesn't need to know if the characteristic
> value is a notification or indication.
> The thermometer implementation could enable automatically
> notifications if there is at least one watcher registered.

The API does that for final measurements. This only enables/disables
the intermediate ones.

> 
> Is it important to know if the characteristic value is intermediate or not?

Yes. Intermediate is a "rough" measurement that is sent for display purposes
only, to keep the user happy, and not necessary when there is nobody watching.
The final measurement is the "trusted" one.

