Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Sep 2012 14:11:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1] gatttool: Fix Characteristic descriptor
 discovery
Message-ID: <20120920111135.GA9102@x220>
References: <CAJdJm_OSzp9i_ox380aFJvrTWwUKUeR2OYeZQDPvoBxSXvYYjw@mail.gmail.com>
 <1348083476-21435-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348083476-21435-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Sep 19, 2012, Claudio Takahasi wrote:
> This patch fixes end condition for Characteristic Descriptor Discovery.
> This sub-procedure is complete when the Error Response is received and
> the Error Code is set to Attribute Not Found or the Find Information
> Response has an Attribute Handle that is equal to the Ending Handle of
> the request.
> ---
>  attrib/interactive.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
