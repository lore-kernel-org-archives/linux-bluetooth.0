Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:30:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Convert storage to use per-remote device directories
Message-ID: <20121001083010.GA21726@x220>
References: <50642389.40107@intel.com>
 <CAJdJm_NbPw0jwWvuUiu7L=wzxc+qxfF_4i2vj7U1G06b=BE2qw@mail.gmail.com>
 <5065A248.7020009@linux.intel.com>
 <CAJdJm_O+8tWER69LEbz9oMeoadfp=gGT3_6V0=fY-LDZ8B90kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_O+8tWER69LEbz9oMeoadfp=gGT3_6V0=fY-LDZ8B90kA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Sep 28, 2012, Anderson Lizardo wrote:
> > Is it possible to save it as we did for SDP records (record entry in profile
> > group) ?
> 
> It seems the SDP records have the UUID as group on the INI file. This
> is not feasible for GATT/ATT because the UUID is not a unique key, but
> the attribute handle is.
> 
> Are you sure that for SDP each record has its own UUID (i.e. no SDP
> record shares same UUID)?

There's no such restriction for BR/EDR. As with ATT the only unique
identifier is the SDP record handle, however (at least with SDP) I think
this is only guaranteed to have the same value for a single connection ,
i.e. in theory subsequent connections could have the same record behind
a different handle.

Johan
