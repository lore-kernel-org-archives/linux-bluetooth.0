Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ad Zeevaarders <ad.zeevaarders@veynex.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Exploring Bluez alternatives
Date: Fri, 27 Nov 2015 08:32:26 +0000
Message-ID: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am an intern at a company. After having developed a few Low Energy applications using BlueZ, the DBus-way and the mgmt way, I was ready for my new assignment. The applications I developed were targeted at an embedded ARM platform running Linux without DBus. The new application I need to develop needs to connect to a device, receive some values using indications, then disconnect. 

To my amazement my employer told me that they wanted me to explore alternatives to BlueZ, as they were unsure of the reliability and especially the performance. They sent me a Wikipedia page listing several embedded Bluetooth stacks, like BlueCode+, and asked me to prove, for every single stack, why Bluez was 'better'. My initial response was "Because it is the official supported Bluetooth stack for Linux, our target development OS." Exploring the other solutions, I could not find any rationale as to why I would choose a different protocol stack.

My question therefore is, what would justify switching from Bluez to a different stack? Are there any specific problems or oddities in Bluez that would make it a poor choice for an embedded platform? I haven't come across any indication as to why Bluez would make a less suitable choice as stack. Are there any benchmarks I could test or view in terms of performance and reliability? Is there even a difference in performance and reliability? I am not asking you to do my homework, but a pointer to any sort of rationale behind possibly switching would be appreciated.The application I am asked to develop is non-commercial, so licensing is not an issue. 

I am also not asking this to use as an argument in a discussion with my employer, I just want to correctly perform my assignment by choosing a suitable stack and have a solid knowledge as to why I am using that specific bluetooth stack, so I can explain it when being asked during an assessment.

Thank you in advance for your help!

Have a great day,

Ad Zeevaarders

