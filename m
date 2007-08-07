Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0708071754160.8578@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0708071702431.8578@pcgl.dsa-ac.de>
	<1186500734.20129.58.camel@violet>
	<Pine.LNX.4.63.0708071754160.8578@pcgl.dsa-ac.de>
Date: Tue, 07 Aug 2007 18:05:20 +0200
Message-Id: <1186502720.20129.64.camel@violet>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] [REGRESSION] last working kernel 2.6.18
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Guennadi,

> > as mentioned multiple times in the past, the "hcitool cc" is not a
> > general purpose command. Nobody needs to create an ACL link. The kernel
> > does this for you in the background and you should let the kernel do its
> > job. It has to be the kernel since it has to track these connections and
> > the users of it. Unused ACL links will be disconnected. Period.
> > 
> > There are simply no excuses for creating low-level ACL links and there
> > is absolutely no need for it at all.
> 
> Thanks, Marcel. Just, what I thought:-) It would've saved us a few minutes 
> of typing and a few electrons shifted around the world if this was 
> documented somewhere:-) Would be great, if someone could, for example, 
> document it in the wiki. I DID look there, and I didn't find anything. 
> Which means, either it is not there, or not everybody is able to find it 
> there within a reasonable amount of time:-)

the documentation in various online articles is wrong. For some reason
people think that "hciool cc" is a good idea. It has always been a debug
command for developers. Nothing more, nothing less. The mailing list is
full of responses from me about it.

However the wiki is for everybody. Feel free to update it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
