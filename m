Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1054913828.26827.45.camel@pegasus>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<1054913828.26827.45.camel@pegasus>
Content-Type: text/plain
Message-Id: <1055156207.4791.301.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 09 Jun 2003 11:56:48 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Fri, 2003-06-06 at 16:37, Marcel Holtmann wrote:
> the current Zaurus packages are done by Joseph Ecker and the kernel
> modules are based on the deprecated bluez-kernel-2.3 package. It seems
> that it is really time to have up-to-date kernel modules for the Zaurus.
> Frist I don't like Joseph last choise to put the userspace tools and the
> kernel modules into one big package. I like to see the kernel stuff
> seperated from the userspace tools.

Yeah me too. Particularly because it's much easier to build the
user-space tools with a cross-compiler.

> However I have no Zaurus, so I can't
> help with that. But some time ago I put some scripts in the BlueZ kernel
> CVS repository which makes it possible to compile and install the
> Bluetooth modules outside the kernel source. Maybe you should take a
> look at it and provide some easy to install ipk packages.

I will think about doing this if I get some time. For now, I have
uploaded the latest basic user-space binaries separately to
ftp://rococosoft.com/pub/zaurus with instructions for installing them in
the right places. It would not be too hard to write packaging scripts
for them --- indeed this is something anyone could do using the
ipkg-build script; volunteers?

> The OpenZaurus project will use a 2.4.19 in future and hopefully they
> include my patch. Do anyone have details about this.

We only have 2 Zauruses here (one with the older Sharp ROM and the other
with the new one) so I can't try OpenZaurus :-(

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
