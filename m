Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYOkxtCP_VgYtKWvSYHTb__m2rMCGujOAh6rKDXXYXLWZQ@mail.gmail.com>
References: <CACUGKYMjKcZZJsYi-SXCd1C=guWtKP3k=SBVPVe=+MR0R=pwHg@mail.gmail.com>
	<502C49F4.9060007@samsung.com>
	<CACUGKYOkxtCP_VgYtKWvSYHTb__m2rMCGujOAh6rKDXXYXLWZQ@mail.gmail.com>
Date: Wed, 15 Aug 2012 19:54:50 -0700
Message-ID: <CACUGKYOUh6G9zkifB98akXd_R8Axv6eh03-OCYnJyLNkkBTq3w@mail.gmail.com>
Subject: Re: Bluez 4.101
From: John Tobias <john.tobias.ph@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Let me take it back. I used the kernel from ubuntu 12.04.

Regards,

john

On Wed, Aug 15, 2012 at 7:19 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>
> Hi Chanyeol,
>
> I used the kernel wl12xx-2012-07-18 from this release
> http://git.kernel.org/?p=linux/kernel/git/luca/wl12xx.git;a=summary
> May I know what kernel should I use?.
>
> Regards,
>
> John
>
>
> On Wed, Aug 15, 2012 at 6:16 PM, Chan-yeol Park
> <chanyeol.park@samsung.com> wrote:
>>
>> Hi John
>>
>>
>> On 08/16/2012 09:26 AM, John Tobias wrote:
>>>
>>> Hi All,
>>>
>>> I downloaded the latest Bluez 4.101, compiled and installed on my
>>> machine. After executing the command (/usr/sbin/bluetoothd -n -d), it
>>> returned "bluetoothd[15067]: mgmt setup failed: Invalid argument."
>>> I am just wondering what are the missing key on my build?.
>>
>> It looks like that your kernel doesn't support mgmt interface.
>> Which version of kernel do you use?
>>
>> Regards
>> chanyeol
>
>
