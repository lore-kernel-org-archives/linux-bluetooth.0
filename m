Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Aug 2010 13:19:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alok barsode <alokbarsode@gmail.com>
Cc: "Ho, Albert O" <albert.o.ho@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: Cannot build BlueZ Release 4.70...
Message-ID: <20100829101959.GA10891@jh-x301>
References: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
 <20100828082256.GA23228@jh-x301>
 <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D28E0@orsmsx501.amr.corp.intel.com>
 <AANLkTi=K6rdg+Pck7FjbDP-LTn=5sXrLVX9Nz8RPqi0v@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=K6rdg+Pck7FjbDP-LTn=5sXrLVX9Nz8RPqi0v@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Aug 29, 2010, alok barsode wrote:
> > The configure line invocation is taken from README file.  Below are
> > copy-paste exact errors.
> 
> I tried building using bootstrap-configure and it built fine.  But
> when I tried building with ./bootstrap and ./configure  it gave the
> same errors as mentioned.
> Maybe we missed some configure option ?

I still can't seem to reproduce this. I just tried "./bootstrap &&
./configure && make" with a clean git tree and it compiles fine.
Downloading the official tarball for 4.70 and doing "./configure &&
make" works fine too. I wonder if the autotools or gcc version has
something to do with this?

Johan
