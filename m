Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D9C33327-2669-4135-9DAA-2109B457B021@holtmann.org>
References: <20160216130927.GA10374@vps217108.ovh.net>
	<D9C33327-2669-4135-9DAA-2109B457B021@holtmann.org>
Date: Tue, 16 Feb 2016 18:35:52 +0000
Message-ID: <CAAu3APacps6c_P_HeyV-Myt-GXxt9CVvVow9HXbW2QEk51CZsA@mail.gmail.com>
Subject: Re: [RFC][PATCH] Add Set Advertising Parameters command
From: Barry Byford <31baz66@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16 February 2016 at 18:11, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Chevallier,
>
>> ---
>> doc/mgmt-api.txt | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 67 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 731a088..4b842fd 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2596,6 +2596,7 @@ Add Advertising Command
>>               4       Add TX Power field to Adv_Data
>>               5       Add Appearance field to Scan_Rsp
>>               6       Add Local Name in Scan_Rsp
>> +             7       Pending Parameters
>>
>>       When the connectable flag is set, then the controller will use
>>       undirected connectable advertising. The value of the connectable
>> @@ -2623,6 +2624,12 @@ Add Advertising Command
>>       supported to provide less air traffic for devices implementing
>>       broadcaster role.
>>
>> +     If the Pending Parameters flag is set, the Advertising Instance
>> +     will only be queued when the Set Advertising Parameters command
>> +     is issued, with the correct Instance identifier. If the next
>> +     command is not a Set Advertising Parameters commmand, the current
>> +     Advertising Instance is cancelled.
>> +
>
> this is an API design, I prefer to not support. It is really complicated and does not feel like a clean design.
>
>>       The Duration parameter configures the length of an Instance. The
>>       value is in seconds.
>>
>> @@ -2680,6 +2687,66 @@ Add Advertising Command
>>                               Invalid Index
>>
>>
>> +Set Advertising Parameters Command
>> +==================================
>> +
>> +     Command Code:           0x003f
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Instance (1 Octet)
>> +                             Adv_Interval_min (2 Octets)
>> +                             Adv_Interval_max (2 Octets)
>> +     Return Parameters:
>> +
>> +     This command is used to set advertising parameters for a Bluetooth
>> +     Low Energy controller.
>> +
>> +     This command can be used to configure global advertising parameters
>> +     that will be applied for advertising issued by the Set Advertising
>> +     command.
>> +
>> +     This command can also be used to configure single Advertising
>> +     Instances. In that case, the parameters applied for the Advertising
>> +     Instance will override global Advertising Parameters when the
>> +     Adversiting Instance is running.
>> +
>> +     When configuring an Advertising Instance, the Instance must have
>> +     been added with the flag "Pending parameters". The Advertising
>> +     Instance will be added to queue only when the Set Advertising
>> +     Parameters will be issued.
>> +
>> +     The Instance parameter designates what we want to configure.
>> +     If the Instance parameter is 0, the Advertising Parameters apply
>> +     globally, for both the advertising issued with the Set Adverting
>> +     and the Advertising Instances issued with Add Averting.
>
> I wonder if we actually want to include the Instance parameter at all here. I mean, why not just have some global setting for advertising parameters and just run with it.
>
> However would fine grained per instance setting actually help you? If you have an instance with a higher interval it will consume the extra power.
>
> And honestly if we ever really need super fine grained control, then I rather design an Add Enhanced Advertising command after we figured out what we really want. Especially looking forward on the next Bluetooth specification, I prefer not to lock myself in at this point in time.
>
> So if we want to add a global Set Advertising Parameters similar to Set Scan Parameters then I am fine with that, but anything more complex seems not the right solution at this point.
>
> Regards
>
> Marcel
>

On the Eddystone beacons they have 3 different frame types and a
typical installation might broadcast two frame types. The suggestion
is that the two fame types would be interleaved and the Eddystone-TLM
frame type would be broadcast less frequently than Eddystone-URL for
example. Would having this parameter per instance allow this to be
done?
