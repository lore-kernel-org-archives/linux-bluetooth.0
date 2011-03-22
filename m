Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Mar 2011 10:14:04 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: David Fries <david@fries.net>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rfcomm/core.c avoid dangling pointer, check session
Message-ID: <20110322141403.GA2512@tuxdriver.com>
References: <20110322023810.GG22204@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110322023810.GG22204@spacedout.fries.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 21, 2011 at 09:38:10PM -0500, David Fries wrote:
> rfcomm_process_sessions is calling rfcomm_process_rx, but
> in this case the session is closed and freed leaving a
> dangling pointer that blows up when rfcomm_process_rx returns
> and rfcomm_process_dlcs is called with the now dangling session
> pointer.

Please trim this commit log substantially before the patch is merged...

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
