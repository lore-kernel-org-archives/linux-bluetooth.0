Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jul 2015 11:08:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 3/8] Bluetooth: Unwind l2cap_sock_shutdown()
Message-ID: <20150716080840.GA28234@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com>
 <20150713110731.GA21598@t440s.lan>
 <55A3F5F8.4070800@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A3F5F8.4070800@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Mon, Jul 13, 2015, Dean Jenkins wrote:
> >Do you think you'll be able to fix this as well as the missing
> >mutex_lock(&conn->chan_lock) issue this week? Otherwise we'll need to
> >consider reverting your patches since it's quite clear we can't make any
> >bluetooth-next pull requests with the current state of the tree.
> 
> I think it would be wise to revert the changes as I am unable to guarantee
> that I get time to propose a fix during this week. I will try to work on a
> v3 patchset based on your feedback.

I went ahead and pushed a rebased tree with your patches 3/8, 4/8 and
5/8 removed. The other five were either harmless or good fixes. So
if/when you have new patches please base them against the new tree.

Johan
