Return-Path: <cyrus@holtmann.org>
Message-ID: <50811E78.6060009@linux.intel.com>
Date: Fri, 19 Oct 2012 11:33:44 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 01/16] doc: Add settings storage documentation
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>  <1350565311-18330-2-git-send-email-frederic.danis@linux.intel.com> <1350602001.2026.35.camel@aeonflux>
In-Reply-To: <1350602001.2026.35.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 19/10/2012 01:13, Marcel Holtmann wrote:
<snip>
>> +Cache directory files
>> +======================
>> +
>> +Each files, named by remote device address, contains 1 [General] group:
>> +  [General]
>> +  Name=device name a
>
> Is this the only thing we are storing in these files? Or are we planning
> to store additional information at some point.
>
>> +Device directory files
>> +======================
>> +
>> +Remote device info file will include a [General] group with device info,
>> +[DeviceID], [LinkKey] and [LongTermKey] groups with related info:
>> +  [General]
>> +  Alias=
>
> Are we just doing the Alias here? We are not keeping the Name? In theory
> we have a short name and full name actually. If we ever only got the
> short name, we need to know that. Then we have to request the long name
> next time.

Name is already stored in cache file. So I think we do not need to save 
it also in device info file.

We may store both short and long names in the cache file.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
