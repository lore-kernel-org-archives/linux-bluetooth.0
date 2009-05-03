Return-Path: <cyrus@holtmann.org>
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
From: Marcel Holtmann <marcel@holtmann.org>
To: Marc Pignat <Marc.Pignat@hevs.ch>
Cc: justinmattock@gmail.com, hidave.darkstar@gmail.com,
	ext-roger.quadros@nokia.com, jkosina@suse.cz,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <49FDCC85020000BF000290ED@mailgw2.hevs.ch>
References: <49FDCC85020000BF000290ED@mailgw2.hevs.ch>
Content-Type: text/plain
Date: Sun, 03 May 2009 13:17:01 -0700
Message-Id: <1241381821.2785.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marc,

you really need to fix your mailer. You keep breaking the threading all
the time and that is clearly your fault.

> > thanks for testing.
> 
> > Marc, Roger, can you test this and confirm that it works for you and
> > doesn't have any other side effects. Then I prepare it work upstream
> > inclusion.
> 
> Tested and working!

great. So I queue this up for 2.6.30 inclusion.

> Exercise left for 2.6.31: use the system wide wq ;)

Actually no, the private workqueue is used on purpose. No need to bother
keventd for a regular task.

Regards

Marcel


