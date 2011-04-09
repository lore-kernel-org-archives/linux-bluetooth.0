Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Apr 2011 11:12:49 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add sap_disconnect_ind interface for sap-sim drivers
Message-ID: <20110409181249.GA28034@jh-x301>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325091759.GA1150@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114481085E2325E@EXMB04.eu.tieto.com>
 <20110328095557.GA11511@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114481085FBEEE1@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085FBEEE1@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Tue, Apr 05, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >> The original idea was to have Disconnect(type) method in 
> >server.c, but 
> >> finally, in a discussion, we came to the conclusion that the 
> >immediate 
> >> disconnect should not be used by user. Driver should handle this if 
> >> it's needed.
> >> 
> >> So, sap-api.txt stays unchanged, and dummy-driver is changed to be 
> >> able to pass some of  PTS tests.
> >
> >Ok, sounds fine to me.
> 
> Are you going to push upstram this patch ?

It's pushed upstream now. Sorry for the delay.

Johan
