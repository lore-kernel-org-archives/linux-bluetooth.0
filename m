Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:36:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v7 2/9] mgmt: Add LE scanning callback
Message-ID: <20121001083630.GA22036@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
 <1348594686-26221-2-git-send-email-jprvita@openbossa.org>
 <20120927074338.GC9610@x220>
 <CAKT1EBdhhqsEU9_zxcAHArtpwzzOo2hmwDmz91SrYNQeiEdEJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKT1EBdhhqsEU9_zxcAHArtpwzzOo2hmwDmz91SrYNQeiEdEJw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Sep 28, 2012, Claudio Takahasi wrote:
> On Thu, Sep 27, 2012 at 4:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
> >> +int mgmt_start_scanning(int index)
> >
> > Firstly I don't think the name is good since BR/EDR also has the concept
> > of scanning (page scan & inquiry scan). Secondly, maybe it'd be simpler
> > to reuse mgmt_start_discovery and simply add a new parameter which
> > provides the value for info->discov_type?
> 
> My suggestions are:
> 1. rename to mgmt_start_le_scanning
> 2. add a new parameter to mgmt_start_discovery: gboolean le_only
> 3. add a new parameter to mgmt_start_discovery: informing the adapter
> operation mode(BREDR/LE/BREDR_LE)
> 
> Option 3 will require to expose controller info/settings to adapter.c.
> It is necessary to know the controller features to send the right
> discover type. btd_adapter_start function could be extended to receive
> the supported features or a parameter specifying the operation mode.
> IMO, using this approach we are duplicating information.
> 
> Which approach do you prefer?

I'd go with 1 for now. Booleans in places where it's not utterly clear
from the calling code what it means shouldn't be used (even enums are
better), i.e. if you don't know the implementation details of the
function there'd be no way for an outsider to know what exactly the
"TRUE" in mgmt_start_discovery(TRUE) means.

Johan
