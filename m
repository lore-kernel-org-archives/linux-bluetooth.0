Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 13:26:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] hciconfig: Remove putkey command
Message-ID: <20121205112614.GA6412@x220.ger.corp.intel.com>
References: <1354703610.1815.0.camel@aeonflux>
 <1354705348-28264-1-git-send-email-frederic.danis@linux.intel.com>
 <1354705606.1815.6.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354705606.1815.6.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 05, 2012, Marcel Holtmann wrote:
> >  tools/hciconfig.c |   64 -----------------------------------------------------
> >  1 file changed, 64 deletions(-)
> 
> that command does have a manpage entry.

And I'd appreciate an explanation in the commit message body for *why*
the command is removed. It's not like it's going to be obvious for
anybody looking at the commit history, at least not a more than a year
from now.

Johan
