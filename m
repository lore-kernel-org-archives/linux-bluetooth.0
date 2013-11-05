Return-Path: <cyrus@holtmann.org>
Message-ID: <5278F8C2.8070608@linux.intel.com>
Date: Tue, 05 Nov 2013 15:55:14 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v3 03/04] android/hid: Implement hid get report in daemon
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1383654126-19237-3-git-send-email-ravikumar.veeramally@linux.intel.com> <20131105131606.GC15228@x220.p-661hnu-f1>
In-Reply-To: <20131105131606.GC15228@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 11/05/2013 03:16 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
>> +	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
>> +			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
>> +			(buf[0]	== (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
>> +		ev = g_malloc(len);
>> +		memset(ev, 0, ev_len);
> Is it intentional that you allocate a different length than what you
> memset to 0 here? If they should be the same just use g_malloc0, and if
> not a code comment might be in order (to explain what the actual
> intention is).
  Ok, type, it should be ev_len.
>> +	ev = g_malloc(ev_len);
>> +	memset(ev, 0, ev_len);
> Here g_malloc0 makes more sense.
>
>> +	ev->status = HAL_HID_STATUS_OK;
>> +	bdaddr2android(&dev->dst, ev->bdaddr);
>> +
>> +	/* Report porotocol mode reply contains id after hdr, in boot
>> +	 * protocol mode id doesn't exist */
>> +	if (dev->boot_dev) {
>> +		ev->len = len - 1;
>> +		memcpy(ev->data, buf + 1, ev->len);
>> +	} else {
>> +		ev->len = len - 2;
>> +		memcpy(ev->data, buf + 2, ev->len);
>> +	}
>> +
>> +send:
>> +	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_GET_REPORT,
>> +						ev_len, ev, -1);
> This doesn't look right for your first allocation (you claim that the
> length of ev is ev_len, but in fact you allocated len amount of bytes.
  Ok. I will fix it.

Thanks,
Ravi.
