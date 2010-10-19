Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 17:01:18 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] bluetooth: Remove some unnecessary error messages
Message-ID: <20101019160118.GA25861@srcf.ucam.org>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com> <1284659895-27984-2-git-send-email-mjg@redhat.com> <1287402917.3316.128.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287402917.3316.128.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 18, 2010 at 01:55:17PM +0200, Marcel Holtmann wrote:
> Hi Matthew,
> 
> > The main reason for these urbs to error out on submission is that runtime
> > pm has kicked in, which is unnecessary noise. Let's just drop them.
> 
> do we wanna remove them or just turn into BT_DBG which is under dynamic
> debug control. Or do we have a set of error results that we do wanna
> print and others that we wanna ignore?

BT_DBG doesn't seem like an obvious problem. Are there any cases where 
this will actually trigger in a problematic way?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
