Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Dec 2014 20:37:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 3.19-rc1 refuse connection from bluetooth headset
Message-ID: <20141224183737.GA21428@t440s.P-661HNU-DI-F1>
References: <201412241815.12922@pali>
 <20141224173652.GA16667@t440s.P-661HNU-DI-F1>
 <201412241932.27264@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201412241932.27264@pali>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pali,

On Wed, Dec 24, 2014, Pali Rohár wrote:
> > Could you try the attached patch? I think the reason might be
> > the dependence on the HCI_CONNECTABLE flag that's only set if
> > the page scan was enabled through mgmt (which wouldn't be the
> > case with BlueZ 4.98).
> > 
> > Johan
> 
> Hi Johan! Thanks for quick reply. Your patch fixes my problem and 
> auto-connection of my bluetooth headset is working again. Will 
> you forward patch to mainline kernel?

Yes, we'll tag it from 3.17.x onwards where this was introduced.

Johan
