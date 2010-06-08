Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 16:02:45 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Fix redundant null check on calling free()
Message-ID: <20100608080245.GA1839@jh-x301>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
 <1275732870-15889-3-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275732870-15889-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Jun 05, 2010, Gustavo F. Padovan wrote:
> Issues found by smatch static check: http://smatch.sourceforge.net/
> ---
>  input/device.c     |    6 +--
>  lib/sdp.c          |   89 +++++++++++++++++----------------------------------
>  src/sdp-xml.c      |    8 +---
>  src/sdpd-request.c |   12 ++-----
>  src/storage.c      |    6 +--
>  test/ipctest.c     |    6 +--
>  6 files changed, 42 insertions(+), 85 deletions(-)

Both NULL-check removal patches have been pushed upstream.

Johan
