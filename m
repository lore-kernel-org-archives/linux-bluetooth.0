Return-Path: <cyrus@holtmann.org>
Message-ID: <557FF390.9010502@gmail.com>
Date: Tue, 16 Jun 2015 11:59:44 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ v8 01/15] doc/mgmt-api: multi-adv implementation details
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com> <1432603329-12846-1-git-send-email-fgrandel@gmail.com> <1434166979-21824-2-git-send-email-fgrandel@gmail.com> <D6DBB2BF-8FB6-4BF0-83C4-2B4B8B6C0BE3@holtmann.org>
In-Reply-To: <D6DBB2BF-8FB6-4BF0-83C4-2B4B8B6C0BE3@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 06/15/2015 01:33 PM, Marcel Holtmann wrote:
> Hi Floran,
>
>> A few additional decisions have been made while implementing the
>> multi-advertising feature where the mgmt api spec was leaving room for
>> interpretation. These changes are being documented in this patch.
>> ---
>> doc/mgmt-api.txt | 66 +++++++++++++++++++++++++++++++++++++++++++++-----------
>> 1 file changed, 54 insertions(+), 12 deletions(-)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 4b97aad..0ac8267 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -305,6 +305,14 @@ Set Powered Command
>> 	switching the controller off will expire this timeout and
>> 	disable discoverable.
>>
>> +	Settings programmed via Set Advertising and Add/Remove
>> +	Advertising while the controller was powered off will be activated
>> +	when powering the controller on.
>> +
>> +	Switching the controller off will permanently cancel and remove
>> +	all configured advertising instances, i.e. advertising instances
>> +	are not being remembered across power cycles.
>> +
>
> actually only the ones with a duration will be cancelled. The ones not having a duration should survive a power cycle. That is how we have done it currently and that is also how discoverable and limited discoverable works.

I assume you mean "timeout" rather than "duration"? That would 
correspond to the behavior of adding instances while powered down.

>
>> 	This command generates a Command Complete event on success or
>> 	a Command Status event on failure.
>>
>> @@ -585,6 +593,10 @@ Set Low Energy Command
>> 	In case the kernel subsystem does not support Low Energy or the
>> 	controller does not either, the command will fail regardless.
>>
>> +	Disabling LE support will permanently disable and remove all
>> +	advertising instances configured with the Add Advertising
>> +	command.
>> +
>
> This something I am actually fine with. As long as we send the correct events to inform that the advertising setting are removed. This should then also apply to everything added via Add Device. In in similar regards apply to disabling BR/EDR.

Yes, these events are being generated (on LE off and on Power down). I 
explicitly mention this in the spec now.

>
>> 	This command generates a Command Complete event on success or
>> 	a Command Status event on failure.
>>
>> @@ -1594,6 +1606,10 @@ Set Advertising Command
>>
>> 	Using this command will temporarily deactive any configuration
>> 	made by the Add Advertising command. This command takes precedence.
>> +	Once a Set Advertising command with value 0x00 is issued any
>> +	previously made configurations via Add/Remove Advertising, including
>> +	such changes made while Set Advertising was active, will be re-
>> +	enabled, though.
>
> I assumed this was clear, but I am fine with adding an extra note about this. Just remove the "though" in the text since that does not read well.

Done.

>
>>
>> 	A pre-requisite is that LE is already enabled, otherwise this
>> 	command will return a "rejected" response.
>> @@ -2548,9 +2564,11 @@ Add Advertising Command
>> 	can be used to switch a Bluetooth Low Energy controller into
>> 	advertising mode.
>>
>> -	Added advertising information with this command will be ignored
>> -	when using the Set Advertising command to enable advertising. The
>> -	usage of Set Advertising command take precedence over this command.
>> +	Added advertising information with this command will be ignored as
>> +	long as advertising is enabled via the Set Advertising command. The
>> +	usage of the Set Advertising command takes precedence over this
>> +	command. Instance information is stored, though, and will be
>> +	advertised once advertising via Set Advertising has been disabled.
>
> No "though" please in the text. Smaller sentences with clear details make this easier to read.

