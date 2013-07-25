Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jul 2013 20:07:49 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Subject: Re: [PATCH v2 2/7] rfcomm: Move the tty initialization and cleanup
 out of open/close
Message-ID: <20130725180749.GA12067@sottospazio.it>
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
 <1374510435-12149-2-git-send-email-gianluca@sottospazio.it>
 <51F0550A.1000402@hurleysoftware.com>
 <20130725053725.GA7214@sottospazio.it>
 <51F1213C.3030900@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F1213C.3030900@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 25, 2013 at 08:59:40AM -0400, Peter Hurley wrote:
> On 07/25/2013 01:37 AM, Gianluca Anzolin wrote:
> >Hello,
> >
> >sorry I'm not very used to submit patches "the right way" and I missed the
> >point that I have to keep the changes to the minimum.
> 
> No need to apologize.
> Every kernel contributor goes through this learning curve.
> 

Hello,

I'm trying to reach the minimal changeset to reach my target, and in the
process I figured out that if I implement the .activate and .shutdown port
methods before the .install and .cleanup methods I could produce less changes.

However I'm stuck now because I cannot guarantee that the intermediate code
between the patches works at all (however it compiles). What should I do?

Thanks,
Gianluca
