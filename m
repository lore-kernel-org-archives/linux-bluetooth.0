Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property updates on Device1.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RRDgorEmBUH0yfTaL8VgLoe2v6E2Vm7W-6Sqgrcgo3zw@mail.gmail.com>
Date: Thu, 2 Oct 2014 10:34:34 +0200
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <4B0E0390-0BB8-4B2C-A2BA-078203AE7D4F@holtmann.org>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org> <12072518.xz8sZz3RZr@uw000953> <CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com> <E68A0F43-AD5C-4ED5-8724-3E43D064F5BA@holtmann.org> <CAHrH25TT+jSUKy_r4Pmfo5EHqQBi1hB1Hu7Qq2DQm32Y99z_FA@mail.gmail.com> <3E482A6F-C48C-4297-A203-6D3E26AFFDA7@holtmann.org> <CAHrH25RRDgorEmBUH0yfTaL8VgLoe2v6E2Vm7W-6Sqgrcgo3zw@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> the D-Bus API have all been designed with user interaction in mind. So it makes sense to impose this kind of extra thresholds. That is why you can map D-Bus things 1:1 to your UI and it will all nicely work.
>> 
> 
> I guess this falls into the overall question of designing an
> application API vs an API for system UI. I always look at the D-Bus
> API as an application API where system UI is one specific application.
> In the end, we should be able to build use cases that require more
> fine-tuned RSSI updates.

the current API was designed for UI frameworks to have an easy and dirt simple way of displaying the core Bluetooth functionality to the user. So this mainly relates to pairing your device and getting extra information about the device. The RSSI property is also only valid if you start a discovery. Which we clearly expected to map 1:1 to someone wanting to display a list of devices and then be able to sort them by approximate distance.

That said, I agree that we should enable applications that want to monitor in range devices. And realistically that is only really possible since Bluetooth LE came into play. With BR/EDR that was extremely power hungry operation even if you used Periodic Inquiry.

> I don't know if the RSSI property of Device1 is the right thing to use
> for this, though I still find it strange that it's hardwired to serve
> system UI only.

Actually on the D-Bus level exposing RSSI is most likely a really bad idea since it has too many controller specific factors. Using pathloss is something that allows for a way better estimation of distance. Just finding devices that include the extra TX Power information on BR/EDR is almost zero. Especially since there are still some devices around that are 2.0 only and these are mainly keyboards and mice. So we opted for RSSI since that is better than nothing. And I am big believer that you should show the most closes devices in the top of your list.

> In any case, I'm open to suggestions. Could we perhaps introduce a new
> API for RSSI updates? Or a new property maybe? Perhaps we could expose
> a property that sets the RSSI update threshold? Something like:
> 
>   int16 RSSIUpdateThreshold  [readwrite]
> 
>        Defines the minimum amount of change required (in dBm) for the
> RSSI property of a device
>        to be updated. Set to 8 dBm by default.
> 
> And this would be a property on Adapter1. I'm mostly thinking out loud
> here though, so this may not be the best answer.

Or we can start smaller and make this a main.conf configurable option.

In addition we really need specific APIs for certain discovery tasks. In a lot of cases you are looking for a specific set of devices. I think that I mentioned this to Scott before. Just tell the daemon what you are looking for and it will scan for you.

The Start Discovery D-Bus API is also the big hammer. It means that it takes over every other operation since it feeds into the Start Discovery mgmt API. If you use it, you block everything else that might be ongoing. That is why I am saying it is tied to UI. Since when you use it, then you expect something visible for the user to happen right away. For this means we have to abort everything else we are doing.

If we say for example an application wants to be notified about xyz devices in range, then it should not block the attempt of a HID device connecting. However the Start Discovery hammer will do exactly that. You should only bring the big tools if you expect immediate feedback to the user.

This goes along the saying, if you only have a hammer, then everything is a nail. That is pretty dangerous approach and will lead down the wrong path. So instead of forcing existing APIs into a new usage model or hacking them to make fit, I prefer that we introduce the appropriate APIs.

On the D-Bus level we are extremely flexible. We can extend the current Adapter1 interface with new methods and signals or we just introduce a new interface.

Regards

Marcel

