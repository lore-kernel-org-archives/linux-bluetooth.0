Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1503685020.12938.19.camel@hadess.net>
Subject: Re: [PATCH v2 0/4] BlueZ: Add support for pairing the DS4
 controller over USB
From: Bastien Nocera <hadess@hadess.net>
To: Juha Kuikka <juha.kuikka@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, frank.praznik@gmail.com,
        roderick.colenbrander@sony.com,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Antonio Ospite <ao2@ao2.it>
Date: Fri, 25 Aug 2017 20:17:00 +0200
In-Reply-To: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2016-12-28 at 16:32 -0800, Juha Kuikka wrote:
> This patch set first refactors the sixaxis plugin to more easily
> support
> multiple controllers with different protocols.
> 
> Secondly support for pairing the Dualshock 4 controller over USB is
> added.
> 
> Last, the PID of the new DS4 controller is added into the input
> device special
> case handler which allows this controller to be used.

I've redone this patchset on top of my "cable pairing authentication"
patches:
https://github.com/hadess/bluez/commits/ds4-cable-pairing

I wanted people to test it out, go through review comments, and fix any
major problems before sending it out to the list.

The cable pairing authentication needs an agent that supports it. If
you have GNOME installed, you're in luck. The cable pairing
authentication has been supported since gnome-bluetooth 3.18.0.

It was implemented in this patch, if you want to try and add support in
one of the tools around:
https://git.gnome.org/browse/gnome-bluetooth/commit/?id=2efefd456b5ae3617e618e8d76ca3a121b83570e

TODO items:
- go through original (Juha's) patchset review comments
- add cancellation for cable pairing when USB is disconnected
- tests tests tests

Comments welcome!
