Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50CE38D1.8010303@linux.intel.com>
References: <CAGXs5wWXOLpn1O77RMiQ-Cvp3vXEKm3KCbRvz07dN6jJwFoe-A@mail.gmail.com>
	<50CE38D1.8010303@linux.intel.com>
Date: Mon, 17 Dec 2012 05:37:09 +0200
Message-ID: <CAGXs5wXfwHME+XpVUq4rMmK_u=Sw2qG_snCC6iLEbKBYeZ0VTA@mail.gmail.com>
Subject: Re: PSCAN and ISCAN flags in hciconfig
From: Kevin Wilson <wkevils@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Thanks Frederic.
Ok, so I rebooted the machine and still
hciconfig shows:
UP RUNNING PSCAN
and also after 'hciconfig hci0 reset"
It stays "UP RUNNING PSCAN".

So what sould I do to make the ISCAN flag set ?

 systemctl status bluetooth.service
shows that it is "active (running)"

rgs,
Kevin


On Sun, Dec 16, 2012 at 11:10 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> On 16/12/2012 18:58, Kevin Wilson wrote:
>>
>> Hello,
>> I have 2 PC with Linux which once used to recognize each other by
>> "hcitool scan" and  to create
>> a PAND-based connection.
>>
>> Now I fail to see each other with "hcitool scan".
>> My question is :
>> I see now only the PSCAN flag when running "hciconfig" on both of then.
>> Is the ISCAN flag (inquiry) mandatory so that a device will be
>> discoverable ?
>
>
> Yes, ISCAN means that your adapter will respond to inquiry scan, so it will
> be discoverable.
>
> Regards
>
> Fred
>
> --
> Frederic Danis                            Open Source Technology Center
> frederic.danis@intel.com                              Intel Corporation
>
