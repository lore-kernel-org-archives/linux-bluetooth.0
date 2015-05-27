Return-Path: <cyrus@holtmann.org>
Message-ID: <55663161.2000508@gmail.com>
Date: Wed, 27 May 2015 23:04:33 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] Bluetooth: Multi-advertising infrastructure
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com> <1432600463-7758-1-git-send-email-fgrandel@gmail.com> <064C8AD4-80B3-4E94-96E9-F40BDA0D38C7@holtmann.org>
In-Reply-To: <064C8AD4-80B3-4E94-96E9-F40BDA0D38C7@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 05/27/2015 09:23 PM, Marcel Holtmann wrote:
> Hi Florian,
>
>> patch set introducing the infrastructure for multi-advertising
>> capability to the HCI core and mgmt API.
>>
>> v1 -> v2:
>> - add missing braces in read_adv_features()
>>
>> v2 -> v3 (changes due to Johan's review):
>> - split change-set into several patches
>> - replace err == 0 by !err
>> - fix coding style problems
>>
>> v3 -> v4 (changes due to Arman's review):
>> - bug fix: when calling remove_advertising with an instance value of
>>   zero (i.e.  remove all instances), the command response also returns
>>   an instance value of zero now as it doesn't make sense to return a
>>   single instance id when removing several instances
>> - splitting the change set into a much larger number of patches to
>>   facilitate review
>> - use HCI_MAX_ADV_INSTANCES in the same patch that introduces it
>> - use adv_info->hdev in the same patch that introduces it
>> - make the logic of hci_find_adv_instance() more readable
>> - make sure that hci_find_adv_instance() is called while hci_dev is
>>   locked
>> - replace hci_num_adv_instances() by an instance counter in hci_dev
>> - add inline comment in get_adv_instance_flags() explaining its return
>>   value in the error case
>> - generate zero-length adv data if the current instance identifier is
>>   invalid
>> - revert erroneous changes to the logic in clear_adv_instance()
>> - use hci_adv_instances_clear() in clear_adv_instance() when removing
>>   all advertising instances also removing a redundant error check
>> - inserting TODO messages to make sure that advertising will not be
>>   switched off prematurely once we allow more than one advertising
>>   instance
>> - inserting TODO messages to make sure that multiple advertising
>>   instances will be advertised in a round-robin fashion once we allow
>>   for more than one advertising instance
>> - identify peding advertising instances (just added but not yet
>>   confirmed in add_advertising_complete) by a boolean flag in the
>>   adv_info struct so that we can identify and remove them even when the
>>   pending add_advertising command cannot be retrieved for some reason -
>>   makes sure that we do not leak advertising instances in this case
>> - only send HCI commands to update advertising data when a new instance
>>   has actually been added
>>
>> v4 -> v5 (changes due to Marcel's review):
>> - split into separate change sets for kernel and userspace
>> - do not trust the adv instance list length when compiling the adv
>>   features struct
>> - introduce adv_info->pending in the same patch it's used for the first
>>   time
>>
>> v5 -> v6 (changes due to Marcel's review):
>> - fix the add adv override bug
>> - fix "Using plain integer as NULL pointer" warning in
>>   set_advertising_complete()
>> - reword the "remove adv instance" commit comment to make it clear that
>>   an existing bug is being fixed
>
> so the max adv instances variable is still 1 after applying this patch set. So fundamentally nothing has changed. However when I set this to any other value, the feature does not really work. Doing a simple thing and adding multiple instances with a default duration value only keeps the last one active forever. It just never rotates. Also when I have two or more instances and remove instance 1, then advertising gets disabled and trying to remove the other instances return an error.
>
> Are multiple instances suppose to work with this patch set?

No. There are a few remaining TODOs (documented in the code) for actual 
multi-advertising. I mention these in the commit messages where applicable.

The idea was to do the more complex changes in a functionally neutral 
refactoring first as a safe starting point for functional changes (see 
my conv. with Arman on the list).

Of course I'm prepared to resolve those remaining TODOs in a second 
patch set. I just think it is a good idea if I go full cycle once to 
avoid those beginner's errors during the next iteration.

If you think that there are no more fundamental flaws in that first 
patch set then I can start with the second one now. What do you think?

Florian
