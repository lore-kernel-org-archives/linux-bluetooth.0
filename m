Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 17 May 2013 09:46:51 +0300
Message-ID: <CABBYNZ+wbDcZfx0v7-cdpO0JL0Are_c_GK0+ju4nVC2m4N6Qnw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/14] tools: Add support for MPRIS TrackList
 interface to mpris-player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 15, 2013 at 6:31 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds support for TrackList interface as defined in MPRIS:
> http://specifications.freedesktop.org/mpris-spec/latest/Track_List_Interface.html
> ---
>  tools/mpris-player.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 286 insertions(+), 13 deletions(-)

This patch-set is now upstream.

Luiz Augusto von Dentz
