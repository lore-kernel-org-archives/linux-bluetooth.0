Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Exploring Bluez alternatives
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
Date: Mon, 30 Nov 2015 11:22:07 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A2408001-8A0A-46AD-A442-ABE609CD9C10@holtmann.org>
References: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
To: Ad Zeevaarders <ad.zeevaarders@veynex.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ad,

> I am an intern at a company. After having developed a few Low Energy applications using BlueZ, the DBus-way and the mgmt way, I was ready for my new assignment. The applications I developed were targeted at an embedded ARM platform running Linux without DBus. The new application I need to develop needs to connect to a device, receive some values using indications, then disconnect. 
> 
> To my amazement my employer told me that they wanted me to explore alternatives to BlueZ, as they were unsure of the reliability and especially the performance. They sent me a Wikipedia page listing several embedded Bluetooth stacks, like BlueCode+, and asked me to prove, for every single stack, why Bluez was 'better'. My initial response was "Because it is the official supported Bluetooth stack for Linux, our target development OS." Exploring the other solutions, I could not find any rationale as to why I would choose a different protocol stack.
> 
> My question therefore is, what would justify switching from Bluez to a different stack? Are there any specific problems or oddities in Bluez that would make it a poor choice for an embedded platform? I haven't come across any indication as to why Bluez would make a less suitable choice as stack. Are there any benchmarks I could test or view in terms of performance and reliability? Is there even a difference in performance and reliability? I am not asking you to do my homework, but a pointer to any sort of rationale behind possibly switching would be appreciated.The application I am asked to develop is non-commercial, so licensing is not an issue. 

I have heard of at least 3 instances where companies choose a different stack than BlueZ for their Linux system. All of these were small embedded systems running Linux and they all were looking into BLE support. The end result was that they paid good money for a proprietary stack and hoped to get good support and integration. Reality was they did not and switched back to BlueZ and had things up and running within less than 2 weeks.

The world is clearly shifting towards BLE and BlueZ can actually be configured as BLE only. There are options in the kernel that you can disable and also configurations options in userspace. That reduces the stack and memory size and also reduces the requirements for qualification.

BlueZ is pretty 14+ years old by now. It has been everywhere and in all kinds of products. The advantage that it runs from tiny peripherals, over set top boxes, to tablets, phones, laptops and cars, means the stack has gotten extensive testing. It is the same code base no matter where you run it. That is something no other stack manufacturer can provide. Mainly since they just keep branching a version for a customer and then forget about it. If you buy a stack, you pay for that branch and every modification extra you need will cost you an arm and a leg. With BlueZ, it is free and you get also the testing for all the other markets and companies that are using BlueZ.

I think interoperability wise BlueZ is hands down the best stack. It does get tested at UnPlugFests and has tons of internal unit and end-to-end tests that verify many areas.

If you are looking at Bluetooth stacks, then BlueZ is also the only one that has its core hardware abstraction and core layers implemented in the kernel. That is something that you will not find anywhere else. It is extreme stable code and also clean code. All interfaces are documented as well.

>From my knowledge is that even pentesting houses uses BlueZ as prime test example for their tools. Mainly since you are unable to crash BlueZ remotely. The code is written in a way that is robust against remote attacks. Look for security presentation about Bluetooth and you see what I mean. Most of them can be found online.

In case you are looking for BLE, you might just look for features that you care about. For example LE Secure Connections support is already part of BlueZ. The only other OS that I know of is iOS. All the other stacks have ignored LE SC support. Keep in mind that Bluetooth 4.2 got released over a year ago and BlueZ has LE SC support since exactly 1 year now. LE L2CAP Connection Oriented Channels is another of these features. Try to find that in other stacks.

BlueZ code size is large. That is just a fact. However it contains analyzing tools, emulator tools, testing tools, sample code and a lot more. It also comes in various flavor, BlueZ upstream, BlueZ for Android, BlueZ Peripheral that can be build and used. They are different frontends that share a lot of code. Some use D-Bus, some use Unix socket and some use no IPC at all.

However if you look at Bluedroid from Android, then you will see that that code base is huge as well. And that is just the stack. It contains no tools around it and its debugging capabilities are bad.

Look at the debugging capabilities of BlueZ and the tools we provide. If something goes wrong, can you analyze what goes wrong and if that is on your side or the remote side. Or do you have to purchase 30k EUR Bluetooth protocol analyzer and still can not figure out what went wrong.

> I am also not asking this to use as an argument in a discussion with my employer, I just want to correctly perform my assignment by choosing a suitable stack and have a solid knowledge as to why I am using that specific bluetooth stack, so I can explain it when being asked during an assessment.

We can not fight FUD (fear, uncertainty and doubt) since BlueZ does not have a marketing department. So you will have stack and silicon manufacturers coming in and try to sell you their stacks for a lot of money. If you buy into that FUD, then you might get screwed over later. As I said, I have it from 3 companies that paid good money and still ended up using BlueZ.

If you run Linux and don't use BlueZ, you are just making your life harder and more complicated for no reason.

Regards

Marcel

