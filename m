Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099433039.7125.13.camel@pegasus>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
Content-Type: text/plain
Message-Id: <1099495689.3265.44.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 15:28:09 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
I've run our basic RFComm server-side security tests against 2.6.9-mh3
and they all seem to pass (previously they'd all failed of course). Nice
work!

Regards,
Steve

On Tue, 2004-11-02 at 22:03, Marcel Holtmann wrote:
> Hi Folks,
> 
> > I released patch-2.6.9-mh3 some minutes ago and it contains the first
> > experimental version of the service level security implementation for
> > the RFCOMM layer.
> > 
> > The libs CVS is also updated to add the specific defines for using it
> > and rctest got some extra paramters for it, but it seems that the CVS
> > service for anonymous access from Sourceforge is broken and so most of
> > you won't get these modification. However this is not a big problem,
> > because you can use L2CAP_LM, L2CAP_LM_AUTH etc. for it. The values
> > behind these defines are identical and so this should work at least for
> > testing this new feature.
> > 
> > Please test this and send reports back to the mailing list.
> 
> what's up? Has nobody tested this new feature so far? The Sourceforge
> CVS is now back in sync and rctest has all needed options.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
