Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <c2a31c480902260429h28579176sdf421f9feda2abc6@mail.gmail.com>
References: <c2a31c480902250519s1ea7a667k6f96b816730fc5cf@mail.gmail.com>
	 <1235571257.24169.19.camel@localhost.localdomain>
	 <c2a31c480902260429h28579176sdf421f9feda2abc6@mail.gmail.com>
Date: Thu, 26 Feb 2009 20:09:35 +0530
Message-ID: <c2a31c480902260639x38ed4e07s10f3e8e32236a0c7@mail.gmail.com>
Subject: Re: API for Input Devices
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,
a) I would like to know if i can access the HID subsystem(to trigger
Sending Get_Report) similar to using ioctl in hid2hci.c.
b) when a bluetooth HID device is connected, where does the device
exist? ie., if i connect a wired usb mouse it gets listed in
/dev/hidraw0 , similarly where will the bluetooth mouse/keyboard be
listed?

Regards,
Sreevani M

On Thu, Feb 26, 2009 at 5:59 PM, sreevani medhahal
<sreevani.medhahal@gmail.com> wrote:
>>> =A0 I would like to know the entry points into BlueZ code to do the fol=
lowing
>>> a) Trigger BlueZ to send the Get_Report to HID Device.
>>> b) Trigger BlueZ to send Reports to Device on Interupt Channel.
>>
>> that is the job of the HID subsystem in the Linux kernel. BlueZ is only
>> providing the HIDP transport.
>>
> Are there any user mode libraries through which i can trigger the HID
> Subsystem to Send Get_Report to a Device.
> Any suggestions on which mailing list to post query will also be helpful.
> Also wanted to know if HID Host is qualified on Linux with BlueZ?
> Thanks & regards,
> Sreevani M
>
