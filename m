Return-Path: <cyrus@holtmann.org>
Subject: Re: HCI_MAX_DEV is a bit too small.
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Reply-To: donpedro@tdcadsl.dk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268609659.3897.56.camel@localhost.localdomain>
References: <1268608837.6400.26.camel@donpedro>
	 <1268609659.3897.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 Mar 2010 03:11:18 +0100
Message-Id: <1268619078.6278.10.camel@donpedro>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi M,

Thanks for the fast reply,

> you are seriously considering the case of more than 16 Bluetooth devices
> are real normal use cases. We are talking about 1 device vs. 2 and can
> not even find an agreement for the UI cases there.
I know that normal users do not use that many devices, but test systems
or bluetooth servers (gateways) can easily have more than 16.

> So I could be convinced to add new functions to read/write the limit
> from within an application itself. So that it can be changed without
> re-compiling the library. Feel free to propose a patch.
I will see what i can do. What is needed is probably a
hci_set_max_devices() call. Then hcitool could call that with the number
of devices needed.

Thanks,

/Pedro
