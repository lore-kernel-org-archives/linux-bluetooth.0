Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Mar 2013 13:08:47 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Bluetooth: Check req->err in hci_req_add
Message-ID: <20130308110845.GA31311@aemeltch-MOBL1>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
 <1362692892-28716-7-git-send-email-andre.guedes@openbossa.org>
 <20130308075009.GB817@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130308075009.GB817@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 08, 2013 at 09:50:09AM +0200, Johan Hedberg wrote:
> Hi Andre,
> 
> On Thu, Mar 07, 2013, Andre Guedes wrote:
> > +	if (req->err)
> > +		return;
> 
> Same thing here with the error check, I think if (err < 0) is more
> consistent.

Using "if (err)" seems to be OK for kernel and looks shorter.

Best regards 
Andrei Emeltchenko 

