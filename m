Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOsEZogjvtwKq9ojZva=T9WtovomWhbezVCKZs=oBNFfjixsVQ@mail.gmail.com>
References: <CAOsEZogjvtwKq9ojZva=T9WtovomWhbezVCKZs=oBNFfjixsVQ@mail.gmail.com>
Date: Mon, 25 Apr 2016 11:31:00 +0300
Message-ID: <CABBYNZKeux81k4hN+QRSiNsSXoZymKPwc5YaEjo1iLes2YGe6Q@mail.gmail.com>
Subject: Re: [Help] HIDP connection info error.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jay Aurabind <jay.aurabind@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

On Fri, Apr 22, 2016 at 9:14 AM, Jay Aurabind <jay.aurabind@gmail.com> wrote:
> Hi,
>
> I'm trying to communicate to my custom HID device. I initiated a
> connection from my laptop to my device, and I see the following in the
> debug log:
>
> Can't get HIDP connection info
>
> I traced this to profiles/input/device.c Line 798, to function
> ioctl_is_connected
>
>
> if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
>                 error("Can't get HIDP connection info");
>                 close(ctl);
>                 return false;
> }
>
>
> Can somebody please tell me what this failure means? Obviously my
> there is something wrong with my device (its getting an L2CAP
> configuration error, looks like my laptop is asking for an MTU close
> to 8k bytes). So I want to know where things are going wrong. I
> suspect my HID descriptors/SDP records are messed up, but I would like
> to know what part of it is wrong.
>
> I could not find any information relating to this ioctl either. man
> ioctl_list doent seem to contain a number 211 (HIDPGETCONNINFO).
> Please give some suggestions on how to debug this problem.

Do you have the logs? For the HID descriptor you can check with
something like this: http://eleccelerator.com/usbdescreqparser/  (just
input your descriptor there to see if makes sense)


-- 
Luiz Augusto von Dentz
