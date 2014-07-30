Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/gatt: Use iterator based discovery result structure.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QOoRJjziR6K1rh3s5HAvKEaX62+LWB022G5E1eZ_WppA@mail.gmail.com>
Date: Wed, 30 Jul 2014 15:17:45 -0700
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <968A3D86-D36A-432B-AB2F-1269D55B2BC9@holtmann.org>
References: <1406664949-25196-1-git-send-email-armansito@chromium.org> <B1DE8040-EA3D-4B9B-9649-033A8FB49F46@holtmann.org> <CAHrH25QOoRJjziR6K1rh3s5HAvKEaX62+LWB022G5E1eZ_WppA@mail.gmail.com>
To: Arman Uguray <armansito@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> +struct result_ptrs {
>>> +     struct bt_gatt_result *head;
>>> +     struct bt_gatt_result *tail;
>>> +};
>>> +
>>> +struct discovery_op {
>>> +     struct bt_att *att;
>>> +     uint16_t end_handle;
>>> +     int ref_count;
>>> +     bt_uuid_t uuid;
>>> +     struct result_ptrs result;
>> 
>> Does this nested struct give you any benefit. Why not just include head and tail pointers directly.
>> 
> 
> I initially thought that I would reuse the result ptrs but I didn't so
> it's not that necessary any more.
> 
> 
>> I was actually thinking that struct bt_gatt_result will keep the tail pointer all by itself. That way it is self-contained.
> 
> I'd rather have the head and tail pointers inside discovery_op. It's a
> bit weird for each "link" (i.e. struct bt_gatt_result) to have a tail
> pointer, which the iterator itself won't ever use later.

then go for putting them in discovery_op. We can optimize things later since these are all internal details.

Regards

Marcel

