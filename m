Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Aug 2010 11:22:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ho, Albert O" <albert.o.ho@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: Cannot build BlueZ Release 4.70...
Message-ID: <20100828082256.GA23228@jh-x301>
References: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

On Sat, Aug 28, 2010, Ho, Albert O wrote:
> Hi, I attempted to build Release 4.70 but it's not buildable.  Using
> sources either from bluez-4.70.tar.gz (www.bluez.org) or from git
> results to compile errors.  The offending lines are all in
> attrib-server.c & all are 'undefined references to xxxxx'.  Same setup
> can build 4.69.  Pls advise.

It compiles fine for me. You'll need to copy-paste the exact errors you
get as well as the configure script options that you used.

Johan
