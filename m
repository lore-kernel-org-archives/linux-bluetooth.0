Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Sep 2010 16:28:09 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] Add hcimgmt command line test tool
Message-ID: <20100920132809.GA17403@jh-x301>
References: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
 <1284980866-3974-4-git-send-email-johan.hedberg@gmail.com>
 <AANLkTi=xM5RSqZJ=bG-PfphpZ8awYKjSY+sB3ey4eu_P@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=xM5RSqZJ=bG-PfphpZ8awYKjSY+sB3ey4eu_P@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Sep 20, 2010, Anderson Lizardo wrote:
> On Mon, Sep 20, 2010 at 7:07 AM,  <johan.hedberg@gmail.com> wrote:
> > +static void usage(void)
> > +{
> > +       int i;
> > +
> > +       printf("hcictl - HCI Control ver %s\n", VERSION);
> 
> hcictl -> hcimgmt

Thanks. I used to call the interface "HCI Control interface" originally
and have forgotten to change all places to match the new "Management"
term.

Johan
