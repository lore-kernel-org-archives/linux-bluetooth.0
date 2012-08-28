Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 08:20:58 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Garbat <rafal.garbat@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
Message-ID: <20120828152058.GA18913@x220.sheraton.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
 <1344870497-6929-2-git-send-email-rafal.garbat@tieto.com>
 <20120814095636.GA7055@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120814095636.GA7055@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 14, 2012, Johan Hedberg wrote:
> Hi,
> 
> On Mon, Aug 13, 2012, Rafal Garbat wrote:
> > +Heart Rate Profile hierarchy
> > +============================
> > +
> > +Service		org.bluez
> > +Interface	org.bluez.HeartRate
> > +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > +
> > +Methods		dict GetProperties()
> > +
> > +			Returns all properties for the interface. See the
> > +			Properties section for the available properties.
> > +
> > +		RegisterWatcher(object agent)
> > +
> > +			Registers a watcher to monitor heart rate measurements.
> > +
> > +			Possible Errors: org.bluez.Error.InvalidArguments
> 
> I'm wondering if it wouldn't make more sense to have these
> RegisterWatcher APIs (thermometer, heart rate, others?) per-adapter
> instead of per-device. That would be much friendlier to applications in
> that they wouldn't need to separately search for paired/configured
> devices supporting a specific service. Moving this to be per-adapter
> would also mean that the first parameter of the Watcher methods would be
> the object path of which device is in question.

So any comments on this? I'd like to get this moving forward and finally
merged upstream.

Johan
