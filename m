Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140213091902.GA2754@x220.p-661hnu-f1>
References: <20140130035506.2A034100F4B@puck.mtv.corp.google.com>
	<20140213091902.GA2754@x220.p-661hnu-f1>
Date: Fri, 14 Feb 2014 12:49:15 -0800
Message-ID: <CAGXr9JFEaEbzLNi8tiECBnHG-vcak+cV3CoSaPn0+B4p3eEn+w@mail.gmail.com>
Subject: Re: [PATCHv3] hog: Use HoG device name as uHID input device name
From: Petri Gynther <pgynther@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Feb 13, 2014 at 1:19 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Wed, Jan 29, 2014, Petri Gynther wrote:
>> If HoG BLE device name is known, use it when creating uHID input device.
>> Pass adapter and device addresses to uHID as well.
>
> Could you perhaps elaborate a bit what exactly the "uniq" and "phys"
> members are in the request (possibly with a reference to the uHID
> documentation). That would make it easier to verify that the content
> you're adding to them makes sense.
>

>From linux/include/linux/hid.h:
struct hid_device {
  ...
  char name[128];    /* Device name */
  char phys[64];        /* Device physical location */
  char uniq[64];         /* Device unique identifier (serial #) */

So, for a Bluetooth HID or HoG device, BT adapter MAC address is good
fit for "phys" and device MAC address is good for "uniq". This is what
hidp module in kernel already does. But, we can be more descriptive
here if we want. These values are readable in sysfs under
/sys/devices/virtual/input/<input-device>.

>> +     if (device_name_known(hogdev->device)) {
>> +             device_get_name(hogdev->device, (char *) ev.u.create.name,
>> +                             sizeof(ev.u.create.name) - 1);
>> +     } else {
>> +             strcpy((char *) ev.u.create.name, "bluez-hog-device");
>> +     }
>
> We don't use { } for single line branches, so you can drop these here.
>

I'll fix this.

>> +     ba2str(btd_adapter_get_address(device_get_adapter(hogdev->device)),
>> +             (char *) ev.u.create.phys);
>
> This is getting a bit messy with the nested function calls. I'd add
> separate adapter variable here to make this a bit more readable.
>
> Also note our coding style wrt split lines: indent the continuation
> lines as much as you can (with tabs) as long as it's under 80 chars.
>
> Also, it might be good to split this up into two patches since you've
> essentially got two independent improvements here. One is making sure
> the name member contains something more useful and the other is adding
> some content to the uniq and phys members.

I'll add name, phys, and uniq variables in struct hog_device, so that
they are easy to pass to uHID when it is time to create the uHID
device.

>
> Johan
