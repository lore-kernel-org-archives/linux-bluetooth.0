Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C93C109F-6ACA-46B4-9C50-BE1E93A314E5@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org>
	<1365628753-16774-6-git-send-email-deymo@chromium.org>
	<362A54BE-466C-4B1E-A968-6DD7F758CBA5@holtmann.org>
	<CAGd9gwj4YDzuYUpwph+CtLgefD1+L+209sP6qp67R6hpBNQebQ@mail.gmail.com>
	<C93C109F-6ACA-46B4-9C50-BE1E93A314E5@holtmann.org>
Date: Thu, 11 Apr 2013 15:01:56 -0700
Message-ID: <CAHZ1yCnU+n0A5t2eBfdg+js-j2ZPnozBma4bvWjv7KLMZa7Xsg@mail.gmail.com>
Subject: Re: [PATCH 5/6] core: Add device_get_class to the public interface.
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alex Deymo <deymo@chromium.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 11, 2013 at 10:23 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

>>>> +uint32_t btd_device_get_class(struct btd_device *device)
>>>> +{
>>>> +     return device->class;
>>>> +}
>>
>>> why not export functions for getting the major and minor class. That se=
ems to better then making a plugin decode that by themselves. Especially si=
nce we know they will get it work.
>>
>> Basically we had the device class exported like that in the previous
>> plugin. I don't see a huge advantage on splitting the class in this
>> file instead of in the plugin... and a plugin could also compare with
>> both the major and minor class at the same time. Anyway, is an easy
>> change and I don't have a strong preference.
>
> the reason why I prefer major and minor class is that then the core does =
the "math" ones and does it right. We had enough issues with it being done =
wrong. Including a kernel bug that we have to live with now.
>
> In addition you actually did not consider the 2 bits that define a format=
 type of major/minor class. Only when they are 0, then the mapping is what =
you are checking against. These 3 bytes are the worst combination of smashi=
ng bits into each other. Check print_dev_class() of btmon to see what I mea=
n.
>

We have do this parsing in applications as well, since BlueZ just
exports the class as a uint32 via D-Bus properties; so if BlueZ is
going to have a single place to parse this, we should also offer the
parsed values to applications as D-Bus properties.

Even the parsing of the Minor Device Class is pretty hairy, since it
depends on the Major Class; so to make sure that's done properly, it
also seems that BlueZ should do that and provide a complete parsed
description of the device.

I guess something exported in Properties like:

  major-service-class: "audio"
  major-device-class: "audio-video"
  minor-device-class: "loudspeaker"

Or for the complex HID example:

  major-service-class: none
  major-device-class: "peripheral"
  minor-device-class: "pointing-device"
  device-functions: "joystick,gamepad,digitizer-tablet"

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
