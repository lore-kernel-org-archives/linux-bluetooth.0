Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOsEZogfYO7adj9yUfyEoXsZDUpewZvY7HCceLP_D_8XSUgErQ@mail.gmail.com>
References: <CAOsEZogjvtwKq9ojZva=T9WtovomWhbezVCKZs=oBNFfjixsVQ@mail.gmail.com>
 <CABBYNZKeux81k4hN+QRSiNsSXoZymKPwc5YaEjo1iLes2YGe6Q@mail.gmail.com>
 <CAOsEZogG0-2xYQyPKmwYxmjwRCmt7XYc=pJah94b5Uv9oQtWnQ@mail.gmail.com> <CAOsEZogfYO7adj9yUfyEoXsZDUpewZvY7HCceLP_D_8XSUgErQ@mail.gmail.com>
From: Jay Aurabind <jay.aurabind@gmail.com>
Date: Tue, 26 Apr 2016 11:34:47 +0530
Message-ID: <CAOsEZoiv0vdAsLA1rqyFVsC1s14ymeBwq0R=nFrvv5TVQjqz_A@mail.gmail.com>
Subject: Re: [Help] HIDP connection info error.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 25 April 2016 at 16:38, Jay Aurabind <jay.aurabind@gmail.com> wrote:
> I just fixed my SDP records and I can connect to my device! (quite happy :))
>
> But I still have "Can't get HIDP connection info"
>
> https://paste.gnome.org/pra2lug4t
>
> Can anybody please tell me what this message means?

Hi Luiz,

I am seeing this line in the bluez debug:

bluetoothd[13684]: src/service.c:change_state() 0x559e47860620: device
18:FF:0F:11:6F:6A profile input-hid state changed: connecting ->
connected (0)

Does it mean that everything the device needs to do for making itself
available as an HID is done? I am hoping that next thing to do is to
make my device send some HID reports ?

>
> On 25 April 2016 at 14:56, Jay Aurabind <jay.aurabind@gmail.com> wrote:
>> On 25 April 2016 at 14:01, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> Hi Jay,
>>>
>>> On Fri, Apr 22, 2016 at 9:14 AM, Jay Aurabind <jay.aurabind@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I'm trying to communicate to my custom HID device. I initiated a
>>>> connection from my laptop to my device, and I see the following in the
>>>> debug log:
>>>>
>>>> Can't get HIDP connection info
>>>>
>>>> I traced this to profiles/input/device.c Line 798, to function
>>>> ioctl_is_connected
>>>>
>>>>
>>>> if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
>>>>                 error("Can't get HIDP connection info");
>>>>                 close(ctl);
>>>>                 return false;
>>>> }
>>>>
>>>>
>>>> Can somebody please tell me what this failure means? Obviously my
>>>> there is something wrong with my device (its getting an L2CAP
>>>> configuration error, looks like my laptop is asking for an MTU close
>>>> to 8k bytes). So I want to know where things are going wrong. I
>>>> suspect my HID descriptors/SDP records are messed up, but I would like
>>>> to know what part of it is wrong.
>>>>
>>>> I could not find any information relating to this ioctl either. man
>>>> ioctl_list doent seem to contain a number 211 (HIDPGETCONNINFO).
>>>> Please give some suggestions on how to debug this problem.
>>>
>>> Do you have the logs? For the HID descriptor you can check with
>>> something like this: http://eleccelerator.com/usbdescreqparser/  (just
>>> input your descriptor there to see if makes sense)
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>>
>> Thank you for the response Luiz! That website is quite useful!
>>
>> And yes, my hid descriptor list is indeed sane, as it can parse it and
>> gave me a comment for each line. So it should be fine. I took a look
>> at my bluetoothd host logs, and I see it complaining about
>> missing/invalid HIDDescriptorList as well.
>>
>> https://paste.gnome.org/phx8vh4x5
>>
>> Output of sdptool browse --raw is at https://paste.gnome.org/pjfdrnfid#line-38
>>
>> I definitely need to fix my SDP records, but is it possible to know in
>> detail what specific attributes its mentioning about ? For example,
>> one line in my log is "sdp_extract_attr: Unknown data descriptor :
>> 0x2d terminating", how can I know when it came across that 0x2d  so
>> that I can go poke in my device's code to find what I'm doing wrong?
>>
>>
>> Thanks in advance!
>>
>>
>> --
>> Regards,
>> Aurabindo J
>
>
>
> --
>
> Thanks and Regards,
> Aurabindo J



-- 

Thanks and Regards,
Aurabindo J
