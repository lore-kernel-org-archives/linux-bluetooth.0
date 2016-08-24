Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory (skb) leak in kernel 4.8-rc2
To: Frederic Dalleau <frederic.dalleau@collabora.co.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
 <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
 <20160820071504.GA9663@t440s.P-661HNU-F1>
 <dd63c403-f35e-2543-e5ba-af40b263ea75@collabora.co.uk>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2be4b143-4f0f-c688-87c3-8056ecc43dfb@lwfinger.net>
Date: Wed, 24 Aug 2016 15:02:36 -0500
MIME-Version: 1.0
In-Reply-To: <dd63c403-f35e-2543-e5ba-af40b263ea75@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/21/2016 07:09 AM, Frederic Dalleau wrote:
> Hi Marcel, Johan,
>
>>>> I am unable to unload module bluetooth to verify that the second
>>>> leak is not a false positive; however, the one in btusb is a real
>>>> memory leak.
>
> There was a bugzilla last week with that backtrace:
> https://bugzilla.kernel.org/show_bug.cgi?id=120691
>
> At the time, I was thinking that the leak could originate from one of the
> req_complete_skb callback, but which one?
>
> And today that the issue has popped again, I found that hci_req_sync_complete
> references the skb in hdev->req_skb. It is called (via hci_req_run_skb) from
> either __hci_cmd_sync_ev which will pass the skb to the caller, or
> __hci_req_sync which leaks.
>
> I have a patch on the grill.

Frédéric,

Any progress on this patch?

Thanks,

Larry
