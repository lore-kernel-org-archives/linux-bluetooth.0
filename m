Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3EF10060-3C76-4240-832A-901BE2831808@holtmann.org>
References: <CAKCXgJ03bfgQYPgJt7R9dXPEX9J7ofiEHgbPBDK9-H=ifaLyRw@mail.gmail.com>
	<20130901150129.GB7440@joana>
	<CAKCXgJ1rgAk2VXzGsf2Un-mCm4H9MjT76bkh40-26TJ7Nh56Gg@mail.gmail.com>
	<3EF10060-3C76-4240-832A-901BE2831808@holtmann.org>
Date: Mon, 2 Sep 2013 15:59:44 +0800
Message-ID: <CAKCXgJ1xYtfQqus+jxkgJpvPm7qqE=usWNVcNB=NqkoOXgDKhQ@mail.gmail.com>
Subject: Re: Compatible Kernels of a certain BlueZ version
From: wei junping <junping.wei@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thank you for your reply.

But what do you mean by "refrain from top posting on this mailing
list"? Do you mean I should not have posted this question here? If so,
where should new comers of BlueZ ask for help?

Best Regards,
Tim Wei

2013/9/2 Marcel Holtmann <marcel@holtmann.org>:
> Hi Wei,
>
> please refrain from top posting on this mailing list.
>
>> Thank you for your reply.
>> I am trying to make 4.93 come with Android 3.0.8 work with Kernel
>> 3.9.6, and I found that values of some mgmt macros in user mode are
>> different from those in kernel.
>> For example:
>> In user mode mgmt.h
>> #define MGMT_OP_READ_FEATURES 0x0002
>> struct mgmt_rp_read_features {
>> uint8_t features[8];
>> } __packed;
>>
>> but in kernel mode mgmt.h
>> #define MGMT_OP_READ_COMMANDS 0x0002
>> #define MGMT_READ_COMMANDS_SIZE 0
>> struct mgmt_rp_read_commands {
>> __le16 num_commands;
>> __le16 num_events;
>> __le16 opcodes[0];
>> } __packed;
>>
>> I haven't tried it, but I would think the meaning of the same value in
>> user and kernel should be the same. Is it?
>
> Before Linux 3.4, the mgmt interface was not official and disabled by default. So values and structs changed. Only with Linux 3.4 they became official. And BlueZ 5.x contains the official values as well.
>
> And version before BlueZ 5.0 will use the raw HCI interface and duplicate all the handling in user space.
>
> Regards
>
> Marcel
>
