Return-Path: <dwmw2@infradead.org>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
   Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1063712005.22723.27.camel@pegasus>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	 <1063712005.22723.27.camel@pegasus>
Content-Type: text/plain
Message-Id: <1063717418.3674.276.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 16 Sep 2003 14:03:39 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2003-09-16 at 13:33 +0200, Marcel Holtmann wrote:
> My work on the 4th (or maybe 5th) generation of a SDP library is making
> good progress and I hope that I will have clean code for publishing very
> soon.

Feature request: Please can we make sdpd retain its knowledge of apps
which have registered with it over a restart, much like portmap does?

-- 
dwmw2
