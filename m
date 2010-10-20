Return-Path: <cyrus@holtmann.org>
Message-ID: <4CBEB27F.1000308@atheros.com>
Date: Wed, 20 Oct 2010 14:42:31 +0530
From: Balamurugan Mahalingam <mbalamurugan@atheros.com>
MIME-Version: 1.0
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>, <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>, <charubala@charubala.com>
Subject: Re: [PATCH] hidd shows different names for same device when connected
 from GUI and CLI.
References: <1287496282-16170-1-git-send-email-mbalamurugan@atheros.com> <20101019140916.GA14730@jh-x301>
In-Reply-To: <20101019140916.GA14730@jh-x301>
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi,
>
> On Tue, Oct 19, 2010, Balamurugan Mahalingam wrote:
>   
>> Blueman and other GUIs use the string from ServiceName attribute as
>> device name in the SDP response, but hidd tool uses strings from
>> Service Description and Provider Name atrribute.
>>
>> SDP response from Microsoft Bluetooth device has extended ASCII
>> character 174(registered symbol) in its ServiceDescription attribute.
>> Android platform expects the device name to have only printable
>> characters and therefore GUI Crashes while connecting Microsoft
>> Bluetooth Mouse using hidd
>>
>> Using the ServiceName attribute from the SDP response
>> instead of ProviderName+ServiceDescription for device name in the
>> hidd tool solves both the issues.
>> ---
>>  compat/sdp.c |   33 +++++++++++++++++----------------
>>  1 files changed, 17 insertions(+), 16 deletions(-)
>>     
>
> Same issues as with the previous commit message. Lines should be max 74
> characters long and please redo the summary line to be of the format
> "Fix ..." and shorter than it is now.
>
> Btw, why are you using hidd and not the bluetoothd input plugin? hidd is
> legacy stuff which will disappear from BlueZ in the future.
>
> Johan
> .
>
>   

Johan,

We use the bluetooth input plugin too.
We use hidd for some scripting works.

Regards
Balamurugan
