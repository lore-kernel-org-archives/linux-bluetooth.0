Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130828121249.GF15469@aemeltch-MOBL1>
References: <521DCF49.5020807@richardneill.org>
	<20130828103920.GD15469@aemeltch-MOBL1>
	<521DDAB3.2050407@richardneill.org>
	<20130828121249.GF15469@aemeltch-MOBL1>
Date: Wed, 28 Aug 2013 11:10:41 -0300
Message-ID: <CAKT1EBc+Dyz5OfBdpEj6u1G5iiL36qG4jS0X4rzRf_mW4g1Gkg@mail.gmail.com>
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Richard Neill <rn214@richardneill.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Richard:

On Wed, Aug 28, 2013 at 9:12 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Richard,
>
>> Thanks for your reply. That was actually very helpful: by searching
>> specifically for "ogf ocf Bluetooth specification", I was able to
>> locate the right part of the relevant document (a 600 page PDF of
>> Bluetooth 4.0 core).
>>
>> However, before I delve into this in great detail, I wonder whether
>
> Those ogf and ocf are just command identifiers, search by command you want
> to run and you will find them.
>
> Best regards
> Andrei Emeltchenko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sets the advertising data:
$sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 $(perl -e 'print "00
" x 28 . "\n"')
Remember that the data needs to follow the EIR/AD format: see Core Spec page1761

Enable adv
$sudo hciconfig hci0 leadv

BR,
Claudio
