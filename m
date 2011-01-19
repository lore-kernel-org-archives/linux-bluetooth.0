Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:50:15 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Add Routing property to MediaTransport interface
Message-ID: <20110119152015.GF2112@jh-x301>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
 <1295344815-1404-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295344815-1404-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 18, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This should indicate to the endpoint what routing the transport is using
> ---
>  audio/transport.c |    4 ++++
>  doc/media-api.txt |    6 ++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)

Pushed upstream, though this brings up the question of who should know
the routing setting. There's no standard HCI command for it which makes
it effectively a platform specific feature which either needs to be
statically "known" in some config file or discovered though some
platform specific plugin. Since we've already got platform specific code
on the PulseAudio side (it needs to know where to write the data in the
PCM case) the knowledge might as well be there and that would make the
property unnecessary. Thoughts?

Johan
