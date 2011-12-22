Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324417223.1965.137.camel@aeonflux>
References: <CACj007=vVUEwvaqr7JhMqJ8VK95j2epK+1_Z+_cJ=1-+UwVnGw@mail.gmail.com>
	<1324417223.1965.137.camel@aeonflux>
Date: Thu, 22 Dec 2011 19:39:13 +0530
Message-ID: <CACj007mRvrE_6uVMeSndKQXYJE=xayiC9hJcb79OuoGQqqRjmw@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor Discussion
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel for the clarifications.


On Wed, Dec 21, 2011 at 3:10 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hemant,
>
>> > Please sync with Anderson Briglia, he already sent a RFC to the ML
>> > some months ago.
>> > In the Bluetooth Summit(Prague), we decided to not proceed with RSSI
>> > monitor emulation in the kernel until we have a clear idea or spec
>> > defining how the controllers will implement RSSI monitoring.
>> Could you please provide some details about what was discussed in the summit.
>>
>> > The ideia was to provide transparency, the userspace doesn't need to
>> > know if RSSI monitoring is emulated or not.
>>
>> As per my understanding the BT spec (4.0, Volume 2, Part E, Section
>> 7.5.4) the HCI_Read_RSSI command can be used to retrieve the RSSI from
>> the controller. In our case, I have tested it against ST-Ericsson BT
>> controller  and it works in our case. Are you suggesting that until we
>> know how the RSSI is determined in controller, we should not implement
>> this functionality in kernel ? I ask this because in Proximity Spec,
>> it is mentioned that the monitor should use appropriate calculations
>> to prevent false alerts on reporter, so if we leave this to layer
>> above BlueZ to do this part, then we are pretty independent with the
>> approach of implementation of Path Loss RSSI Monitoring in BlueZ and
>> Kernel.
>>
>> If I misunderstood anything please clarify.
>
> we need proper notifications about RSSI changes triggered by the
> Bluetooth controller and not having the host polling the controller all
> the time. So just the existence of HCI_Read_RSSI is not enough to make
> this part efficient. And we can only emulate the RSSI notification via
> polling once we know how the new HCI commands will look like. We are
> kinda stuck here.
>
> Regards
>
> Marcel
>
>



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
