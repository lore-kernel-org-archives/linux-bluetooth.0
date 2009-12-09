Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1260335175.2901.20.camel@violet>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260335175.2901.20.camel@violet>
From: Nick Pelly <npelly@google.com>
Date: Tue, 8 Dec 2009 22:13:35 -0800
Message-ID: <35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 8, 2009 at 9:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> Right now Bluez always requests flushable ACL packets (but does not
>> set a flush timeout, so effectively they are non-flushable):
>>
>> However it is desirable to use an ACL flush timeout on A2DP packets so
>> that if the ACL packets block for some reason then the LM can flush
>> them to make room for newer packets.
>>
>> Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag by
>> default (non-flushable packet), and let userspace request flushable
>> packets on A2DP L2CAP sockets with the socket option
>> L2CAP_LM_RELIABLE.
>
> the reliable option has a different meaning. It comes back from the old
> Bluetooth 1.1 qualification days where we had to tests on L2CAP that had
> to confirm that we can detect malformed packets and report them. These
> days it is just fine to drop them.

Got it, how about introducing

#define L2CAP_LM_FLUSHABLE 0x0040

struct l2cap_pinfo {
   ...
   __u8 flushable;
}

> You can not just blindly use ACL_START_FLUSHABLE without proper version
> checking. This feature has been introduced later and will not work with
> all stacks out there. Please go through the different spec. versions to
> see the difference.

Will do.

Nick
