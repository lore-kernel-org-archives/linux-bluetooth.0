Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 20 Apr 2011 22:18:52 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: Read RSSI through Management Interface?
Message-ID: <20110421011852.GB9392@joana>
References: <BANLkTinpSJeozeWCcYCBeQ=sxKU5SJSrSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTinpSJeozeWCcYCBeQ=sxKU5SJSrSQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-04-20 19:20:57 -0300]:

> Hi guys,
> 
> we need to read the RSSI of LE and basic rate connections to implement
> the Proximity profile. RSSI included in the advertising packets can't
> be used for Proximity, it requires an "active" connection.
> 
> Here are some suggestions:
> 
> 1. Add a new command to mgmt interface to add a given address into a
> RSSI "monitoring list".
>    When the connection is established the kernel will automatically
> track the RSSI of the connection on regular intervals sending
> HCI_Read_RSSI. Read RSSI value can be reported through a new event in
> the management interface
> 
> Forgetting SMP, we can keep the hciops compatibility implementing the
> same logic inside the hciops plugin.

I'm against this in hciops. Let's add the new features only to mgmtopts, so we
force people to use it and deprecate hciops.

> 
> 2. Add a new command to mgmt interface to actively read the RSSI of a
> given connection/address

If the user use this in the wrong way it will waste power. Let's
do (1) and not give him this option to actively read RSSI.

-- 
Gustavo F. Padovan
http://profusion.mobi
