Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <DBCCCD9D-7CAC-45F6-89E2-9BE30B625FC6@holtmann.org>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-3-git-send-email-jaganathx.kanakkassery@intel.com> <DBCCCD9D-7CAC-45F6-89E2-9BE30B625FC6@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Tue, 28 Nov 2017 17:09:20 +0530
Message-ID: <CAJzH+boShmEL4+N0bWWx67ZVSEi4gds197bkVR=n0qNeYZFC9g@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] doc/mgmt-api: Add support for Set default Phy command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Jaganath,
>
>> ---
>> doc/mgmt-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 69e84cd..b59bf0c 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2940,9 +2940,47 @@ Get PHY Information Command
>>       LE 1M TX and LE 1M RX would be supported by default.
>>
>>       This command is only available for LE capable controllers.
>> +        It will return Not Supported otherwise.
>> +
>> +        Possible errors:        Not Supported
>> +                             Invalid Index
>> +
>> +Set Default PHY Command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> I think the name =E2=80=9CSet PHY Configuration=E2=80=9D would be better.
>
>> +
>> +     Command Code:           0x0044
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Default_phy (1 Octet)
>> +     Return Parameters:      Current_phys (1 Octet)
>
> Returning the current selected PHYs is rather useless here. It would be e=
xactly the same value we put in. However what might be useful is an event t=
hat indicates the change of the PHY Configuration.
>

I will remove Current_phys. But do we really need PHY Configuration
Changed event since it
can be changed only by Set PHY Configuration command and user can
understand the currently
selected_phys based on whether command is succeeded or failed?

We might need PHY changed event on a particular connection which
should correspond to
PHY Update Complete HCI Event.

Thanks,
Jaganath
