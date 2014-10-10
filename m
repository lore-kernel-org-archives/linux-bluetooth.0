Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when unpairing without disconnecting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4pJOC3gA1g-+o1e4HRJraFqpCGOAUuqNiS7b0CvAqEBJg@mail.gmail.com>
Date: Fri, 10 Oct 2014 09:36:46 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B2B9E083-A86D-426A-9E79-5F168A8FA017@holtmann.org>
References: <1412859828-6224-1-git-send-email-fons@spotify.com> <20141009141430.GA31807@t440s.P-661HNU-F1> <CAHF=Y4pJOC3gA1g-+o1e4HRJraFqpCGOAUuqNiS7b0CvAqEBJg@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>>> +
>>> +     if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
>>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>>> }
>>> 
>>> /* Enter sniff mode */
>>> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
>>> 
>>>      hci_conn_del_sysfs(conn);
>>> 
>>> +     if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
>>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>> I suppose the above two test_and_clear_bit() calls should be operating
>> on HCI_CONN_PARAM_REMOVAL_PEND and not HCI_CONN_MODE_CHANGE_PEND?
> 
> Darn. Yes, my bad.

don't we also need to clear the flag when the new pairing succeed?

If we destroy hci_conn anyway, there is pretty much no point in test_and_clear_bit and we could just use test_bit here.

Regards

Marcel

