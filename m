Return-Path: <dwmw2@infradead.org>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
   Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1063756197.29942.17.camel@pegasus>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	 <1063712005.22723.27.camel@pegasus>
	 <1063717418.3674.276.camel@hades.cambridge.redhat.com>
	 <1063756197.29942.17.camel@pegasus>
Content-Type: text/plain
Message-Id: <1063779740.788.66.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Wed, 17 Sep 2003 07:22:20 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2003-09-17 at 01:49 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > Feature request: Please can we make sdpd retain its knowledge of apps
> > which have registered with it over a restart, much like portmap does?
> 
> actually I don't know how we can do this, but I put a note on my feature
> list for the new SDP server.

I don't know either -- but portmap does seem to get it right. 

-- 
dwmw2
