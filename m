Return-Path: <ak@suse.de>
Date: Sun, 15 Feb 2004 00:25:13 +0100
From: Andi Kleen <ak@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net, netdev@oss.sgi.com,
   viro@zenII.linux.org.uk
Subject: Re: some bluetooth fixes
Message-Id: <20040215002513.7c6fc532.ak@suse.de>
In-Reply-To: <1076525743.2792.1.camel@pegasus>
References: <20040206050042.20a2b3b0.ak@suse.de>
	<1076079512.2806.40.camel@pegasus>
	<20040207032428.56ffbebc.ak@suse.de>
	<1076152411.14418.73.camel@pegasus>
	<20040207125723.391a1fcd.ak@suse.de>
	<1076173068.2670.4.camel@pegasus>
	<20040207172436.GB449@wotan.suse.de>
	<1076525743.2792.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 11 Feb 2004 19:55:43 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andi,
> 
> > Doing size checks after the multiply is too late - they could
> > have already overflowed. You have to check the raw value from the user.
> 
> new patch is attached.


+	if (req.conn_num * sizeof(*ci) > PAGE_SIZE * 2)
+		return -EINVAL;

This can still overflow. It should be 

	if (req.conn_num > (PAGE_SIZE * 2)/sizeof(*ci))
		return -EINVAL

-Andi
