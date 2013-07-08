Return-Path: <cyrus@holtmann.org>
Message-ID: <51DA8707.3010402@linux.intel.com>
Date: Mon, 08 Jul 2013 11:31:51 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older devices
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com> <20130708023309.GA31844@echo>
In-Reply-To: <20130708023309.GA31844@echo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

Le 08/07/2013 04:33, Vinicius Costa Gomes a écrit :
> I remember seeing a couple of 2.0 controllers that have Transparent SCO
> feature bit set but don't have support for eSCO.
>
> I wonder if it would be better to use Setup Synchronous Connection if
> transparent SCO is needed (and the controller supports it).

I saw your previous mail about this. There are several other places in
the code (hci_sco_setup, hci_conn_request_evt maybe others) where Bluez
decides whether to use Add_Sco or Setup_Synchronous_Connection based on
lmp_esco_capable() macro. Supporting transparent data on these adapters 
would need these places changed as well.

> Another problem is in the accepting side, we are using Add SCO if the
> controller doesn't support eSCO, this fails (IIRC Invalid LMP Parameters
> or somehing) if the other side has requested a SCO link expecting
> transparent SCO data.

This patch only applies to connecting side. Accepting side should
not be impacted. If voice settings on both side are matching, I don't
see why it would fail.

Regards,
Fred

