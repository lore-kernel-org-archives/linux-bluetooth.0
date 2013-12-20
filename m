Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 13:30:01 +0100
From: Stevie Trujillo <stevie.trujillo@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: Hui Wang <hui.wang@canonical.com>, Marcel Holtmann
 <marcel@holtmann.org>, tedd.an@intel.com, "linux-bluetooth@vger.kernel.org
 development" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
Message-ID: <20131220133001.36d5e7aa@localhost>
In-Reply-To: <CALkxMhFBoJO+_1PRQhS-a9g8qQW_Vc+7Ss6HG6P8i0DDoeZYmw@mail.gmail.com>
References: <526F8804.9060906@canonical.com>
	<A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org>
	<52707428.9070908@canonical.com>
	<6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org>
	<5271EAA2.1030705@canonical.com>
	<D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org>
	<5273147E.4040004@canonical.com>
	<C3BBD7E9-6D91-430E-96DF-2D4885F89DCC@holtmann.org>
	<527371D4.1010305@canonical.com>
	<9DFD9618-158E-41C4-8183-134A3FC4E61F@holtmann.org>
	<527737C7.40208@canonical.com>
	<20131104141539.772e1636@localhost>
	<527858A5.2080801@canonical.com>
	<20131105194431.54fba8fb@localhost>
	<527B0CF1.7010703@canonical.com>
	<20131107110719.445e8e6f@localhost>
	<527C41C5.8070209@canonical.com>
	<CALkxMhEzw+mL5UtF=gZ8MQrWRM_2WEQQeq6jR1hvYiSZ=Mfi3g@mail.gmail.com>
	<CALkxMhFBoJO+_1PRQhS-a9g8qQW_Vc+7Ss6HG6P8i0DDoeZYmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 26 Nov 2013 10:11:47 +0100
Michal Labedzki <michal.labedzki@tieto.com> wrote:

> Bug is now fixed in "svn path=/trunk/; revision=53525". You can wait
> for next development (1.11.3) or stable (1.12), however you can build
> Wireshark from sources (should be easy - like BlueZ: git clone
> http://code.wireshark.org/git/wireshark; ./autogen; ./configure; make;
> ./wireshark) or via "private" sources like:
> $ sudo add-apt-repository ppa:dreibh/ppa
> $ sudo apt-get update
> $ sudo apt-get install wireshark

Thank you! I was busy failing exams and I didn't get to filing the
bug report.
I will try it out after xmas. I bought an $1 Bluetooth USB which seems
to do SCO fine, but it usually dies after a few minutes (with
Bluetooth: hci0 command {0x1009,0x0419,etc} tx timeout).
I took a quick look in wireshark, comparing this USB thing vs Intel,
it seems like they set up SCO in a different way. I think the USB stick
might be Bluetooth 2.0 (despite the decription saying Bluetooth 2.1).
