Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 5/6] core: Add device_get_class to the public interface.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwj4YDzuYUpwph+CtLgefD1+L+209sP6qp67R6hpBNQebQ@mail.gmail.com>
Date: Thu, 11 Apr 2013 10:23:08 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <C93C109F-6ACA-46B4-9C50-BE1E93A314E5@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org> <1365628753-16774-6-git-send-email-deymo@chromium.org> <362A54BE-466C-4B1E-A968-6DD7F758CBA5@holtmann.org> <CAGd9gwj4YDzuYUpwph+CtLgefD1+L+209sP6qp67R6hpBNQebQ@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>> +uint32_t btd_device_get_class(struct btd_device *device)
>>> +{
>>> +     return device->class;
>>> +}
> 
>> why not export functions for getting the major and minor class. That seems to better then making a plugin decode that by themselves. Especially since we know they will get it work.
> 
> Basically we had the device class exported like that in the previous
> plugin. I don't see a huge advantage on splitting the class in this
> file instead of in the plugin... and a plugin could also compare with
> both the major and minor class at the same time. Anyway, is an easy
> change and I don't have a strong preference.

the reason why I prefer major and minor class is that then the core does the "math" ones and does it right. We had enough issues with it being done wrong. Including a kernel bug that we have to live with now.

In addition you actually did not consider the 2 bits that define a format type of major/minor class. Only when they are 0, then the mapping is what you are checking against. These 3 bytes are the worst combination of smashing bits into each other. Check print_dev_class() of btmon to see what I mean.

Regards

Marcel

