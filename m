Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Aug 2010 15:59:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tom Counihan <tomcounihan@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove dup VCard2.1 SDP format for OPP
Message-ID: <20100820125948.GA16376@jh-x301>
References: <AANLkTin+CRVwKgC+UaDK6q4PRrw9eGi3c7++PSxWODcu@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin+CRVwKgC+UaDK6q4PRrw9eGi3c7++PSxWODcu@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Fri, Aug 20, 2010, Tom Counihan wrote:
> OPP SDP record appears to have a duplicate
> entry for Supported Formats List.
> 
> ---
>  plugins/opp.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

The patch looks fine but doesn't apply against latest git:

error: patch failed: plugins/opp.c:83
error: plugins/opp.c: patch does not apply
Patch failed at 0001 Remove dup VCard2.1 SDP format for OPP

Could you make sure that it applies cleanly to latest git and then
resend? Thanks.

Johan
