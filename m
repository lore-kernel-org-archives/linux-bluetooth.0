Return-Path: <cyrus@holtmann.org>
Message-ID: <1350663141.2026.40.camel@aeonflux>
Subject: Re: [PATCH v6 01/16] doc: Add settings storage documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 09:12:21 -0700
In-Reply-To: <50811E78.6060009@linux.intel.com>
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
	  <1350565311-18330-2-git-send-email-frederic.danis@linux.intel.com>
	 <1350602001.2026.35.camel@aeonflux> <50811E78.6060009@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> >> +Cache directory files
> >> +======================
> >> +
> >> +Each files, named by remote device address, contains 1 [General] group:
> >> +  [General]
> >> +  Name=device name a
> >
> > Is this the only thing we are storing in these files? Or are we planning
> > to store additional information at some point.
> >
> >> +Device directory files
> >> +======================
> >> +
> >> +Remote device info file will include a [General] group with device info,
> >> +[DeviceID], [LinkKey] and [LongTermKey] groups with related info:
> >> +  [General]
> >> +  Alias=
> >
> > Are we just doing the Alias here? We are not keeping the Name? In theory
> > we have a short name and full name actually. If we ever only got the
> > short name, we need to know that. Then we have to request the long name
> > next time.
> 
> Name is already stored in cache file. So I think we do not need to save 
> it also in device info file.
> 
> We may store both short and long names in the cache file.

I was assuming that the cache file is only used for LE devices with
static random addresses, but know I remember that we even need to store
the names for devices that we only discovered and not paired with.

Regards

Marcel


