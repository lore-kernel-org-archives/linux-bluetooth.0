Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <653A85C7F32C4741880F71219266EA02030BD03BB6@EXGMBX01.sasken.com>
References: <ba5648fa0909212143g36f47acck2e4b610429c477ec@mail.gmail.com>
	 <20090922143053.287fc8a5@vlado>
	 <2d5a2c100909220608j1600e8f2k4063d6b2ff7b3296@mail.gmail.com>
	 <653A85C7F32C4741880F71219266EA02030BD03BB6@EXGMBX01.sasken.com>
Date: Tue, 22 Sep 2009 19:26:57 +0530
Message-ID: <ba5648fa0909220656x93d9701le6b45a58cd0d3105@mail.gmail.com>
Subject: Re: BlueZ Supported Profiles
From: bluezprofile kernel <bluezprofile@gmail.com>
To: Sreenivasulu Yellamaraju <sreenivasulu.yellamaraju@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 22, 2009 at 7:02 PM, Sreenivasulu Yellamaraju
<sreenivasulu.yellamaraju@sasken.com> wrote:
>
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Tuesday, September 22, 2009 6:38 PM
> To: Vladimir Botka
> Cc: bluezprofile kernel; Linux Kernel Mailing List; linux-bluetooth@vger.kernel.org
> Subject: Re: BlueZ Supported Profiles
>
> Hi,
>
> On Tue, Sep 22, 2009 at 9:30 AM, Vladimir Botka <vbotka@gmail.com> wrote:
>> On Tue, 22 Sep 2009 10:13:40 +0530
>> bluezprofile kernel <bluezprofile@gmail.com> wrote:
>>
>>> Hi,
>>> I would like to know what are all profiles supported by BlueZ?
>>> Is there any site gives list of profiles supported by BlueZ?
>>> I am using BlueZ 4.46.
>>>
>
> BlueZ is modular, so it depends on which plugins you have enabled.
> Also some profiles like a2dp and hfp depend on others components such
> as PulseAudio to really work, so the answer is not that simple.
> Perhaps you should ask what profiles you want so we can give a more
> direct answer, in general we support most profiles used by desktops
> and phones.
>
>> Hi,
>> you can see the provided services with the command:
>> # sdptool browse BTADDR
>>
>> Get the BTADDR from the output of:
>> # hcitool scan
>>
>> Run these command from another Linux box.
>
> You can do the very same think locally:
> # sdptool browse local
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Hi,
>
> "sdptool browse local" command will only show currently registered services and this list may not be exhaustive.
> The actual list of supported services can be seen from manpage of sdptool. Search for a list of keywords-
> OPUSH,SP,KEYB,AVRTG etc.  You can try adding all of those services one by one and see if they are
> registered without any errors in local database.
>
> However, mere successful registration of service in local database doesn't mean a certain
> Profile is activated and working in the host. So, you can depend on service registration
> process for only a hint.
>
> Regards,
> Sreenivasulu Y
> SASKEN BUSINESS DISCLAIMER
> -------------------------
> This message may contain confidential, proprietary or legally privileged information. In
> case you are not the original intended Recipient of the message, you must not, directly or
> indirectly, use, Disclose, distribute, print, or copy any part of this message and you are
> requested to delete it and inform the sender. Any views expressed in this message are
> those of the individual sender unless otherwise stated. Nothing contained in this message
> shall be construed as an offer or acceptance of any offer by Sasken Communication
> Technologies Limited ("Sasken") unless sent with that express intent and with due
> authority of Sasken. Sasken has taken enough precautions to prevent the spread of
> viruses. However the company accepts no liability for any damage caused by any virus
> transmitted by this email
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks for the propt replies.

As for as I know BlueZ will support

A2DP, AVRCP, HS, HF, FTP, OPP, DUN, HID profiles.

and protocols GAP, SDP, AVDTP, AVCTP, RFCOMM, BNEP, L2CAP.

sdptool gives set of services. All the services implemented in BlueZ?
What is the version of each service/profile implemented in BlueZ?

Specially I would like to know details for the following profiles

GOEP - Generic Object Exchange Profile
HCRP - Hardcopy Cable Replacement Profile
HDP - Health Device Profile
MAP - Message Access Profile
PBAP - Phone Book Access Profile
SYNC - Synchronization Profile
SyncML - Multi Sync
VDP - Video Distribution Profile


-- Nic Shen
