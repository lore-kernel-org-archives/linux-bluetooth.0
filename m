Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120216221213.GA3889@x220.ger.corp.intel.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	<1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
	<20120216221213.GA3889@x220.ger.corp.intel.com>
Date: Thu, 16 Feb 2012 20:30:41 -0300
Message-ID: <CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Feb 16, 2012 at 7:12 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Thu, Feb 16, 2012, Andre Guedes wrote:
>>  #define INQUIRY_LEN_BREDR            0x08    /* TGAP(100) */
>> +#define INQUIRY_LEN_BREDR_LE         0x04    /* TGAP(100)/2 */
>> +
>>
>>  #define SERVICE_CACHE_TIMEOUT (5 * 1000)
>
> One unnecessary empty line added above.

Thanks, I'll fix it.

>> +int mgmt_interleaved_discovery(struct hci_dev *hdev)
>> +{
>> +     int err;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
>> +     if (err < 0) {
>> +             hci_dev_lock(hdev);
>> +             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>> +             hci_dev_unlock(hdev);
>> +     }
>> +
>> +     return err;
>> +}
>
> The locking doesn't look right to me above. hci_do_inquiry should be
> called with the lock held. I think it might be simpler if you make
> mgmt_interleaved_discovery() require the caller to hold the lock.

Yes, you're right. I just realized hci_do_inquiry now calls inquiry_
cache_flush which requires hdev->lock held. I'll fix this too. Thanks.

BR,

Andre
