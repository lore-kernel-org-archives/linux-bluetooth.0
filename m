Return-Path: <sudeepta.bhuyan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <B26A4952-B5DC-47BB-B45B-5D95FAEE6D98@holtmann.org>
References: <CA+TC0NqnhXH=jxSoV-XhkDJ05S7evYJhW28peD4LPAnSRn3spw@mail.gmail.com>
 <B26A4952-B5DC-47BB-B45B-5D95FAEE6D98@holtmann.org>
From: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Date: Wed, 14 Feb 2018 15:32:31 +0530
Message-ID: <CA+TC0NrLx9aMPtYTGrcROzOrmKL++f0RwMdc7jxYfwFs_669Mg@mail.gmail.com>
Subject: Re: hciattach alternative to change default address after upgrading
 to BlueZ 5.47
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel. I was able to get it done using btmgmt.

Sudeepta

On Mon, Feb 12, 2018 at 7:38 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sudeepta,
>
>> Prior to upgrading BlueZ to 5.47 in my project, I was using hciattach
>> to set the UART device's address before starting bluetoothd.
>>
>> hciattach /dev/ttyS2 bcm43xx flow nosleep xx:xx:xx:xx:xx
>>
>> However since hciattach is deprecated in newer BlueZ, I am now using
>> btattach instead to do the same. But btattach does not provide an
>> option to set the bluetooth address of the device.
>>
>> What is the standard procedure to set the bluetooth address of the
>> UART device using newer BlueZ tools?
>
> there is btmgmt public-addr command that will work if your driver supports hdev->set_bdaddr. For Broadcom chips that should be fully supported.
>
> Regards
>
> Marcel
>
