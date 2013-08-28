Return-Path: <cyrus@holtmann.org>
Message-ID: <521E0CFE.2090702@richardneill.org>
Date: Wed, 28 Aug 2013 15:45:18 +0100
From: Richard Neill <rn214@richardneill.org>
MIME-Version: 1.0
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
References: <521DCF49.5020807@richardneill.org> <20130828103920.GD15469@aemeltch-MOBL1> <521DDAB3.2050407@richardneill.org> <20130828121249.GF15469@aemeltch-MOBL1> <CAKT1EBc+Dyz5OfBdpEj6u1G5iiL36qG4jS0X4rzRf_mW4g1Gkg@mail.gmail.com>
In-Reply-To: <CAKT1EBc+Dyz5OfBdpEj6u1G5iiL36qG4jS0X4rzRf_mW4g1Gkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 28/08/13 15:10, Claudio Takahasi wrote:

> Sets the advertising data:
> $sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 $(perl -e 'print "00
> " x 28 . "\n"')
> Remember that the data needs to follow the EIR/AD format: see Core Spec page1761
>
> Enable adv
> $sudo hciconfig hci0 leadv
>
> BR,
> Claudio

Dear Claudio,

Thanks very much - that's really helpful :-)

Best wishes,

Richard


