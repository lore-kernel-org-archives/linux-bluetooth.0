Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Dec 2012 11:02:39 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: PSCAN and ISCAN flags in hciconfig
Message-ID: <20121217090237.GB12861@aemeltch-MOBL1>
References: <CAGXs5wWXOLpn1O77RMiQ-Cvp3vXEKm3KCbRvz07dN6jJwFoe-A@mail.gmail.com>
 <50CE38D1.8010303@linux.intel.com>
 <CAGXs5wXfwHME+XpVUq4rMmK_u=Sw2qG_snCC6iLEbKBYeZ0VTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXs5wXfwHME+XpVUq4rMmK_u=Sw2qG_snCC6iLEbKBYeZ0VTA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin

On Mon, Dec 17, 2012 at 05:37:09AM +0200, Kevin Wilson wrote:
> Hi,
> Thanks Frederic.
> Ok, so I rebooted the machine and still
> hciconfig shows:
> UP RUNNING PSCAN
> and also after 'hciconfig hci0 reset"
> It stays "UP RUNNING PSCAN".
> 
> So what sould I do to make the ISCAN flag set ?

hciconfig hciX piscan

Best regards 
Andrei Emeltchenko 

> 
>  systemctl status bluetooth.service
> shows that it is "active (running)"
> 
> rgs,
> Kevin
> 
> 
> On Sun, Dec 16, 2012 at 11:10 PM, Frederic Danis
> <frederic.danis@linux.intel.com> wrote:
> > On 16/12/2012 18:58, Kevin Wilson wrote:
> >>
> >> Hello,
> >> I have 2 PC with Linux which once used to recognize each other by
> >> "hcitool scan" and  to create
> >> a PAND-based connection.
> >>
> >> Now I fail to see each other with "hcitool scan".
> >> My question is :
> >> I see now only the PSCAN flag when running "hciconfig" on both of then.
> >> Is the ISCAN flag (inquiry) mandatory so that a device will be
> >> discoverable ?
> >
> >
> > Yes, ISCAN means that your adapter will respond to inquiry scan, so it will
> > be discoverable.
> >
> > Regards
> >
> > Fred
> >
> > --
> > Frederic Danis                            Open Source Technology Center
> > frederic.danis@intel.com                              Intel Corporation
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
