Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] SDP memory leak?
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Mischke <StefanMischke@web.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   "Stefan Mischke (E-Mail)" <survivor@upb.de>
In-Reply-To: <1093613681.2581.135.camel@pegasus>
References: <412F29D2.7000001@web.de>  <1093610969.2581.119.camel@pegasus>
	 <1093613489.5066.49.camel@baroque.rococosoft.com>
	 <1093613681.2581.135.camel@pegasus>
Content-Type: text/plain
Message-Id: <1093617635.5848.53.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 15:40:35 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, Stefan,

On Fri, 2004-08-27 at 14:34, Marcel Holtmann wrote:
> Hi Steve,
> 
> > The sdp library is free (I think) of memory leaks, thanks to the wonders
> > of valgrind: http://valgrind.kde.org.
> 
> would you also take care of the tools in bluez-utils that uses the SDP
> library?

I have just committed changes to pand's service registration. The CVS
diff should show what is required to fix this in the other applications.
(Note: sdptool also cleans up properly in its "add" subcommands.)

Unfortunately I haven't time to do the others at the moment but this
should be a start for others. (Send in the patches!)

Regards,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