Done. I also replaced "ignored" by "invisible" as it was misleading in 
the same way as it was for the "Remove Advertising" command below.

>
>>
>> 	The Instance identifier is a value between 1 and the number of
>> 	supported instances. The value 0 is reserved.
>> @@ -2593,13 +2611,13 @@ Add Advertising Command
>> 	broadcaster role.
>>
>> 	The Duration parameter configures the length of an Instance. The
>> -	value is in seconds and a value of 0 indicates an automatic choice
>> -	for the Duration. If only one advertising Instance has been added,
>> -	then the Duration value will be ignored. It only applies for the
>> -	case where multiple Instances are configured. In that case every
>> -	Instance will be available for the Duration time and after that
>> -	it switches to the next one. This is a simple round-robin based
>> -	approach.
>> +	value is in seconds and a value of 0 indicates a default value
>> +	(currently 2 seconds) will be chosen for the Duration. If only
>> +	one advertising Instance has been added, then the Duration value
>> +	will be ignored. It only applies for the case where multiple
>> +	Instances are configured. In that case every Instance will be
>> +	available for the Duration time and after that it switches to
>> +	the next one. This is a simple round-robin based approach.
>
> Just add a separate paragraph that talks about the default of 2 seconds. And we really need to figure out the best value here.

Done. The value can be easily changed via #define once you decide what 
default is appropriate.

>
>>
>> 	The Timeout parameter configures the life-time of an Instance. In
>> 	case the value 0 is used it indicates no expiration time. If a
>> @@ -2611,8 +2629,21 @@ Add Advertising Command
>>
>> 	When a Timeout is provided, then the Duration substracts from
>> 	the actual Timeout value of that Instance. For example an Instance
>> -	with Timeout of 6 and Duration of 2 will be scheduled exactly 3
>> -	times. Other Instances have no influence on the Timeout.
>> +	with Timeout of 5 and Duration of 2 will be scheduled exactly 3
>> +	times, twice with 2 seconds and once with one second. Other
>> +	Instances have no influence on the Timeout.
>> +
>> +	Re-adding an already existing instance (i.e. issuing the Add
>> +	Advertising command with an Instance identifier of an existing
>> +	instance) will update that instance's configuration.
>> +
>> +	An instance being added or changed while another instance is
>> +	being advertised will not be visible immediately but only when
>> +	the new/changed instance is being scheduled by the round robin
>> +	advertising algorithm. Changes to an instance that is currently
>> +	being advertised will be visible right away, i.e. the previous
>> +	configuration will be canceled immediately and the new
>> +	one activated.
>
> Actually that is not fully correct. I think modifying an existing instance will stop it right away and go to the next instance. In case that only a single instance is active, then it will actually change right away.

Ok. I'll document the behavior as you describe it and change the 
implementation accordingly.

>
>>
>> 	A pre-requisite is that LE is already enabled, otherwise this
>> 	command will return a "rejected" response.
>> @@ -2645,6 +2676,17 @@ Remove Advertising Command
>> 	When the Instance parameter is zero, then all previously added
>> 	advertising Instances will be removed.
>>
>> +	Removing advertising information with this command will be ignored
>> +	as long as advertising is enabled via the Set Advertising command.
>> +	The usage of the Set Advertising command takes precedence over this
>> +	command. Changes to Instance information are stored, though, and
>> +	will be advertised once advertising via Set Advertising has been
>> +	disabled.
>
> This is bogus. The instance will be removed. However it will not change the current active advertising, but it really means that instance is gone.

You are right. That's how it has been implemented anyway. I changed the 
text to correctly describe the actual behavior.

>
>> +
>> +	Removing an instance while it is being advertised will immediately
>> +	cancel the instance, even when it has been advertised less then its
>> +	configured Timeout or Duration.
>> +
>> 	This command can be used when the controller is not powered and
>> 	all settings will be programmed once powered.
>
> Regards
>
> Marcel

Florian
