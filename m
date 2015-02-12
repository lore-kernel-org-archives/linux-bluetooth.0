Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD8Lp44CQ5Au9YQ98==Lxpi3mMh+jbpZBOZFjVSweV5ykUyqbg@mail.gmail.com>
Date: Thu, 12 Feb 2015 12:56:19 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	Larry Finger <larry.finger@lwfinger.net>,
	=?utf-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Message-Id: <78B34B30-0194-46CF-AFAF-ABB44E825C7D@holtmann.org>
References: <1423522782-18956-1-git-send-email-drake@endlessm.com> <3A3386F2-F288-4B13-B31A-92ADF57505CC@holtmann.org> <CAD8Lp44CQ5Au9YQ98==Lxpi3mMh+jbpZBOZFjVSweV5ykUyqbg@mail.gmail.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Thanks for the feedback! It all makes sense, I just need clarification
> on one part.
> 
> On Thu, Feb 12, 2015 at 2:26 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> +     if (id->driver_info & BTUSB_RTL8723A)
>>> +             hdev->setup = btusb_setup_rtl8723a;
>>> +
>>> +     if (id->driver_info & BTUSB_RTL8723B)
>>> +             hdev->setup = btusb_setup_rtl8723b;
>>> +
>> 
>> I would really prefer to be able to detect this with a HCI command and not have a long list of chipsets.
> 
> Can you explain a little more what you mean here? I should have just 1
> entry point for both firmware types, where a HCI command is run, then
> it dispatches the appropriate firmware loading code?
> 
> I thought by doing it like I did in this patch, I was addressing one
> of your comments on the v2 patch, where you said:
> 
> "You do know that you can add individual hdev->setup function for each
> different firmware loading mechanism. They do not need to be all the
> same. I get the feeling you are trying too hard to push it all into a
> single entry point."
> from http://www.spinics.net/lists/linux-bluetooth/msg50141.html

it might be the only way to do it. However the blacklist list is pretty long and if we have any chance to use USB_VENDOR_AND_INTERFACE_INFO to shrink that would be great. If not, then we have to deal with it.

Regards

Marcel

