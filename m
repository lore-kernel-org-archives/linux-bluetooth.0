Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A479074C8@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
	<CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4784F664@banasiexm01.ASIA.ROOT.PRI>
	<CAJdJm_P4TTd_nb8ae-WBp_TkDaEH-QsgCJz3rgCZkeCQoPTjJg@mail.gmail.com>
	<8DCFA6B89B9E70418E47A2348D55495A479074C8@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 21 Oct 2011 11:07:44 -0300
Message-ID: <CAKT1EBcOukEO4+a_f45xDDyFwJ2=+3+2MbtQcEEfB+ans+iGeg@mail.gmail.com>
Subject: Re: Query regarding BLE GetPrimaryServices()
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Fri, Oct 21, 2011 at 10:04 AM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
>>You cannot do this by hand. It is done right after connection (or
>>pairing, if using CreatePairedDevice). For more information on how to
>>read the services and characteristics over D-Bus, see
>>doc/attribute-api.txt.
>
> Does this mean that it is not possible for an Application to just come up, and list the primary services of a remote LE device that is already connected(due to another application)? (via DBUS)
> Is this something that we can just add as a new API (listPrimaryServices) to the " org.bluez.Device" interface of the device object?
>

Applications can access the primary service using the Generic Attribute API.
After pairing, bluetoothd executes discover all primary services.
Check the "Services" property in the Device to discovery, it contains
an array of paths for the primary services.

Use the test/test-attrib script to understand how it works. Using
d-feet you can also access the primary services and characteristics.

BR,
Claudio
