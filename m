Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4C4D637A-1741-449B-BDF0-35CE1088988B@holtmann.org>
References: <1457091512-21270-1-git-send-email-patrik.flykt@linux.intel.com> <4C4D637A-1741-449B-BDF0-35CE1088988B@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Nov 2016 19:06:43 +0200
Message-ID: <CABBYNZ+2WU3KHDCuBMPAHNXFet+tXStThCwTV+x8pUYm1F9icQ@mail.gmail.com>
Subject: Re: [RFC v3] doc: Add Management Interface Network API definitions
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Patrik Flykt <Patrik.Flykt@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 4, 2016 at 7:27 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Patrik,
>
>> ---
>> v3: added interface index to 'Network' block, removed Nework_Role parame=
ter
>>    and dropped text about LE being enabled.
>>
>> doc/doc.txt      |   0
>> doc/mgmt-api.txt | 142 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> 2 files changed, 142 insertions(+)
>> create mode 100644 doc/doc.txt
>>
>> diff --git a/doc/doc.txt b/doc/doc.txt
>> new file mode 100644
>> index 0000000..e69de29
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 731a088..6317255 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2801,6 +2801,107 @@ Start Limited Discovery Command
>>                               Invalid Index
>>
>>
>> +Get Networks Command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +     Command Code:           0x0042
>> +     Controller Index:       <controller id>
>> +     Command Parameters:
>> +     Return Parameters:      Connection_Count (2 Octets)
>> +                             Network1 {
>> +                                     Address (6 Octets)
>> +                                     Address_Type (1 Octet)
>> +                                     Interface Index (4 Octets)
>> +                             }
>> +                             Network2 { }
>> +                             ...
>> +
>> +     This command is used to retrieve a list of BTLE network
>> +     connections. A pre-requisite is that LE is supported
>> +     by the controller, otherwise this command will return a
>> +     "not supported" response.
>> +
>> +     Possible values for the Address_Type parameter:
>> +             0       Reserved
>> +             1       LE Public
>> +             2       LE Random
>> +
>> +     For devices using resolvable random addresses with a known
>> +     identity resolving key, the Address and Address_Type will
>> +     contain the identity information.
>> +
>> +     This command can only be used when the controller is powered.
>> +
>> +     This command generates a Command Complete event on success or
>> +     a Command Status event on failure.
>> +
>> +     Possible errors:        Invalid Parameters
>> +                             Not Supported
>> +                             Invalid Index
>> +
>> +
>> +Add Network Command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +     Command Code:           0x0043
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +     Return Parameters:      Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             Interface Index (4 Octets)
>
> actually we have a bit of an issue here. So my understanding is that this=
 command does not necessarily connects right away. If it is similar to Add =
Device, then you add your remote device here and at some point in the futur=
e if the device is found, it might get connected. If it gets connected it w=
ill also establish IPSP or BNEP.
>
> So first of all, we are operating under the assumption that Add Network d=
oes not really do any trigger of scanning or advertising. We let that one b=
e handled by Add Device and Add Advertising. This is just for the network s=
ide of things to decide if we establish the network layer.
>
> The second problem here is really if the above is what we want, that the =
Interface Index will not be available at this point in time. Yes, for IPSP =
we can just create it at this point and have it available in the system, bu=
t for BNEP this is not going to work. That interface is only available once=
 you actually connected. Unless we also want to change that and create the =
BNEP interface ahead of time and mark it has LOWER_DOWN (meaning no link).
>
> In any case, we should keep a Type or Mode parameter here to select betwe=
en IPSP and BNEP. Even while currently they are clearly limited to the addr=
ess type, but in theory, there is nothing stopping us to run IPSP over BR/E=
DR or a new future IPv6 / 6LoWPAN solution coming up that might be connecti=
on-less.
>
> And no matter what we should have a note here that mentions Add Device an=
d Add Advertising to be used to handle the connection parts of the establis=
hment.

Another thing to consider here is that IPSP actually mention that
security level 2 and 3 (and I guess fips as well although not
mentioned) may be used depending on the use case, but the 6lowpan only
does level 1 which might actually not be what we want by default, so
Id consider adding a MGMT command to tell when to enable the L2CAP
channel and what security level it shall use. Also maybe this could be
applied to router if we want to force a certain security level then
Add Network perhaps should the security level as input.


--=20
Luiz Augusto von Dentz
