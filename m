Return-Path: <cyrus@holtmann.org>
Message-ID: <4EFC350A.5000404@linux.intel.com>
Date: Thu, 29 Dec 2011 10:38:18 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v6 1/8] audio: Move tel drivers to DBus interface
References: <1325080093-20469-1-git-send-email-frederic.danis@linux.intel.com> <1325080093-20469-2-git-send-email-frederic.danis@linux.intel.com> <CABBYNZJGakUpv=vbq47h7qxaCNV5p808Jq5YYj7TxwmbBH6oEA@mail.gmail.com>
In-Reply-To: <CABBYNZJGakUpv=vbq47h7qxaCNV5p808Jq5YYj7TxwmbBH6oEA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Le 29/12/2011 09:49, Luiz Augusto von Dentz a écrit :
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
>> +                       has been established. This method assumes that DBus
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
>> +                               strict Device:
>> +
>> +                                       BlueZ remote device object.
>> +
>> +                               string UUID:
>> +
>> +                                       Profile UUID of the connection.
>> +
>> +                               uint16 Version:
>> +
>> +                                       Remote profile version.
>> +
>> +                               uint16 Features:
>> +
>> +                                       Remote profile features.
>> +
>> +                               string MediaTransportPath:
>> +
>> +                                       Optional. MediaTransport object path.
>
> This should be an object not a string and IMO it should be called
> Transport just to keep it sort.

OK

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

