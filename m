Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Mar 2011 12:55:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add sap_disconnect_ind interface for sap-sim drivers
Message-ID: <20110328095557.GA11511@jh-x301>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325091759.GA1150@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114481085E2325E@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085E2325E@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Mon, Mar 28, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >Are you planning to have some additional Disconnect* method in 
> >the future since you didn't reuse the existing "Disconnect" 
> >method name for this? The patch is also missing the 
> >corresponding update to sap-api.txt.
> 
> The Disconnect method mentioned in sap-api.txt is implemented in
> server.c and it's the gracefull disconnect. The one I've changes in
> the patch is used in sap-dummy.c driver, which is used for tests only.
>
> The original idea was to have Disconnect(type) method in server.c, but
> finally, in a discussion, we came to the conclusion that the immediate
> disconnect should not be used by user. Driver should handle this if
> it's needed.
> 
> So, sap-api.txt stays unchanged, and dummy-driver is changed to be
> able to pass some of  PTS tests.

Ok, sounds fine to me.

Johan
