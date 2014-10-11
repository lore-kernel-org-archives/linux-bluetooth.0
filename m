Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4o7BE5hVzNgyXR0_jGPqNLnfjj1MgzuTU0iB-tvvgKa3A@mail.gmail.com>
Date: Sat, 11 Oct 2014 13:56:01 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5240CE7E-B366-410A-93C4-5FCC3358A68F@holtmann.org>
References: <1412991237-20847-1-git-send-email-fons@spotify.com> <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org> <CAHF=Y4o7BE5hVzNgyXR0_jGPqNLnfjj1MgzuTU0iB-tvvgKa3A@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>>> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *work)
>>>              conn->state = BT_CLOSED;
>>>              break;
>>>      }
>>> +
>>> +     if (test_and_clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
>>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>> 
>> do we really need this one? The hci_conn_timeout should trigger when the connection establishment has a timeout and that is really non of the concerns here. And in case we hit an idle disconnect timeout, we are still ending up in hci_conn_del eventually, right? If not, I am having the slight feeling that you might have uncovered a bug that we should fix.
> 
> It's probably just lack of familiarity with the code, but it wasn't
> all that clear to me that hci_conn_del is called after
> hci_conn_timeout kicks in. I removed it.

there is always a possibility that you found an actual bug that we trigger, but has not done any harm. At least not harm that anybody has noticed so far. So if this happens, then I like to fix the actual bug.

Regards

Marcel

