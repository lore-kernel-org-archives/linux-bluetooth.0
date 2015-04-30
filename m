Return-Path: <cyrus@holtmann.org>
Message-ID: <55424E64.2000402@gmail.com>
Date: Thu, 30 Apr 2015 17:46:44 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Bluetooth: mgmt: Start using multi-adv inst list
References: <20150409094913.GB10676@t440s.lan>	<1428633041-18415-1-git-send-email-fgrandel@gmail.com>	<1428633041-18415-3-git-send-email-fgrandel@gmail.com> <CAHrH25TvFm1ZTbVG51qpJ0HmcUhJMPHt+zqDvi9-VR2RUt_TLg@mail.gmail.com>
In-Reply-To: <CAHrH25TvFm1ZTbVG51qpJ0HmcUhJMPHt+zqDvi9-VR2RUt_TLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

to answer your remaining review questions...

>> @@ -1044,11 +1047,13 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
>>          }
>>
>>          if (instance) {
>
> Maybe we should do this check earlier and just return 0 if instance
> doesn't exist. This code worked before since the only valid instances
> were 0x00 and 0x01. Now you may need to do a look up earlier and
> return 0 if instance is non-zero and hci_find_adv_instance returns
> NULL.
>

Agreed. I'm checking for this condition early on now and return 0 when 
the current instance identifier is invalid for some reason.

>> -static void clear_adv_instance(struct hci_dev *hdev)
>> +static void clear_adv_instance(struct sock *sk, struct hci_dev *hdev,
>> +                              u8 instance)
>>   {
>> -       struct hci_request req;
>> -
>> -       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
>> -               return;
>> -
>> -       if (hdev->adv_instance.timeout)
>> -               cancel_delayed_work(&hdev->adv_instance.timeout_exp);
>> -
>> -       memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
>> -       advertising_removed(NULL, hdev, 1);
>> -       hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
>> -
>> -       if (!hdev_is_powered(hdev) ||
>> -           hci_dev_test_flag(hdev, HCI_ADVERTISING))
>> -               return;
>> +       struct adv_info *adv_instance, *n;
>> +       int err;
>>
>> -       hci_req_init(&req, hdev);
>> -       disable_advertising(&req);
>> -       hci_req_run(&req, NULL);
>
> Why did you remove this logic? Advertising needs to be disabled if
> HCI_ADVERTISING_INSTANCE is set and HCI_ADVERTISING wasn't. Hence most
> of the logic above (within this function) is still needed.

This was a serious oversight on my side. My intention was to deduplicate 
code in remove_advertising(). While this is probably a good idea, I just 
didn't implement it correctly. For the moment being I removed the 
refactoring. I'll propose an improved patch later on. Just not now - my 
change set is large enough without that change. ;-)

>
>> +       /* A value of 0 indicates that all instances should be cleared. */
>> +       if (instance == 0x00) {
>> +               list_for_each_entry_safe(adv_instance, n,
>> +                                        &hdev->adv_instances, list) {
>
> Didn't you add a hci_adv_instances_clear for this purpose? Now you
> have nested loops for iterating through the list and doing the lookup.
> If you've added this loop just to send the removed event, then perhaps
> it makes more sense to make advertising_removed public (like
> mgmt_advertising_removed) and to call it from hci.c. Or, just do a
> loop first to send the removed events and then call
> hci_adv_instances_clear.

I implemented the latter proposal.

>> @@ -4697,11 +4694,14 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
>>           * set up earlier, then enable the advertising instance.
>>           */
>>          if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
>> -           !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
>> +           !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
>> +           list_empty(&hdev->adv_instances))
>
> We should make sure that the HCI_ADVERTISING_INSTANCE setting is set
> as long as hdev->adv_instances is non-empty and it's not set if the
> list is empty.

I introduced a TODO for that as there are several other similar cases in 
the code. The code currently still relies on HCI_MAX_ADV_INSTANCES being 
exactly one and should work correctly in that case. All places in the 
code that need tweaking for real multi-adv support are marked with TODOs 
now.

>
>> @@ -6882,24 +6883,37 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
>>          if (status) {
>> +               /* TODO: Start advertising another adv instance if any? */
>>                  hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
>> -               memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
>> -               advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
>> +
>> +               if (cmd) {
>
> If "cmd" is NULL for whatever reason, then we'll end up leaking the
> instance. Maybe there is a better way to propagate the pending
> instance ID?

I fixed that by introducing a "pending" flag in the adv_info struct. 
This also catches other cases, e.g. when no new instance has been 
introduced.


>> @@ -6981,38 +7015,31 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
>>                  goto unlock;
>>          }
>>
>> +       /* TODO: Trigger an advertising added event even when instance
>> +        * advertising is already switched on?
>> +        */
>
> With a single instance, what this prevents is sending an "added" event
> for an instance that was previously added. So the TODO doesn't make
> sense in that context but the new code needs to correctly abide by
> that logic. What you actually need to pay attention to is to not send
> any HCI commands to update advertising data every time you add a new
> instance. So maybe add a TODO for that.

I obviously didn't understand the purpose of this code. I refactored the 
code to make it work in the way you propose at least for one instance 
and introduced a TODO for the real multi-adv case.

> The patch is still a bit too large
> for linux-bluetooth standards and it's a bit difficult to get through,
> so if you can break it down into smaller logical pieces it will be
> easier for the others to review it.

I now split up the code in much more manageable pieces. This comes at 
the cost, though, that e2e-tests (mgmt-tester) won't run any more if you 
take away parts of the change set. I asked the question on the list, 
whether that was ok, but this was probably overlooked. I assume, though, 
that such a thing is valid as otherwise there would be no means to 
introduce such a strongly coherent patch in multiple pieces. I'm making 
sure though (git rebase -i --exec make) that the build will not break 
for any of the pieces.

Thanks again for your great in-depth review!

Florian
