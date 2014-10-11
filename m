Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v4] Bluetooth: Defer connection-parameter removal when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4oqcDKpPySM-qgscD8-=oTrm01Y_KnezTZt4irJ8C1FPg@mail.gmail.com>
Date: Sat, 11 Oct 2014 18:10:53 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <0B397464-8049-478A-B49D-7B5CEED6EFA5@holtmann.org>
References: <1413026054-5913-1-git-send-email-fons@spotify.com> <0025B704-1B18-4B1E-B27D-DF84AA2F9201@holtmann.org> <CAHF=Y4oqcDKpPySM-qgscD8-=oTrm01Y_KnezTZt4irJ8C1FPg@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>>>      if (cp->addr.type == BDADDR_BREDR) {
>>> +             if (cp->disconnect)
>>> +                     conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>>> +                                                    &cp->addr.bdaddr);
>>> +             else
>>> +                     conn = NULL; /* Avoid disconnecting later on*/
>>> +
>> 
>> I do not think this is a comment style that is valid in the network subsystem coding style and even if it is valid, it would be pretty unusual.
> 
> Excuse my ignorance, but Where is the network subsystem coding style
> documented? I haven't been able to find it.

that is actually a good question and I am not sure I have a really good answer for that.

It is essentially Documentation/CodingStyle plus a few extra special cases. Some of them I think are only documented in scripts/checkpatch.pl --strict. The --strict switch is also called --subjective so some of the rules really only apply to the net/ and drivers/net/. I think the term subjective gives it away pretty clearly ;)

We just end up following the rules of the network subsystem here. So there is a difference between the coding style that we use in BlueZ userspace and the one that we use in the kernel. Not a major difference, but it comes to comment styles and multi-line indentations you see the difference.

Regards

Marcel

