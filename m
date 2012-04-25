Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120425101422.GB26311@x220>
References: <1335340311-25057-1-git-send-email-vishal.agarwal@stericsson.com>
	<20120425090505.GA25179@x220>
	<CA+_sZW-2a4NiLA4SpYV44DLwWnnFeiD88_K_gQOSQX9rN9Bugg@mail.gmail.com>
	<20120425101422.GB26311@x220>
Date: Wed, 25 Apr 2012 17:30:05 +0530
Message-ID: <CA+_sZW_w5wZePmECvgrPkQy8vPPm=MKEQ3kYhRfPcwaA3cofQQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: eir_append_data should take care of padding
From: vishal agarwal <vishal.bluez@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 25, 2012 at 3:44 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vishal,
>
> No top-posting! I think I've told you this already before.
>
> On Wed, Apr 25, 2012, vishal agarwal wrote:
>> In function mgmt_device_found, which is called from
>> hci_extended_inquiry_result_evt eir_append_data function is called
>> without taking care of padding bytes. I will create a new function
>> which will return the padding offset in the EIR data andit will be
>> called in function mgmt_device_found before calling the
>> eir_append_data function.
>
> That's indeed a bug but please do it in hci_extended_inquiry_result_evt
> since in the LE case the mgmt_device_found already gets the right
> parameter value and we'd be needlessly trying to find the offset for LE
> events.
I was thinking of doing it inside the
if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV)) {

}
it will help us doing it only when needed(no class of device inside EIR data).
And also in case of BLE dev_class is NULL so it will not go inside if.
and also code will be more clear.
what do you think?
>
> Johan

Vishal
