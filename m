Return-Path: <cyrus@holtmann.org>
Message-ID: <5516AD7C.3040401@gmail.com>
Date: Sat, 28 Mar 2015 14:32:44 +0100
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Multi-Advertising: implementation options, timing questions
References: <5515ECE9.9080101@gmail.com> <0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org> <55164DEC.6070009@gmail.com> <E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>
In-Reply-To: <E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

 >
> Whatever you read in the link layer section is something you can forget about right now. That is why the mgmt API actually does not mention advertising delay or internal or alike. It is a bit higher level API with the same affect. It is just less efficient to do that in kernel, then in the controller.
>
> So here is how it is suppose to be done. The duration parameter controls the length an advertising instance stays active. Let say you have two instances, both with 5 seconds each as duration parameter. All instances will be scheduled in round robin fashion.
>
> 	instance 1 -> 5 seconds, instance 2 -> 5 seconds, instance 1 -> 5 seconds and so on
>
> One thing we need to figure out if controllers let us change the advertising data and scan response data on the fly without disabling advertising or if we have to disable it first. Maybe this needs quirking if different controllers behave differently.
>
> This is as close as we get towards multi-advertising that we just emulate in the host. If there is a controller with offload capabilities, we can at some point just start using it. However that is not the main concern. It has to work on standard hardware as well. Even if it is less efficient.
>

Got it. Makes all sense to me.

I also found the documentation for the command in mgmt-api.txt in the 
meantime.

I'll see how far I get from here then...
