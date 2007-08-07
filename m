Return-Path: <gl@dsa-ac.de>
Date: Tue, 7 Aug 2007 17:56:58 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] [REGRESSION] last working kernel 2.6.18
In-Reply-To: <1186500734.20129.58.camel@violet>
Message-ID: <Pine.LNX.4.63.0708071754160.8578@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0708071702431.8578@pcgl.dsa-ac.de>
 <1186500734.20129.58.camel@violet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, 7 Aug 2007, Marcel Holtmann wrote:

> as mentioned multiple times in the past, the "hcitool cc" is not a
> general purpose command. Nobody needs to create an ACL link. The kernel
> does this for you in the background and you should let the kernel do its
> job. It has to be the kernel since it has to track these connections and
> the users of it. Unused ACL links will be disconnected. Period.
> 
> There are simply no excuses for creating low-level ACL links and there
> is absolutely no need for it at all.

Thanks, Marcel. Just, what I thought:-) It would've saved us a few minutes 
of typing and a few electrons shifted around the world if this was 
documented somewhere:-) Would be great, if someone could, for example, 
document it in the wiki. I DID look there, and I didn't find anything. 
Which means, either it is not there, or not everybody is able to find it 
there within a reasonable amount of time:-)

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
