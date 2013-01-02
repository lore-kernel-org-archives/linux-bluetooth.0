Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix uuid output in debugfs
References: <1356130624-29234-1-git-send-email-gustavo@padovan.org>
	<87623g9chw.fsf@nemi.mork.no> <20130102113122.GA22512@x220>
Date: Wed, 02 Jan 2013 13:37:45 +0100
In-Reply-To: <20130102113122.GA22512@x220> (Johan Hedberg's message of "Wed, 2
	Jan 2013 13:31:22 +0200")
Message-ID: <87wqvv92w6.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg <johan.hedberg@gmail.com> writes:

>> Why can't all this be replaced with
>> 
>> static void print_bt_uuid(struct seq_file *f, u8 *uuid)
>> {
>>         seq_printf(f, "%pUl\n", uuid);
>> }
>> 
>> ?
>
> I don't think there's any reason assuming that there are no unaligned
> access considerations (which I pointed out in my other reply). I wasn't
> aware of printk having such a nice extension to the usual format
> specifiers (and neither was Gustavo as it seems). Thanks for making us
> aware of it!

lib/vsprintf.c:uuid_string() will only access "uuid" byte-by-byte so
alignment shouldn't be a problem.


Bjørn
