Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Support for adding UUID128 to extended inquiry
 response
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: Inga Stotland <ingas@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
In-Reply-To: <4C375658.10904@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
	 <1278540518-18620-2-git-send-email-ingas@codeaurora.org>
	 <1278609452.10421.31.camel@localhost.localdomain>
	 <4C375658.10904@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 14:35:35 -0300
Message-ID: <1278696935.10421.139.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> >>  void register_public_browse_group(void)
> >> diff --git a/src/sdpd.h b/src/sdpd.h
> >> index e93b0b6..8fd8bbe 100644
> >> --- a/src/sdpd.h
> >> +++ b/src/sdpd.h
> >> @@ -6,6 +6,7 @@
> >>   *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
> >>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> >>   *  Copyright (C) 2002-2003  Stephen Crane <steve.crane@rococosoft.com>
> >> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
> > 
> > I prefer that we actually see major code contributions that justify a
> > copyright here before you start adding it. And so let the maintainers
> > worry about that later on. I don't wanna see just random copyright
> > additions for obvious fixes or changes that are most likely even derived
> > from existing code.
> >  
> 
> I'm unsure of the reasoning unless the idea is to add copyright markings
> to show attribution and level of contribution. In our case it's just a
> legal marking.
> 
> If the reasoning for adding or not adding is the former, does this not
> rise to that level, and for my own education and future reference why not?

we normally automatically add the copyright for companies or individual
when they make large contributions. Not just small extensions or fixes
where it is questionable if they are copyrightable anyway.

For just tracking contributions, we have GIT :)

Regards

Marcel


