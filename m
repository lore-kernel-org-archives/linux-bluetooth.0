Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090403201207.GA8156@jh-x301>
References: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
	 <20090403201207.GA8156@jh-x301>
Date: Sat, 4 Apr 2009 08:48:46 +0800
Message-ID: <ac8af0be0904031748u4b109e11kb78a1db3d50ead71@mail.gmail.com>
Subject: Re: [PATCH 1/4] add the D-Bus interface definition for HFP Audio
	gateway -- take4 -- rebased
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Forrest <forrest.zhao@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> The first three patches have been pushed upstream with some minor modifications
> (compilation warning fixes and disabling the new feature by default). However,
> the fourth one which binds it all to the IPC needs some rethinking. Right now
> it'd break backwards compatibility for the IPC which we'd like to avoid since
> we juts did that for 4.34. Also, there are some added terms like master and
> slave (used for HFP/A2DP roles) which should be renamed to something more
> intuitive (assuming they need to be in the IPC at all).

Thank you for your comments. I'll revise the IPC part ASAP after coming back
from the Chinese Qingming holiday.

Thanks,
Forrest
