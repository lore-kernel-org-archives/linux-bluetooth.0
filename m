Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <362A54BE-466C-4B1E-A968-6DD7F758CBA5@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org>
 <1365628753-16774-6-git-send-email-deymo@chromium.org> <362A54BE-466C-4B1E-A968-6DD7F758CBA5@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 11 Apr 2013 10:12:19 -0700
Message-ID: <CAGd9gwj4YDzuYUpwph+CtLgefD1+L+209sP6qp67R6hpBNQebQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] core: Add device_get_class to the public interface.
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> +uint32_t btd_device_get_class(struct btd_device *device)
>> +{
>> +     return device->class;
>> +}

> why not export functions for getting the major and minor class. That seems to better then making a plugin decode that by themselves. Especially since we know they will get it work.

Basically we had the device class exported like that in the previous
plugin. I don't see a huge advantage on splitting the class in this
file instead of in the plugin... and a plugin could also compare with
both the major and minor class at the same time. Anyway, is an easy
change and I don't have a strong preference.
