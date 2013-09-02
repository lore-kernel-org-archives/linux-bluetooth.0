Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130901150129.GB7440@joana>
References: <CAKCXgJ03bfgQYPgJt7R9dXPEX9J7ofiEHgbPBDK9-H=ifaLyRw@mail.gmail.com>
	<20130901150129.GB7440@joana>
Date: Mon, 2 Sep 2013 11:11:03 +0800
Message-ID: <CAKCXgJ1rgAk2VXzGsf2Un-mCm4H9MjT76bkh40-26TJ7Nh56Gg@mail.gmail.com>
Subject: Re: Compatible Kernels of a certain BlueZ version
From: wei junping <junping.wei@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	wei junping <junping.wei@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Thank you for your reply.
I am trying to make 4.93 come with Android 3.0.8 work with Kernel
3.9.6, and I found that values of some mgmt macros in user mode are
different from those in kernel.
For example:
In user mode mgmt.h
#define MGMT_OP_READ_FEATURES 0x0002
struct mgmt_rp_read_features {
uint8_t features[8];
} __packed;

but in kernel mode mgmt.h
#define MGMT_OP_READ_COMMANDS 0x0002
#define MGMT_READ_COMMANDS_SIZE 0
struct mgmt_rp_read_commands {
__le16 num_commands;
__le16 num_events;
__le16 opcodes[0];
} __packed;

I haven't tried it, but I would think the meaning of the same value in
user and kernel should be the same. Is it?

Best Regards,
Tim Wei

2013/9/1 Gustavo Padovan <gustavo@padovan.org>:
> Hi Tim,
>
> 2013-08-31 wei junping <junping.wei@gmail.com>:
>
>> Who can tell me how I know which kernel is compatible with which BlueZ
>> version, for example, BlueZ 5.7? I didn't find any info in the doc
>> folder of the package.
>
> Any BlueZ 5 version works with an 3.4 kernel or newer. The old BlueZ 4 works
> with any kernel out there.
>
>         Gustavo
