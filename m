Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Apr 2009 23:12:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] add the D-Bus interface definition for HFP Audio
	gateway -- take4 -- rebased
Message-ID: <20090403201207.GA8156@jh-x301>
References: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

The first three patches have been pushed upstream with some minor modifications
(compilation warning fixes and disabling the new feature by default). However,
the fourth one which binds it all to the IPC needs some rethinking. Right now
it'd break backwards compatibility for the IPC which we'd like to avoid since
we juts did that for 4.34. Also, there are some added terms like master and
slave (used for HFP/A2DP roles) which should be renamed to something more
intuitive (assuming they need to be in the IPC at all).

Johan
