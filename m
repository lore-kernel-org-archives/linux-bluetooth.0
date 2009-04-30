Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] *** SUBJECT HERE ***
From: Marcel Holtmann <marcel@holtmann.org>
To: ngh@isomerica.net
Cc: linux-bluetooth@vger.kernel.org,
	Nathan Holstein <nathan@lampreynetworks.com>
In-Reply-To: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
References: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 19:01:28 -0700
Message-Id: <1241056888.3389.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

> This is a revamping of the previous patches that I submited.  I started from
> scratch, rebase all the changes onto the latest bluetooth-testing (2.6.30-rc3).
> While applying the changes, I attempted to clean up the code and apply the
> input from Marcel and Gustavo.
> 
> Unfortunately, I did not get a chance to test this for regressions vs. the
> previous version of the code.  I did remove the code which segmented outgoing
> PDUs: it wouldn't have worked with the current tx window=1, and would have
> produced memory leaks.
> 
> The code is available from git://staticfree.info/git/el2cap on branch "ertm".

no idea why are using a branch for this. Just a remote repository should
be enough. Anyhow you have to add Signed-off-by statements to your
patches. Otherwise I can't apply them.

Regards

Marcel


