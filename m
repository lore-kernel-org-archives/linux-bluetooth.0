Return-Path: <ak@suse.de>
Date: Sat, 7 Feb 2004 18:24:36 +0100
From: Andi Kleen <ak@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andi Kleen <ak@suse.de>, bluez-devel@lists.sourceforge.net,
   netdev@oss.sgi.com, viro@zenII.linux.org.uk
Subject: Re: some bluetooth fixes
Message-ID: <20040207172436.GB449@wotan.suse.de>
References: <20040206050042.20a2b3b0.ak@suse.de> <1076079512.2806.40.camel@pegasus> <20040207032428.56ffbebc.ak@suse.de> <1076152411.14418.73.camel@pegasus> <20040207125723.391a1fcd.ak@suse.de> <1076173068.2670.4.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076173068.2670.4.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, Feb 07, 2004 at 05:57:48PM +0100, Marcel Holtmann wrote:
> I now looked carefully through your patch and changed and added some
> parts to better fit into. I also fixed another RFCOMM refcount bug.
> Please review it, before I send it to Dave.

Doing size checks after the multiply is too late - they could
have already overflowed. You have to check the raw value from the user.

-Andi
