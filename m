Return-Path: <johan.hedberg@gmail.com>
Date: Fri, 6 Jul 2018 13:41:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Inga Stotland <inga.stotland@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Directory re-org for meshctl tool
Message-ID: <20180706104155.GA6509@x1c.lan>
References: <20180622063200.7394-1-inga.stotland@intel.com>
 <A4890F67-3CCD-4A8A-B40F-B01F6FA240D4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A4890F67-3CCD-4A8A-B40F-B01F6FA240D4@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 06, 2018, Marcel Holtmann wrote:
> > This set of patches moves mechctl tool code from under bluez/mesh
> > into tools directory.
> > 
> > mesh directory will be re-established with the implementation of mesh
> > daemon.
> > 
> > Inga Stotland (2):
> >  tools: Move meshctl tool under tools directory
> >  tools: Move meshctl sources under tools/mesh directory
> 
> I am missing patch 1/2 for some reason. Make sure to --cc me when
> patches might get rejected because of size by the mailing list.

I don't think it's a mailing list issue this time, since I did receive
it, and it's also visible in the archives:

	https://www.spinics.net/lists/linux-bluetooth/msg76150.html

Johan
