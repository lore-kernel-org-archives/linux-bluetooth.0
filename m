Return-Path: <cyrus@holtmann.org>
Message-ID: <533C1271.3040004@openbossa.org>
Date: Wed, 02 Apr 2014 10:36:49 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] doc: Connection Parameters Command
References: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org> <5E9DA4DA-78DE-4670-B27A-D497AF6A1986@holtmann.org>
In-Reply-To: <5E9DA4DA-78DE-4670-B27A-D497AF6A1986@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 03/29/2014 03:23 PM, Marcel Holtmann wrote:
> Hi Andre,
>
>> This patch introduces commands to add and remove connection parameters.
>> ---
>> doc/mgmt-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 78f0bd2..20e3e6c 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -995,7 +995,8 @@ Unpair Device Command
>> Return Parameters: Address (6 Octets)
>> Address_Type (1 Octet)
>>
>> - Removes all keys associated with the remote device.
>> + Removes all keys and connection parameters associated with the remote
>> + device.
>>
>> Possible values for the Address_Type parameter:
>> 0 BR/EDR
>> @@ -1668,6 +1669,87 @@ Load Identity Resolving Keys Command
>> Invalid Index
>>
>>
>> +Load Connection Parameters Command
>> +====================================
>> +
>> + Command Code: 0x0031
>> + Controller Index: <controller id>
>> + Command Parameters: Params_Count (2 Octets)
>> + Params1 {
>> + Address (6 Octets)
>> + Address_Type (1 Octet)
>> + Auto_Connect_Option (1 Octet)
>> + Min_Connection_Interval (2 Octets)
>> + Max_Connection_Interval (2 Octes)
>> + }
>> + Params2 {  }
>> + ...
>> + Return Parameters:
>> +
>> + This command is used load connection parameters from several LE devices
>> + into kernel. It is only supported on controllers with LE support.
>> +
>> + The provided Address and Address_Type are the identity of a device. So
>> + either its public address or static random address. Unresolvable random
>> + addresses and resolvable random addresses are not valid and will be
>> + rejected.
>> +
>> + Possible values for the Address_Type parameter:
>> + 0 Reserved (not in use)
>> + 1 LE Public
>> + 2 LE Random
>> +
>> + Possible values for the Auto_Connect_Option parameter:
>> + 0 Disabled
>> + 1 Always
>> + 2 Link Loss
>> +
>> + The 'Always' option configures the kernel to always re-establish the
>> + connection, no matter the reason the connection was terminated. The
>> + 'Link Loss' option configures the kernel to re-establish the connection
>> + only in case the connection was terminated due to a link loss.
>> +
>> + The Min_Connection_Interval and Max_Connection_Interval parameters
>> + should be configured as described in Core 4.1 spec, Vol 2, 7.8.12.
>
> I think we should include the Connection_Latency and Supervision_Timeout here as well. Both are used on LE_Create_Connection and LE_Connection_Update commands.

I'll add them.

>> +
>> + This command can be used when the controller is not powered.
>> +
>> + This command generates a Command Complete event on success or
>> + a Command Status event on failure.
>> +
>> + Possible errors: Invalid Parameters
>> + Invalid Index
>> + Not Supported
>
> To complete this command, we actually need an event like "New Connection Parameter” that will inform userspace about the configured connection parameter setting. Either from the old L2CAP procedure to update them or from the Bluetooth 4.1 LE Remote Connection Parameter Request feature.
>
> We should start out with defaults like we do already and in case they get changed we notify userspace about them. So userspace can store them and on next reboot, load the known values into the system.

Agreed.

>> +
>> +
>> +Add Connection Parameters Command
>> +====================================
>
> If we use this command, then it should be “Set Connection Parameter”.

Agreed.

>> +
>> + Command Code: 0x0032
>> + Controller Index: <controller id>
>> + Command Parameters: Address (6 Octets)
>> + Address_Type (1 Octet)
>> + Auto_Connect_Option (1 Octet)
>> + Min_Connection_Interval (2 Octets)
>> + Max_Connection_Interval (2 Octes)
>
> However I am not really sure if we want to just allow modification of the Auto_Connect_Option or also allow setting the other values.
>
> Maybe it would be actually be better to allow changing these parameters through a socket option. Since with Bluetooth 4.1 both sides are allowed to request parameter changes. Maybe even setting the Auto_Connect_Mode through a socket option would be a better choice.
>
> I am thinking of, okay, I am connected now, if I loose the link, please try to re-connect me. And from now on use xyz latency for it.
>
> So what we should do is focus on loading the default settings and notifying userspace about changed connection parameter settings. That all by itself already improves the system since the remote side does not always has to request the settings, we can start out with good ones for each individual device.

Ok, I'll focus on that loading command and later we discuss about this 
other command.

I'm going to send a new version of this RFC soon.

Regards,

Andre
