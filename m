Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <71D63FC5-0A59-48E2-ACF5-F28768A232D9@gmail.com>
References: <C6A28C41-E0ED-4070-A66F-F32C1B657D8F@gmail.com>
	<71D63FC5-0A59-48E2-ACF5-F28768A232D9@gmail.com>
Date: Thu, 31 Mar 2016 10:51:41 +0300
Message-ID: <CABBYNZJVX7V7R-Ck-xQcDXER=CZTYou3kTQ42Q-_kRwu=BU6CQ@mail.gmail.com>
Subject: Re: good dbus command line tool for embedded exploration of the ble api?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Fri, Mar 25, 2016 at 10:09 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
>
>> On Mar 24, 2016, at 5:04 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
>>
>> I just started transitioning from 5.37 to 5.38. 2 or so months ago, I had gotten an Arm single board computer acting as a peripheral based on copying/guesswork from how example-advertise and example-gatt-server work. I’m trying to resurrect that work. But one thing I think I need to understand better is how dbus works. I’m looking for some kind of command line tool that I can use in this environment to explore the bus layout and get a feel for how it all fits together. Does someone have a good recommendation, preferably something that’s available as debian (jessie) package. I had seen a reference to qdbus, but it looks like it would drag in the entire Qt framework. If there was something for python(3) that explained the jst of dbus and how to explore it with python, I could just use that, but the python dbus docs I’ve found haven’t done a lot to help me.  Thanks for any hints, tips, etc.
>
> I thought I’d report that I did find mdbus2. Which is very light on dependencies. It can send show the topology and send messages. But I’m not sure how to make it access properties. And I did discover dbus-monitor thanks to Barry Byford, which seems to be good for watching traffic, though I couldn’t figure out to how to use it to explore what was there.--

Have you tried d-feet?

-- 
Luiz Augusto von Dentz
