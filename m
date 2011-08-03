Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A435FBDE@EXDCVYMBSTM005.EQ1STM.local>
References: <CAKT1EBfK1P7oJpLrm2HNTQTOKoN0Z+6mh7BoeaVeA8gUQpD49g@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A435FBDE@EXDCVYMBSTM005.EQ1STM.local>
Date: Wed, 3 Aug 2011 08:54:24 -0300
Message-ID: <CAKT1EBebYWwjNURbciEM9s3saKX5tYHp2Jtr-VTcqV+eUrMSvA@mail.gmail.com>
Subject: Re: Current status on BLE development
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Tue, Aug 2, 2011 at 8:49 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Hi Claudio,
>
>>It is common to see questions in the ML or in the IRC asking the
>>status of BLE development and where the get the source code.
>>Below a short summary of our latest development on Bluetooth Low Energy:
>>
>>* Discovery procedure over management interface (kernel): patches sent
>>to the mailing list, waiting maintainer approval
>>
>>* SM(Security Manager): kernel & userspace
>>- Just Works key generation method is working and accepted upstream;
>>- Key Exchange and Storage: a first version of the implementation is
>>implemented and working, but before being accepted upstream it needs
>>some changes;
>>- Passkey Entry: Still not implemented;
>>- Out of Band: Still not implemented;
>>- Address Resolution: Planned but still not implemented;
>>- Command Signing: Still not implemented;
>>
>>* LE connection improvements: under development
> <snip ..>
>
> Thanks for the detailed summary. However I would also like to understand the status of mgmt interface in terms of its completeness for BR/EDR and LE support. I can see LE Discovery related patches being pushed upstream for mgmt i/f however what intrigues me is whether its totally unavoidable to upgrade to mgmt interface for LE/profiles?
> Since for SMP key exchange, hciops is inadequate, I am trying to understand as to how far hciops can be relied in terms of LE profiles which would need SMP key distribution and storage?
>

If the LE profile requires SM/encryption it is necessary to use mgmt.
The RSSI threshold monitor is another feature missing for Proximity
Path Loss, it can be implemented in hciops but I am pretty sure that
the maintainers will complain about it.

Currently, it is not possible to open a socket for the SM L2CAP fixed
channel, change the code(moving all logic to the userspace) at this
point is not feasible. Interleaved discovery works on both interfaces,
bonding only using mgmt.

BR,
Claudio.

>
>
> Thanks,
> Arun
