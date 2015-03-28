Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <5516AD7C.3040401@gmail.com>
References: <5515ECE9.9080101@gmail.com>
	<0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>
	<55164DEC.6070009@gmail.com>
	<E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>
	<5516AD7C.3040401@gmail.com>
Date: Sat, 28 Mar 2015 13:18:49 -0700
Message-ID: <CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com>
Subject: Re: Multi-Advertising: implementation options, timing questions
From: Arman Uguray <armansito@chromium.org>
To: Florian Grandel <fgrandel@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> On Sat, Mar 28, 2015 at 6:32 AM, Florian Grandel <fgrandel@gmail.com> wrote:
>>
>>
>> Whatever you read in the link layer section is something you can forget
>> about right now. That is why the mgmt API actually does not mention
>> advertising delay or internal or alike. It is a bit higher level API with
>> the same affect. It is just less efficient to do that in kernel, then in the
>> controller.
>>
>> So here is how it is suppose to be done. The duration parameter controls
>> the length an advertising instance stays active. Let say you have two
>> instances, both with 5 seconds each as duration parameter. All instances
>> will be scheduled in round robin fashion.
>>
>>         instance 1 -> 5 seconds, instance 2 -> 5 seconds, instance 1 -> 5
>> seconds and so on
>>
>> One thing we need to figure out if controllers let us change the
>> advertising data and scan response data on the fly without disabling
>> advertising or if we have to disable it first. Maybe this needs quirking if
>> different controllers behave differently.
>>
>> This is as close as we get towards multi-advertising that we just emulate
>> in the host. If there is a controller with offload capabilities, we can at
>> some point just start using it. However that is not the main concern. It has
>> to work on standard hardware as well. Even if it is less efficient.
>>
>
> Got it. Makes all sense to me.
>
> I also found the documentation for the command in mgmt-api.txt in the
> meantime.
>
> I'll see how far I get from here then...
>

Now that most of the logic for a single instance is in place it should
be straightforward to extend it for multiple instances. I would start
by turning the adv_instance field of hci_dev into a list of
adv_instances and a way to determine and get a pointer to the
currently active instance. You would then modify the code in
net/bluetooth/mgmt.c that accesses the instance 1 parameters to use
the new getter instead. Once all of that is done, the second step
would be a matter of inserting new elements into the advertising list
and handling the round-robin logic and the duration parameter.

If it makes things easier I can start tackling the first step which is
mostly refactoring my recent code to enable multiple instances. You
can then cleanly build the multiple instance logic on top of that.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
