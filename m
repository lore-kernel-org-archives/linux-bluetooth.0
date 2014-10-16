Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1410161007340.1316-100000@iolanthe.rowland.org>
References: <CAG0bkv+bu23Fm_thq7A5AOrCEXaaWmcKNaX-193GqFh=W0S8xA@mail.gmail.com>
	<Pine.LNX.4.44L0.1410161007340.1316-100000@iolanthe.rowland.org>
Date: Thu, 16 Oct 2014 20:35:54 +0530
Message-ID: <CAG0bkvLtNwYBVJeRKQ7JZ0f4M4+FBSK3U98X_wyPTSfKE08yOA@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ok, I will do this and update you.
But Currently I am on long leave and I can update you on 27th Oct.

Thanks,
Naveen

On Thu, Oct 16, 2014 at 7:39 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 16 Oct 2014, Naveen Kumar Parna wrote:
>
>> > Indeed. However, it is possible to use an additional in between your
>> > devices and the internal hub.
>> >
>> >         Regards
>> >                 Oliver
>> >
>> >
>>
>>
>> Tested with this configuration(external hubs Dev 3, Dev 4, Dev 17, Dev
>> 10) and got the same result.
>>
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>>
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>>
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>
>>         |__ Port 5: Dev 3, If 0, Class=hub, Driver=hub/7p, 12M
>>
>>             |__ Port 1: Dev 4, If 0, Class=hub, Driver=hub/7p, 12M
>
> This is not what Oliver meant.  You have to use a USB-2 hub.  And
> having one of them is enough; you don't need two.
>
> Alan Stern
>
