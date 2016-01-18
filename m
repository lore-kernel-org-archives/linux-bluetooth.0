Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Could example-gatt-server and example-advertisement be folded into one?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CABBYNZJd+fdjLnUTfoeFK515shuG=ncPncRo9joYSoY910hktw@mail.gmail.com>
Date: Mon, 18 Jan 2016 10:32:57 -0800
Message-Id: <47E3D55F-711F-40D0-B9EB-61EABF4752B0@gmail.com>
References: <5B92EB78-6761-4617-9186-CC5040532A91@gmail.com> <CABBYNZJd+fdjLnUTfoeFK515shuG=ncPncRo9joYSoY910hktw@mail.gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Jan 17, 2016, at 4:54 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Travis,
> 
> On Sat, Jan 16, 2016 at 3:10 AM, Travis Griggs <travisgriggs@gmail.com> wrote:
>> Subject mostly asks it all. I’m not asking whether the bluez distributed examples could be folded into one.
>> 
>> I have been able able to build a working BLE interface to my Linux SBC using python to operate as a peripheral. I worked from these two files. Is there any reason I couldn’t weld the two files together into one? Or do they need to be run as two separate processes with two separate mainloops?
>> 
>> I’m really hoping to get any answer, my last few questions went unanswered (which happens), but I’ve begun to wonder if my emails are getting through.
> 
> I guess they were done separately just exercise their interfaces, note
> that you may not want to advertise in the beginning or actually stop
> advertise if something else happen, e.g. sensor is no longer active,
> that is why the interfaces are separated. Also note these are just
> examples, we don't expect anyone using this code in production.

Thanks for the reply Luiz. I’ll experiment with refactoring them/merging them some.

Can you help me understand your comment about “don’t expect anyone using this code in production.”?

I’m trying to build a device based on an ARM SBC running Debian Linux, that acts as a control point for a guy with a BLE enabled phone. So as long as it’s powered, I want someone to be able to walk up to it and fire up my BLE app on their device and control the things the device does. Based on response from an earlier email, I took the example-gatt-server and example-advertise, made copies, and started modifying/refactoring etc, based on the idea that this was a good starting point to learn how the encouraged method was to write such an app. In some small way, my hope is to use my code in some sort of limited production in the future. In your opinion, am I on the right track? Or does your comment mean I should be doing something different? My own application code on the device is written in python3.

Thanks!