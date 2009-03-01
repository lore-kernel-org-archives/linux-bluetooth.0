Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D97BBDAF-F830-4495-B1CC-B56C5C235E72@gmail.com>
From: Carles Cufi <carles.cufi@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1235931668.6074.47.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: =?ISO-8859-1?Q?Re:_Bluetooth_radio_doesn=B4t_reply_to_inquiry_re?=
 =?ISO-8859-1?Q?quest?=
Date: Sun, 1 Mar 2009 19:55:06 +0100
References: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com> <1235931668.6074.47.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your reply.

>
> why don't you use periodic inquiry instead and let the controller  
> handle
> the timing.
>

Because the specific bit I am working on is a C++ library capable of  
doing (among other things) asynchronous discovery while avoiding any  
intermediate caches (that's why I don't use the D-Bus interface or the  
ioctl call) and I do not have control over the periodicity of the  
inquiry nor know when it is going to be cancelled or started again.  
The API requirements were to provide an fast, not cached inquiry that  
can be started and cancelled at will by the application.
Having examined the logs the amount of inquiry requests I am sending  
is fairly low (every 30 seconds or so) and so I thought it wouldn't be  
a problem for the HCI or USB layers to handle in terms of data volume.

> Also should try the bluetooth-testing.git tree since it contains an
> updated btusb.ko driver.

I will try it and let you know about the results.
Does this imply that it looks like a problem in the btusb driver? The  
only other explanations that occurred me until now were:

- The problem is in the hardware (USB hub or BlueCores): I discarded  
this possibility because I took a different hub and 3 dongles  
containing Broadcom modules and reproduced it immediately.
- The problem could be the library sending commands directlly to the  
HC and therefore conflicting with another source of commands  
(bluetooth daemon or other): This seems unlikely given that the logs  
show that on hci2 the only commands are the inquiry requests and  
cancels being sent by the library.

Thanks!

Carles
