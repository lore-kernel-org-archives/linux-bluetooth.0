Return-Path: <cyrus@holtmann.org>
Message-ID: <4D394E86.9070109@iam.unibe.ch>
Date: Fri, 21 Jan 2011 10:14:46 +0100
From: =?UTF-8?B?VWxyaWNoIELDvHJnaQ==?= <buergi@iam.unibe.ch>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with inquiry result with rssi
References: <4D385855.2050709@iam.unibe.ch> <AANLkTinWBAvaFv-nS7gPvfGzWyC8S3vzm_BpfKo3qWhb@mail.gmail.com>
In-Reply-To: <AANLkTinWBAvaFv-nS7gPvfGzWyC8S3vzm_BpfKo3qWhb@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,


>>         if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,
>> WRITE_INQUIRY_MODE_RP_SIZE,&cp)<  0) {
>
> Taking a look at your code, a few things look out of place: you are
> using cp uninitialized, it is expecting a write_inquiry_mode_cp, not a
> inquiry_cp and the plen parameter seems wrong.

Silly me! How could I have missed this?
Well, now I use write_inquiry_mode_cp with a mode set to 0x01 and the 
proper plen.
Everything works as expected!

Thank you very much for the quick help!
Ulrich
