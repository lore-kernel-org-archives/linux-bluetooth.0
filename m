Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Dec 2011 13:11:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix strict-aliasing rules handling for hciemu and
 IP ports
Message-ID: <20111230111110.GC32368@x220>
References: <1325184068-30979-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1325184068-30979-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Dec 29, 2011, Anderson Lizardo wrote:
> This fix is based on commit 97046eaf3fc44b4451157b1a1bbc166ab0f4dda8.
> ---
> 
> Due to some recent change, gcc 4.4.3 (from Ubuntu 10.04) started complaining
> about this code:
> 
> test/hciemu.c: In function ‘hci_host_control’:
> test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does break
> strict-aliasing rules
> test/hciemu.c:431: note: initialized from here
> 
> 
>  test/hciemu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied, but I had to move the stuff below --- to the actual commit
message since it's important to retain the reasons for the patches in
the git commit history.

Johan
