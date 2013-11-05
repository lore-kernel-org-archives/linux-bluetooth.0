Return-Path: <cyrus@holtmann.org>
Message-ID: <5278F81B.6020009@linux.intel.com>
Date: Tue, 05 Nov 2013 15:52:27 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v3 02/04] android/hid: Implement hid set protocol in daemon
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1383654126-19237-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131105131232.GB15228@x220.p-661hnu-f1>
In-Reply-To: <20131105131232.GB15228@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/05/2013 03:12 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
>>   static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
>>   								uint16_t len)
>>   {
>> -	DBG("Not Implemented");
>> +	struct hid_device *dev;
>> +	GSList *l;
>> +	bdaddr_t dst;
>> +	int fd;
>> +	uint8_t hdr[1];
> If it's just one element there's no need for an array. Just use
> "uint8_t hdr;" instead.
>
>> +	hdr[0] = HID_MSG_SET_PROTOCOL | cmd->mode;
> And then here hdr = ...;
>
>> +	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
>> +
>> +	if (write(fd, hdr, sizeof(hdr)) < 0) {
> And here &hdr, sizeof(hdr)
  Ok.

Thanks,
Ravi.
