Return-Path: <dv_mlist@verizon.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: digger vermont <dv_mlist@verizon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1074698544.7088.102.camel@pegasus>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
	 <1074698544.7088.102.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074749699.2573.17.camel@myrna>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 00:34:59 -0500
List-ID: <bluez-users.lists.sourceforge.net>

On Wed, 2004-01-21 at 10:22, Marcel Holtmann wrote:
> I don't have any experiences with Apple machines. Ask Benjamin
> Herrenschmidt about this specific problem.
> 

Ben, thanks for answering this in another reply.

> > 
> > running "hciattach /dev/tts/0 socket" I get:
> > 
> > BCSP initialization timed out
> > 
> > I built and tried a 2.4.24 kernel and the command works fine.   I would
> > prefer to stay with the 2.6 kernel.  I there anything I can try? If its
> > of any help there's lofiles, etc below.
> 
> My Com1 card uses also BCSP and I will try it later with 2.6.2-rc1.
> Please check again with this kernel, too.
> 

I'll have to wait. The benh kernel, at least the rsync'd one, is at
2.6.1.  Is the "BCSP initialization timed out" one that may  be specific
to the powerpc kernels and better dealt with on the powerpc list? Or as
Ben H. said regarding the serial port allocation, it is not platform
specific?  

Thanks again,

digger
