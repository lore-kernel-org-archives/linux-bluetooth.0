Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 10:42:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] attrib: Fix memleak if att_data_list_alloc fails
Message-ID: <20121019074227.GC2243@x220>
References: <CAJdJm_NiL522WPLrV-RiaJKBZeOBBgo_vSzQCwTdZwLZLTw88A@mail.gmail.com>
 <1350549561-16424-1-git-send-email-luf@pzkagis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350549561-16424-1-git-send-email-luf@pzkagis.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Thu, Oct 18, 2012, Ludek Finstrle wrote:
> Fix for memory leak which was introduced in commit
> f8619bef3406a2134082dc41c208105fe028c09f.
> I tested it with older bluez and rebase for git. Please review it.
> ---
>  src/attrib-server.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)

Applied (with the last commit message line removed as suggested by
Vinicius). Thanks.

Johan
