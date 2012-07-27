Return-Path: <cyrus@holtmann.org>
Message-ID: <501251B5.1060101@linux.intel.com>
Date: Fri, 27 Jul 2012 10:30:45 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v15 01/14] doc: Add telephony interface documents
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com> <1343292324-959-2-git-send-email-frederic.danis@linux.intel.com> <CANT-zCVCXCSha3CTC2BL9TA9564RQyB8x86QGoOrUuo6OBKU3g@mail.gmail.com>
In-Reply-To: <CANT-zCVCXCSha3CTC2BL9TA9564RQyB8x86QGoOrUuo6OBKU3g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Mikel,

On 27/07/2012 09:52, Mikel Astiz wrote:
>> +TelephonyAgent hierarchy
>> +========================
>> +
>> +Service                unique name
>> +Interface      org.bluez.TelephonyAgent
>> +Object path    freely definable
>> +
>> +Methods                void NewConnection(filedescriptor fd, dict properties)
>> +
>> +                       This method gets called whenever a new connection
>> +                       has been established. This method assumes that D-Bus
>> +                       daemon with file descriptor passing capability is
>> +                       being used.
>> +
>> +                       The agent should only return successfully once the
>> +                       establishment of the service level connection (SLC)
>> +                       has been completed.  In the case of Handsfree this
>> +                       means that BRSF exchange has been performed and
>> +                       necessary initialization has been done.
>> +
>> +                       possible properties:
>> +
>> +                               object Device:
>> +
>> +                                       BlueZ remote device object.
>> +
>> +                               string UUID:
>> +
>> +                                       Profile UUID of the connection.
>
> What would be the purpose of this property?
>
> I believe the agent was already registered for a specific UUID, so
> this seems redundant.
>

You're right, even if agent registers for multiple profiles, the object 
path should be unique for a specific UUID.

I will remove it.

Regards

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

