Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20151016052910.GB28796@t440s.P-661HNU-F1>
References: <1444938838-3225-1-git-send-email-jpawlowski@google.com>
	<20151016052910.GB28796@t440s.P-661HNU-F1>
Date: Thu, 15 Oct 2015 23:00:49 -0700
Message-ID: <CAD0=r8wM3n6xmJ12S7yQGHxk0XL-wug8NNe0xOoRDh4G60whJA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix double scan updates
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 15, 2015 at 10:29 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, Oct 15, 2015, Jakub Pawlowski wrote:
>> When disble/enable scan command is issued twice, some controllers would
>> return error for second request. Therefore requests including those would
>> fail on some controllers, and succeed on others.
>
> Do you actually have examples of controllers that don't fail? I haven't
> seen any. Also, the usual convention is the provide a btmon output
> snippet of the failure in the commit message.
Atheros controller do that.
I'm unable to provide btmon snippet at the moment, I'll be able to add
it tomorrow.

>
>> @@ -6124,7 +6124,11 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
>>       case HCI_AUTO_CONN_ALWAYS:
>>               if (!is_connected(hdev, addr, addr_type)) {
>>                       list_add(&params->action, &hdev->pend_le_conns);
>> -                     __hci_update_background_scan(req);
>> +                     /* If we are connecting to device using random address,
>> +                      * we were already added to pend_le_conns and scanning.
>> +                      */
>> +                     if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
>> +                             __hci_update_background_scan(req);
>
> The patch looks in general fine, but the above code comment has always
> confused me. What has this got to do with random addresses? Wouldn't we
> be scanning regardless of what type of address had previously been
> added?

Yes, comment fixed.

>
> Johan
